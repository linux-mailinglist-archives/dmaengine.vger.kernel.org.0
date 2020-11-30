Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC412C90A1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Nov 2020 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgK3WH4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Nov 2020 17:07:56 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45472 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgK3WH4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Nov 2020 17:07:56 -0500
Received: by mail-il1-f194.google.com with SMTP id w8so12878303ilg.12;
        Mon, 30 Nov 2020 14:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Il5bX+C/6AFCcXPkSp4GDC8FUcjzfQ4UtKU2jfJxUuU=;
        b=TyTx369moS42kfKTGXs0al3LkpHJtTmZARxEhU29reT0/yK7JayKuAm1hA3Rux3IFl
         cXPBmw6d58bx18ZKCQpEbcBiguG6gdR+KE83XWlIrvOvrPB/uIBLILd+lMY2kKVgnmIL
         gsr5TSm3MChZG+G7lfbAL1p26upLJUqfFlcCZDNnwMKMtWVHYYAUqvEbdcQwuKETfa+i
         OX9lPo8bJSgL+FHiXNKoisL0Ms5tB7LuaptCgXexxxEkCZPxAukP2n1TU4hLhs0xNXT2
         3+ksnG2ZsnZwbg0bsRrBHT5svOKsEzIAmKTLoWoIry/Cv2CLFP6MFS8IQOkt0tOj1wgF
         961w==
X-Gm-Message-State: AOAM530+ITqiy+GoJnarwwLQdZVijLPFR4JY9vdvX5zrT2pfrD5+JhK5
        QDw4HxyrBhS4U7X08xX9+A==
X-Google-Smtp-Source: ABdhPJyHEYIlPLINmOKAGg88zs45cA/PyIQKFe86oDTQlgjR4fA9EKs6gMw9Hbut0YzVaFwN0JE23w==
X-Received: by 2002:a92:d03:: with SMTP id 3mr21496223iln.197.1606774034237;
        Mon, 30 Nov 2020 14:07:14 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o7sm8287994iov.1.2020.11.30.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:07:13 -0800 (PST)
Received: (nullmailer pid 3117129 invoked by uid 1000);
        Mon, 30 Nov 2020 22:07:11 -0000
Date:   Mon, 30 Nov 2020 15:07:11 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: Document the hi3559a clock bindings
Message-ID: <20201130220711.GA3112118@robh.at.kernel.org>
References: <20201119200129.28532-1-gengdongjiu@huawei.com>
 <20201119200129.28532-2-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119200129.28532-2-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 19, 2020 at 08:01:26PM +0000, Dongjiu Geng wrote:
> Add DT bindings documentation for hi3559a SoC clock.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  .../clock/hisilicon,hi3559av100-clock.yaml    |  66 +++++++
>  include/dt-bindings/clock/hi3559av100-clock.h | 165 ++++++++++++++++++
>  2 files changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> new file mode 100644
> index 000000000000..0f531e8186d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/hisilicon,hi3559av100-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon SOC Clock for HI3559AV100
> +
> +maintainers:
> +  - Dongjiu Geng <gengdongjiu@huawei.com>
> +
> +description: |
> +  Hisilicon SOC clock control module which supports the clocks, resets and
> +  power domains on HI3559AV100.
> +
> +  See also:
> +    dt-bindings/clock/hi3559av100-clock.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,hi3559av100-clock
> +      - hisilicon,hi3559av100-shub-clock
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 2

What's in each cell?

> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2

