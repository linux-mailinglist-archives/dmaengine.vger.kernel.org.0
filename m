Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB1511CD5
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiD0Sa5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiD0SaL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:30:11 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248708148E;
        Wed, 27 Apr 2022 11:21:45 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso1622660otk.10;
        Wed, 27 Apr 2022 11:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNkqFtfWIpgg7q9nQFPkAJIRdW96mm2Dj66zabaF1FI=;
        b=yYP1VJgT7NbDUdGL0+pfrE9bOX5p6XvOFxbM9i3+JX8PoCjhaW2DDGKMsBLY82aPsn
         fHlBoDNpgJhfMavgzSEnjjHhiwmqp7wBDwC8IvYM92St6umU4Ggc1dGJFlngqfPY7HWC
         a/e6t8VOkKZOkX26oTa5ehVnjMCg9UX/ZKmZ3xTrqV3Amd2mY+Q5m4jHKVtxqaS7JFv0
         L/iMM2z7Lun7QvYuDjqz7rKR3UpIkVNr8/RFKP0LvD48KVv7S/0dOCZV2oNKWIa5yR3T
         fMdNEVCN2sm8TngHEAAHnzf9mghRmDu3tdHB9Lq01pcXV61j5z0d7gCj4I5EaeRfX700
         MluA==
X-Gm-Message-State: AOAM530f2VliQyHb30YMtB1RYuQlUF3w89Dq9xnZBdUVfVeJXyQN35Yb
        IIPfUGRAJTTweHVSAG+cGc4CbgiPTQ==
X-Google-Smtp-Source: ABdhPJyux0Hlm+XzojBSEe9lEgsQs7GAExFCj6tUC8uAd6UyLMkitUemslG49L02pGfQQa/jnCa2BQ==
X-Received: by 2002:a05:6830:2414:b0:605:4d82:8d93 with SMTP id j20-20020a056830241400b006054d828d93mr10162244ots.130.1651083704278;
        Wed, 27 Apr 2022 11:21:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d7312000000b006054dfa7eb6sm6089856otk.78.2022.04.27.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:21:43 -0700 (PDT)
Received: (nullmailer pid 402242 invoked by uid 1000);
        Wed, 27 Apr 2022 18:21:43 -0000
Date:   Wed, 27 Apr 2022 13:21:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: dma: pl330: Add power-domains
Message-ID: <YmmJt29rGZ38w+ie@robh.at.kernel.org>
References: <20220427064048.86635-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427064048.86635-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 27 Apr 2022 08:40:48 +0200, Krzysztof Kozlowski wrote:
> The pl330 DMA controller on Exynos SoC (e.g. dma-controller@3880000 in
> Exynos5420) belongs to power domain, so allow such property.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
