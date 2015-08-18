#include <assert.h>
#include <stdint.h>
#include <string.h>
#include <inttypes.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int8.h"
#include "int16.h"
#include "int128.h"
#include "uint8.h"
#include "uint16.h"
#include "uint32.h"
#include "uint64.h"
#include "uint128.h"

CAMLprim value
int_of_int8(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Int8_val(v)));
}

CAMLprim value
int_of_int16(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Int16_val(v)));
}

CAMLprim value
int_of_int32(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Int32_val(v)));
}

CAMLprim value
int_of_int64(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Int64_val(v)));
}

CAMLprim value
int_of_int128(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Int128_val(v)));
}

CAMLprim value
int_of_uint8(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Uint8_val(v)));
}

CAMLprim value
int_of_uint16(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Uint16_val(v)));
}

CAMLprim value
int_of_uint32(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Uint32_val(v)));
}

CAMLprim value
int_of_uint64(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Uint64_val(v)));
}

CAMLprim value
int_of_uint128(value v)
{
  CAMLparam1(v);
  CAMLreturn (Val_int((int)Uint128_val(v)));
}

