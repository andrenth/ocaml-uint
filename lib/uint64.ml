open Stdint

type uint64 = Uint64.t
type t = uint64

let add = Uint64.add
let sub = Uint64.sub
let mul = Uint64.mul
let div = Uint64.div
let rem = Uint64.rem
let logand = Uint64.logand
let logor = Uint64.logor
let logxor = Uint64.logxor
let lognot = Uint64.lognot
let shift_left = Uint64.shift_left
let shift_right = Uint64.shift_right
let of_int = Uint64.of_int
let to_int = Uint64.to_int
let of_int32 = Uint64.of_int32
let to_int32 = Uint64.to_int32
let of_int64 = Uint64.of_int64
let to_int64 = Uint64.to_int64
let of_nativeint = Uint64.of_nativeint
let to_nativeint = Uint64.to_nativeint
let of_float = Uint64.of_float
let to_float = Uint64.to_float
let bits_of_float = Uint64.of_float (* This may cause issues *)
let float_of_bits = Uint64.to_float (* This may cause issues *)

let zero = Uint64.zero
let one = Uint64.one
let succ = Uint64.succ
let pred = Uint64.pred
let max_int = Uint64.max_int
let min_int = Uint64.min_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint64
  let name    = "Uint64"
  let fmt     = "UL"
  let zero    = zero
  let max_int = max_int
  let bits    = 64
  let of_int  = of_int
  let to_int  = to_int
  let add     = add
  let mul     = mul
  let divmod  = (fun x y -> div x y, rem x y)
end)

let of_string = Conv.of_string
let to_string = Conv.to_string
let to_string_bin = Conv.to_string_bin
let to_string_oct = Conv.to_string_oct
let to_string_hex = Conv.to_string_hex
let printer = Conv.printer
let printer_bin = Conv.printer_bin
let printer_oct = Conv.printer_oct
let printer_hex = Conv.printer_hex

let compare = Stdlib.compare
