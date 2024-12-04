Return-Path: <dmaengine+bounces-3876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9249E3A4D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0316B34330
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055A1BD032;
	Wed,  4 Dec 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDOl4K0/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0B1BC08B;
	Wed,  4 Dec 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315256; cv=none; b=N/oOhsZNzFZaOEUs73pRtPV/jK6ZtjLanejTDPCfUrEz7b4ySi7UtS2y+IGtMmYvn8PP6j7vWdp74Qfwcz1i9kzweJerwHjA1WSasZncPM7hT+HO8wprJT3EQaZsm6lZAfI2QsgvvUUv2xqaAtIxGjn9eZ4BCAY7DHh8/HXasmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315256; c=relaxed/simple;
	bh=Tf2N6u4X8T3vx9X8/GSCe+wHISQSsJpRIqZ4jdWOQhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGlsLM0gMW7nxxhvPm7oL2Wlf+2U1erWMkLA2ksY4UfdGC56/jlvjorlYCrCawkFvDQNYB09lLoB7vIawKKW/dmIkrrNc4nO7wp5FhRJNA69aqoio/gP0W7G7KUxm8jLxJb7X8yDszdZAavnTBPvSP6LlO5SqNDnoR02JomB7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDOl4K0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41900C4CED1;
	Wed,  4 Dec 2024 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733315255;
	bh=Tf2N6u4X8T3vx9X8/GSCe+wHISQSsJpRIqZ4jdWOQhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDOl4K0/L3XsCDjL2mHnFZZjDG0k3XFNtrRIAMxEGvSfdqy8jckhtbl1MtBS/aqth
	 ZM1imGjRPctJZuFJmVJVsM+CclByUFIxt8BwlUXyWWT+jCW0QWy3cMpxOszYsvVfra
	 IE8X0egYx5puCN0hCXnHTV+PZcfigGbItA2UjOV4GbU34uv3M44W0Zv7+XrUDRM668
	 RwztyBG54VEeXir6p93oOZCNI6x4nhcCs1AwjKIWFYHxSIhelpBYifmorF47xI1H65
	 FC3hcIz09kR3LEB61ZbTBAGTzNWm4k7Ihz5fJq7Sep2k2aYjUUuChGyLEi2CqeSDt1
	 paANWv7fZpMzw==
Date: Wed, 4 Dec 2024 17:57:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH V5 2/9] dmaengine: bcm2835-dma: add suspend/resume pm
 support
Message-ID: <Z1BKtHPN+2qiveHJ@vaman>
References: <20241025103621.4780-1-wahrenst@gmx.net>
 <20241025103621.4780-3-wahrenst@gmx.net>
 <Z03l308ur7xuE1SB@vaman>
 <d418a30d-f0b0-49c5-8f2a-ddda9a7eeb07@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d418a30d-f0b0-49c5-8f2a-ddda9a7eeb07@gmx.net>

On 02-12-24, 19:51, Stefan Wahren wrote:
> Hi Vinod,
> 
> Am 02.12.24 um 17:52 schrieb Vinod Koul:
> > On 25-10-24, 12:36, Stefan Wahren wrote:
> > > bcm2835-dma provides the service to others, so it should
> > > suspend late and resume early.
> > > 
> > > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > > ---
> > >   drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > > index e1b92b4d7b05..647dda9f3376 100644
> > > --- a/drivers/dma/bcm2835-dma.c
> > > +++ b/drivers/dma/bcm2835-dma.c
> > > @@ -875,6 +875,35 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
> > >   	return chan;
> > >   }
> > > 
> > > +static int bcm2835_dma_suspend_late(struct device *dev)
> > > +{
> > > +	struct bcm2835_dmadev *od = dev_get_drvdata(dev);
> > > +	struct bcm2835_chan *c, *next;
> > > +
> > > +	list_for_each_entry_safe(c, next, &od->ddev.channels,
> > > +				 vc.chan.device_node) {
> > > +		void __iomem *chan_base = c->chan_base;
> > > +
> > > +		if (readl(chan_base + BCM2835_DMA_ADDR)) {
> > > +			dev_warn(dev, "Suspend is prevented by chan %d\n",
> > > +				 c->ch);
> > > +			return -EBUSY;
> > > +		}
> > Can you help understand how this helps by logging... we are not adding
> > anything except checking this and resume is NOP as well!
> My intention of this patch is just to make sure, that no DMA transfer is
> in progress during late_suspend. So i followed the implementation of
> fsldma.c
> 
> Additionally i added this warning mostly to know if this ever occurs.
> But i wasn't able to trigger.

Okay in the case I dont think it is a abd idea. But the patch
description should mention that add a warning while suspending if
channels are active or something like that.
Patch title and description should mention this..

> 
> Should i drop the warning and make resume callback = NULL?

Yes that would be better as well, no point in having dummy code

-- 
~Vinod

