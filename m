Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5AC5326C2
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiEXJqq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiEXJqp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 05:46:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34752CE24
        for <dmaengine@vger.kernel.org>; Tue, 24 May 2022 02:46:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u23so29920605lfc.1
        for <dmaengine@vger.kernel.org>; Tue, 24 May 2022 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IMbxClHWPS03PbbitBq3EQjBaeTdpKNatYW1zH8rzVo=;
        b=YHoPt3HgNPBuYbbTNSRtINqeAZgMQZGvk+Za2ftRzKkNR9F9TWpSdCLuDANiVg4Ha5
         HlebbofUvH/fLuZbeMQf0JsfDkjNoZfqiR56opCYbjizHVYfPHHBXmbNXPMFRW+AuNlo
         xgaP/P2zVxyM8M0vuMHEdVM6b1ZV4L773kW3vlt7onYfpkCLa8yHzER9NeB0QxlTS6/m
         VwIDL8qnKLc/t2L1mpbtzn7Vv5VTcPDN6XE/LizsVC9VoIdYRqe7kuoMgnEC3PWyVvtk
         zj2TohBH9rkF2xAPJzaRBkQSyqluadvDmaDntru1tLs9PrsNVrd9JyKqeiIZpjP3FSCA
         fzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IMbxClHWPS03PbbitBq3EQjBaeTdpKNatYW1zH8rzVo=;
        b=azOlJNG3DLHLYajxA3GXcifYOr5Juzf05ek7Uf63Qqemm8Ooig2o5w5Qz8WZU97v9z
         G8emznM7juZv2pMy0UQJ8hzAM+SCVRp8hTPfh8PJcqq8xvV5TqNff11hHa+TG9ZPBsk1
         hAVvqjXDy26bZeWFzRy1ujck5ca//NSPjurjPnngFF+PSOiur9Pf0IWBnzotsb75rKKK
         E8PIXadadMWYSYc6LEzxSED3oCIp17foU+yIeO8/A5lfpbMwnv0XTnsn++ZPd7iff8qQ
         tHeJLHSwZeo/0aiJlZnjUU9+yo0/1RMfEZ2oAA9o3+Lq+u5HVYykwJRu8tY4YqKRQ/vz
         QgGQ==
X-Gm-Message-State: AOAM533xZt627iMYq4yGfxnujGPbO84s9ugE7OaXAiIkzdCbWL8R6OW0
        XF4U3KlrI0EN2J0B6cP8SLHK5g==
X-Google-Smtp-Source: ABdhPJxYev9XNLxFP7wwILeL72uQun1SCV/fVs8X5/P+XotqeyeO0wiY2eMv6f5dNGdPO9WpfO3cZA==
X-Received: by 2002:a05:6512:12c6:b0:477:990f:f56e with SMTP id p6-20020a05651212c600b00477990ff56emr18743357lfg.249.1653385602190;
        Tue, 24 May 2022 02:46:42 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25111000000b0047861cba7bdsm1613359lfb.53.2022.05.24.02.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:46:41 -0700 (PDT)
Message-ID: <cbaf3536-d89d-08cf-1f47-d298ee11a80e@linaro.org>
Date:   Tue, 24 May 2022 11:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220524080337.1322240-1-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524080337.1322240-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24/05/2022 10:03, Joy Zou wrote:
> Add HDMI Audio transfer type.
> 
> convert the sdma bindings txt into yaml in v2.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes since v1:
> convert the sdma bindings txt into yaml in v2.
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.yaml | 135 ++++++++++++++++++

There is no conversion here, only new file...

>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml
> new file mode 100644
> index 000000000000..5b4f7a09a395
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml

Filename: fsl,imx-sdma.yaml

> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl-imx-sdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>

This should not be subsystem maintainer but someone closer to the actual
device.

> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +# Everything else is described in the common file

Skip the comment please.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx25-sdma
> +          - fsl,imx31-sdma
> +          - fsl,imx31-to1-sdma
> +          - fsl,imx31-to2-sdma
> +          - fsl,imx35-to1-sdma
> +          - fsl,imx35-to2-sdma
> +          - fsl,imx51-sdma
> +          - fsl,imx53-sdma
> +          - fsl,imx6q-sdma
> +          - fsl,imx7d-sdma
> +          - fsl,imx6sx-sdma
> +          - fsl,imx6ul-sdma
> +          - fsl,imx8mm-sdma
> +          - fsl,imx8mn-sdma
> +          - fsl,imx8mp-sdma
> +      - enum:
> +          - fsl,imx35-sdma
> +          - fsl,imx8mq-sdma

No, fallback cannot be variable. I doubt that
fsl,imx25-sdma+fsl,imx8mq-sdma makes any sense!

Additionally, this does not match existing DTS. Please run `make
dtbs_check`.

> +
> +  reg:
> +    description: Should contain SDMA registers location and length

Skip description. Uou need to add maxItems

> +
> +  interrupts:
> +    description: Should contain SDMA interrupt

Skip description. Uou need to add maxItems


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
> +              description: needs firmware more than ver 2> +          - Shared ASRC: 23
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
> +    description: The phandle to the General Purpose Register (GPR) node

type/ref needed

> +
> +  fsl,sdma-event-remap:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Register bits of sdma event remap, the format is <reg shift val>.
> +      - reg: the GPR register offset
> +      - shift: the bit position inside the GPR register
> +      - val: the value of the bit (0 or 1)

Need maxItems or items with description.

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
> +#DMA clients connected to the i.MX SDMA controller must use the format
> +#described in the dma-controller.yaml file.
> +  - |
> +    ssi2: ssi@70014000 {

Skip consumer example, it's obvious.

> +      compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> +      reg = <0x70014000 0x4000>;
> +      interrupts = <30>;
> +      clocks = <&clks 49>;
> +      dmas = <&sdma 24 1 0>,
> +             <&sdma 25 1 0>;
> +      dma-names = "rx", "tx";
> +      fsl,fifo-depth = <15>;
> +    };
> +
> +...


Best regards,
Krzysztof
