Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15395AB9FE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Sep 2022 23:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiIBVY7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Sep 2022 17:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIBVY6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Sep 2022 17:24:58 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36F2CDEF;
        Fri,  2 Sep 2022 14:24:54 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11f4e634072so7765215fac.13;
        Fri, 02 Sep 2022 14:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nWfePJvke98pyDOeR3hu3O0BXoprWVwc51YjG9//cHs=;
        b=zkMpc3HheAMNww9d/wSpu9slyjPy/ets05F1kATk3i24ygQuvYRDvESivXdH3Fy8fr
         BG06pD3WbQYxjf2U+UPPXq5ZUBKIf8Qkjim9eknVCJOZwoJtYBmXw1cp0GV3xbkHHQob
         QNjLkYLLE4QZ0GD+E8P4l4ltWH1OxmwoFvTdkIL/hDlpwNw3VhOmDc0uu4kxay104KHP
         pYXZRZH9SrWNN5mzgdK39BqdCw+Z3ogO6lxFdbhsYRdDSFZagoXxSmT0+3wy+7B9IZJL
         9wVOSlLGxMz8bEVjz/bxUVeesicaJFY4GVNffE47w98MCVZk9yZ7NjLq6woNdZdH1yO1
         LhoA==
X-Gm-Message-State: ACgBeo3L/G27h/+O8rAEdygX/vwztJe4l5EQiPNYPjWbGJOynSXzE/uu
        dKD0qMS2euMLl9Hf4daGsQ==
X-Google-Smtp-Source: AA6agR6B1rjNr3cQUwoF3dgojbI+towcP+9EwdL045VRc7rJZ2wd6bdRwfHCrr2x+XvmBO51inRMvg==
X-Received: by 2002:a05:6870:4283:b0:122:5a99:f28a with SMTP id y3-20020a056870428300b001225a99f28amr3172579oah.55.1662153893278;
        Fri, 02 Sep 2022 14:24:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 101-20020a9d086e000000b0063696cbb6bdsm1524214oty.62.2022.09.02.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:24:52 -0700 (PDT)
Received: (nullmailer pid 440221 invoked by uid 1000);
        Fri, 02 Sep 2022 21:24:52 -0000
Date:   Fri, 2 Sep 2022 16:24:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     krzysztof.kozlowski@linaro.org, shengjiu.wang@nxp.com,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Message-ID: <20220902212452.GA419590-robh@kernel.org>
References: <20220901015926.50082-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901015926.50082-1-joy.zou@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 01, 2022 at 09:59:26AM +0800, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format usingjson-schema.
> 
> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
> fsl,imx50-sdma,fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The original

space            ^

> binding don't list all compatible used.
> 
> In addition, add new peripheral types HDMI Audio.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes since (implicit) v3:
> modify the commit message in patch v4.
> delete the quotes in patch v4.
> modify the compatible in patch v4.
> delete maxitems and add items for clock-names property in patch v4.
> add iram property in patch v4.
> ---
>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 143 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 ---------------
>  2 files changed, 143 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> new file mode 100644
> index 000000000000..18b31758cc67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,imx-sdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> +
> +maintainers:
> +  - Joy Zou <joy.zou@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx50-sdma
> +              - fsl,imx51-sdma
> +              - fsl,imx53-sdma
> +              - fsl,imx6q-sdma
> +              - fsl,imx7d-sdma
> +          - const: fsl,imx35-sdma
> +      - items:
> +          - enum:
> +              - fsl,imx6sx-sdma
> +              - fsl,imx6sl-sdma
> +          - const: fsl,imx6q-sdma
> +      - items:
> +          - const: fsl,imx6ul-sdma
> +          - const: fsl,imx6q-sdma
> +          - const: fsl,imx35-sdma
> +      - items:
> +          - const: fsl,imx6sll-sdma
> +          - const: fsl,imx6ul-sdma
> +      - items:
> +          - const: fsl,imx8mq-sdma
> +          - const: fsl,imx7d-sdma
> +      - items:
> +          - enum:
> +              - fsl,imx8mp-sdma
> +              - fsl,imx8mn-sdma
> +              - fsl,imx8mm-sdma
> +          - const: fsl,imx8mq-sdma
> +      - items:
> +          - enum:
> +              - fsl,imx25-sdma
> +              - fsl,imx31-sdma
> +              - fsl,imx35-sdma
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,sdma-ram-script-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Should contain the full path of SDMA RAM scripts firmware.
> +
> +  "#dma-cells":
> +    const: 3
> +    description: |
> +      The first cell: request/event ID
> +
> +      The second cell: peripheral types ID
> +        enum:
> +          - MCU domain SSI: 0
> +          - Shared SSI: 1
> +          - MMC: 2
> +          - SDHC: 3
> +          - MCU domain UART: 4
> +          - Shared UART: 5
> +          - FIRI: 6
> +          - MCU domain CSPI: 7
> +          - Shared CSPI: 8
> +          - SIM: 9
> +          - ATA: 10
> +          - CCM: 11
> +          - External peripheral: 12
> +          - Memory Stick Host Controller: 13
> +          - Shared Memory Stick Host Controller: 14
> +          - DSP: 15
> +          - Memory: 16
> +          - FIFO type Memory: 17
> +          - SPDIF: 18
> +          - IPU Memory: 19
> +          - ASRC: 20
> +          - ESAI: 21
> +          - SSI Dual FIFO: 22
> +              description: needs firmware more than ver 2
> +          - Shared ASRC: 23
> +          - SAI: 24
> +          - HDMI Audio: 25
> +
> +       The third cell: transfer priority ID
> +         enum:
> +           - High: 0
> +           - Medium: 1
> +           - Low: 2
> +
> +  gpr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the General Purpose Register (GPR) node
> +
> +  fsl,sdma-event-remap:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      - description: The GPR register offset, shift and value for RX
> +      - description: The GPR register offset, shift and value for TX

