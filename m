Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930826048B4
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiJSOGg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSOGK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FA18F0C0;
        Wed, 19 Oct 2022 06:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A015F618D9;
        Wed, 19 Oct 2022 13:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827EAC433C1;
        Wed, 19 Oct 2022 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187171;
        bh=1/q8N0Fw/4Mp5qWBCxTYfIZcq7XxY4Dqr4WN1uWHwsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtuuDjra0KqaJkgWdHlRjdiKQ5XBsBzgajyatrGjgGk5ZRAfIsqynqMCRBF4ifqzr
         SJvhScuhESNc2JAy74qvY9Ilfi0F6QnR67Imv68SvHldOLbXT++PKPu4W5EuuIlMeP
         /tRhuLzh3po9/JwqNL2bTEPOsyfvBsrLlCqTI06IGmveQ745vwznJqi/uPSdmMQ8UY
         w44glkfBMRSG5io4V6cdgWYX5lLtvdRdWmfxDPeH0Lpj4oCW2O98pb5N9W3Q/PbZYk
         O2d2FA0aiXs7lKwWl+C7nFMOdy88u2B2u+pXX2y0j3ran9NPvRn3FKt6m0vGcAYn5a
         ol9QItAOpGRsQ==
Date:   Wed, 19 Oct 2022 19:16:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: ti: edma: Remove the unused function
 edma_and()
Message-ID: <Y0//nxmB2CEjFvMp@matsya>
References: <20221018083820.25297-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018083820.25297-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-10-22, 16:38, Jiapeng Chong wrote:
> The function edma_and() is defined in the edma.c file, but not called
> elsewhere, so remove this unused function.
> 
> drivers/dma/ti/edma.c:321:20: warning: unused function 'edma_and'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2430
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

Where is this report?

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/dma/ti/edma.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index fa06d7e6d8e3..9ea91c640c32 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -318,14 +318,6 @@ static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
>  	edma_write(ecc, offset, val);
>  }
>  
> -static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
> -{
> -	unsigned val = edma_read(ecc, offset);
> -
> -	val &= and;
> -	edma_write(ecc, offset, val);
> -}
> -
>  static inline void edma_or(struct edma_cc *ecc, int offset, unsigned or)
>  {
>  	unsigned val = edma_read(ecc, offset);
> -- 
> 2.20.1.7.g153144c

-- 
~Vinod
