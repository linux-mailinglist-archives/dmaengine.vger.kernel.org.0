Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072C66E307C
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDOKNN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDOKNK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FC3C1E;
        Sat, 15 Apr 2023 03:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EDE460F15;
        Sat, 15 Apr 2023 10:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F1CC433EF;
        Sat, 15 Apr 2023 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553588;
        bh=y8PFiTJmyHVcHoADVCxHznp9xq9eD+8CSpYGucAEaE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRkWhbnlSseV5l3hBHRP/eNaCxSXMpLHob+yibG4SaXV/siBfZUZzlyCZ/o5H4U9Z
         YPkHs8kURnehXrBRyfQXgOWs6pcetoJ8cAxOvT1LU0inYvVYTY6tye57rQutNtTlZf
         jMSixDxbp2YqX4CnxJ8wu2G+x5K/KdekvsHxArInDCFIGQyn5t+B70U+Rhrez3ghlp
         v1Qslr3kDv3YXE+jzQlqbFJW/N5xEYbJj/csRRIuXHEYPAf/2eP43tEXDdjqYjC5pq
         xF4zynIr1Wysm7XqAq5qAwlVmhLq/i2Ez0ZcOeWoqVyg36+SjJvLvK2IY6sLuyLuq8
         oYaUxJWBLqjmg==
Date:   Sat, 15 Apr 2023 18:02:14 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dmaengine: dw-axi-dmac: fix reading register hen
 runtime suspended
Message-ID: <ZDp2JjQRkSzwx03g@xhacker>
References: <20230313170450.897-1-jszhang@kernel.org>
 <20230313170450.897-2-jszhang@kernel.org>
 <ZDbrTvfPdnvW4Gue@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDbrTvfPdnvW4Gue@matsya>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 12, 2023 at 11:03:02PM +0530, Vinod Koul wrote:
> s/hen/when..? or something else
> 
> On 14-03-23, 01:04, Jisheng Zhang wrote:
> > We should runtime resume the device before calling
> > axi_chan_is_hw_enable().
> 
> why is that can you please explain..

If the device is suspended, I.E not resumed, accessing any
registers in axi_chan_is_hw_enable() will cause cpu abort.

I will add this info into commit log of v2.

> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 7f3a60e28e38..23a10dbdecb7 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -462,13 +462,17 @@ static void dw_axi_dma_synchronize(struct dma_chan *dchan)
> >  
> >  static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
> >  {
> > +	int ret;
> >  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> >  
> > +	pm_runtime_get(chan->chip->dev);
> > +
> >  	/* ASSERT: channel is idle */
> >  	if (axi_chan_is_hw_enable(chan)) {
> >  		dev_err(chan2dev(chan), "%s is non-idle!\n",
> >  			axi_chan_name(chan));
> > -		return -EBUSY;
> > +		ret = -EBUSY;
> > +		goto err_busy;
> >  	}
> >  
> >  	/* LLI address must be aligned to a 64-byte boundary */
> > @@ -478,13 +482,16 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
> >  					  64, 0);
> >  	if (!chan->desc_pool) {
> >  		dev_err(chan2dev(chan), "No memory for descriptors\n");
> > -		return -ENOMEM;
> > +		ret = -ENOMEM;
> > +		goto err_busy;
> >  	}
> >  	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
> >  
> > -	pm_runtime_get(chan->chip->dev);
> > -
> >  	return 0;
> > +
> > +err_busy:
> > +	pm_runtime_put(chan->chip->dev);
> > +	return ret;
> >  }
> >  
> >  static void dma_chan_free_chan_resources(struct dma_chan *dchan)
> > -- 
> > 2.39.2
> 
> -- 
> ~Vinod
