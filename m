Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460256785E
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGEU2q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 16:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiGEU2p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 16:28:45 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240D1B791;
        Tue,  5 Jul 2022 13:28:44 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id u20so12218172iob.8;
        Tue, 05 Jul 2022 13:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VB8ohulxGJw/3gfUW0YzwYFtWNanlD/OW6g8qh8iMm8=;
        b=ZRq0pc8HRZo8iM/vfzdNvfDfnDo7zxL4cHsktDRkv78c7kjOuTr3L9PUS9V5rb92SR
         e1Yvs/8bbgKoUbzX0uhDTYWClozJnD3qUE0Jlbl/cip0Tf8PDdG0JlMhlue7G0JLjtvY
         SlPaKy1VY42nu25eeZJ7NbAguGDuVHM0o8J7W+Bi/LqNE6O1TI2xd6NVJVYlqZoYWtR3
         S9+J6UKHWECwKFLNeg9hSkL6lZ5Ti6pSfInhRlO2jeJ1I0u60EMb1ugdzhJW61THu4mc
         2TUcunZUcEQ2d2b3P3nN6agidPLeZ7P5eJpJmeR2ey/zHpCK4kogdtb5X86zrjSOjuk0
         o6Rg==
X-Gm-Message-State: AJIora8Gl+rFdi8cJwOrQUJMhXQsG3MT0NsghXBw18UCZB7UnnOPoeUc
        2NqqtmOp7L/7HQidFklOcQ==
X-Google-Smtp-Source: AGRyM1t/6jrKHfXmUGua2XcbKRa40KMbkZHlN4pybq69FIdjiz0yKozsXIHZLJCaSGa75SjE2+4hUg==
X-Received: by 2002:a05:6638:2514:b0:33e:d925:efe8 with SMTP id v20-20020a056638251400b0033ed925efe8mr7329632jat.202.1657052924068;
        Tue, 05 Jul 2022 13:28:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q15-20020a02a98f000000b0033ee1e67c6esm1959787jam.79.2022.07.05.13.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:28:43 -0700 (PDT)
Received: (nullmailer pid 2570063 invoked by uid 1000);
        Tue, 05 Jul 2022 20:28:41 -0000
Date:   Tue, 5 Jul 2022 14:28:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max
 typo
Message-ID: <20220705202841.GA2570015-robh@kernel.org>
References: <20220702031903.21703-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702031903.21703-1-samuel@sholland.org>
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

On Fri, 01 Jul 2022 22:19:02 -0500, Samuel Holland wrote:
> The conditional block for variants with a second clock should have set
> minItems, not maxItems, which was already 2. Since clock-names requires
> two items, this typo should not have caused any problems.
> 
> Fixes: edd14218bd66 ("dt-bindings: dmaengine: Convert Allwinner A31 and A64 DMA to a schema")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
