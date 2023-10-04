Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158CC7B78B6
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjJDH3d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 03:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJDH3c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 03:29:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF33FA7;
        Wed,  4 Oct 2023 00:29:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38CBC433C8;
        Wed,  4 Oct 2023 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696404569;
        bh=7gJoTQ9PDdIbeq4D3fsl2MCJhtdJJmthj0WgCiLTxxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZjYsEWmSrA3UbuP+KSwQX5dJHI0sA/Mwrapi8qkC/ZQKmdMzqeNp2+qABGZuaU8u
         eT4iHn7foTSSHpv3OC6Yl/KrliAffvQPS67W/GW3GJ0c+gER5DccDM5oiyl2UrifjK
         +lurzy7CYs5FNzVMPNz8MFGnzVlOm015Chawf+2PbJ1qzI+3LplarNg7Fh7+chlz6Q
         ulA2jK/Sj2z1UJI1lmQUpd/Qkprk+BJlgJP0P1RTvw5uRgEg4YjBJs7eZIB2fATuoX
         Nv2PH4Yu8nCo/UkO4HvoTuVlN3ApdYTYQeDlKIJtoZYEGiclkfvzGY08zqzIuc2KNz
         zMWWO1oeo+WsA==
Date:   Wed, 4 Oct 2023 12:59:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: xilinx: xdma: Support cyclic transfers
Message-ID: <ZR0UVYAKgix2nRrb@matsya>
References: <20230922162056.594933-1-miquel.raynal@bootlin.com>
 <20230922162056.594933-3-miquel.raynal@bootlin.com>
 <ZRVbZwQz13hL2QfY@matsya>
 <20231003110256.44286fcd@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003110256.44286fcd@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-10-23, 11:02, Miquel Raynal wrote:
> Hi Vinod,
> 
> Thanks for the feedback.
> 
> vkoul@kernel.org wrote on Thu, 28 Sep 2023 16:24:31 +0530:
> 
> > On 22-09-23, 18:20, Miquel Raynal wrote:
> > 
> > > @@ -583,7 +690,36 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
> > >  static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > >  				      struct dma_tx_state *state)
> > >  {
> > > -	return dma_cookie_status(chan, cookie, state);
> > > +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> > > +	struct xdma_desc *desc = NULL;
> > > +	struct virt_dma_desc *vd;
> > > +	enum dma_status ret;
> > > +	unsigned long flags;
> > > +	unsigned int period_idx;
> > > +	u32 residue = 0;
> > > +
> > > +	ret = dma_cookie_status(chan, cookie, state);
> > > +	if (ret == DMA_COMPLETE)
> > > +		return ret;
> > > +
> > > +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> > > +
> > > +	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
> > > +	if (vd)
> > > +		desc = to_xdma_desc(vd);  
> > 
> > vd is not used in below check, so should be done after below checks, why
> > do this for cyclic case?
> 
> I'm not sure I get this comment. vd is my way to get the descriptor,
> and I need the descriptor to know whether we are in a cyclic transfer
> or not. If the transfer is not cyclic, I just return the value from
> dma_cookie_status() like before, otherwise I update the residue based
> on the content of desc.
> 
> Maybe I don't understand what you mean, would you mind explaining it
> again?

Sorry I am not sure what I was thinking, this looks fine, we need the
lock to get the desc and use it

-- 
~Vinod
