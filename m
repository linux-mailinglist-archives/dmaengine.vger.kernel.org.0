Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18805493406
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jan 2022 05:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbiASEYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 23:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiASEYA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 23:24:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684AC061574;
        Tue, 18 Jan 2022 20:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4433B818AF;
        Wed, 19 Jan 2022 04:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D838C004E1;
        Wed, 19 Jan 2022 04:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642566237;
        bh=14cx5s1WHsPTvP5g/nc9FBRXmga8O2vQTNNDmJLESBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPOR5BkcBLDhO2H/pTZcT8+l/nAp0/0NLvWxXO9Ru4apiAdDAJlPGdOXqqyEw6ajr
         Mc+s7rilRXqrz/3swhQ+JxlQDxEJ/kkMOD5033+d8iw/OBv6zG34pCHGXI/kjoaD0z
         4m9cnNlRhlF2ctDrUYd0DlMKXdnjcLzBzO0/1635J9cFhnLbkido0KT+AeL+x5vBXU
         XpwQkznM86MuLOnQGv3nEGN7qIyNG5WOiDSiMAEQGrJ6/nlspp1XVPvXcsLVbSlbsa
         aysj3VaoiRraNo+dF0cUxk1j0+rNO8hxSfxlYGGiacfDl4G5DsGZ+zH33H0R1lZt0a
         1YC87sQA3eCWA==
Date:   Wed, 19 Jan 2022 09:53:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ptdma: fix concurrency issue with multiple
 dma transfer
Message-ID: <YeeSWEZi+BOWb3CK@matsya>
References: <1639735118-9798-1-git-send-email-Sanju.Mehta@amd.com>
 <YdLfLc8lfOektWmi@matsya>
 <38ae8876-610a-3c32-5025-1419466167e4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ae8876-610a-3c32-5025-1419466167e4@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-01-22, 13:27, Sanjay R Mehta wrote:
> On 1/3/2022 5:04 PM, Vinod Koul wrote:
> > On 17-12-21, 03:58, Sanjay R Mehta wrote:
> >> From: Sanjay R Mehta <sanju.mehta@amd.com>
> >>
> >> The command should be submitted only if the engine is idle,
> >> for this, the next available descriptor is checked and set the flag
> >> to false in case the descriptor is non-empty.
> >>
> >> Also need to segregate the cases when DMA is complete or not.
> >> In case if DMA is already complete there is no need to handle it
> >> again and gracefully exit from the function.
> >>
> >> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> >> ---
> >>  drivers/dma/ptdma/ptdma-dmaengine.c | 24 +++++++++++++++++-------
> >>  1 file changed, 17 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
> >> index c9e52f6..91b93e8 100644
> >> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
> >> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> >> @@ -100,12 +100,17 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
> >>  		spin_lock_irqsave(&chan->vc.lock, flags);
> >>  
> >>  		if (desc) {
> >> -			if (desc->status != DMA_ERROR)
> >> -				desc->status = DMA_COMPLETE;
> >> -
> >> -			dma_cookie_complete(tx_desc);
> >> -			dma_descriptor_unmap(tx_desc);
> >> -			list_del(&desc->vd.node);
> >> +			if (desc->status != DMA_COMPLETE) {
> >> +				if (desc->status != DMA_ERROR)
> >> +					desc->status = DMA_COMPLETE;
> >> +
> >> +				dma_cookie_complete(tx_desc);
> >> +				dma_descriptor_unmap(tx_desc);
> >> +				list_del(&desc->vd.node);
> >> +			} else {
> >> +				/* Don't handle it twice */
> >> +				tx_desc = NULL;
> >> +			}
> >>  		}
> >>  
> >>  		desc = pt_next_dma_desc(chan);
> >> @@ -233,9 +238,14 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
> >>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> >>  	struct pt_dma_desc *desc;
> >>  	unsigned long flags;
> >> +	bool engine_is_idle = true;
> >>  
> >>  	spin_lock_irqsave(&chan->vc.lock, flags);
> >>  
> >> +	desc = pt_next_dma_desc(chan);
> >> +	if (desc)
> >> +		engine_is_idle = false;
> >> +
> >>  	vchan_issue_pending(&chan->vc);
> >>  
> >>  	desc = pt_next_dma_desc(chan);
> >> @@ -243,7 +253,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
> >>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >>  
> >>  	/* If there was nothing active, start processing */
> >> -	if (desc)
> >> +	if (engine_is_idle)
> > 
> > Can you explain why do you need this flag and why desc is not
> > sufficient..
> 
> Here it is required to know if the engine was idle or not before
> submitting new desc to the active list (i.e, before calling
> "vchan_issue_pending()" API). So that if there was nothing active then
> start processing this desc otherwise later.
> 
> Here desc is submitted to the engine after vchan_issue_pending() API
> called which will actually put the desc into the active list and then if
> I get the next desc, the condition will always be true. Therefore used
> this flag here to solve this issue.

ok





> 
> > 
> > It also sounds like 2 patches to me...
> 
> Once the desc is submitted to the engine that will be handled by
> pt_handle_active_desc() function. This issue was resolved by making
> these changes together. Hence kept into the single patch.
> 
> Please suggest to me, if this still needs to be split. I'll make the
> changes accordingly.

2 patches please

-- 
~Vinod
