open Stdint

type uint32 = Uint32.t
type t = uint32

let add = Uint32.add
let sub = Uint32.sub
let mul = Uint32.mul
let div = Uint32.div
let rem = Uint32.rem
let logand = Uint32.logand
let logor = Uint32.logor
let logxor = Uint32.logxor
let shift_left = Uint32.shift_left
let shift_right = Uint32.shift_right
let of_int = Uint32.of_int
let to_int = Uint32.to_int
let of_float = Uint32.of_float
let to_float = Uint32.to_float
let of_int32 = Uint32.of_int32
let to_int32 = Uint32.to_int32
let bits_of_float = Uint32.of_float
let float_of_bits = Uint32.to_float

let zero = Uint32.zero
let one = Uint32.one
let succ = Uint32.succ
let pred = Uint32.pred
let max_int = Uint32.max_int
let min_int = Uint32.min_int
let lognot = Uint32.lognot

module Conv = Uint.Str_conv.Make(struct
  type t      = uint32
  let fmt     = "Ul"
  let name    = "Uint32"
  let zero    = zero
  let max_int = max_int
  let bits    = 32
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
