Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7621568F1A
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGFQ1f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiGFQ1Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 12:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CE27CCE;
        Wed,  6 Jul 2022 09:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 065B361CAA;
        Wed,  6 Jul 2022 16:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DE8C3411C;
        Wed,  6 Jul 2022 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657124842;
        bh=4aItf/nscQZL1SybsK3P9rnGm4HeS4pp4DKgi8jCtAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amYVJ1/X6HSUPvDWF6hQJQoY8s0krw9Tvu+ST+qZK13iyxPNf4YQ7E0288lvv7rfC
         XQE93Dif4iub11kK6q7sOr9Mb826hXizt7sxN2TEYqnoxv0lj0pgkLkEBY+vR/mRct
         6rx6CGC7lQwrTHYPicck/Q8v8Xxdcmzg7EkFgL71R4DMPmW3mZ5El9EJ4zsmrEylr6
         bR8owydhEkI41Ga5fb7SJ3jppXfaq6kkLJdNgF2/EHGaFLwqs2ih20B6O3lR7Yfbtp
         LKeXtw5hSgzS3IC+ZBDIPK2TcHlqoTQwpa2dmoXkZRM2WHoHcZPHDXyhpdpH72mnH1
         l8hvQmEwLAqxQ==
Date:   Wed, 6 Jul 2022 21:57:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max
 typo
Message-ID: <YsW35YxGAA3XdmK9@matsya>
References: <20220702031903.21703-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702031903.21703-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-07-22, 22:19, Samuel Holland wrote:
> The conditional block for variants with a second clock should have set
> minItems, not maxItems, which was already 2. Since clock-names requires
> two items, this typo should not have caused any problems.

Applied, thanks

-- 
~Vinod
