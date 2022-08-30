Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580F5A5EB0
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH3Iyh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiH3Iyg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 04:54:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF43DBED
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 01:54:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m2so10810082lfp.11
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=IMw4JArBn4ymteNHpz0WLIXGL5BOlZDMP6Z8aZ5GIeQ=;
        b=z8c8/mLeQK3JexEL4YnEXidIRLofaU4et/G3D9Jk6RT8H22Ui5O3Ev08ZPBniW5FNW
         qANqs4aGDk++u9SRe/t8cOThhFT3EOqB3ELK2cb+rFdyFRVztpce8+IZG63BQYsETdDz
         or0XJhkGVKaOK9nNC3MPPPSMzdJ6+K0MROeUHeSCfAxaK2bIHYGXVyks6QX/LA309QGl
         n7tCmU9R7S4IH8ix/JQoxIT8zhGMg1nTQdwAIyOyKAfUN1/zOgdGG5lN5z/CstmA+dEZ
         W1ON44dZbPr08lUPO7mPGy2Ij4HqED+F3oLOID0XaCDNRvTvuOLS8fjJMyikrs/y53i9
         yuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IMw4JArBn4ymteNHpz0WLIXGL5BOlZDMP6Z8aZ5GIeQ=;
        b=GN6Wmr1ecQ1wfB/nBlXbzHqRyNuA4CYSXxVF2QWFcaTeCpY5vQmqFIboR03XmcS2HC
         /cn5+QtvOISikhc4v2xHI+msOLdLnOkIMLx8VfsvOWsgyRFK1460cy/Tu8NWnlHv+dDI
         67tc5MV8Iwb1OhWQH5aR8GSa1tixdnslNDRMwAFN5CNAbS2T9N+WOTfPQN+9kdVYbSWp
         ovxUbnDCZor7GZmsJxmJlXN1HSvnWoAc7NwNhhmZY8KcSUHVtqg8CnB346C+NoRtbSln
         IY+WZwPpJfKLiDrtqIu74pPBazOQl9ZUR8Df6oUUqlzFmbwuPEjDGYcCwRehEVry4kqa
         7ZiA==
X-Gm-Message-State: ACgBeo0tIhZyZXasFIphV00HfLwX4wb6cfV69w9YRKEHhEx5/2TTIaSi
        DLhjxCVHn/JNVmM8hV46GVm56g==
X-Google-Smtp-Source: AA6agR61sFeF3pDiNE7U01TZbVDXzBRLDwyl1TBBiDItl96Zw2jfLyBjGDZEJxLkukOToiJLOfRHZw==
X-Received: by 2002:a05:6512:68f:b0:492:cbb1:c4b2 with SMTP id t15-20020a056512068f00b00492cbb1c4b2mr8041801lfe.130.1661849672401;
        Tue, 30 Aug 2022 01:54:32 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bx37-20020a05651c19a500b00263a62baf3csm1049705ljb.51.2022.08.30.01.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:54:31 -0700 (PDT)
Message-ID: <98c8ef73-56d1-8f01-df4e-428b74ade202@linaro.org>
Date:   Tue, 30 Aug 2022 11:54:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>
Cc:     shengjiu.wang@nxp.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220830081839.1201720-1-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830081839.1201720-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30/08/2022 11:18, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using
> json-schema. In addition, add new peripheral types HDMI
> Audio.

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> when run dtbs_check will occur nodename not match issue
> because the old dts nodename can't match new rule. I have
> modified thoes old dts, and will upstream in the near future.

Please send it with this series.

> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes since (implicit) v2:
> modify the commit message in patch v3.
> modify the filename in patch v3.
> modify the maintainer in patch v3.
> delete the unnecessary comment in patch v3.
> modify the compatible and run dt_binding_check and
> dtbs_check in patch v3.
> add clocks and clock-names property in patch v3.
> delete the reg description and add maxItems in patch v3.
> delete the interrupts description and add maxItems in patch v3.
> add ref for gpr property.
> modify the fsl,sdma-event-remap ref type and add items
> in patch v3.
> delete consumer example in patch v3.
> ---
>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 142 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 ---------------
>  2 files changed, 142 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> new file mode 100644
> index 000000000000..54cd99ae127f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> @@ -0,0 +1,142 @@
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
> +allOf:
> +  - $ref: "dma-controller.yaml#"

Drop the quotes.

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

What happened to fsl,imx35-to1-sdma and others? This does not look like
pure conversion and your commit msg did not explain differences to the
binding.

> +      - items:
> +          - enum:
> +              - fsl,imx6sx-sdma
> +              - fsl,imx6ul-sdma
> +              - fsl,imx6sl-sdma
> +          - const: fsl,imx6q-sdma

All this also differ from original binding, so describe the reason
behind the changes.

> +      - items:
> +          - const: fsl,imx6ul-sdma
> +          - const: fsl,imx6q-sdma
> +          - const: fsl,imx35-sdma

You have fsl,imx6ul-sdma above so this is duplicating stuff. I am sorry
but this looks very odd.


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
> +          - const: fsl,imx25-sdma
> +      - items:
> +          - const: fsl,imx31-sdma
> +      - items:
> +          - const: fsl,imx35-sdma

All these three last entries are not "items", but one enum.

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
> +    description: |
> +      Register bits of sdma event remap, the format is <reg shift val>.
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    maxItems: 2

You need to list the items and if they are non-obvious also describe
them in clocks.

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

Include such text in fsl,sdma-event-remap description.

Best regards,
Krzysztof
