open Crowbar
open Core

module type Testable = sig
  type t
  val to_int : t -> int
  val of_int : int -> t
  val to_int32 : t -> int32
  val of_int32 : int32 -> t
  val to_string: t -> string
  val logand: t -> t -> t
  val logor: t -> t -> t
  val logxor: t -> t -> t
  val lognot: t -> t
  val shift_left : t -> int -> t
  val shift_right: t -> int -> t
  val to_float: t -> float
  val of_float: float -> t
  val max_int : t
end

module type TaggedTestable = sig
  include Testable
  val name : string
end

module Test (T: TaggedTestable) (E : Testable) = struct
  let valid x = 
    let upper = T.max_int |> T.to_int in
    let lower = 0 in
    x < upper && x > lower
  let validi x = 
    Int32.(
      let upper = T.max_int |> T.to_int32 in
      let lower = zero in
      x < upper && x > lower
    )

  let add_tests () = 
    add_test ~name:(T.name ^ "_int_conv") [int] 
      (fun i -> 
         guard(valid i);
         check_eq i (i |> T.of_int |> T.to_int)
      );
    add_test ~name:(T.name ^ "_int32_conv") [int32]
      (fun i -> 
         guard(validi i);
         check_eq i (i |> T.of_int32 |> T.to_int32)
      );
    add_test ~name:(T.name ^ "_string_conv") [int32]
      (fun i ->
         guard(validi i);
         check_eq (Int32.to_string i) (i |> T.of_int32 |> T.to_string)
      );
    add_test ~name:(T.name ^ "_land") [int; int] 
      (fun i j ->
         guard(valid i);
         guard(valid j);
         check_eq
           (T.logand (T.of_int i) (T.of_int j) |> T.to_int )
           (E.logand (E.of_int i) (E.of_int j) |> E.to_int )
      );
    add_test ~name:(T.name ^ "_lor") [int; int] 
      (fun i j ->
         guard(valid i);
         guard(valid j);
         check_eq
           (T.logor (T.of_int i) (T.of_int j) |> T.to_int )
           (E.logor (E.of_int i) (E.of_int j) |> E.to_int )
      );
    add_test ~name:(T.name ^ "_lxor") [int; int] 
      (fun i j ->
         guard(valid i);
         guard(valid j);
         check_eq 
           (T.logxor (T.of_int i) (T.of_int j) |> T.to_int )
           (E.logxor (E.of_int i) (E.of_int j) |> E.to_int )
      );
    add_test ~name:(T.name ^ "_lnot") [int32] 
      (fun i ->
         guard(validi i);
         check_eq 
           (i |> T.of_int32 |> T.lognot |> T.to_int32) 
           (i |> E.of_int32 |> E.lognot |> E.to_int32)
      );
    add_test ~name:(T.name ^ "_lsl") [int32; range 31] 
      (fun i j ->
         guard(validi i);
         guard(valid j);
         check_eq 
           (i |> T.of_int32 |> (fun i -> T.shift_left i j) |> T.to_int32) 
           (i |> E.of_int32 |> (fun i -> E.shift_left i j) |> E.to_int32)
      );
    add_test ~name:(T.name ^ "_lsr") [int32; range 31] 
      (fun i j ->
         guard(validi i);
         guard(valid j);
         check_eq 
           (i |> T.of_int32 |> (fun i -> T.shift_right i j) |> T.to_int32) 
           (i |> E.of_int32 |> (fun i -> E.shift_right i j) |> E.to_int32)
      );
    add_test ~name:(T.name ^ "_float") [Crowbar.float]
      (fun i ->
         check_eq 
           (i |> T.of_float |> T.to_float)
           (i |> E.of_float |> E.to_float)
      )
end

module T_Uint8 = Test(
  struct 
    include Uint8
    let name = "uint8"
  end
  ) (Stdint.Uint8)
let () = T_Uint8.add_tests ()

module T_Uint16 = Test(
  struct 
    include Uint16
    let name = "uint16"
  end
  ) (Stdint.Uint16)
let () = T_Uint16.add_tests ()

module T_Uint32 = Test(
  struct 
    include Uint32
    let name = "uint32"
  end
  ) (Stdint.Uint32)
let () = T_Uint32.add_tests ()

module T_Uint64 = Test(
  struct
    include Uint64
    let name = "uint64"
  end
  ) (Stdint.Uint64)
let () = T_Uint64.add_tests ()

module T_Uint128 = Test(
    struct 
      include Uint128
      let name = "uint128"
    end
    ) (Stdint.Uint128)
let () = T_Uint128.add_tests ()
