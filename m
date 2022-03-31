Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495E4ED43C
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiCaG4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiCaG4j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 02:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3903D64E6
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 23:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0F061769
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 06:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D2C340F0;
        Thu, 31 Mar 2022 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648709691;
        bh=3cpNOIC58K2mPuFQa4I9a7tDPdbpizXHXwtv3e9Vdyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rgopfod6Vrk6MKrUCeaTFi/j45YjEqNee7fOspU9UNtrgYxJ6nL+FcCmO/sPK5pGu
         JOnpE5+pRedE/6kVdSyERmKsqyyYgjs61KzSpb9TD9eQGYRA61TDcM14+06nk3hCuN
         M8H2nqoI218E0LT0fzMCTxcxcaPU0DazvhIhWZ0PhNeTdPvrQSpCNLW7yliSRhrNJb
         XthFPX2TiWcvmU4BRD13LA7DFYYxSJYr0ZWVzh34KVPEHDyy9CeKVKtN9RyMZAvtF1
         qDQeGD4ZyCJXeI2w3HEd9HQosFS3R0nh2/PmSQKzHxTKIBLbrn5hPxYGnGbRBvx/CT
         02z4ViS7aosuA==
Date:   Thu, 31 Mar 2022 12:24:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <YkVQNhTpeIT7qO/7@matsya>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-11-s.hauer@pengutronix.de>
 <YkU7cYhZUuGyWbob@matsya>
 <20220331064903.GC4012@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331064903.GC4012@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-03-22, 08:49, Sascha Hauer wrote:
> On Thu, Mar 31, 2022 at 10:56:09AM +0530, Vinod Koul wrote:
> > On 28-03-22, 13:27, Sascha Hauer wrote:
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > it is dmaengine: xxx
> 
> Ok.
> 
> > 
> > Also is this patch dependent on rest of the series, if not consider
> > sending separately
> 
> The rest of this series indeed depends on this patch.
> 
> > 
> > > diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> > > index 281adbb26e6bd..4a43a048e1b4d 100644
> > > --- a/include/linux/platform_data/dma-imx.h
> > > +++ b/include/linux/platform_data/dma-imx.h
> > > @@ -39,6 +39,7 @@ enum sdma_peripheral_type {
> > >  	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
> > >  	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
> > >  	IMX_DMATYPE_SAI,	/* SAI */
> > > +	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
> > >  };
> > >  
> > >  enum imx_dma_prio {
> > > @@ -65,4 +66,10 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
> > >  		!strcmp(chan->device->dev->driver->name, "imx-dma");
> > >  }
> > >  
> > > +struct sdma_peripheral_config {
> > > +	int n_fifos_src;
> > > +	int n_fifos_dst;
> > > +	bool sw_done;
> > > +};
> > 
> > Not more platform data :(
> 
> I'm not sure what you are referring to as platform_data. This is not the
> classical platform_data that is attached to a platform_device to
> configure behaviour of that device. It is rather data that needs to be
> communicated from the clients of the SDMA engine to the SDMA engine.
> 
> I have put this into include/linux/platform_data/dma-imx.h because
> that's the only existing include file that is available. I could move
> this to a new file if you like that better.

Lets move to include/linux/dma/

> 
> > 
> > Can you explain this structure and why this is required? What do these
> > fields refer to..?
> 
> The reasoning for this structure is described in the commit message that
> I have forgotten:
> 
>     The i.MX SDMA engine can read from / write to multiple successive
>     hardware FIFO registers, referred to as "Multi FIFO support". This is
>     needed for the micfil driver and certain configurations of the SAI
>     driver. This patch adds support for this feature.
> 
>     The number of FIFOs to read from / write to must be communicated from
>     the client driver to the SDMA engine. For this the struct
>     dma_slave_config::peripheral_config field is used.
> 
> I can describe the individual fields of struct sdma_peripheral_config in
> the header file if that's your point.

So you need to know the number of fifo right, what does sw_done imply?

Also if this is hardware information, why not use dma-cells for this?

-- 
~Vinod 
