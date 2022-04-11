Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA44FBDBF
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiDKNvV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346708AbiDKNvV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 09:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9AD56;
        Mon, 11 Apr 2022 06:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A2F6110F;
        Mon, 11 Apr 2022 13:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368C3C385A4;
        Mon, 11 Apr 2022 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649684943;
        bh=/0A9RpEJ7REnvajp9XnL1qbAsYgD6WdtYUuCp70lPuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7NRIa6/3QJzic6TUhKuERXEHkt6FvlYPg0Eca4L2iuKcH4/frGG7D0H6qDJiqNcd
         rr0t2u9lFXWOhUvsbq0Tidp9cSSJpaKCq9wdjsB+AyA8q/uXrMAiY1uKAilE1wK3d9
         rLEiJ5v/v/ImJkdzukYCsvkq5nfhDERdGj0TbcK+1AkuhsxooD+zCyV3N5nga1rapp
         fVYRp6q4VzVlYFnpcdUiP2psCz5bAVDNoqdqIlOshGIVe/bo7Fleiy50visJ53pEyK
         AqQzt1TlflPVkQGfOZAHcV+tql4k97H+vXyTIFaNR8dfCcNUYsQQqBhGgj9KQbPO+x
         wD9WbRlJ03b9Q==
Date:   Mon, 11 Apr 2022 19:18:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Huibin Hong <huibin.hong@rock-chips.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: Fix unbalanced runtime PM
Message-ID: <YlQxy0e/39M4xTdL@matsya>
References: <1648296988-45745-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648296988-45745-1-git-send-email-sugar.zhang@rock-chips.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-03-22, 20:16, Sugar Zhang wrote:
> This driver use runtime PM autosuspend mechanism to manager clk.
> 
>   pm_runtime_use_autosuspend(&adev->dev);
>   pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);
> 
> So, after ref count reached to zero, it will enter suspend
> after the delay time elapsed.
> 
> The unbalanced PM:
> 
> * May cause dmac the next start failed.
> * May cause dmac read unexpected state.
> * May cause dmac stall if power down happen at the middle of the transfer.
>   e.g. may lose ack from AXI bus and stall.
> 
> Considering the following situation:
> 
>       DMA TERMINATE               TASKLET ROUTINE
>             |                            |
>             |                       issue_pending
>             |                            |
>             |                     pch->active = true
>             |                       pm_runtime_get
>   pm_runtime_put(if active)              |
>     pch->active = false                  |
>             |                      work_list empty
>             |                            |
>             |                     pm_runtime_put(force)

maybe unconditional is a better word than force here?

>             |                            |
> 
> At this point, it's unbalanced(1 get / 2 put).
> 
> After this patch:
> 
>       DMA TERMINATE               TASKLET ROUTINE
>             |                            |
>             |                       issue_pending
>             |                            |
>             |                     pch->active = true
>             |                       pm_runtime_get
>   pm_runtime_put(if active)              |
>     pch->active = false                  |
>             |                      work_list empty
>             |                            |
>             |                   pm_runtime_put(if active)
>             |                            |
> 
> Now, it's balanced(1 get / 1 put).
> 
> Fixes:
> commit 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
> commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")

That is not the right way for Fixes tag
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  drivers/dma/pl330.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 858400e..ccd430e 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2084,7 +2084,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
>  		spin_lock(&pch->thread->dmac->lock);
>  		_stop(pch->thread);
>  		spin_unlock(&pch->thread->dmac->lock);
> -		power_down = true;
> +		power_down = pch->active;
>  		pch->active = false;
>  	} else {
>  		/* Make sure the PL330 Channel thread is active */
> -- 
> 2.7.4

-- 
~Vinod
