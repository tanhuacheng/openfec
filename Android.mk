LOCAL_PATH := $(call my-dir)

####################################################################################################
# libopenfec
include $(CLEAR_VARS)
LOCAL_MODULE := libopenfec
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -g -Wall --std gnu11 -UNDEBUG \
				-Wno-unused-variable -Wno-unused-parameter -Wno-unused-function \
				-Wno-missing-field-initializers -Wno-strict-aliasing -Wno-sign-compare \
				-Wno-implicit-function-declaration -Wno-unused-label -Wno-sometimes-uninitialized
LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	src/lib_advanced/ldpc_from_file/of_ldpc_ff_api.c \
	src/lib_common/linear_binary_codes_utils/binary_matrix/of_hamming_weight.c \
	src/lib_common/linear_binary_codes_utils/binary_matrix/of_matrix_convert.c \
	src/lib_common/linear_binary_codes_utils/binary_matrix/of_matrix_dense.c \
	src/lib_common/linear_binary_codes_utils/binary_matrix/of_matrix_sparse.c \
	src/lib_common/linear_binary_codes_utils/binary_matrix/of_tools.c \
	src/lib_common/linear_binary_codes_utils/it_decoding/of_it_decoding.c \
	src/lib_common/linear_binary_codes_utils/ml_decoding/of_ml_decoding.c \
	src/lib_common/linear_binary_codes_utils/ml_decoding/of_ml_tool.c \
	src/lib_common/linear_binary_codes_utils/of_create_pchk.c \
	src/lib_common/linear_binary_codes_utils/of_symbol.c \
	src/lib_common/statistics/of_statistics.c \
	src/lib_common/of_mem.c \
	src/lib_common/of_openfec_api.c \
	src/lib_common/of_rand.c \
	src/lib_stable/2d_parity_matrix/of_2d_parity_api.c \
	src/lib_stable/ldpc_staircase/of_ldpc_staircase_api.c \
	src/lib_stable/ldpc_staircase/of_ldpc_staircase_pchk.c \
	src/lib_stable/reed-solomon_gf_2_8/of_reed-solomon_gf_2_8_api.c \
	src/lib_stable/reed-solomon_gf_2_8/of_reed-solomon_gf_2_8.c \
	src/lib_stable/reed-solomon_gf_2_m/galois_field_codes_utils/algebra_2_4.c \
	src/lib_stable/reed-solomon_gf_2_m/galois_field_codes_utils/algebra_2_8.c \
	src/lib_stable/reed-solomon_gf_2_m/galois_field_codes_utils/of_galois_field_code.c \
	src/lib_stable/reed-solomon_gf_2_m/of_reed-solomon_gf_2_m_api.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/src

include $(BUILD_STATIC_LIBRARY)
