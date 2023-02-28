Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827726A5C19
	for <lists+dmaengine@lfdr.de>; Tue, 28 Feb 2023 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB1PiJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Feb 2023 10:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB1PiI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Feb 2023 10:38:08 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2549535A9;
        Tue, 28 Feb 2023 07:37:54 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id e18-20020a0568301e5200b00690e6abbf3fso5774571otj.13;
        Tue, 28 Feb 2023 07:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiGxUIZlhBoSVJeBkYFENOg4GIwTPCWwmZd3MMsJWhQ=;
        b=Eyj3my3T8G9E2KlOObouKMbTU3cKiEF2Zru+ToDGlX0Jg3BQ3x1UOWWQgtQCk1YYBE
         848qbagJJq4O5OlNJZMAGSpAjLPAPw4Zk57K4JGuD1GYbTkE5zxE6XJwKLX9h4N0cEH0
         I721OkYhGPyoi2EtCwyMg/dKWUqg7U5ulPTOJYSzbuRdxuq2sTutHhQjuicvV6p6C363
         QEOfoDmbgol1H8N41CzhWOvl7NK6mU1qCMYqehbZy0iY5PnHPi0JuRv+mQnmYXPhnpjh
         6jnlz11iGlk9QSq0UDI8ycr9qpEWNBzz2AavUoPe746Jo9jqQwWd+h6dss7euIEOYK6K
         YNNQ==
X-Gm-Message-State: AO0yUKVStz7OEDVFnGTg2KYyrLr8RICO9apIurrLWzWyuHYcw0RZHDJJ
        dq5P955wRT0YYJsGW1XFBA==
X-Google-Smtp-Source: AK7set+FQZfJKzMSvooj0J0L2qXGToOzW6Emupz5aqZutC3zQGwWlbQGMFREATBJh3CAD4IfO/nfVQ==
X-Received: by 2002:a05:6830:4122:b0:693:daa8:ea82 with SMTP id w34-20020a056830412200b00693daa8ea82mr2201143ott.13.1677598673203;
        Tue, 28 Feb 2023 07:37:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id do11-20020a0568300e0b00b0068bcef4f543sm3834723otb.21.2023.02.28.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:37:52 -0800 (PST)
Received: (nullmailer pid 3296057 invoked by uid 1000);
        Tue, 28 Feb 2023 15:37:52 -0000
Date:   Tue, 28 Feb 2023 09:37:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain
 minItems/maxItems of resets for JH7110 DMA
Message-ID: <20230228153752.GA3292255-robh@kernel.org>
References: <20230227131042.16125-1-walker.chen@starfivetech.com>
 <20230227131042.16125-2-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227131042.16125-2-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 27, 2023 at 09:10:40PM +0800, Walker Chen wrote:
> The DMA controller needs two reset items to work properly on JH7110 SoC,
> so there is need to change the maxItems' value to 2 and add minItems
> whose value is equal to 1. Other platforms do not have this constraint.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index ad107a4d3b33..4ed0a6b7ca69 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -12,14 +12,12 @@ maintainers:
>  description:
>    Synopsys DesignWare AXI DMA Controller DT Binding
>  
> -allOf:
> -  - $ref: "dma-controller.yaml#"
> -
>  properties:
>    compatible:
>      enum:
>        - snps,axi-dma-1.01a
>        - intel,kmb-axi-dma
> +      - starfive,jh7110-axi-dma
>  
>    reg:
>      minItems: 1
> @@ -58,7 +56,8 @@ properties:
>      maximum: 8
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    snps,dma-masters:
>      description: |
> @@ -109,6 +108,24 @@ required:
>    - snps,priority
>    - snps,block-size
>  
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - starfive,jh7110-axi-dma
> +    then:
> +      properties:
> +        resets:
> +          minItems: 1
> +          maxItems: 2

A given platform should not have a variable number of resets. This also 
does nothing because you just duplicated the top-level constraints. If 
you have 2, then you want just 'minItems: 2'.

Rob
