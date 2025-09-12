Return-Path: <dmaengine+bounces-6493-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1DB5538B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA931D68235
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA49223DF0;
	Fri, 12 Sep 2025 15:28:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4F22154F
	for <dmaengine@vger.kernel.org>; Fri, 12 Sep 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690900; cv=none; b=E7z7YkNbNawvsJNUFTU0K1sBKZFoYJ9WLSBsGHzIkKQ7vsrMw/N88LnetJNTogh2vMsEJiJHFl+9BS/oVkEnewA9at+12WzZtO+6dmT7v255zjIwG1pHtWFXuhdYkPftFhySxEQbQ/EDcVskpaWXVkfjmOhVEporI2oSYe90a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690900; c=relaxed/simple;
	bh=1J+ny7LKPXsnDwoQUpd/se26HOP6NxiKEsHAFbX8lzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqL5RNFxTlikElpNNRGB99C5iOem8FoMihT33b7SVMYS7G+Ykll2ylgSYLIa5vupOQB4d/7PBMzzQtk482XlsXaUzaBGBN832r5Yfv7Cjuq0eH086aNfQ9gizS1Bz2E1gTCKr2GHrM2vV5sn+UmJcNglCEJYRKKCeg/jjMCzHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5h3-0005sz-Dg; Fri, 12 Sep 2025 17:28:09 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5h3-000xIq-0a;
	Fri, 12 Sep 2025 17:28:09 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5h3-0032oV-0E;
	Fri, 12 Sep 2025 17:28:09 +0200
Date: Fri, 12 Sep 2025 17:28:09 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma-controller
Message-ID: <20250912152809.nj3yk5wmrb7ojjoo@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
 <aMQzNDE8QuUZwGkt@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQzNDE8QuUZwGkt@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-09-12, Frank Li wrote:
> On Thu, Sep 11, 2025 at 11:56:50PM +0200, Marco Felsch wrote:
> > Use the devres capabilities to cleanup the driver remove() callback.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/dma/imx-sdma.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index d6d0d4300f540268a3ab4a6b14af685f7b93275a..a7e6554ca223e2e980caf2e2dea832db9ad60ed6 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -2264,6 +2264,13 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> >  				     ofdma->of_node);
> >  }
> >
> > +static void sdma_dma_of_dma_controller_unregister_action(void *data)
> > +{
> > +	struct sdma_engine *sdma = data;
> > +
> > +	of_dma_controller_free(sdma->dev->of_node);
> > +}
> > +
> >  static void sdma_dma_device_unregister_action(void *data)
> >  {
> >  	struct sdma_engine *sdma = data;
> > @@ -2408,6 +2415,12 @@ static int sdma_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >
> > +	ret = devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register of-dma-controller unregister hook\n");
> > +		return ret;
> > +	}
> > +
> 
> return dev_err_probe()

Please check my last patch.

Regards,
  Marco

> 
> Frank
> >  	/*
> >  	 * Because that device tree does not encode ROM script address,
> >  	 * the RAM script in firmware is mandatory for device tree
> > @@ -2431,7 +2444,6 @@ static void sdma_remove(struct platform_device *pdev)
> >  	struct sdma_engine *sdma = platform_get_drvdata(pdev);
> >  	int i;
> >
> > -	of_dma_controller_free(sdma->dev->of_node);
> >  	/* Kill the tasklet */
> >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> >  		struct sdma_channel *sdmac = &sdma->channel[i];
> >
> > --
> > 2.47.3
> >
> 

