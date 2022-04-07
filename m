Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B74F878F
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiDGTBI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344697AbiDGTBH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 15:01:07 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056EC22C6CE;
        Thu,  7 Apr 2022 11:59:06 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-dacc470e03so7376113fac.5;
        Thu, 07 Apr 2022 11:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afrFLzt1gRoFoVRMojGGVgBPp/vAdD+p5A9V+fiaSKw=;
        b=6r9fkr5C27LSai/tqOR8G+fynQmwoqUjpHjhMiq4cJhIc9wCLTmW4asUi18wMe01PU
         1sSdbn6CTlWGchdmrvZ6HWrxTA7uGKRhmNAH07gYXBOVpJtuGK3PoG8jM+481dj6sutJ
         n0ZwiluwdY2rkpfBQti2yL3KmPnK24C/L1JiZDtX0M5cQh4zwpM2rk/N1PJmXLHZat8d
         sOSo17FQaT4jNT0iAP+01txVJJ5yAd5cN3VFIvQYX7d0RsIMxpwHoqlKlxoe74e03hz8
         e2xcyswuKlLtOrPto60rZc2HJEVu7KmBAfIs9Fv1d+VM97nmd6iNAOr0bw9cuRzP6PRr
         ElrQ==
X-Gm-Message-State: AOAM532Sl/K9OYXpjvkwCRKDKMtTRXjQXfuXD1cvqS0fx4QKyPyteOqg
        YP59k4tCXrqLDhUkg8Nllw==
X-Google-Smtp-Source: ABdhPJxNUG2HZcl4skpjdoCUqh+tz6W3QDAPX323irG1n56LqoDXcyZehrhf7pPhSiaz6mtTAfvVUw==
X-Received: by 2002:a05:6870:5584:b0:e1:e254:141d with SMTP id n4-20020a056870558400b000e1e254141dmr7201344oao.95.1649357945276;
        Thu, 07 Apr 2022 11:59:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm7568561oos.22.2022.04.07.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:59:04 -0700 (PDT)
Received: (nullmailer pid 1783762 invoked by uid 1000);
        Thu, 07 Apr 2022 18:59:04 -0000
Date:   Thu, 7 Apr 2022 13:59:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: uniphier: Use unevaluatedProperties
Message-ID: <Yk80eFKwDVnU67p/@robh.at.kernel.org>
References: <1649317447-20996-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649317447-20996-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On Thu, Apr 07, 2022 at 04:44:07PM +0900, Kunihiko Hayashi wrote:
> This refers common bindings, so this is preferred for
> unevaluatedProperties instead of additionalProperties.

Yes and no. If you want to define specific common properties are used 
(and not used), then listing them in the specific schema with 
'additionalProperties' is the right way to do that. If all properties in 
the referenced schema are valid, then unevaluatedProperties is correct.

If we wanted using unevaluatedProperties to be a hard rule, we could 
make the meta-schema enforce that.

> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml    | 2 +-
>  .../devicetree/bindings/dma/socionext,uniphier-xdmac.yaml       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
> index e7bf6dd7da29..b40f247e07be 100644
> --- a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
> @@ -45,7 +45,7 @@ required:
>    - clocks
>    - '#dma-cells'
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> index 371f18773198..b2bd21cbeb7f 100644
> --- a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> @@ -40,7 +40,7 @@ properties:
>      minimum: 1
>      maximum: 16
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  required:
>    - compatible
> -- 
> 2.25.1
> 
> 
