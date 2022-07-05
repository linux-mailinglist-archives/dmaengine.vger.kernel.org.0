Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8F567859
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGEU2h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGEU2g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 16:28:36 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A41A821;
        Tue,  5 Jul 2022 13:28:34 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id m13so12294650ioj.0;
        Tue, 05 Jul 2022 13:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SaypPa2UN7YAKRNdvopBZ88Wz+LgeGmrvVofkpjWV/M=;
        b=cu0kx1z1ipVBJmvjxVvav+rdrEqK96g0dXw+05hCtERe8PJ8Oz7hnScfZnvtOLXODv
         F353N770r9HwClZXF1/JfsEOHJ+E0L0EtzeqwH1HhXrHwmJ7eyFQ/54epXePVXd40hin
         CpqkTYV1SKVotdu84WMgleMk3t6hyERUCUl0ry3w1BtfOVqIhyCSEVH9pA6z+L2dcF2S
         8TTSKmk1D8fTP6P7NsCGMx9bG0vDsVXJrZ2yiOaDB2cefYgx/UKry/v/hpZuN/I4V0AM
         wqrxR9CY4OF6K/5Kp0+GX9Co6fzcL2EvpmGIjE+JBkIS1WDdi9/7CmS6NsC2gwFrTFHG
         JmFg==
X-Gm-Message-State: AJIora8Wck54ReAjQFYcu1N6R3pG4exIEw4u3mSJUkULzK+cOoMhF1fD
        TCcp2ff8hbJK7uYCXZArPQ==
X-Google-Smtp-Source: AGRyM1s10kfU9RWJJPfL6HqFC30mwyWv5jIBxtvyb4UhOhX1Ds2bGKDJOeRnPv4JmBoCUjuE502fOw==
X-Received: by 2002:a02:9f09:0:b0:339:e88d:f9bd with SMTP id z9-20020a029f09000000b00339e88df9bdmr23494080jal.298.1657052914263;
        Tue, 05 Jul 2022 13:28:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02114700b002dc258e3093sm1016417ill.64.2022.07.05.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:28:33 -0700 (PDT)
Received: (nullmailer pid 2569771 invoked by uid 1000);
        Tue, 05 Jul 2022 20:28:31 -0000
Date:   Tue, 5 Jul 2022 14:28:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max
 typo
Message-ID: <20220705202831.GA2566864-robh@kernel.org>
References: <20220702031903.21703-1-samuel@sholland.org>
 <22696538.6Emhk5qWAg@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22696538.6Emhk5qWAg@jernej-laptop>
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

On Sat, Jul 02, 2022 at 09:34:41PM +0200, Jernej Škrabec wrote:
> Dne sobota, 02. julij 2022 ob 05:19:02 CEST je Samuel Holland napisal(a):
> > The conditional block for variants with a second clock should have set
> > minItems, not maxItems, which was already 2. Since clock-names requires
> > two items, this typo should not have caused any problems.
> > 
> > Fixes: edd14218bd66 ("dt-bindings: dmaengine: Convert Allwinner A31 and A64
> > DMA to a schema") Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> >  .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> > b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml index
> > ff0a5c58d78c..e712444abff1 100644
> > --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> > @@ -67,7 +67,7 @@ if:
> >  then:
> >    properties:
> >      clocks:
> > -      maxItems: 2
> > +      minItems: 2
> 
> These specific variants have exactly 2 clocks. Having both limits seems right.

You do. The main section has 2 for the max.

Rob
