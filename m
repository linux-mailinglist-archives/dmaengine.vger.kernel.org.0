Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0176E6F8B
	for <lists+dmaengine@lfdr.de>; Wed, 19 Apr 2023 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjDRWmB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Apr 2023 18:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDRWmA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Apr 2023 18:42:00 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454108A46;
        Tue, 18 Apr 2023 15:41:48 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-54506afdf60so683314eaf.3;
        Tue, 18 Apr 2023 15:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857707; x=1684449707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4erP0VsSx34YeXcErgipr+nd4eR3XtxADF/qUHIhYAg=;
        b=JGqfR63yrqIlh4ujfgCZtyKnXmLIOXs6Y5XyeEHqJPFOuk/BchgEh6T/Blmwas/6v+
         6fIarsNKJHBBTXNOvuoYZFnydP6ZuUuoiHNc+Ktj4XForGOdmOFMjEC2Dy5iLB+28JT4
         Dol0HilwH4pkal6NOkvNpFosYIzsXul1hpMwu65G9jKUOdXTgasfHlPVQkHEwKW9WOSy
         2vo9v/c1amZPXWARqBv/ShWQaWbGYHsQk/RdgZxyHmP/Qg7XulMSQ8SlAnuOOv3u8F+o
         E1MlOFpen1u/aoiKAgbQfWlwpvSA5j/8aQVShRtyGXgxbNKK57KjIfS22OSJoZEe8p5t
         nxGw==
X-Gm-Message-State: AAQBX9fS/PzHx7PlCBTHhPgutYqRyImSSOJ9ZW7sbNbAY6G1mJUUn6KJ
        Ba+SQH2TTFIW5o2qpMTnIA==
X-Google-Smtp-Source: AKy350ZNnMxDWnMjDmUodqaqxOtd7hdDsrTfnCpoppZ4zWEa7VXLHMnr2biukzmVvJcCex7AdC31zw==
X-Received: by 2002:a05:6808:1402:b0:38d:ee6e:235f with SMTP id w2-20020a056808140200b0038dee6e235fmr2430172oiv.47.1681857707478;
        Tue, 18 Apr 2023 15:41:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i11-20020aca3b0b000000b0038c235e24fesm2571828oia.48.2023.04.18.15.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:41:47 -0700 (PDT)
Received: (nullmailer pid 2456811 invoked by uid 1000);
        Tue, 18 Apr 2023 22:41:46 -0000
Date:   Tue, 18 Apr 2023 17:41:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: dma: dma40: Prefer to pass sram through
 phandle
Message-ID: <20230418224146.GA2453289-robh@kernel.org>
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
 <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
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

On Mon, Apr 17, 2023 at 09:55:46AM +0200, Linus Walleij wrote:
> Extend the DMA40 bindings so that we can pass two SRAM
> segments as phandles instead of directly referring to the
> memory address in the second reg cell. This enables more
> granular control over the SRAM, and adds the optiona LCLA
> SRAM segment as well.
> 
> Deprecate the old way of passing LCPA as a second reg cell,
> make sram compulsory.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/dma/stericsson,dma40.yaml  | 35 +++++++++++++++++-----
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 64845347f44d..4fe0df937171 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -112,14 +112,23 @@ properties:
>        - const: stericsson,dma40
>  
>    reg:
> -    items:
> -      - description: DMA40 memory base
> -      - description: LCPA memory base
> +    oneOf:
> +      - items:
> +          - description: DMA40 memory base
> +      - items:
> +          - description: DMA40 memory base
> +          - description: LCPA memory base, deprecated, use eSRAM pool instead
> +        deprecated: true
> +
>  
>    reg-names:
> -    items:
> -      - const: base
> -      - const: lcpa
> +    oneOf:
> +      - items:
> +          - const: base
> +      - items:
> +          - const: base
> +          - const: lcpa
> +        deprecated: true
>  
>    interrupts:
>      maxItems: 1
> @@ -127,6 +136,14 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  sram:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Drop quotes.

> +    items:
> +      maxItems: 2

phandle-array really means phandle+args array. So the inner size is 1 
plus number of arg cells. Since you have no arg cells, that would be:

maxItems: 2
items:
  maxItems: 1

> +    description:
> +      List of phandles for the SRAM used by the DMA40 block, the first
> +      phandle is the LCPA memory, the second is the LCLA memory.
> +
>    memcpy-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: Array of u32 elements indicating which channels on the DMA
> @@ -138,6 +155,7 @@ required:
>    - reg
>    - interrupts
>    - clocks
> +  - sram
>    - memcpy-channels
>  
>  additionalProperties: false
> @@ -149,8 +167,9 @@ examples:
>      #include <dt-bindings/mfd/dbx500-prcmu.h>
>      dma-controller@801c0000 {
>          compatible = "stericsson,db8500-dma40", "stericsson,dma40";
> -        reg = <0x801c0000 0x1000>, <0x40010000 0x800>;
> -        reg-names = "base", "lcpa";
> +        reg = <0x801c0000 0x1000>;
> +        reg-names = "base";
> +        sram = <&lcpa>, <&lcla>;
>          interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>          #dma-cells = <3>;
>          memcpy-channels = <56 57 58 59 60>;
> 
> -- 
> 2.39.2
> 