#address-cells and #size-cells are for child nodes, but you have none so 
drop them.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock: clock0@12010000 {

clock-controller@...

> +            compatible = "hisilicon,hi3559av100-clock";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            #clock-cells = <1>;
> +            #reset-cells = <2>;
> +            reg = <0x0 0x12010000 0x0 0x10000>;
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/clock/hi3559av100-clock.h b/include/dt-bindings/clock/hi3559av100-clock.h
> new file mode 100644
> index 000000000000..88baa86cff85
> --- /dev/null
> +++ b/include/dt-bindings/clock/hi3559av100-clock.h
> @@ -0,0 +1,165 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Don't care about non-GPL OS/users?

> +/*
> + * Copyright (c) 2019-2020, Huawei Tech. Co., Ltd.
> + *
> + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
> + */
> +
> +#ifndef __DTS_HI3559AV100_CLOCK_H
> +#define __DTS_HI3559AV100_CLOCK_H
> +
> +/*  fixed   rate    */
> +#define HI3559AV100_FIXED_1188M     1
> +#define HI3559AV100_FIXED_1000M     2
> +#define HI3559AV100_FIXED_842M      3
> +#define HI3559AV100_FIXED_792M      4
> +#define HI3559AV100_FIXED_750M      5
> +#define HI3559AV100_FIXED_710M      6
> +#define HI3559AV100_FIXED_680M      7
> +#define HI3559AV100_FIXED_667M      8
> +#define HI3559AV100_FIXED_631M      9
> +#define HI3559AV100_FIXED_600M      10
> +#define HI3559AV100_FIXED_568M      11
> +#define HI3559AV100_FIXED_500M      12
> +#define HI3559AV100_FIXED_475M      13
> +#define HI3559AV100_FIXED_428M      14
> +#define HI3559AV100_FIXED_400M      15
> +#define HI3559AV100_FIXED_396M      16
> +#define HI3559AV100_FIXED_300M      17
> +#define HI3559AV100_FIXED_250M      18
> +#define HI3559AV100_FIXED_198M      19
> +#define HI3559AV100_FIXED_187p5M    20
> +#define HI3559AV100_FIXED_150M      21
> +#define HI3559AV100_FIXED_148p5M    22
> +#define HI3559AV100_FIXED_125M      23
> +#define HI3559AV100_FIXED_107M      24
> +#define HI3559AV100_FIXED_100M      25
> +#define HI3559AV100_FIXED_99M       26
> +#define HI3559AV100_FIXED_74p25M    27
> +#define HI3559AV100_FIXED_72M       28
> +#define HI3559AV100_FIXED_60M       29
> +#define HI3559AV100_FIXED_54M       30
> +#define HI3559AV100_FIXED_50M       31
> +#define HI3559AV100_FIXED_49p5M     32
> +#define HI3559AV100_FIXED_37p125M   33
> +#define HI3559AV100_FIXED_36M       34
> +#define HI3559AV100_FIXED_32p4M     35
> +#define HI3559AV100_FIXED_27M       36
> +#define HI3559AV100_FIXED_25M       37
> +#define HI3559AV100_FIXED_24M       38
> +#define HI3559AV100_FIXED_12M       39
> +#define HI3559AV100_FIXED_3M        40
> +#define HI3559AV100_FIXED_1p6M      41
> +#define HI3559AV100_FIXED_400K      42
> +#define HI3559AV100_FIXED_100K      43
> +#define HI3559AV100_FIXED_200M      44
> +#define HI3559AV100_FIXED_75M       75
> +
> +#define HI3559AV100_I2C0_CLK    50
> +#define HI3559AV100_I2C1_CLK    51
> +#define HI3559AV100_I2C2_CLK    52
> +#define HI3559AV100_I2C3_CLK    53
> +#define HI3559AV100_I2C4_CLK    54
> +#define HI3559AV100_I2C5_CLK    55
> +#define HI3559AV100_I2C6_CLK    56
> +#define HI3559AV100_I2C7_CLK    57
> +#define HI3559AV100_I2C8_CLK    58
> +#define HI3559AV100_I2C9_CLK    59
> +#define HI3559AV100_I2C10_CLK   60
> +#define HI3559AV100_I2C11_CLK   61
> +
> +#define HI3559AV100_SPI0_CLK    62
> +#define HI3559AV100_SPI1_CLK    63
> +#define HI3559AV100_SPI2_CLK    64
> +#define HI3559AV100_SPI3_CLK    65
> +#define HI3559AV100_SPI4_CLK    66
> +#define HI3559AV100_SPI5_CLK    67
> +#define HI3559AV100_SPI6_CLK    68
> +
> +#define HI3559AV100_EDMAC_CLK     69
> +#define HI3559AV100_EDMAC_AXICLK  70
> +#define HI3559AV100_EDMAC1_CLK    71
> +#define HI3559AV100_EDMAC1_AXICLK 72
> +#define HI3559AV100_VDMAC_CLK     73
> +
> +/*  mux clocks  */
> +#define HI3559AV100_FMC_MUX     80
> +#define HI3559AV100_SYSAPB_MUX  81
> +#define HI3559AV100_UART_MUX    82
> +#define HI3559AV100_SYSBUS_MUX  83
> +#define HI3559AV100_A73_MUX     84
> +#define HI3559AV100_MMC0_MUX    85
> +#define HI3559AV100_MMC1_MUX    86
> +#define HI3559AV100_MMC2_MUX    87
> +#define HI3559AV100_MMC3_MUX    88
> +
> +/*  gate    clocks  */
> +#define HI3559AV100_FMC_CLK     90
> +#define HI3559AV100_UART0_CLK   91
> +#define HI3559AV100_UART1_CLK   92
> +#define HI3559AV100_UART2_CLK   93
> +#define HI3559AV100_UART3_CLK   94
> +#define HI3559AV100_UART4_CLK   95
> +#define HI3559AV100_MMC0_CLK    96
> +#define HI3559AV100_MMC1_CLK    97
> +#define HI3559AV100_MMC2_CLK    98
> +#define HI3559AV100_MMC3_CLK    99
> +
> +#define HI3559AV100_ETH_CLK         100
> +#define HI3559AV100_ETH_MACIF_CLK   101
> +#define HI3559AV100_ETH1_CLK        102
> +#define HI3559AV100_ETH1_MACIF_CLK  103
> +
> +/*  complex */
> +#define HI3559AV100_MAC0_CLK                110
> +#define HI3559AV100_MAC1_CLK                111
> +#define HI3559AV100_SATA_CLK                112
> +#define HI3559AV100_USB_CLK                 113
> +#define HI3559AV100_USB1_CLK                114
> +
> +/* pll clocks */
> +#define HI3559AV100_APLL_CLK                250
> +#define HI3559AV100_GPLL_CLK                251
> +
> +#define HI3559AV100_CRG_NR_CLKS	            256
> +
> +#define HI3559AV100_SHUB_SOURCE_SOC_24M	    0
> +#define HI3559AV100_SHUB_SOURCE_SOC_200M    1
> +#define HI3559AV100_SHUB_SOURCE_SOC_300M    2
> +#define HI3559AV100_SHUB_SOURCE_PLL         3
> +#define HI3559AV100_SHUB_SOURCE_CLK         4
> +
> +#define HI3559AV100_SHUB_I2C0_CLK           10
> +#define HI3559AV100_SHUB_I2C1_CLK           11
> +#define HI3559AV100_SHUB_I2C2_CLK           12
> +#define HI3559AV100_SHUB_I2C3_CLK           13
> +#define HI3559AV100_SHUB_I2C4_CLK           14
> +#define HI3559AV100_SHUB_I2C5_CLK           15
> +#define HI3559AV100_SHUB_I2C6_CLK           16
> +#define HI3559AV100_SHUB_I2C7_CLK           17
> +
> +#define HI3559AV100_SHUB_SPI_SOURCE_CLK     20
> +#define HI3559AV100_SHUB_SPI4_SOURCE_CLK    21
> +#define HI3559AV100_SHUB_SPI0_CLK           22
> +#define HI3559AV100_SHUB_SPI1_CLK           23
> +#define HI3559AV100_SHUB_SPI2_CLK           24
> +#define HI3559AV100_SHUB_SPI3_CLK           25
> +#define HI3559AV100_SHUB_SPI4_CLK           26
> +
> +#define HI3559AV100_SHUB_UART_CLK_32K       30
> +#define HI3559AV100_SHUB_UART_SOURCE_CLK    31
> +#define HI3559AV100_SHUB_UART_DIV_CLK       32
> +#define HI3559AV100_SHUB_UART0_CLK          33
> +#define HI3559AV100_SHUB_UART1_CLK          34
> +#define HI3559AV100_SHUB_UART2_CLK          35
> +#define HI3559AV100_SHUB_UART3_CLK          36
> +#define HI3559AV100_SHUB_UART4_CLK          37
> +#define HI3559AV100_SHUB_UART5_CLK          38
> +#define HI3559AV100_SHUB_UART6_CLK          39
> +
> +#define HI3559AV100_SHUB_EDMAC_CLK          40
> +
> +#define HI3559AV100_SHUB_NR_CLKS            50
> +
> +#endif  /* __DTS_HI3559AV100_CLOCK_H */
> +
> -- 
> 2.17.1
> 