This doesn't fully define the matrix. You need something like this:

maxItems: 2
items:
  items:
    - description: GPR register offset
    - description: GPR register shift
    - description: GPR register value

> +    description: |
> +      Register bits of sdma event remap, the format is <reg shift val>.

And add the order is RX then TX.

> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ahb
> +
> +  iram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the On-chip RAM (OCRAM) node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,sdma-ram-script-name
> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sdma: dma-controller@83fb0000 {
> +      compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
> +      reg = <0x83fb0000 0x4000>;
> +      interrupts = <6>;
> +      #dma-cells = <3>;
> +      fsl,sdma-ram-script-name = "sdma-imx51.bin";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> deleted file mode 100644
> index 12c316ff4834..000000000000
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ /dev/null
> @@ -1,118 +0,0 @@
> -* Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> -
> -Required properties:
> -- compatible : Should be one of
> -      "fsl,imx25-sdma"
> -      "fsl,imx31-sdma", "fsl,imx31-to1-sdma", "fsl,imx31-to2-sdma"
> -      "fsl,imx35-sdma", "fsl,imx35-to1-sdma", "fsl,imx35-to2-sdma"
> -      "fsl,imx51-sdma"
> -      "fsl,imx53-sdma"
> -      "fsl,imx6q-sdma"
> -      "fsl,imx7d-sdma"
> -      "fsl,imx6ul-sdma"
> -      "fsl,imx8mq-sdma"
> -      "fsl,imx8mm-sdma"
> -      "fsl,imx8mn-sdma"
> -      "fsl,imx8mp-sdma"
> -  The -to variants should be preferred since they allow to determine the
> -  correct ROM script addresses needed for the driver to work without additional
> -  firmware.
> -- reg : Should contain SDMA registers location and length
> -- interrupts : Should contain SDMA interrupt
> -- #dma-cells : Must be <3>.
> -  The first cell specifies the DMA request/event ID.  See details below
> -  about the second and third cell.
> -- fsl,sdma-ram-script-name : Should contain the full path of SDMA RAM
> -  scripts firmware
> -
> -The second cell of dma phandle specifies the peripheral type of DMA transfer.
> -The full ID of peripheral types can be found below.
> -
> -	ID	transfer type
> -	---------------------
> -	0	MCU domain SSI
> -	1	Shared SSI
> -	2	MMC
> -	3	SDHC
> -	4	MCU domain UART
> -	5	Shared UART
> -	6	FIRI
> -	7	MCU domain CSPI
> -	8	Shared CSPI
> -	9	SIM
> -	10	ATA
> -	11	CCM
> -	12	External peripheral
> -	13	Memory Stick Host Controller
> -	14	Shared Memory Stick Host Controller
> -	15	DSP
> -	16	Memory
> -	17	FIFO type Memory
> -	18	SPDIF
> -	19	IPU Memory
> -	20	ASRC
> -	21	ESAI
> -	22	SSI Dual FIFO	(needs firmware ver >= 2)
> -	23	Shared ASRC
> -	24	SAI
> -
> -The third cell specifies the transfer priority as below.
> -
> -	ID	transfer priority
> -	-------------------------
> -	0	High
> -	1	Medium
> -	2	Low
> -
> -Optional properties:
> -
> -- gpr : The phandle to the General Purpose Register (GPR) node.
> -- fsl,sdma-event-remap : Register bits of sdma event remap, the format is
> -  <reg shift val>.
> -    reg is the GPR register offset.
> -    shift is the bit position inside the GPR register.
> -    val is the value of the bit (0 or 1).
> -
> -Examples:
> -
> -sdma@83fb0000 {
> -	compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
> -	reg = <0x83fb0000 0x4000>;
> -	interrupts = <6>;
> -	#dma-cells = <3>;
> -	fsl,sdma-ram-script-name = "sdma-imx51.bin";
> -};
> -
> -DMA clients connected to the i.MX SDMA controller must use the format
> -described in the dma.txt file.
> -
> -Examples:
> -
> -ssi2: ssi@70014000 {
> -	compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> -	reg = <0x70014000 0x4000>;
> -	interrupts = <30>;
> -	clocks = <&clks 49>;
> -	dmas = <&sdma 24 1 0>,
> -	       <&sdma 25 1 0>;
> -	dma-names = "rx", "tx";
> -	fsl,fifo-depth = <15>;
> -};
> -
> -Using the fsl,sdma-event-remap property:
> -
> -If we want to use SDMA on the SAI1 port on a MX6SX:
> -
> -&sdma {
> -	gpr = <&gpr>;
> -	/* SDMA events remap for SAI1_RX and SAI1_TX */
> -	fsl,sdma-event-remap = <0 15 1>, <0 16 1>;
> -};
> -
> -The fsl,sdma-event-remap property in this case has two values:
> -- <0 15 1> means that the offset is 0, so GPR0 is the register of the
> -SDMA remap. Bit 15 of GPR0 selects between UART4_RX and SAI1_RX.
> -Setting bit 15 to 1 selects SAI1_RX.
> -- <0 16 1> means that the offset is 0, so GPR0 is the register of the
> -SDMA remap. Bit 16 of GPR0 selects between UART4_TX and SAI1_TX.
> -Setting bit 16 to 1 selects SAI1_TX.
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
