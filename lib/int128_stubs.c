#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int128.h"

static int
int128_cmp(value v1, value v2)
{
    __int128_t i1 = Int128_val(v1);
    __int128_t i2 = Int128_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
int128_hash(value v)
{
    return Int128_val(v);
}

static void
int128_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_failwith("unimplemented");
}

static uintnat
int128_deserialize(void *dst)
{
    caml_failwith("unimplemented");
    return 16;
}

struct custom_operations int128_ops = {
    "uint.int128",
    custom_finalize_default,
    int128_cmp,
    int128_hash,
    int128_serialize,
    int128_deserialize
};

CAMLprim value
copy_int128(__int128_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&int128_ops, 16, 0, 1);
    Int128_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
int128_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) + Int128_val(v2)));
}

CAMLprim value
int128_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) - Int128_val(v2)));
}

CAMLprim value
int128_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) * Int128_val(v2)));
}

CAMLprim value
int128_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    __int128_t divisor = Int128_val(v2);

    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_int128(Int128_val(v1) / divisor));
}

CAMLprim value
int128_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    __int128_t divisor = Int128_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_int128(Int128_val(v1) % divisor));
}

CAMLprim value
int128_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) & Int128_val(v2)));
}

CAMLprim value
int128_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) | Int128_val(v2)));
}

CAMLprim value
int128_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) ^ Int128_val(v2)));
}

CAMLprim value
int128_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) << Int_val(v2)));
}

CAMLprim value
int128_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int128(Int128_val(v1) >> Int_val(v2)));
}

CAMLprim value
int128_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; __int128_t i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_int128(u.i));
}

CAMLprim value
int128_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; __int128_t i; } u;
    u.i = Int128_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
int128_max_int(void)
{
    CAMLparam0();
    __int128_t i = INT64_MAX;
    i <<= 64;
    i |= UINT64_MAX;
    CAMLreturn (copy_int128(i));
}

CAMLprim value
int128_min_int(void)
{
    CAMLparam0();
    __int128_t i = 1;
    i <<= 127;
    CAMLreturn (copy_int128(i));
}

CAMLprim value
int128_abs(value v)
{
    CAMLparam1(v);
    __int128_t i = Int128_val(v);
    i = i < 0 ? (-i) : i;
    CAMLreturn (copy_int128(i));
}

CAMLprim value
int128_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&int128_ops);
    CAMLreturn (Val_unit);
}

