Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3C5AE603
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiIFK4I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbiIFKzq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 06:55:46 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894C31EE4;
        Tue,  6 Sep 2022 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662461718; x=1693997718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4jAcprb4ri56XwdsGMJfbSSgoRuiMSLAeqNznvvMxM=;
  b=bO06tk8L77nHOkSiF7+KzOzJYRWBo8trjn3Zqvkaa06o5fJRyo07KMtF
   zRjpAvjKMQh1zj3viPZKj9Rykdb/bTRlNx9b77aLxzUXgUKhKkmdryyXS
   42dVb1oultmR9HMvlsqcDgW+BMkys0S+/6sY7fV9IecrHQc5bkENvnWsP
   InU+ggAj8T65r/HFCkArSvbGvMzR+zXH/NcSQikGbbpXAQmv19LElA+Yq
   ffZe1qC5JowwoytmZQeQw9Krr3E5f6VkxZFMol163AVjV0pKWGrFrzU7f
   cj8up8g7kjRWVlMdSPx0Q+wVP5BxevLc4dYin2sh3lACqT3ly9YCRTdSJ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654552800"; 
   d="scan'208";a="26013587"
X-URL-LookUp-ScanningError: 1
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Sep 2022 12:55:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 06 Sep 2022 12:55:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 06 Sep 2022 12:55:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662461715; x=1693997715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4jAcprb4ri56XwdsGMJfbSSgoRuiMSLAeqNznvvMxM=;
  b=qfw+9Yyx3BbLGP8RJrySNN4zJ6J0XGTzSJU6SCSLlkiO0ASqash1r7CQ
   hwiQ6FE0FOp9ak3T5smSN0lT3xozFkHmtnAjM1cRMI0N/uP+V0xJ//m3X
   +aXZ5PB99sW6VrWkbUM5bzAt159rTpFp669twCKmbMAvScUaiohcwSDuK
   LMVVQhrD5wqnTBX3GIpiFU5Q8fDVrI6lnHTnyLfGoeuBJvOlLJ4ng5VKn
   dMIh+FMZ0/Nxk4+isest9+Yk5LI0dG/NPBf7SjchpbtbZ+jufG4k1A+QT
   zYCsv6H8FaOdY/6lAgayIjDM2qDkd8gKSLkbLktUxiTP3XOYVJLDzn9NI
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654552800"; 
   d="scan'208";a="26013586"
X-URL-LookUp-ScanningError: 1
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Sep 2022 12:55:15 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0F693280056;
        Tue,  6 Sep 2022 12:55:15 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        peng.fan@nxp.com, david@ixit.cz, aford173@gmail.com,
        hongxing.zhu@nxp.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Tue, 06 Sep 2022 12:55:12 +0200
Message-ID: <4743969.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220906094256.3787384-2-joy.zou@nxp.com>
References: <20220906094256.3787384-1-joy.zou@nxp.com> <20220906094256.3787384-2-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

thanks for the YAML conversion patch.

Am Dienstag, 6. September 2022, 11:42:53 CEST schrieb Joy Zou:
> Convert the i.MX SDMA binding to DT schema format using json-schema.
> 
> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
> fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The
> original binding don't list all compatible used.
> 
> In addition, add new peripheral types HDMI Audio.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v6:
> delete tag Acked-by from commit message.
> 
> Changes in v5:
> modify the commit message fromat.
> add additionalProperties, because delete the quotes in patch v4.
> delete unevaluatedProperties due to similar to additionalProperties.
> modification fsl,sdma-event-remap items and description.
> 
> Changes in v4:
> modify the commit message.
> delete the quotes in patch.
> modify the compatible in patch.
> delete maxitems and add items for clock-names property.
> add iram property.
> 
> Changes in v3:
> modify the commit message.
> modify the filename.
> modify the maintainer.
> delete the unnecessary comment.
> modify the compatible and run dt_binding_check and dtbs_check.
> add clocks and clock-names property.
> delete the reg description and add maxItems.
> delete the interrupts description and add maxItems.
> add ref for gpr property.
> modify the fsl,sdma-event-remap ref type and add items.
> delete consumer example.
> 
> Changes in v2:
> convert imx sdma bindings to DT schema.
> ---
>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
>  2 files changed, 147 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml new file mode
> 100644
> index 000000000000..3da65d3ea4af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> @@ -0,0 +1,147 @@
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

Is it sensible to add something like this?

  $nodename:
    pattern: "^dma-controller(@.*)?$"

You are changing the node names in patch 3 anyway.

Best regards,
Alexander

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
> +    maxItems: 2
> +    items:
> +      items:
> +        - description: GPR register offset
> +        - description: GPR register shift
> +        - description: GPR register value
> +    description: |
> +      Register bits of sdma event remap, the format is <reg shift val>.
> +      The order is <RX>, <TX>.
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
> +additionalProperties: false
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
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt deleted file mode
> 100644
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
> -  correct ROM script addresses needed for the driver to work without
> additional -  firmware.
> -- reg : Should contain SDMA registers location and length
> -- interrupts : Should contain SDMA interrupt
> -- #dma-cells : Must be <3>.
> -  The first cell specifies the DMA request/event ID.  See details below
> -  about the second and third cell.
> -- fsl,sdma-ram-script-name : Should contain the full path of SDMA RAM
> -  scripts firmware
> -
> -The second cell of dma phandle specifies the peripheral type of DMA
> transfer. -The full ID of peripheral types can be found below.
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




