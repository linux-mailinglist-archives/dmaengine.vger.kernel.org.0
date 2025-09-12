Return-Path: <dmaengine+bounces-6497-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA26B554FF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85B05C512A
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9E320CDE;
	Fri, 12 Sep 2025 16:49:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31184322A13
	for <dmaengine@vger.kernel.org>; Fri, 12 Sep 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695796; cv=none; b=e4wTItX1CTQPJKyN70OOpl6XdGrP8TaMyYgM8VRlomWyvQxETrVO9ZjySGNaIgFOBbd0fkIIldaxOOLxw0Ynrcf53IwzSrakby7cFCTOn02sjihy78pOEw5ZuS3ZGzm/xh/JAIVwv5KgHfd9QxqWf49CTRzpYLlIAbBbWeskZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695796; c=relaxed/simple;
	bh=RrJ5q9STYJMdPVlaw0BgI4YoUoSC25LVeZFcwMPMYmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuhPYPudUn8pyxWxyAyoFZFJmGXqNDAU92spXRTBkxE0WJtGIhdWJEa+WVqxyGGlf5o8DyuhYtN/MN8vL2Gf6Z6l5jJpnJnJYj1oyd1TqtHfRIpkuCTVUt7+6YCPXvtg4hiXDk8L9A/oSw7kMm7j/9fCL64Ok0lK5SmHgmqPWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux6xz-0004dA-7V; Fri, 12 Sep 2025 18:49:43 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux6xy-000xpe-2y;
	Fri, 12 Sep 2025 18:49:42 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux6xy-0033g6-2a;
	Fri, 12 Sep 2025 18:49:42 +0200
Date: Fri, 12 Sep 2025 18:49:42 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma_device
Message-ID: <20250912164942.p7w2p63wvracosra@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-8-d315f56343b5@pengutronix.de>
 <aMQy+Ocs+UWq7WoR@lizhi-Precision-Tower-5810>
 <20250912152508.ccxk2qpcmhxjjsns@pengutronix.de>
 <aMRMWfwcAnkF7wwn@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMRMWfwcAnkF7wwn@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-09-12, Frank Li wrote:
> On Fri, Sep 12, 2025 at 05:25:08PM +0200, Marco Felsch wrote:
> > On 25-09-12, Frank Li wrote:
> > > On Thu, Sep 11, 2025 at 11:56:49PM +0200, Marco Felsch wrote:
> > > > Make use of the devm_add_action_or_reset() to register a custom devm_
> > > > release hook. This is required to turn off the IRQs before calling
> > > > dma_async_device_unregister().
> > > >
> > > > Furthermore it removes the last goto error handling within probe() and
> > > > trims the remove().
> > > >
> > > > Make use of disable_irq() and let the devm-irq do the job to free the
> > > > IRQ, because the only purpose of using devm_free_irq() was to disable
> > > > the IRQ before calling dma_async_device_unregister().
> > > >
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >  drivers/dma/imx-sdma.c | 23 +++++++++++++++--------
> > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > > index d39589c20c4b2a26d0239feb86cce8d5a0f5acdd..d6d0d4300f540268a3ab4a6b14af685f7b93275a 100644
> > > > --- a/drivers/dma/imx-sdma.c
> > > > +++ b/drivers/dma/imx-sdma.c
> > > > @@ -2264,6 +2264,14 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> > > >  				     ofdma->of_node);
> > > >  }
> > > >
> > > > +static void sdma_dma_device_unregister_action(void *data)
> > > > +{
> > > > +	struct sdma_engine *sdma = data;
> > > > +
> > > > +	disable_irq(sdma->irq);
> > >
> > > May not related this cleanup patch, I am just curious why not mask sdma irq
> > > request.
> >
> > You mean by setting irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)
> > infront? Not sure if this is required since this is just the cleanup
> > path.
> 
> It is not important for this patch.
> 
> >
> > > > +	dma_async_device_unregister(&sdma->dma_device);
> > > > +}
> > > > +
> > > >  static int sdma_probe(struct platform_device *pdev)
> > > >  {
> > > >  	struct device *dev = &pdev->dev;
> > > > @@ -2388,10 +2396,16 @@ static int sdma_probe(struct platform_device *pdev)
> > > >  		return ret;
> > > >  	}
> > > >
> > > > +	ret = devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Unable to register release hook\n");
> > > > +		return ret;
> > > > +	}
> > >
> > > why not use dev_err_probe() her?
> >
> > Please see my last patch.
> 
> You can direct use dev_err_probe() here, instead replace all in last one.

I get your point and yes I could do this, but I have to do the last
patch anyway. Therefore I'm not sure what difference this makes for this
series.

> 
> Frank
> 
> >
> > Regards,
> >   Marco
> >
> > >
> > > > +
> > > >  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "failed to register controller\n");
> > > > -		goto err_register;
> > > > +		return ret;
> > >
> > > the same here.
> > >
> > > Frank
> > > >  	}
> > > >
> > > >  	/*
> > > > @@ -2410,11 +2424,6 @@ static int sdma_probe(struct platform_device *pdev)
> > > >  	}
> > > >
> > > >  	return 0;
> > > > -
> > > > -err_register:
> > > > -	dma_async_device_unregister(&sdma->dma_device);
> > > > -
> > > > -	return ret;
> > > >  }
> > > >
> > > >  static void sdma_remove(struct platform_device *pdev)
> > > > @@ -2423,8 +2432,6 @@ static void sdma_remove(struct platform_device *pdev)
> > > >  	int i;
> > > >
> > > >  	of_dma_controller_free(sdma->dev->of_node);
> > > > -	devm_free_irq(&pdev->dev, sdma->irq, sdma);
> > > > -	dma_async_device_unregister(&sdma->dma_device);
> > > >  	/* Kill the tasklet */
> > > >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> > > >  		struct sdma_channel *sdmac = &sdma->channel[i];
> > > >
> > > > --
> > > > 2.47.3
> > > >
> > >
> 

