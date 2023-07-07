Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154774AAB6
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 07:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGGFpM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGGFpM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 01:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B01FDA;
        Thu,  6 Jul 2023 22:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D402A6172B;
        Fri,  7 Jul 2023 05:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B01CC433C8;
        Fri,  7 Jul 2023 05:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688708706;
        bh=BuNKHQM+AbtEogO//6uIHH2q4jczG+Dn/agtCsQXsPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrXD2QMSGVojNIxOIZARbiT95dYwoiPqpcVoWANrwGbZSxqBmd9/VZK/OLOIH5aH/
         qUZWDXi1fPepzfJnYmnY2jQeBvN02RKS9DdQZgdLD90wFUglNM8t0NvesBPunPBA/t
         UVbnaHIrhZxztiuQWZUiY4xZZM5espZIj9mQPCEUkda7JwVJnlnJc27oOvw1CFkRHf
         3OXT7kJ9Xn1I8sHwhZjqI13JqL6n1mZq1SgB87GMi4T/jK7KsPh934XHctim0Vp9pv
         jBpEJ4hjaftSovpqdH2ofCE8dRwlifiWHi5N5GmHi4fbtXo67YFTpcT42xUoavPsXK
         CfUB0cVjui/8A==
Date:   Fri, 7 Jul 2023 11:15:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, joy.zou@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev
Subject: Re: [PATCH v9 13/13] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Message-ID: <ZKemXv7geMnBQoZI@matsya>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <20230620201221.2580428-14-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620201221.2580428-14-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-23, 16:12, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

This should be patch before it use (which is 12th patch now right)

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 106 ++++++++++++++++--
>  1 file changed, 99 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..437db0c62339 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,32 +21,41 @@ properties:
>        - enum:
>            - fsl,vf610-edma
>            - fsl,imx7ulp-edma
> +          - fsl,imx8qm-adma
> +          - fsl,imx8qm-edma
> +          - fsl,imx93-edma3
> +          - fsl,imx93-edma4
>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
>  
>    reg:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 3
>  
>    interrupts:
> -    minItems: 2
> -    maxItems: 17
> +    minItems: 1
> +    maxItems: 64
>  
>    interrupt-names:
> -    minItems: 2
> -    maxItems: 17
> +    minItems: 1
> +    maxItems: 64
>  
>    "#dma-cells":
> -    const: 2
> +    enum:
> +      - 2
> +      - 3
>  
>    dma-channels:
> -    const: 32
> +    minItems: 1
> +    maxItems: 64
>  
>    clocks:
> +    minItems: 1
>      maxItems: 2
>  
>    clock-names:
> +    minItems: 1
>      maxItems: 2
>  
>    big-endian:
> @@ -65,6 +74,29 @@ required:
>  
>  allOf:
>    - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-adma
> +              - fsl,imx8qm-edma
> +              - fsl,imx93-edma3
> +              - fsl,imx93-edma4
> +    then:
> +      properties:
> +        "#dma-cells":
> +          const: 3
> +        # It is not necessary to write the interrupt name for each channel.
> +        # instead, you can simply maintain the sequential IRQ numbers as
> +        # defined for the DMA channels.
> +        interrupt-names: false
> +        clock-names:
> +          items:
> +            - const: dma
> +        clocks:
> +          maxItems: 1
> +
>    - if:
>        properties:
>          compatible:
> @@ -72,18 +104,26 @@ allOf:
>              const: fsl,vf610-edma
>      then:
>        properties:
> +        clocks:
> +          minItems: 2
>          clock-names:
>            items:
>              - const: dmamux0
>              - const: dmamux1
>          interrupts:
> +          minItems: 2
>            maxItems: 2
>          interrupt-names:
>            items:
>              - const: edma-tx
>              - const: edma-err
>          reg:
> +          minItems: 2
>            maxItems: 3
> +        "#dma-cells":
> +          const: 2
> +        dma-channels:
> +          const: 32
>  
>    - if:
>        properties:
> @@ -92,14 +132,22 @@ allOf:
>              const: fsl,imx7ulp-edma
>      then:
>        properties:
> +        clock:
> +          minItems: 2
>          clock-names:
>            items:
>              - const: dma
>              - const: dmamux0
>          interrupts:
> +          minItems: 2
>            maxItems: 17
>          reg:
> +          minItems: 2
>            maxItems: 2
> +        "#dma-cells":
> +          const: 2
> +        dma-channels:
> +          const: 32
>  
>  unevaluatedProperties: false
>  
> @@ -153,3 +201,47 @@ examples:
>         clock-names = "dma", "dmamux0";
>         clocks = <&pcc2 IMX7ULP_CLK_DMA1>, <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx93-clock.h>
> +
> +    dma-controller@44000000 {
> +      compatible = "fsl,imx93-edma3";
> +      reg = <0x44000000 0x200000>;
> +      #dma-cells = <3>;
> +      dma-channels = <31>;
> +      interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk IMX93_CLK_EDMA1_GATE>;
> +        clock-names = "dma";
> +    };
> -- 
> 2.34.1

-- 
~Vinod
