Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A795AB649
	for <lists+dmaengine@lfdr.de>; Fri,  2 Sep 2022 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiIBQMV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Sep 2022 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiIBQLz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Sep 2022 12:11:55 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AC1BEA5;
        Fri,  2 Sep 2022 09:06:58 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11f11d932a8so5828034fac.3;
        Fri, 02 Sep 2022 09:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Yww8nSqo/YWqOlhFjUuAmIA0GxHSNv2JljX3oLJvbjc=;
        b=PlUlLwLJKZlQ7T16gwjGrJCBZXDNDqNaFIjQzzRO9HjsIpaHK8w4gT87hJ5a/oaoft
         1JawZVawi211GENhnq8leeGhoAVLpFSg6KhJH+REUaqAjkITaOtTeTc5hEZMyPehfJ4M
         0o2n9i4OIbN0XjSq0oyCVVDP9PjcyqcW0rUo5/5aPe2nNlY7/BKF+fY7wOYDM4xL+5kt
         ocUeSyRuRRg6XMJtoDRZRz85Z1+GJy4FD2eyEu943vfMFomo8yQ88Lox0kLsD7YE1jiF
         lqgMH7ncLFz5hAyeHG1daR41zXUJFH+gQsHLxUN8ixGN/m6Jjg8fairpp+O0DpZO2D1c
         4fAg==
X-Gm-Message-State: ACgBeo1hbhYxLxx+YZZNMHNHVXOdvQMhPyaiSCCRWDxgtLSdNFKs3+Ga
        WY93xi0d335PMhhWAxK5ZZI0F56zSQ==
X-Google-Smtp-Source: AA6agR5IWlwQcgO3ctzkIvS04VMiB9a7SRTGcxI9I4Ik/vbqf2xUQToOBCJItnmp8Wid4YGkWvDx5Q==
X-Received: by 2002:aca:3056:0:b0:345:64e9:7435 with SMTP id w83-20020aca3056000000b0034564e97435mr2166616oiw.19.1662134817390;
        Fri, 02 Sep 2022 09:06:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d5c87000000b0063736db0ae9sm1203733oti.15.2022.09.02.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:06:56 -0700 (PDT)
Received: (nullmailer pid 4168981 invoked by uid 1000);
        Fri, 02 Sep 2022 16:06:56 -0000
Date:   Fri, 2 Sep 2022 11:06:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: arm,pl330: Add missing 'iommus'
 property
Message-ID: <20220902160656.GA4168277-robh@kernel.org>
References: <20220801210237.1501488-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801210237.1501488-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 01, 2022 at 03:02:37PM -0600, Rob Herring wrote:
> The pl330 can be behind an IOMMU which is the case for Arm Juno board.
> Add the 'iommus' property allowing for 1 IOMMU entry per channel for
> writes and 1 IOMMU entry for reads.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Include IOMMU entry for read channel
> ---
>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Ping!

> 
> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> index 2bec69b308f8..4a3dd6f5309b 100644
> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> @@ -55,6 +55,12 @@ properties:
>  
>    dma-coherent: true
>  
> +  iommus:
> +    minItems: 1
> +    maxItems: 9
> +    description: Up to 1 IOMMU entry per DMA channel for writes and 1
> +      IOMMU entry for reads.
> +
>    power-domains:
>      maxItems: 1
>  
> -- 
> 2.34.1
> 
> 
