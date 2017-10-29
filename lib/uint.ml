module type Str_conv_sig = sig
  module type UintSig = sig
    type t
    val name    : string
    val fmt     : string
    val zero    : t
    val max_int : t
    val bits    : int
    val of_int  : int -> t
    val to_int  : t -> int
    val add     : t -> t -> t
    val mul     : t -> t -> t
    val divmod  : t -> t -> t * t
  end

  module type S = sig
    type t
    val of_string : string -> t
    val to_string : t -> string
    val to_string_bin : t -> string
    val to_string_oct : t -> string
    val to_string_hex : t -> string
    val printer : Format.formatter -> t -> unit
    val printer_bin : Format.formatter -> t -> unit
    val printer_oct : Format.formatter -> t -> unit
    val printer_hex : Format.formatter -> t -> unit
  end

  module Make (U : UintSig) : S with type t = U.t
end

module Str_conv : Str_conv_sig = struct
  module type UintSig = sig
    type t
    val name    : string
    val fmt     : string
    val zero    : t
    val max_int : t
    val bits    : int
    val of_int  : int -> t
    val to_int  : t -> int
    val add     : t -> t -> t
    val mul     : t -> t -> t
    val divmod  : t -> t -> t * t
  end

  module type S = sig
    type t
    val of_string : string -> t
    val to_string : t -> string
    val to_string_bin : t -> string
    val to_string_oct : t -> string
    val to_string_hex : t -> string
    val printer : Format.formatter -> t -> unit
    val printer_bin : Format.formatter -> t -> unit
    val printer_oct : Format.formatter -> t -> unit
    val printer_hex : Format.formatter -> t -> unit
  end

  module Make (U : UintSig) : S with type t = U.t = struct
    type t = U.t

    let digit_of_char c =
      let disp =
        if c >= '0' && c <= '9' then 48
        else if c >= 'A' && c <= 'F' then 55
        else if c >= 'a' && c <= 'f' then 87
        else failwith (U.name ^ ".of_string") in
      int_of_char c - disp

    let of_string' s base =
      let base = U.of_int base in
      let res = ref U.zero in
      let thresh = fst (U.divmod U.max_int base) in
      for i = 0 to String.length s - 1 do
        let c = s.[i] in
        if !res > thresh then failwith (U.name ^ ".of_string");
        if c <> '_' then begin
          let d = U.of_int (digit_of_char c) in
          res := U.add (U.mul !res base) d;
          if !res < d then failwith (U.name ^ ".of_string");
        end
      done;
      !res

    let of_string s =
      let fail = U.name ^ ".of_string" in
      let len = String.length s in
      match len with
      | 0 -> invalid_arg fail
      | 1 | 2 -> of_string' s 10
      | _ ->
          if s.[0] = '0' && (s.[1] < '0' || s.[1] > '9') then
            let base =
              match s.[1] with
              | 'b' | 'B' -> 2
              | 'o' | 'O' -> 8
              | 'x' | 'X' -> 16
              | _ -> invalid_arg fail in
            of_string' (String.sub s 2 (len - 2)) base
          else
            of_string' s 10

    let to_string_base base prefix x =
      let y = ref x in
      if !y = U.zero then
        "0"
      else begin
        let buffer = Bytes.create U.bits in
        let conv = "0123456789abcdef" in
        let base = U.of_int base in
        let i = ref (Bytes.length buffer) in
        while !y <> U.zero do
          let x', digit = U.divmod !y base in
          y := x';
          decr i;
          Bytes.set buffer !i conv.[U.to_int digit]
        done;
        prefix ^ Bytes.sub_string buffer !i (Bytes.length buffer - !i)
      end

    let to_string = to_string_base 10 ""
    let to_string_bin = to_string_base 2 "0b"
    let to_string_oct = to_string_base 8 "0o"
    let to_string_hex = to_string_base 16 "0x"

    let print_with f fmt x =
      Format.fprintf fmt "@[%s@]" (f x ^ U.fmt)

    let printer = print_with to_string
    let printer_bin = print_with to_string_bin
    let printer_oct = print_with to_string_oct
    let printer_hex = print_with to_string_hex
  end
end
