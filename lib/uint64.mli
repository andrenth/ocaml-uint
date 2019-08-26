type t
type uint64 = t
val zero : uint64
val one : uint64
val add : uint64 -> uint64 -> uint64
val sub : uint64 -> uint64 -> uint64
val mul : uint64 -> uint64 -> uint64
val div : uint64 -> uint64 -> uint64
val rem : uint64 -> uint64 -> uint64
val succ : uint64 -> uint64
val pred : uint64 -> uint64
val max_int : uint64
val min_int : uint64
val logand : uint64 -> uint64 -> uint64
val logor : uint64 -> uint64 -> uint64
val logxor : uint64 -> uint64 -> uint64
val lognot : uint64 -> uint64
val shift_left : uint64 -> int -> uint64
val shift_right : uint64 -> int -> uint64
val of_int : int -> uint64
val to_int : uint64 -> int
val of_float : float -> uint64
val to_float : uint64 -> float
val of_int32 : int32 -> uint64
val to_int32 : uint64 -> int32
val of_nativeint : nativeint -> uint64
val to_nativeint : uint64 -> nativeint
val of_int64 : int64 -> uint64
val to_int64 : uint64 -> int64
val of_string : string -> uint64
val to_string : uint64 -> string
val to_string_bin : uint64 -> string
val to_string_oct : uint64 -> string
val to_string_hex : uint64 -> string
val bits_of_float : float -> uint64
  [@@ocaml.alert deprecated]
val float_of_bits : uint64 -> float
  [@@ocaml.alert deprecated]
val compare : t -> t -> int
val printer : Format.formatter -> uint64 -> unit
val printer_bin : Format.formatter -> uint64 -> unit
val printer_oct : Format.formatter -> uint64 -> unit
val printer_hex : Format.formatter -> uint64 -> unit
