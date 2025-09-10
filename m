Return-Path: <dmaengine+bounces-6434-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7196B51313
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 11:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD21C813ED
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD02314B81;
	Wed, 10 Sep 2025 09:45:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D53191B1
	for <dmaengine@vger.kernel.org>; Wed, 10 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497524; cv=none; b=MlJC8Gnch54EmfyWziitvoDnhnNoDIiGszTbS3d4mu6uGdCMV2tg3SJNRemLww3FwqEFGjCDB39b9nhLAVn4QON8FeK+KbzLjEr/ulmQ85fLc3dkCwhNlPvBImE4eqEN2z8z+3dSKCz8IynHzMgF4Z6nt7o6LppVJCLszSS7g74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497524; c=relaxed/simple;
	bh=3zQu35m1C6YPImywyjnt2q1c7Rr8khcAX2jfPUML1h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNF7N8FqSDpBaWvxZYrBacF4DdYFgRPiep2SDGxdcgYfKEBkGcFXB5dIICX3soRmC6PqDCLI7dsJQmb1YZjGVSE6xUiZ+k4PoLBsTSL10thPJQ/8KyA6SWd00t/8pJTih4Bdgg5eeFnCTRVSCcNhM/6sVhEVB/kCh2rBhVO/TZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHO6-0000Ts-30; Wed, 10 Sep 2025 11:45:14 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHO5-000ZMU-2h;
	Wed, 10 Sep 2025 11:45:13 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHO5-00GDN2-2E;
	Wed, 10 Sep 2025 11:45:13 +0200
Date: Wed, 10 Sep 2025 11:45:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] dmaengine: imx-sdma: fix missing
 of_dma_controller_free()
Message-ID: <20250910094513.eawc5n6zbddtg5c5@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-8-ac7bab629e8b@pengutronix.de>
 <aLhZ2zfh5bnNoH8X@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhZ2zfh5bnNoH8X@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-09-03, Frank Li wrote:
> On Wed, Sep 03, 2025 at 03:06:16PM +0200, Marco Felsch wrote:
> > Add the missing of_dma_controller_free() to free the resources allocated
> > via of_dma_controller_register(). The missing free was introduced long
> > time ago  by commit 23e118113782 ("dma: imx-sdma: use
> > module_platform_driver for SDMA driver") while adding a proper .remove()
> > implementation.
> >
> > Fixes: 23e118113782 ("dma: imx-sdma: use module_platform_driver for SDMA driver")
> 
> Look it is hard to back port to old kernel.  Can move it to before cleanup?

I know that fixing commits should come first but this commit dates back
to v3.18-rc1, therefore I thought that backporting this commit would
cause more troubles than it's worth it.

Anyway, after checking the current LTS and stable kernels I think that
the commit could be backported without troubles because the APIs used
do exist on all these kernels.

Regards,
  Marco

> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/dma/imx-sdma.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index e30dd46cf6522ee2aa4d3aca9868a01afbd29615..6c6d38b202dd2deffc36b1bd27bc7c60de3d7403 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -2232,6 +2232,13 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
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
> > @@ -2370,6 +2377,8 @@ static int sdma_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "failed to register controller\n");
> >
> > +	devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
> > +
> >  	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> >  	ret = of_address_to_resource(spba_bus, 0, &spba_res);
> >  	if (!ret) {
> >
> > --
> > 2.47.2
> >
> 

