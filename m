Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F338534B16
	for <lists+dmaengine@lfdr.de>; Thu, 26 May 2022 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbiEZIBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 May 2022 04:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbiEZIBr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 May 2022 04:01:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9E2982F
        for <dmaengine@vger.kernel.org>; Thu, 26 May 2022 01:01:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h11so852671eda.8
        for <dmaengine@vger.kernel.org>; Thu, 26 May 2022 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nd0aS4XTdk1Zg4grTiu5ttSxSBDZV5Q51FAnuUtF0kE=;
        b=UJ32M+hVRboBmqNhcx1ypbpuPw/R/WvcZBI8hf6IGOtG7cfavIJ1D8Kj4Zr4E/aid+
         g1zSoCKxaiVeeZXmfy+bzcOQI+EFJ384yQpc8qn2/V3a9l7rmrGMMEssjlVJqSJb0ESZ
         J7ba5GFQ9gIpw9RkQZGPqa3PMQPkjwJVmoCmScjNjIW/4DtjWpZWtFkI6wc//wKu5brO
         AVE6pDX7pw9KkSsznTLoLKFlnzqsKjfpxZaLs65/f3+dbmKhauEwjojvE+WtQKOfy8+8
         S9Qaw0oElSaICzcVPgWZItaYQAa6Gu7f/6arwHUy7vZa7MHmkClUcSjtVlJ23wVmZ7Vi
         w5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nd0aS4XTdk1Zg4grTiu5ttSxSBDZV5Q51FAnuUtF0kE=;
        b=HcrzVb+SHcVCkbOTL697p0wET/fsH8FsaQ9/nJc4XKvGozrPDsv/rTsR73wRc+Euos
         SwuBOlQUHVGvKQb5Rqs4VT25YSfqOD90S60W0IR1WPbMG70/pIqWlzmAqkxf0tqRUnCt
         pGRcjvZWdj3+FN8zGbcy1xKSqfUQrnU5X2bBi+eTIQglp1lq85zGxT5q0eV4L2KcIo6L
         KqzghyyWo47MlVZzGz6Rzsy6JjMiwlqW6RxEAwtu3CMyXaCuOtkvzljPnwJ19GliP+3d
         C6x2rDeA2nsq7w/fONGNiqreaZymwpA6aMTD65YuZpZ8JSHUkvUJe46wr2+up9M032uA
         GudA==
X-Gm-Message-State: AOAM532WIFrwNabqX0xcitT+IhdHk7lyZcL/iagj5EpCPMYreDfT255p
        GPIQJ6Gm0mWPncJskub1KaPorQ==
X-Google-Smtp-Source: ABdhPJwYpTZwwXvyTIw2oAbj4OEtV+DLj5T9UYsIzWBazg34v5yPvyzB5xo4pW+oXB5N45wIa3IWsg==
X-Received: by 2002:a05:6402:2995:b0:42a:843f:ac82 with SMTP id eq21-20020a056402299500b0042a843fac82mr38368670edb.370.1653552103549;
        Thu, 26 May 2022 01:01:43 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709065e0400b006feb7b1379dsm270061eju.181.2022.05.26.01.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 01:01:43 -0700 (PDT)
Message-ID: <bf9915ca-29cb-01f3-1124-eb17ba60245e@linaro.org>
Date:   Thu, 26 May 2022 10:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: dma: fsl-edma: Convert to DT schema
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220526035611.4063102-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526035611.4063102-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26/05/2022 05:56, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the eDMA controller binding to DT schema.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 136 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-edma.txt      | 111 --------------
>  2 files changed, 136 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> new file mode 100644
> index 000000000000..dbb69aca7d67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale enhanced Direct Memory Access(eDMA) Controller
> +
> +description: |
> +  The eDMA channels have multiplex capability by programmble

programmable

> +  memory-mapped registers. channels are split into two groups, called
> +  DMAMUX0 and DMAMUX1, specific DMA request source can only be multiplexed
> +  by any channel of certain group, DMAMUX0 or DMAMUX1, but not both.
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,vf610-edma
> +      - const: fsl,imx7ulp-edma

These should be one enum.

> +      - items:
> +          - const: fsl,ls1028a-edma
> +          - const: fsl,vf610-edma
> +
> +  "#dma-cells":
> +    const: 2
> +
> +  dma-channels:
> +    minItems: 32
> +    maxItems: 64
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 65

Old binding mentions only three regions. Why 65?

> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 65

The maxItems look weird here. Shouldn't this be 17? This needs its own
constraints in allOf:if:then per variant.

> +
> +  clocks:
> +    maxItems: 2
> +
> +  big-endian:
> +    description: |
> +      If present registers and hardware scatter/gather descriptors of the
> +      eDMA are implemented in big endian mode, otherwise in little mode.
> +    type: boolean
> +
> +  interrupt-names:
> +    items:
> +      - const: edma-tx
> +      - const: edma-err

Put it next to interrupts.


> +
> +required:
> +  - "#dma-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - dma-channels
> +
> +if:

This should be under allOf and that entire allOf block (with $ref)
should be located here.

> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,imx7ulp-edma
> +then:
> +  properties:
> +    clock-names:
> +      items:
> +        - const: dma
> +        - const: dmamux0
> +else:
> +  properties:
> +    clock-names:
> +      items:
> +        - const: dmamux0
> +        - const: dmamux1
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/vf610-clock.h>
> +
> +    edma0: dma-controller@40018000 {
> +      #dma-cells = <2>;
> +      compatible = "fsl,vf610-edma";
> +      reg = <0x40018000 0x2000>,
> +            <0x40024000 0x1000>,
> +            <0x40025000 0x1000>;
> +      interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
> +                   <0 9 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "edma-tx", "edma-err";
> +      dma-channels = <32>;
> +      clock-names = "dmamux0", "dmamux1";
> +      clocks = <&clks VF610_CLK_DMAMUX0>, <&clks VF610_CLK_DMAMUX1>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx7ulp-clock.h>
> +
> +    edma1: dma-controller@40080000 {
> +      #dma-cells = <2>;
> +      compatible = "fsl,imx7ulp-edma";
> +      reg = <0x40080000 0x2000>,
> +            <0x40210000 0x1000>;
> +      dma-channels = <32>;
> +      interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +                   /* last is eDMA2-ERR interrupt */
> +                   <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +       clock-names = "dma", "dmamux0";
> +       clocks = <&pcc2 IMX7ULP_CLK_DMA1>, <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documentation/devicetree/bindings/dma/fsl-edma.txt
> deleted file mode 100644
> index ee1754739b4b..000000000000
> --- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -* Freescale enhanced Direct Memory Access(eDMA) Controller
> -
> -  The eDMA channels have multiplex capability by programmble memory-mapped
> -registers. channels are split into two groups, called DMAMUX0 and DMAMUX1,
> -specific DMA request source can only be multiplexed by any channel of certain
> -group, DMAMUX0 or DMAMUX1, but not both.
> -
> -* eDMA Controller
> -Required properties:
> -- compatible :
> -	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
> -	- "fsl,imx7ulp-edma" for eDMA2 used similar to that on i.mx7ulp
> -	- "fsl,ls1028a-edma" followed by "fsl,vf610-edma" for eDMA used on the
> -	  LS1028A SoC.
> -- reg : Specifies base physical address(s) and size of the eDMA registers.
> -	The 1st region is eDMA control register's address and size.
> -	The 2nd and the 3rd regions are programmable channel multiplexing
> -	control register's address and size.
> -- interrupts : A list of interrupt-specifiers, one for each entry in
> -	interrupt-names on vf610 similar SoC. But for i.mx7ulp per channel
> -	per transmission interrupt, total 16 channel interrupt and 1
> -	error interrupt(located in the last), no interrupt-names list on
> -	i.mx7ulp for clean on dts.
> -- #dma-cells : Must be <2>.
> -	The 1st cell specifies the DMAMUX(0 for DMAMUX0 and 1 for DMAMUX1).
> -	Specific request source can only be multiplexed by specific channels
> -	group called DMAMUX.
> -	The 2nd cell specifies the request source(slot) ID.
> -	See the SoC's reference manual for all the supported request sources.
> -- dma-channels : Number of channels supported by the controller
> -- clock-names : A list of channel group clock names. Should contain:
> -	"dmamux0" - clock name of mux0 group
> -	"dmamux1" - clock name of mux1 group
> -	Note: No dmamux0 on i.mx7ulp, but another 'dma' clk added on i.mx7ulp.
> -- clocks : A list of phandle and clock-specifier pairs, one for each entry in
> -	clock-names.
> -
> -Optional properties:
> -- big-endian: If present registers and hardware scatter/gather descriptors
> -	of the eDMA are implemented in big endian mode, otherwise in little
> -	mode.
> -- interrupt-names : Should contain the below on vf610 similar SoC but not used
> -	on i.mx7ulp similar SoC:
> -	"edma-tx" - the transmission interrupt
> -	"edma-err" - the error interrupt
> -
> -
> -Examples:
> -
> -edma0: dma-controller@40018000 {
> -	#dma-cells = <2>;
> -	compatible = "fsl,vf610-edma";
> -	reg = <0x40018000 0x2000>,
> -		<0x40024000 0x1000>,
> -		<0x40025000 0x1000>;
> -	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
> -		<0 9 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-names = "edma-tx", "edma-err";
> -	dma-channels = <32>;
> -	clock-names = "dmamux0", "dmamux1";
> -	clocks = <&clks VF610_CLK_DMAMUX0>,
> -		<&clks VF610_CLK_DMAMUX1>;
> -}; /* vf610 */
> -
> -edma1: dma-controller@40080000 {
> -	#dma-cells = <2>;
> -	compatible = "fsl,imx7ulp-edma";
> -	reg = <0x40080000 0x2000>,
> -		<0x40210000 0x1000>;
> -	dma-channels = <32>;
> -	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> -		     /* last is eDMA2-ERR interrupt */
> -		     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -	clock-names = "dma", "dmamux0";
> -	clocks = <&pcc2 IMX7ULP_CLK_DMA1>,
> -		 <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
> -}; /* i.mx7ulp */
> -
> -* DMA clients
> -DMA client drivers that uses the DMA function must use the format described
> -in the dma.txt file, using a two-cell specifier for each channel: the 1st
> -specifies the channel group(DMAMUX) in which this request can be multiplexed,
> -and the 2nd specifies the request source.
> -
> -Examples:
> -
> -sai2: sai@40031000 {
> -	compatible = "fsl,vf610-sai";
> -	reg = <0x40031000 0x1000>;
> -	interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
> -	clock-names = "sai";
> -	clocks = <&clks VF610_CLK_SAI2>;
> -	dma-names = "tx", "rx";
> -	dmas = <&edma0 0 21>,
> -		<&edma0 0 20>;
> -};


Best regards,
Krzysztof
