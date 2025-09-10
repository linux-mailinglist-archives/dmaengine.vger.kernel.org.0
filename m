Return-Path: <dmaengine+bounces-6433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3EB5129A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83994660DA
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD53148A1;
	Wed, 10 Sep 2025 09:34:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C7313547
	for <dmaengine@vger.kernel.org>; Wed, 10 Sep 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496883; cv=none; b=uX3uu56FPlo3bntpX/zhczsGzwd5e4Yls0UaOSR4EwaFOvCCAQhdMc9xfhe9OjfoV6ZMCc9Lzkt12UYruMJVzJJ24LkFUT8mdYuLqJPJhGoetLa6bQLQrnFb7O4U3C3XWzopHEArqGqZ4nMKrWpdlb7m6F5nlyTeScyCoZSHff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496883; c=relaxed/simple;
	bh=ftDfmHApYEI/kLahMFO4fkdDsJP51o7c9whkaMg8jO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCnayGzuv52HDrS+h6Oc2nnUbDeC9K3mf5bFxBBBaYBRINoE9YPhthIzorzMfQa5QysCfWzsuuSf8oc/j897XTBQ+WMKXPgRjiMJLVKtsnWVs71IhKppZO6Ssce4F01DDEnFKEX8L+YbTQ2MI2u+XuLmXVYJtnmw2l2f5/GergA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHDh-0007O8-2b; Wed, 10 Sep 2025 11:34:29 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHDg-000ZLH-1S;
	Wed, 10 Sep 2025 11:34:28 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHDg-00GDJG-12;
	Wed, 10 Sep 2025 11:34:28 +0200
Date: Wed, 10 Sep 2025 11:34:28 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] dmaengine: add support for device_link
Message-ID: <20250910093428.qq5vskqhvumgjsow@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
 <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
 <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
 <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-09-09, Frank Li wrote:
> On Tue, Sep 09, 2025 at 02:03:09PM +0200, Marco Felsch wrote:
> > Hi Frank,
> >
> > On 25-09-03, Frank Li wrote:
> > > On Wed, Sep 03, 2025 at 03:06:17PM +0200, Marco Felsch wrote:
> > > > Add support to create device_links between dmaengine suppliers and the
> > > > dma consumers. This shifts the device dep-chain teardown/bringup logic
> > > > to the driver core.
> > > >
> > > > Moving this to the core allows the dmaengine drivers to simplify the
> > > > .remove() hooks and also to ensure that no dmaengine driver is ever
> > > > removed before the consumer is removed.
> > > >
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > >
> > > Thank you work for devlink between dmaengine and devices. I have similar
> > > idea.
> > >
> > > This patch should be first patch.
> >
> > I can shuffle it of course!
> >
> > > The below what planned commit message in my local tree.
> >
> > Okay, so you focused on runtime PM handling. Not quite sure if I can
> > test this feature with the SDMA engine. I also have limited time for
> > this feature.
> >
> > Is it okay for you and the DMA maintainers to add the runtime PM feature
> > as separate patch (provided by NXP/Frank)?
> 
> we can support runtime pm later.
> 
> >
> > > Implementing runtime PM for DMA channels is challenging. If a channel
> > > resumes at allocation and suspends at free, the DMA engine often remains on
> > > because most drivers request a channel at probe.
> > >
> > > Tracking the number of pending DMA descriptors is also problematic, as some
> > > consumers append new descriptors in atomic contexts, such as IRQ handlers,
> > > where runtime resume cannot be called.
> > >
> > > Using a device link simplifies this issue. If a consumer requires data
> > > transfer, it must be in a runtime-resumed state, ensuring that the DMA
> > > channel is also active by device link. This allows safe operations, like
> > > appending new descriptors. Conversely, when the consumer no longer requires
> > > data transfer, both it and the supplier (DMA channel) can enter a suspended
> > > state if no other consumer is using it.
> > >
> > > Introduce the `create_link` flag to enable this feature.
> > >
> > > also suggest add create_link flag to enable this feature in case some
> > > side impact to other dma-engine. After some time test, we can enable it
> > > default.
> >
> > What regressions do you have in mind? I wouldn't hide the feature behind
> > a flag because this may slow done the convert process, because no one is
> > interessted in, or has no time for testing, ...
> 
> Unlike other devices, like phys, regulator, mailbox..., which auto create
> devlink at probe. I am not clear why dma skip this one. So I think there
> should be some reason behind. Maybe other people, rob or Vinod Koul know
> the reason.
> 
> static const struct supplier_bindings of_supplier_bindings[] = {
>         ...
> 	{ .parse_prop = parse_dmas, .optional = true, },
> 
> If remove "optional = true", devlink will auto create. I am not sure why
> set true here.

I've seen this too. Could be because DMA controllers + users aren't OF
related and therefore should be handled within the framework itself.

> > > >  drivers/dma/dmaengine.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
> > > > --- a/drivers/dma/dmaengine.c
> > > > +++ b/drivers/dma/dmaengine.c
> > > > @@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > >  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > >  	struct dma_device *d, *_d;
> > > >  	struct dma_chan *chan = NULL;
> > > > +	struct device_link *dl;
> > > >
> > > >  	if (is_of_node(fwnode))
> > > >  		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> > > > @@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > >  	/* No functional issue if it fails, users are supposed to test before use */
> > > >  #endif
> > > >
> > > > +	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > >
> > > chan->device->dev is dmaengine devices. But some dmaengine's each channel
> > > have device, consumer should link to chan's device, not dmaengine device
> > > because some dmaengine support per channel clock\power management.
> >
> > I get your point. Can you give me some pointers please? To me it seems
> > like the dma_chan_dev is only used for sysfs purpose according the
> > dmaengine.h.
> 
> Not really, there are other dma engineer already reuse it for other purpose.
> So It needs update kernel doc for dma_chan_dev.

Okay.

> > > chan's device's parent devices is dmaengine devices. it should also work
> > > for sdma case
> >
> > I see, this must be tested of course.
> > > >         if (chan->device->create_devlink) {
> > >                 u32 flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
> >
> > According device_link.rst: using DL_FLAG_STATELESS and
> > DL_FLAG_AUTOREMOVE_CONSUMER is invalid.
> >
> > >                 if (pm_runtime_active(dev))
> > >                         flags |= DL_FLAG_RPM_ACTIVE;
> >
> > This is of course interessting, thanks for the hint.
> >
> > > When create device link (apply channel), consume may active.
> >
> > I have read it as: "resue the supplier and ensure that the supplier
> > follows the consumer runtime state".
> >
> > >                 dl = device_link_add(chan->slave, &chan->dev->device, flags);
> >
> > Huh.. you used the dmaengine device too?
> 
> /**
>  * struct dma_chan_dev - relate sysfs device node to backing channel device
>  * @chan: driver channel device
>  * @device: sysfs device
>  * @dev_id: parent dma_device dev_id
>  * @chan_dma_dev: The channel is using custom/different dma-mapping
>  * compared to the parent dma_device
>  */
> struct dma_chan_dev {
> 	struct dma_chan *chan;
> 	struct device device;
> 	int dev_id;
> 	bool chan_dma_dev;
> };
> 
> struct dma_chan {
> 	struct dma_device *device; /// this one should be dmaengine
> 	struct dma_chan_dev *dev; /// this one is pre-chan device.
> }

Argh.. mixed it within my head while writing the mail :/

Regards,
  Marco

