Return-Path: <dmaengine+bounces-6451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CBB5316A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AED168AAB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E7220F2C;
	Thu, 11 Sep 2025 11:51:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F32DEA9D
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591472; cv=none; b=if3qzatsYZbyj93rPbID6kldmaKzTgJgruyB0AV5rzYfMVe8+qWeWf7U+VwD+RxbCjMcs4KInMB3Q28m12Dw6F8NXk9i+/SrijN3KImK3qQwOoTy2ywvilJbckBe2PSVgZVhMx8O3BkNZXWBtl1lZ1pPRcr0YAuo4KH1g7JNy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591472; c=relaxed/simple;
	bh=g1wJsOjuoZRk5XEGAdAnxXZu7mHjjwjfxtp7rB73yOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS4xnwRIIGLKmxsqumv/JPnQ6v6sW5dWlYltzAN0FdPHQ85s+Sl6Nn/Bs4+d9BF9U8E79M0tPlzHsyhuS+B/cktTyHmt2+3pGh/3b4wdKbCJR/oDlnfMwB6hl7kO2PCV3Mkp6epZAagU1Bc+TS7baKnBGfhosgSNBaMEn5UjIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwfpI-0002zD-Hd; Thu, 11 Sep 2025 13:50:56 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwfpI-000ksS-0g;
	Thu, 11 Sep 2025 13:50:56 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwfpI-000nd0-0D;
	Thu, 11 Sep 2025 13:50:56 +0200
Date: Thu, 11 Sep 2025 13:50:56 +0200
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
Message-ID: <20250911115056.5iufhnjdhsbiwugw@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
 <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
 <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
 <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
 <20250910193545.gx3qoyjamoxlncqd@pengutronix.de>
 <aMHwbogOA6QTc3Dm@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMHwbogOA6QTc3Dm@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-09-10, Frank Li wrote:
