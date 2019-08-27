type t = Stdint.Uint128.t
type uint128 = t
val zero : uint128
val one : uint128
val add : uint128 -> uint128 -> uint128
val sub : uint128 -> uint128 -> uint128
val mul : uint128 -> uint128 -> uint128
val div : uint128 -> uint128 -> uint128
val rem : uint128 -> uint128 -> uint128
val succ : uint128 -> uint128
val pred : uint128 -> uint128
val max_int : uint128
val min_int : uint128
val logand : uint128 -> uint128 -> uint128
val logor : uint128 -> uint128 -> uint128
val logxor : uint128 -> uint128 -> uint128
val lognot : uint128 -> uint128
val shift_left : uint128 -> int -> uint128
val shift_right : uint128 -> int -> uint128
val shift_right_logical : uint128 -> int -> uint128
val of_int : int -> uint128
val to_int : uint128 -> int
val of_float : float -> uint128
val to_float : uint128 -> float
val of_int32 : int32 -> uint128
val to_int32 : uint128 -> int32
val of_int64 : int64 -> uint128
val to_int64 : uint128 -> int64
val of_nativeint : nativeint -> uint128
val to_nativeint : uint128 -> nativeint
val of_string : string -> uint128
val to_string : uint128 -> string
val to_string_bin : uint128 -> string
val to_string_oct : uint128 -> string
val to_string_hex : uint128 -> string
val compare : t -> t -> int
val printer : Format.formatter -> uint128 -> unit
val printer_bin : Format.formatter -> uint128 -> unit
val printer_oct : Format.formatter -> uint128 -> unit
val printer_hex : Format.formatter -> uint128 -> unit
