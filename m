Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25264ED41C
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 08:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiCaGu7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 02:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiCaGu7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 02:50:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADD646D
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 23:49:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nZocC-0001TB-HE; Thu, 31 Mar 2022 08:49:04 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nZocB-0000xX-GG; Thu, 31 Mar 2022 08:49:03 +0200
Date:   Thu, 31 Mar 2022 08:49:03 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <20220331064903.GC4012@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-11-s.hauer@pengutronix.de>
 <YkU7cYhZUuGyWbob@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkU7cYhZUuGyWbob@matsya>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:35:53 up 19:05, 36 users,  load average: 0.05, 0.14, 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 31, 2022 at 10:56:09AM +0530, Vinod Koul wrote:
> On 28-03-22, 13:27, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> it is dmaengine: xxx

Ok.

> 
> Also is this patch dependent on rest of the series, if not consider
> sending separately

The rest of this series indeed depends on this patch.

> 
> > diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> > index 281adbb26e6bd..4a43a048e1b4d 100644
> > --- a/include/linux/platform_data/dma-imx.h
> > +++ b/include/linux/platform_data/dma-imx.h
> > @@ -39,6 +39,7 @@ enum sdma_peripheral_type {
> >  	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
> >  	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
> >  	IMX_DMATYPE_SAI,	/* SAI */
> > +	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
> >  };
> >  
> >  enum imx_dma_prio {
> > @@ -65,4 +66,10 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
> >  		!strcmp(chan->device->dev->driver->name, "imx-dma");
> >  }
> >  
> > +struct sdma_peripheral_config {
> > +	int n_fifos_src;
> > +	int n_fifos_dst;
> > +	bool sw_done;
> > +};
> 
> Not more platform data :(

I'm not sure what you are referring to as platform_data. This is not the
classical platform_data that is attached to a platform_device to
configure behaviour of that device. It is rather data that needs to be
communicated from the clients of the SDMA engine to the SDMA engine.

I have put this into include/linux/platform_data/dma-imx.h because
that's the only existing include file that is available. I could move
this to a new file if you like that better.

> 
> Can you explain this structure and why this is required? What do these
> fields refer to..?

The reasoning for this structure is described in the commit message that
I have forgotten:

    The i.MX SDMA engine can read from / write to multiple successive
    hardware FIFO registers, referred to as "Multi FIFO support". This is
    needed for the micfil driver and certain configurations of the SAI
    driver. This patch adds support for this feature.

    The number of FIFOs to read from / write to must be communicated from
    the client driver to the SDMA engine. For this the struct
    dma_slave_config::peripheral_config field is used.

I can describe the individual fields of struct sdma_peripheral_config in
the header file if that's your point.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
