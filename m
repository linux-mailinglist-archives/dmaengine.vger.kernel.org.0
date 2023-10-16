Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA07CA64E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJPLLH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJPLLG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:11:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FF483;
        Mon, 16 Oct 2023 04:11:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128F2C433C8;
        Mon, 16 Oct 2023 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697454663;
        bh=lVB3Zy9EHqhxD+7XTnrniBL/mRSy6WczNg24vNkvBcc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=NgcyglY9QC5upCi7f7lr2wW18jKwF0fCzlqrPjMUJXth7LhMKOWBUU9klax5RYlZu
         Yt5uPzLb3XZjPlSCsLcF+ZfQn1Ve4oEMf6DDAqcO9U4L7wxvnEGZArpA7qy6TPn2mv
         M4I5XAQXmz/8+NuMYzxjQZdBFEjn6tp+L85sJ42ucrDGLgP+Ii/wA5HNUbuy47WKhv
         R9wIqRRGDK917H0Ai7C9WpNiv1L4Vr7TohZ9DEEwPWVLQKDpbh5tqznz+mq4DMwlGh
         9DNONA/aDFkS2K5L7BsbOjNpWqHJfXMj+WyIC4lXEC8qCDNlRjAzdO4PxCOfYR0L9z
         CDQPX97RLrGXg==
Date:   Mon, 16 Oct 2023 16:41:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        stable@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: correct desc prep when channel
 running
Message-ID: <ZS0aREGECQ7G+fry@matsya>
References: <20231009082450.452877-1-amelie.delaunay@foss.st.com>
 <20231009090213.GA1547647@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009090213.GA1547647@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-10-23, 11:02, Alain Volmat wrote:
> Hi Amélie,
> 
> thanks a lot.
> 
> Tested-by: Alain Volmat <alain.volmat@foss.st.com>

Please **do ** not ** top post!

> 
> Regards,
> Alain
> 
> On Mon, Oct 09, 2023 at 10:24:50AM +0200, Amelie Delaunay wrote:
> > From: Alain Volmat <alain.volmat@foss.st.com>
> > 
> > In case of the prep descriptor while the channel is already running, the
> > CCR register value stored into the channel could already have its EN bit
> > set.  This would lead to a bad transfer since, at start transfer time,
> > enabling the channel while other registers aren't yet properly set.
> > To avoid this, ensure to mask the CCR_EN bit when storing the ccr value
> > into the mdma channel structure.
> > 
> > Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
> > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/dma/stm32-mdma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> > index bae08b3f55c7..f414efdbd809 100644
> > --- a/drivers/dma/stm32-mdma.c
> > +++ b/drivers/dma/stm32-mdma.c
> > @@ -489,7 +489,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
> >  	src_maxburst = chan->dma_config.src_maxburst;
> >  	dst_maxburst = chan->dma_config.dst_maxburst;
> >  
> > -	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
> > +	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
> >  	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
> >  	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
> >  
> > @@ -965,7 +965,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
> >  	if (!desc)
> >  		return NULL;
> >  
> > -	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
> > +	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
> >  	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
> >  	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
> >  	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
> > -- 
> > 2.25.1
> > 

-- 
~Vinod
