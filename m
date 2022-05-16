Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31585284EA
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiEPNF1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiEPNFZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 09:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0EE39B8B;
        Mon, 16 May 2022 06:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2950612CF;
        Mon, 16 May 2022 13:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BFFC385B8;
        Mon, 16 May 2022 13:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652706323;
        bh=eq1rcuLPkdu0+ErdkB7P6X9b1HszMe8ou3QsV1dHQYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTafzldvGKdyljfANYw13cE2sQ874aht66TSnNi3zI1IHuVNCf93AChAvR1Dl2nUj
         gWhVODf/m2KPPWfSpS9YE3XUXr8Bc8CGcLJIyV8E34fe92IhLDo1y6VRdHcyDXWGKi
         Z1pt62ABpXZcuVVPwIKjmntko61Imx4YTmSRAmoLv2ggR/rEd4yLlAiTMYnRwMP7LV
         mpIB0AI9dmv3y0+coRonGrsebuSSqaPz+IEim6VJzbmx4IJsxpSyc5vuRe4kat4ycy
         GgsnolHu/lXohA/fbHu69WV44JrIxGqr2h3f1rlhvSNvvb8oO7qZftl7i6tBt+f4p5
         QKtZMoW2bAO5Q==
Date:   Mon, 16 May 2022 18:35:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dmaengine/ARM: sprd: use proper
 'dma-channels/requests' properties
Message-ID: <YoJMD5+jcSHEA3tR@matsya>
References: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-05-22, 08:51, Krzysztof Kozlowski wrote:
> Hi,
> 
> The core DT schema defines generic 'dma-channels' and 'dma-requests'
> properties, so in preparation to moving bindings to DT schema, convert
> existing users of '#dma-channels' and '#dma-requests' to the generic
> variant.

Applied 1-2 to dmaengine tree, thanks

> 
> Not tested on hardware.
> 
> The patchset is bisectable - please pick up through independent trees.
> 
> Changes since v2
> ================
> 1. Keep old properties, so the patchset is bisectable.
> 2. Add review tags.
> 
> See also:
> [1] https://lore.kernel.org/linux-devicetree/fedb56be-f275-aabb-cdf5-dbd394b8a7bd@linaro.org/T/#m6235f451045c337d70a62dc65eab9a716618550b
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (3):
>   dt-bindings: dmaengine: sprd: deprecate '#dma-channels'
>   dmaengine: sprd: deprecate '#dma-channels'
>   arm64: dts: sprd: use new 'dma-channels' property
> 
>  Documentation/devicetree/bindings/dma/sprd-dma.txt | 7 +++++--
>  arch/arm64/boot/dts/sprd/whale2.dtsi               | 4 ++++
>  drivers/dma/sprd-dma.c                             | 6 +++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> -- 
> 2.32.0

-- 
~Vinod
