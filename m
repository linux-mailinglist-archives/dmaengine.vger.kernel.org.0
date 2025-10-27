Return-Path: <dmaengine+bounces-6995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4BC0B925
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 02:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9FE3B6BFC
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C72343B6;
	Mon, 27 Oct 2025 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mjG63zty"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF328EB;
	Mon, 27 Oct 2025 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527484; cv=none; b=OcWoedfhUb+37rH8e0NM7ImurY8dfmTRfQZACduUGQaZDFLDJIq7GWS269VkHvnDJxUJ6MkQPSDD8yqw9Wbgl+eQGXIJs3YOz8J4ENuq6TFBFZmPlw6xKK4ZoD74J50jJpJsVIGakc6fz+TzNRyp6s6kqX6j6UR6ZPdM3J1hXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527484; c=relaxed/simple;
	bh=wDAHYZ2XDq9G1bNOJF4J3PL4MjpM9SKkBVwAR7etS9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWkjWce6zwBJAEd4HWbXfHgftI+RUxeE43Vefb470KWDJXQ8B71lHzw+2Bs1jlXjhb42E1tDAYK2GU4FibeKJhk89054S/8YvMwWFGp0W3NdRHP7Zo5bcRvc8L8i3/IhlOYG6mRqQdvr8gnKB7kobOwKEkJibAV/1cmfdIiziJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mjG63zty; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-16.bb.dnainternet.fi [82.203.161.16])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id B938B666;
	Mon, 27 Oct 2025 02:09:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761527370;
	bh=wDAHYZ2XDq9G1bNOJF4J3PL4MjpM9SKkBVwAR7etS9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjG63zty12ng3dohZnH7VMI9WGMBDwHQaQjSBDAlq4Gky9yqB9GNG9u2SonxF/mtV
	 3XQaQ2mRydgaXAjfrjcsya5qOrE3t6u7KcaOmp4NVv9V68HSi+OcPXTfyYvTvuu+Gl
	 sTKzxc5CSXh5A14ko9mvKra4w1Zy3UG1oE3pGrho=
Date: Mon, 27 Oct 2025 03:11:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, robh@kernel.org,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: add device_link support
Message-ID: <20251027011103.GR13023@pendragon.ideasonboard.com>
References: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
 <20250912-v6-16-topic-dma-devlink-v1-1-4debc2fbf901@pengutronix.de>
 <aNVufDmHjLRauKYo@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNVufDmHjLRauKYo@lizhi-Precision-Tower-5810>

On Thu, Sep 25, 2025 at 12:31:56PM -0400, Frank Li wrote:
> On Fri, Sep 12, 2025 at 12:00:41AM +0200, Marco Felsch wrote:
> > Shift the device dependency handling to the driver core by adding
> > support for devlinks.
> >
> > The link between the consumer device and the dmaengine device is
> > established by the consumer via the dma_request_chan() automatically if
> > the dmaengine driver supports it (create_devlink flag set).
> >
> > By adding the devlink support it is ensured that the supplier can't be
> > removed while the consumer still uses the dmaengine. Furthermore it
> > ensures that the supplier driver is present and actual bound before the
> > consumer is uses the supplier.

How is the latter ensured by this patch ? The link is created in
dma_request_chan() (which is called by the consumer), after successfully
obtaining the channel. I don't see how the link improves that mechanism.

> >
> > Additional PM and runtime-PM dependency handling can be added easily too
> > by setting the required flags (not implemented by this commit).

I've long thought that the DMA engine API should offer calls to "prepare"
and "unprepare" (names subject to bikeshedding) a DMA engine channel, so
that consumers can explicitly indicate when they are getting ready to
use DMA, and when they stop.

> >
> > The new create_devlink flag controlls the devlink creation to not cause
> > any regressions with existing dmaengine drivers. This flag can be
> > removed once all drivers are successfully tested to support devlinks.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> 
> Add previous discussion link:
> https://lore.kernel.org/all/aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810/
> 
> Another thread
> https://lore.kernel.org/dmaengine/20250801120007.GB4906@pendragon.ideasonboard.com/
> 
> Add Laurent Pinchart, who may instest this topic also.
> 
> Add Rob Herring, who may know why dma engine can't create dev_link default
> like other provider (clk, phy, gpio ...)
> 
> 
> >  drivers/dma/dmaengine.c   | 15 +++++++++++++++
> >  include/linux/dmaengine.h |  3 +++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..e81985ab806ae87ff3aa4739fe6f6328b2587f2e 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -858,6 +858,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> >  	/* No functional issue if it fails, users are supposed to test before use */
> >  #endif
> >
> > +	/*
> > +	 * Devlinks between the dmaengine device and the consumer device
> > +	 * are optional till all dmaengine drivers are converted/tested.
> > +	 */
> > +	if (chan->device->create_devlink) {
> > +		struct device_link *dl;
> > +
> > +		dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> 
> I suggest link to per channel device, instead dma engine devices.
> chan->dev->device like phy drivers because some dma-engine have per channel
> resources, like power domain and clocks.
> 
> Frank
> 
> > +		if (!dl) {
> > +			dev_err(dev, "failed to create device link to %s\n",
> > +					dev_name(chan->device->dev));
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +	}
> > +
> >  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> >  	if (!chan->name)
> >  		return chan;
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f..c67737a358df659f2bf050a9ccb8d23b17ceb357 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -817,6 +817,8 @@ struct dma_filter {
> >   *	DMA tansaction with no software intervention for reinitialization.
> >   *	Zero value means unlimited number of entries.
> >   * @descriptor_reuse: a submitted transfer can be resubmitted after completion
> > + * @create_devlink: create a devlink between a dma_chan_dev supplier and
> > + *	dma-channel consumer device
> >   * @residue_granularity: granularity of the transfer residue reported
> >   *	by tx_status
> >   * @device_alloc_chan_resources: allocate resources and return the
> > @@ -894,6 +896,7 @@ struct dma_device {
> >  	u32 max_burst;
> >  	u32 max_sg_burst;
> >  	bool descriptor_reuse;
> > +	bool create_devlink;
> >  	enum dma_residue_granularity residue_granularity;
> >
> >  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> >
> > --
> > 2.47.3
> >

-- 
Regards,

Laurent Pinchart

