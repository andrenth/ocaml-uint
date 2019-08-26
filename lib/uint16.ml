open Stdint

type uint16 = Uint16.t
type t = uint16

let add = Uint16.add
let sub = Uint16.sub
let mul = Uint16.mul
let div = Uint16.div
let rem = Uint16.rem
let logand = Uint16.logand
let logor = Uint16.logor
let logxor = Uint16.logxor
let lognot = Uint16.lognot
let shift_left = Uint16.shift_left
let shift_right = Uint16.shift_right
let of_int = Uint16.of_int
let to_int = Uint16.to_int
let of_float = Uint16.of_float
let to_float = Uint16.to_float
let of_int32 = Uint16.of_int32
let to_int32 = Uint16.to_int32
let bits_of_float = Uint16.of_float (* This may cause issues *)
let float_of_bits = Uint16.to_float (* This may cause issues *)

let zero = Uint16.zero
let one = Uint16.one
let succ = Uint16.succ
let pred = Uint16.pred
let max_int = Uint16.max_int
let min_int = Uint16.min_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint16
  let fmt     = "Ul"
  let name    = "Uint16"
  let zero    = zero
  let max_int = max_int
  let bits    = 16
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
