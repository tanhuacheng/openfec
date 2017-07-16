#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "of_openfec_api.h"

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    int k = 8;
    int n = 11;
    int s = 160;

    of_parameters_t param = {
        .nb_source_symbols = k,
        .nb_repair_symbols = n - k,
        .encoding_symbol_length = s,
    };

    uint8_t data[n][s];

    for (int loop = 0; loop < 2; loop++) {
        void* buff[n];
        for (int i = 0; i < n; i++) {
            buff[i] = data[i];
        }

        of_session_t* enc = NULL;
        of_create_codec_instance(&enc, OF_CODEC_REED_SOLOMON_GF_2_8_STABLE, OF_ENCODER, 2);
        of_set_fec_parameters(enc, &param);

        for (int i = 0; i < k; i++) {
            for (int j = 0; j < s; j++) {
                data[i][j] = rand();
            }
        }
        for (int i = 0; i < n - k; i++) {
            of_build_repair_symbol(enc, buff, k + i);
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 8; j++) {
                printf("%02x ", data[i][j]);
            }
            printf("\n");
        }
        printf("\n");
        of_release_codec_instance(enc);


        of_session_t* dec = NULL;
        of_create_codec_instance(&dec, OF_CODEC_REED_SOLOMON_GF_2_8_STABLE, OF_DECODER, 2);
        of_set_fec_parameters(dec, &param);

        for (int i = 0; i < n; i++) {
            if (i == 0 || i == 3 || i == 7) {
                continue;
            }
            of_decode_with_new_symbol(dec, data[i], i);
        }
        of_finish_decoding(dec);

        memset(buff, 0, sizeof(buff));
        of_get_source_symbols_tab(dec, buff);

        for (int i = 0; i < k; i++) {
            printf("%p, %p\n", data[i], buff[i]);
            if (buff[i]) {
                for (int j = 0; j < 8; j++) {
                    printf("%02x ", ((uint8_t*)buff[i])[j]);
                }
                printf("\n");
            }
            if (buff[i] != data[i]) {
                printf("free alloced by decode\n");
                free(buff[i]);
            }
        }
        printf("\n");
        of_release_codec_instance(dec);
    }

    return 0;
}
