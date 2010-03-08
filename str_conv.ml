module type UintSig = sig
  type t
  val name    : string
  val fmt     : string
  val zero    : t
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
  val to_string2 : t -> string
  val to_string8 : t -> string
  val to_string16 : t -> string
  val printer : Format.formatter -> t -> unit
  val printer2 : Format.formatter -> t -> unit
  val printer8 : Format.formatter -> t -> unit
  val printer16 : Format.formatter -> t -> unit
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
    for i = 0 to String.length s - 1 do
      let c = s.[i] in
      if c <> '_' then
        res := U.add (U.mul !res base) (U.of_int (digit_of_char c))
    done;
    !res

  let of_string s =
    let fail = U.name ^ ".of_string" in
    let len = String.length s in
    match len with
    | 0 -> invalid_arg fail
    | 1 | 2 -> of_string' s 10
    | _ ->
        if s.[0] = '0' then
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
      let buffer = String.create 42 in
      let conv = "0123456789abcdef" in
      let base = U.of_int base in
      let i = ref (String.length buffer) in
      while !y <> U.zero do
        let x', digit = U.divmod !y base in
        y := x';
        decr i;
        buffer.[!i] <- conv.[U.to_int digit]
      done;
      prefix ^ String.sub buffer !i (String.length buffer - !i)
    end

  let to_string = to_string_base 10 ""
  let to_string2 = to_string_base 2 "0b"
  let to_string8 = to_string_base 8 "0o"
  let to_string16 = to_string_base 16 "0x"

  let print_with f fmt x =
    Format.fprintf fmt "@[%s@]" (f x ^ U.fmt)

  let printer = print_with to_string
  let printer2 = print_with to_string2
  let printer8 = print_with to_string8
  let printer16 = print_with to_string16
end
