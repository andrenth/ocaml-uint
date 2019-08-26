open Stdint

type uint8 = Uint8.t
type t = uint8

let add = Uint8.add
let sub = Uint8.sub
let mul = Uint8.mul
let div = Uint8.div
let rem = Uint8.rem
let logand = Uint8.logand
let logor = Uint8.logor
let logxor = Uint8.logxor
let lognot = Uint8.lognot
let shift_left = Uint8.shift_left
let shift_right = Uint8.shift_right
let of_int = Uint8.of_int
let to_int = Uint8.to_int
let of_float = Uint8.of_float
let to_float = Uint8.to_float
let of_int32 = Uint8.of_int32
let to_int32 = Uint8.to_int32
let bits_of_float = Uint8.of_float (* This may cause issues *)
let float_of_bits = Uint8.to_float (* This may cause issues *)

let zero = of_int 0
let one = of_int 1
let succ = Uint8.succ
let pred = Uint8.pred
let max_int = Uint8.max_int
let min_int = Uint8.min_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint8
  let fmt     = "Ul"
  let name    = "Uint8"
  let zero    = zero
  let max_int = max_int
  let bits    = 8
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
