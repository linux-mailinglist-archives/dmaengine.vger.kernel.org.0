Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EE2D1935
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 20:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgLGTNG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 14:13:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39296 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgLGTNG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 14:13:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id v85so6045707oia.6;
        Mon, 07 Dec 2020 11:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8SHydtJy4B3UMw3R1X7HeF54ElAdK6mKxbhCrnomd5Q=;
        b=kf4DjB58l02T7qrDiBCoWVZ3IiINYjISsLT0HOceyJ7ObkuNgINW6BIOMfytlgWYhe
         a8f+G5SfgqYws2Gqk6yjBJTPeyvpBWfUC/jPMvxI3K+eGUDTVfKvAeQqsTRHYowSlPme
         kUlT7dXyX8Wy5vdyFS9GyP5R4Qd9QJJwL68erDx8vAeDs9ZnIuJI7ctCCA3C3GRn2iP9
         xuP/S8tTOUhQbEbyoEqsRrq8hyL1VPVhTHmDFYJtW+ru6PkZPs0ZVBVMt3CGU5m88PEB
         qXF3S61ZJ1N9OOi7dKEWwp1deCt+lYwo0O/36Pk0k0HtfVJIwot26I/3PEGBmVvDC1GF
         qiFw==
X-Gm-Message-State: AOAM532QSK5EI12Dd7hc236KRQa7GvlYPbpbqEdbE+fak/PDbdSwFVp0
        +JWKCpLfpWeWNMNX05Y1Gw==
X-Google-Smtp-Source: ABdhPJxgi/17L27QdomEpugFdHxI2nUtjU+HIG03xT2QjHS4m2+jGomkvAidntLme6xWFNc1IL3xow==
X-Received: by 2002:aca:5291:: with SMTP id g139mr229980oib.63.1607368344472;
        Mon, 07 Dec 2020 11:12:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z14sm476443oot.5.2020.12.07.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:12:23 -0800 (PST)
Received: (nullmailer pid 643080 invoked by uid 1000);
        Mon, 07 Dec 2020 19:12:22 -0000
Date:   Mon, 7 Dec 2020 13:12:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: Convert Qualcomm ADM bindings to
 yaml
Message-ID: <20201207191222.GA629533@robh.at.kernel.org>
References: <20201115181242.GA30004@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115181242.GA30004@earth.li>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Nov 15, 2020 at 06:12:42PM +0000, Jonathan McDowell wrote:
> Converts the device tree bindings for the Qualcomm Application Data
> Mover (ADM) DMA controller over to YAML schemas.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> ---
>  .../devicetree/bindings/dma/qcom,adm.yaml     | 102 ++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_adm.txt      |  61 -----------
>  2 files changed, 102 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,adm.yaml b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
> new file mode 100644
> index 000000000000..353d85d3326d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/qcom,adm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM ADM DMA Controller
> +
> +maintainers:
> +  - Jonathan McDowell <noodles@earth.li>
> +
> +description: |
> +  QCOM Application Data Mover (ADM) DMA controller found in the MSM8x60
> +  and IPQ/APQ8064 platforms.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,adm

Needs SoC specific compatible(s).

> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Address range for DMA registers

Drop description. Doesn't really add anything specific to this binding.

> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Should contain one interrupt shared by all channels

Drop.

> +
> +  "#dma-cells":
> +    const: 2
> +    description:
> +      First cell denotes the channel number.  Second cell denotes CRCI
> +      (client rate control interface) flow control assignment. If no
> +      flow control is required, use 0.
> +
> +  clocks:
> +    maxItems: 2
> +    description:
> +      Should contain the core clock and interface clock.
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +
> +  resets:
> +    maxItems: 4
> +    description:
> +      Must contain an entry for each entry in reset names.
> +
> +  reset-names:
> +    items:
> +      - const: clk
> +      - const: c0
> +      - const: c1
> +      - const: c2
> +
> +  qcom,ee:
> +    maxItems: 1

maxItems is for arrays and this is a scalar.

> +    description:
> +      Indicates the security domain identifier used in the secure world.

How do I get 'ee' from this? Is this something other QCom blocks need?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - "#dma-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - qcom,ee
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/qcom,gcc-ipq806x.h>
> +
> +    adm_dma: dma@18300000 {

Drop unused labels.

> +             compatible = "qcom,adm";
> +             reg = <0x18300000 0x100000>;
> +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +             #dma-cells = <2>;
> +
> +             clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
> +             clock-names = "core", "iface";
> +
> +             resets = <&gcc ADM0_RESET>,
> +                      <&gcc ADM0_C0_RESET>,
> +                      <&gcc ADM0_C1_RESET>,
> +                      <&gcc ADM0_C2_RESET>;
> +             reset-names = "clk", "c0", "c1", "c2";
> +             qcom,ee = <0>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/dma/qcom_adm.txt b/Documentation/devicetree/bindings/dma/qcom_adm.txt
> deleted file mode 100644
> index 9d3b2f917b7b..000000000000
> --- a/Documentation/devicetree/bindings/dma/qcom_adm.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -QCOM ADM DMA Controller
> -
> -Required properties:
> -- compatible: must contain "qcom,adm" for IPQ/APQ8064 and MSM8960
> -- reg: Address range for DMA registers
> -- interrupts: Should contain one interrupt shared by all channels
> -- #dma-cells: must be <2>.  First cell denotes the channel number.  Second cell
> -  denotes CRCI (client rate control interface) flow control assignment.
> -- clocks: Should contain the core clock and interface clock.
> -- clock-names: Must contain "core" for the core clock and "iface" for the
> -  interface clock.
> -- resets: Must contain an entry for each entry in reset names.
> -- reset-names: Must include the following entries:
> -  - clk
> -  - c0
> -  - c1
> -  - c2
> -- qcom,ee: indicates the security domain identifier used in the secure world.
> -
> -Example:
> -		adm_dma: dma@18300000 {
> -			compatible = "qcom,adm";
> -			reg = <0x18300000 0x100000>;
> -			interrupts = <0 170 0>;
> -			#dma-cells = <2>;
> -
> -			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
> -			clock-names = "core", "iface";
> -
> -			resets = <&gcc ADM0_RESET>,
> -				<&gcc ADM0_C0_RESET>,
> -				<&gcc ADM0_C1_RESET>,
> -				<&gcc ADM0_C2_RESET>;
> -			reset-names = "clk", "c0", "c1", "c2";
> -			qcom,ee = <0>;
> -		};
> -
> -DMA clients must use the format descripted in the dma.txt file, using a three
> -cell specifier for each channel.
> -
> -Each dmas request consists of 3 cells:
> - 1. phandle pointing to the DMA controller
> - 2. channel number
> - 3. CRCI assignment, if applicable.  If no CRCI flow control is required, use 0.
> -    The CRCI is used for flow control.  It identifies the peripheral device that
> -    is the source/destination for the transferred data.
> -
> -Example:
> -
> -	spi4: spi@1a280000 {
> -		spi-max-frequency = <50000000>;
> -
> -		pinctrl-0 = <&spi_pins>;
> -		pinctrl-names = "default";
> -
> -		cs-gpios = <&qcom_pinmux 20 0>;
> -
> -		dmas = <&adm_dma 6 9>,
> -			<&adm_dma 5 10>;
> -		dma-names = "rx", "tx";
> -	};
> -- 
> 2.29.2
> 
