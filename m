Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53E584FFB
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jul 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiG2MJ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiG2MJ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 08:09:58 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 05:09:57 PDT
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79387F7B
        for <dmaengine@vger.kernel.org>; Fri, 29 Jul 2022 05:09:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CEE251F9C3;
        Fri, 29 Jul 2022 14:00:04 +0200 (CEST)
Message-ID: <a8fa9e22-8c3f-60b2-a0db-01cfd5c37765@somainline.org>
Date:   Fri, 29 Jul 2022 14:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] arm64: dts: mediatek: Add support for MT6795 Sony
 Xperia M5 smartphone
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        fparent@baylibre.com, sam.shih@mediatek.com,
        sean.wang@mediatek.com, long.cheng@mediatek.com,
        wenbin.mei@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-8-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220729104441.39177-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 29.07.2022 12:44, AngeloGioacchino Del Regno wrote:
> Add a basic support for the Sony Xperia M5 (codename "Holly")
> smartphone, powered by a MediaTek Helio X10 SoC.
> 
> This achieves a console boot.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index af362a085a02..72fd683c9264 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
-holly.dtb?

>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> new file mode 100644
> index 000000000000..94d011c4126c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Collabora Ltd
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +/dts-v1/;
> +#include "mt6795.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
Looks unused.

> +
> +/ {
> +	model = "Sony Xperia M5";
> +	compatible = "sony,xperia-m5", "mediatek,mt6795";
sony,holly?

> +	chassis-type = "handset";
> +
> +	aliases {
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x1E800000>;
Lowercase hex in size. Also, doesn't the bootloader fill it in?

> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
Is that true for all devices with this SoC, or..? If so, it may be worth
moving this into mt6795.dtsi.

> +		bl31_secmon_reserved: secmon@43000000 {
memory@, everywhere. Use labels to name the nodes.

> +			no-map;
reg goes first.
> +			reg = <0 0x43000000 0 0x30000>;
> +		};
> +
> +		/* preloader and bootloader regions cannot be touched */
> +		preloader-region@44800000 {
> +			no-map;
> +			reg = <0 0x44800000 0 0x100000>;
> +		};
> +
> +		bootloader-region@46000000 {
> +			no-map;
> +			reg = <0 0x46000000 0 0x400000>;
> +		};
> +	};
> +};
> +
> +&pio {
> +	uart0_pins: uart0-pins {
> +		pins-rx {
> +			pinmux = <PINMUX_GPIO113__FUNC_URXD0>;
> +			bias-pull-up;
> +			input-enable;
> +		};
> +		pins-tx {
> +			pinmux = <PINMUX_GPIO114__FUNC_UTXD0>;
> +			output-high;
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		pins-rx {
> +			pinmux = <PINMUX_GPIO31__FUNC_URXD2>;
> +			bias-pull-up;
> +			input-enable;
> +		};
> +		pins-tx {
> +			pinmux = <PINMUX_GPIO32__FUNC_UTXD2>;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
Status last here and below, please.

Konrad
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +};
> 
