Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1E2C2DD0
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbgKXRHZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390345AbgKXRHY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:24 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E7620715;
        Tue, 24 Nov 2020 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606237643;
        bh=3A0orJ4E1dOTRPI9W6zjPzDHp40NITzySDDGtNNr7cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zlw8qdgPbwZ9c/V7USQ2d89jJoRbcqu4EwyQiifk/+TcMRCuJFhhm4Z9v62TVCocB
         qJsy9XsnVpEOyGV4R223nXuyWcxMg1v9kPd2ZEi6HDiSTCl8FyEsAo8V5tOuz087/x
         E29SlN4Ldm2yjdXv6jreo/kvEY1uZBLnsPtAvncE=
Date:   Tue, 24 Nov 2020 22:37:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: Convert Qualcomm ADM bindings to
 yaml
Message-ID: <20201124170719.GQ8403@vkoul-mobl>
References: <20201115181242.GA30004@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115181242.GA30004@earth.li>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-11-20, 18:12, Jonathan McDowell wrote:
> Converts the device tree bindings for the Qualcomm Application Data
> Mover (ADM) DMA controller over to YAML schemas.

Rob ?

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
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Address range for DMA registers
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Should contain one interrupt shared by all channels
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
> +    description:
> +      Indicates the security domain identifier used in the secure world.
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

-- 
~Vinod