> On Wed, Sep 10, 2025 at 09:35:45PM +0200, Marco Felsch wrote:
> > On 25-09-09, Frank Li wrote:
> >
> > ...
> >
> > > > > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > > > > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
> > > > > > --- a/drivers/dma/dmaengine.c
> > > > > > +++ b/drivers/dma/dmaengine.c
> > > > > > @@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > > > >  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > >  	struct dma_device *d, *_d;
> > > > > >  	struct dma_chan *chan = NULL;
> > > > > > +	struct device_link *dl;
> > > > > >
> > > > > >  	if (is_of_node(fwnode))
> > > > > >  		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> > > > > > @@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > > > >  	/* No functional issue if it fails, users are supposed to test before use */
> > > > > >  #endif
> > > > > >
> > > > > > +	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > > > >
> > > > > chan->device->dev is dmaengine devices. But some dmaengine's each channel
> > > > > have device, consumer should link to chan's device, not dmaengine device
> > > > > because some dmaengine support per channel clock\power management.
> > > >
> > > > I get your point. Can you give me some pointers please? To me it seems
> > > > like the dma_chan_dev is only used for sysfs purpose according the
> > > > dmaengine.h.
> > >
> > > Not really, there are other dma engineer already reuse it for other purpose.
> > > So It needs update kernel doc for dma_chan_dev.
> >
> > Can you please provide me some pointers? I checked the kernel code base
> > for the struct::dma_chan_dev. I didn't found any references within the
> > dmaengine drivers. The only usage I found was for the sysfs purpose.
> 
> static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
> {
> 	struct device *chan_dev = &chan->dev->device;
> 	...
> }
> 
> >
> > > > > chan's device's parent devices is dmaengine devices. it should also work
> > > > > for sdma case
> > > >
> > > > I see, this must be tested of course.
> > > > > >         if (chan->device->create_devlink) {
> > > > >                 u32 flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
> > > >
> > > > According device_link.rst: using DL_FLAG_STATELESS and
> > > > DL_FLAG_AUTOREMOVE_CONSUMER is invalid.
> > > >
> > > > >                 if (pm_runtime_active(dev))
> > > > >                         flags |= DL_FLAG_RPM_ACTIVE;
> > > >
> > > > This is of course interessting, thanks for the hint.
> > > >
> > > > > When create device link (apply channel), consume may active.
> > > >
> > > > I have read it as: "resue the supplier and ensure that the supplier
> > > > follows the consumer runtime state".
> > > >
> > > > >                 dl = device_link_add(chan->slave, &chan->dev->device, flags);
> > > >
> > > > Huh.. you used the dmaengine device too?
> > >
> > > /**
> > >  * struct dma_chan_dev - relate sysfs device node to backing channel device
> > >  * @chan: driver channel device
> > >  * @device: sysfs device
> > >  * @dev_id: parent dma_device dev_id
> > >  * @chan_dma_dev: The channel is using custom/different dma-mapping
> > >  * compared to the parent dma_device
> > >  */
> > > struct dma_chan_dev {
> > > 	struct dma_chan *chan;
> > > 	struct device device;
> > > 	int dev_id;
> > > 	bool chan_dma_dev;
> > > };
> > >
> > > struct dma_chan {
> > > 	struct dma_device *device; /// this one should be dmaengine
> > > 	struct dma_chan_dev *dev; /// this one is pre-chan device.
> > > }
> >
> > I've tested your approach but it turns out that teh dma_chan_dev has no
> > driver. Of course we could use the DL_FLAG_STATELESS flag but this is
> > described as:
> >
> > | When driver presence on the supplier is irrelevant and only correct
> > | suspend/resume and shutdown ordering is needed, the device link may
> > | simply be set up with the ``DL_FLAG_STATELESS`` flag.  In other words,
> > | enforcing driver presence on the supplier is optional.
> >
> > I want to enforce the driver presence, therefore I used the manged flags
> > which excludes the DL_FLAG_STATELESS, if I get it right.
> >
> > Please see the below the debug output:
> >
> > ** use the dmaengine device as supplier **
> >
> > device_link_init_status: supplier.dev:30bd0000.dma-controller supplier.drv:imx-sdma supplier.status:0x2 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> > device_link_init_status: supplier.dev:30e10000.dma-controller supplier.drv:imx-sdma supplier.status:0x2 consumer:dev:30c20000.sai consumer.drv:fsl-sai consumer.status:0x1
> >
> >
> > ** use the dma channel device as supplier **
> >
> > device_link_init_status: supplier.dev:dma0chan0 supplier.drv:no-driver supplier.status:0x0 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> > device_link_init_status: supplier.dev:dma0chan1 supplier.drv:no-driver supplier.status:0x0 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> 
> It should be similar with phy drivers, which phy_create() create individual
> phy devices (like dma channel devices).

Unfortunately phy drivers do use the DL_FLAG_STATELESS mechanism. My
main goal was to have managed links to overcome the current situation:
dmaengine drivers can be removed without removing the consumer drivers
first.

You have a valid point by making use dma-channel devices ( dma<X>cha<Y>)
to manage suspend/resume, as well as runtime-PM for each channel.

But I see this rather as an addition to my solution because these links
must be stateless and stateless/unmanaged links don't guarantee the
correct remove order (my main goal).

That beeing said, I'm not sure how you want to handle the clock/power
enablement per channel-device. This would require additional work on the
dma_devclass to add a proper .pm hook else the PM and runtime-PM calls
are only forwarded to the parent dmaengine driver. On this level the
dmaengine driver has no knowledge which channel is going to be
enabled/disabled.

In conclusion, I see my approach as valid to ensure the correct remove
order. Your suggestion is valid and can be added later on too since this
needs more work to have a proper per-channel runtime-PM.

Regards,
  Marco

> 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 51 at /drivers/base/core.c:1387 device_links_driver_bound+0x170/0x3a0
> > ...
> > ---[ end trace 0000000000000000 ]---
> > ------------[ cut here ]------------
> >
> > As said, I get your point regarding the usage of the dma-channel device
> > but I didn't found any reference to a driver which used the dma-channel
> > device. Also since I want to have the supply driver to enforced by the
> > devlink I don't want to use the DL_FLAG_STATELESS flag.
> 
> Maybe add DL_FLAG, link to parent's device driver. Need some time to
> investigate more. PHY driver should good example to refer to.
> 
> >
> > Regarding your point, that some DMA controllers may have seperate clocks
> > for each channel: I think this can be handled by the dmaengine driver,
> > e.g. via the device_alloc_chan_resources() hook.
> 
> device_alloc_chan_resources() is not efficient enough, most driver allocate
> channel at probe, so clk of this channel will be always on. ideally, only
> when consumer devices is runtime resume state,  turn on dma channel clock.
> 
> Frank
> >
> > @all
> > I'm pleased about any input :)
> >
> > Regards,
> >   Marco
> 

