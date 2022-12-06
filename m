Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29C8643EAA
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 09:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiLFIcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Dec 2022 03:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiLFIc1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Dec 2022 03:32:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999411AF12
        for <dmaengine@vger.kernel.org>; Tue,  6 Dec 2022 00:32:20 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn5so16415033ljb.2
        for <dmaengine@vger.kernel.org>; Tue, 06 Dec 2022 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/U0+bRA30/guCjp3BjPsilCOo26Q3nbofGjk/PAYTc=;
        b=lX64SB0AHg+zC6GCkwFDi3a/DgyIdNKjjPyFEkcPIndhQtcDMtI2HSEpfEdMIEkqBS
         AaLFtGuGsXA4oywVHcNJmgvU9gAtdbuleQ39BhLTRfWHOY5IxmQ2TqOV+QC8pZlXc5mZ
         npSqljv47Z+Pyj1GgvgIujBC2PQW/BVYnBK2HD4YR1zTQGvBdWn1e31Wx+r/rXcw0EWi
         XFq3nELeXTi5gKPzgvc1pHOPsf79eJPIlH9BczTM1iGHdFZI1abKp5nezCzBet1Zs4rR
         zgztbIYEZ11Tj4F7Vd09Rziw56fQWVajZO+GmBbAub1Qp5LohUgxZ2BGGKS5ay5xL+Ow
         000A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/U0+bRA30/guCjp3BjPsilCOo26Q3nbofGjk/PAYTc=;
        b=Qtug4KzQ70c6OKTzNfSsVx7bmA770LQYKxGdYXhZ7evXKM1uu+Fu4CZdbn7NZjJpoc
         YV2JYL4lVRrcBgVcXJDYnrUi7o5CgmlYXcb/HBA93yYrG0ttMKPORFqDmPcUU0JbGjxC
         LO33/8VRxZ2uQZMoxTv2+aZHNql4iDEySTefWnfOnel3aX4Qrbure9qyGXr0b0NxquXM
         heq/9xmYyMKQrW/uff/K0lxAW9NyjAl7t4RpH+03VKcmsJHc4hezZWRSLg/wSXe8ir7I
         TaxVoReTX5jEK5YSUswbGOrYtgURHfWrHdBMFtMMULRpTCNVv9F3aVtSnyjyTBki4TtO
         PSfQ==
X-Gm-Message-State: ANoB5pk419c8TIbhT4qXEszL8H07jTGaYMRtr7qt/ybeknCKCeX20zVY
        zhq7aCi/WZ6Bvp95Su7oM0sIQGFc0Y32AsTU8sc=
X-Google-Smtp-Source: AA0mqf4TihAnfhidTWmryUNmodx2rjq7DG2qDLZsA/FbwYTTKb5ZxqFKlPpNGD89VRVGzBppANz9IA==
X-Received: by 2002:a05:651c:1948:b0:277:21c8:aac5 with SMTP id bs8-20020a05651c194800b0027721c8aac5mr22217972ljb.491.1670315538789;
        Tue, 06 Dec 2022 00:32:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be11-20020a05651c170b00b002799b5aa42esm1585784ljb.55.2022.12.06.00.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:32:18 -0800 (PST)
Message-ID: <63e1e565-b1e7-ecfc-009a-ee036108f160@linaro.org>
Date:   Tue, 6 Dec 2022 09:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for
 BCDMA CSI RX
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-2-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221206043554.1521522-2-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/12/2022 05:35, Vignesh Raghavendra wrote:
> AM62A SoC has a dedicated BCDMA that serves Camera Serial Interface
> (CSI) IP. Add new compatible for the same. Unlike system
> BCDMA, this instance only has RX DMA channels and lack TX or block copy
> channel. Thus make those properties optional. Additionally CSI RX has
> independent power domain, add the binding for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 87 ++++++++++++++-----
>  1 file changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index 08627d91e607..d7b5adbb9b2e 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -32,9 +32,66 @@ allOf:
>    - $ref: /schemas/dma/dma-controller.yaml#
>    - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>  

When adding if:then:, please move entire allOf after "required:" part.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,am62a-dmss-bcdma-csirx
> +    then:
> +      properties:
> +        ti,sci-rm-range-bchan: false
> +        ti,sci-rm-range-tchan: false
> +
> +        reg:
> +          maxItems: 3
> +
> +        reg-names:
> +          items:
> +            - const: gcfg
> +            - const: rchanrt
> +            - const: ringrt

With my changes further this can be only "maxItems: 3"

> +
> +      required:
> +        - compatible
> +        - "#dma-cells"
> +        - reg
> +        - reg-names
> +        - msi-parent
> +        - ti,sci
> +        - ti,sci-dev-id
> +        - ti,sci-rm-range-rchan
> +        - power-domains
> +
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 5
> +
> +        reg-names:
> +          items:
> +            - const: gcfg
> +            - const: bchanrt
> +            - const: rchanrt
> +            - const: tchanrt
> +            - const: ringrt

With my changes further this can be only "minItems: 5"

> +
> +      required:
> +        - compatible
> +        - "#dma-cells"
> +        - reg
> +        - reg-names
> +        - msi-parent
> +        - ti,sci
> +        - ti,sci-dev-id
> +        - ti,sci-rm-range-bchan
> +        - ti,sci-rm-range-tchan
> +        - ti,sci-rm-range-rchan
> +
>  properties:
>    compatible:
> -    const: ti,am64-dmss-bcdma
> +    enum:
> +      - ti,am64-dmss-bcdma
> +      - ti,am62a-dmss-bcdma-csirx

Keep some order, e.g. alphabetical. This reduces later conflicts on
simultaneous edits.

>  
>    "#dma-cells":
>      const: 3
> @@ -65,19 +122,13 @@ properties:
>  
>        cell 3: ASEL value for the channel
>  
> -  reg:
> -    maxItems: 5

Keep it here with widest constrains - minItems: 3, maxItems: 5

> -
> -  reg-names:
> -    items:
> -      - const: gcfg
> -      - const: bchanrt
> -      - const: rchanrt
> -      - const: tchanrt
> -      - const: ringrt

Keep the list here with minItems: 3

> -
>    msi-parent: true
>  
> +  power-domains:
> +    description:
> +      Power domain if available
> +    maxItems: 1
> +
>    ti,asel:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: ASEL value for non slave channels
> @@ -115,18 +166,6 @@ properties:
>      items:
>        maximum: 0x3f
>  
> -required:
> -  - compatible
> -  - "#dma-cells"
> -  - reg
> -  - reg-names
> -  - msi-parent
> -  - ti,sci
> -  - ti,sci-dev-id
> -  - ti,sci-rm-range-bchan
> -  - ti,sci-rm-range-tchan
> -  - ti,sci-rm-range-rchan

Keep required here. Customize it if needed in if:then:else.

> -
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

