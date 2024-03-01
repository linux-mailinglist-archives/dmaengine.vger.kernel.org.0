Return-Path: <dmaengine+bounces-1214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C753D86E2D2
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BB91C20BF9
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9D6EB56;
	Fri,  1 Mar 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ayRVMTn2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LXO3nMUZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AgBaMp8q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syRxMmZ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572F6EB52;
	Fri,  1 Mar 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301349; cv=none; b=Dzt/7aP5a05gZUXayHwDAebWZ5FW9I1foyVZ5P9o6dwukNSDMA6jxhieoYgM/8ceFIqoX/M/S9F9l8j4Y1Gr1LyfAHwaTk2Bzf7ov6SsmEWj0LJiqphWHGydX33cZc6GqHV5tgzKQhtTy6sm8MGfmJ8xJ4BebVjI0XhlJO0WX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301349; c=relaxed/simple;
	bh=3hrWIthYyqTMLuS3XHF4A0/c+QGJASBf1+y9bQKt0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgoIvpuWlDFLGoyvJeAf5Z0Ek52wv6YFraV5VhhEr87S4Lz22qjG8zimUPtePdVLEah16IlP2KWQzZr/WlMO422qByU1r/t2xYGLVsv0sjG8UwfLfcoIMSoUrBnsuhA29nSvrmMfzoTgVj7Kb/fx0Ni5m2epIBW2ppYNCHqh4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ayRVMTn2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LXO3nMUZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AgBaMp8q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syRxMmZ+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1B3A22D5F;
	Fri,  1 Mar 2024 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709301339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24jGTan3PFnpCEBhN6T2OEe8QFjQk85yxFC3EYC70Mk=;
	b=ayRVMTn2TF7NxaJ79MminGnvCX5VSasYg9i4f0fOHzv4zADrTqcBrKI4k3wX4n7FNv6vXh
	hqPbnAwa1mhFPbrYh+V6Rl9ACceEaiCh0YD27LKCCt8iRhI/3Bt+QpSzQTArNQ2frEEz+i
	aVCx7fardqEKSoIwasvoHIEXOyXGoc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709301339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24jGTan3PFnpCEBhN6T2OEe8QFjQk85yxFC3EYC70Mk=;
	b=LXO3nMUZQfn+rhiNce5J4abXmDZhhzusu9MzfHfbQ60Zyxnsp9+2itEK1q94JcPA3etB9z
	iaVsnnQgvaoEX6Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709301338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24jGTan3PFnpCEBhN6T2OEe8QFjQk85yxFC3EYC70Mk=;
	b=AgBaMp8q8eVNAQtFIJXbMfW9tYhwRp7/ulsbcwIqhU7EYJn5vudG0JMASjtCBttvzPSM/f
	Z2jvBQRNbQ/aib1yfvxc1Znm11T0kNJMWM4CBwhNMwzqbKsSIE+/LxE69wk82SD0SHLLIv
	R/+ZFVm/IGq31UXdLPCpx2kGhyUroWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709301338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24jGTan3PFnpCEBhN6T2OEe8QFjQk85yxFC3EYC70Mk=;
	b=syRxMmZ+iklqkw2LyS0JzobSCCTuvfIkOQoQN1i6Iy+9iuKWsMXBOna1iE5wVdYZYHkDEK
	rMH/WdTQWD8Fw+Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D104413581;
	Fri,  1 Mar 2024 13:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sAMDMVre4WXZWgAAn2gu4w
	(envelope-from <aporta@suse.de>); Fri, 01 Mar 2024 13:55:38 +0000
Date: Fri, 1 Mar 2024 14:55:30 +0100
From: Andrea della Porta <aporta@suse.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 04/12] bcm2835-dma: Advertise the full DMA range
Message-ID: <ZeHeUh06ZBazgMDO@apocalypse>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <a56a6d24066a64598efe4343090e51e2223475b8.1706948717.git.andrea.porta@suse.com>
 <1e71c153-e482-409c-b229-9b9c0662b67e@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e71c153-e482-409c-b229-9b9c0662b67e@arm.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AgBaMp8q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=syRxMmZ+
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.com,kernel.org,broadcom.com,vger.kernel.org,lists.infradead.org,cerno.tech,gmail.com,raspberrypi.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F1B3A22D5F
X-Spam-Level: 
X-Spam-Score: -4.81
X-Spam-Flag: NO

On 17:55 Mon 05 Feb     , Robin Murphy wrote:
> On 2024-02-04 6:59 am, Andrea della Porta wrote:
> > From: Phil Elwell <phil@raspberrypi.com>
> > 
> > Unless the DMA mask is set wider than 32 bits, DMA mapping will use a
> > bounce buffer.
> > 
> > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > ---
> >   drivers/dma/bcm2835-dma.c | 18 +++++++++++++++---
> >   1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index 36bad198b655..237dcdb8d726 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -39,6 +39,7 @@
> >   #define BCM2711_DMA_MEMCPY_CHAN 14
> >   struct bcm2835_dma_cfg_data {
> > +	u64	dma_mask;
> >   	u32	chan_40bit_mask;
> >   };
> > @@ -308,10 +309,12 @@ DEFINE_SPINLOCK(memcpy_lock);
> >   static const struct bcm2835_dma_cfg_data bcm2835_dma_cfg = {
> >   	.chan_40bit_mask = 0,
> > +	.dma_mask = DMA_BIT_MASK(32),
> >   };
> >   static const struct bcm2835_dma_cfg_data bcm2711_dma_cfg = {
> >   	.chan_40bit_mask = BIT(11) | BIT(12) | BIT(13) | BIT(14),
> > +	.dma_mask = DMA_BIT_MASK(36),
> >   };
> >   static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
> > @@ -1263,6 +1266,8 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
> >   static int bcm2835_dma_probe(struct platform_device *pdev)
> >   {
> > +	const struct bcm2835_dma_cfg_data *cfg_data;
> > +	const struct of_device_id *of_id;
> >   	struct bcm2835_dmadev *od;
> >   	struct resource *res;
> >   	void __iomem *base;
> > @@ -1272,13 +1277,20 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
> >   	int irq_flags;
> >   	uint32_t chans_available;
> >   	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
> > -	const struct of_device_id *of_id;
> >   	int chan_count, chan_start, chan_end;
> > +	of_id = of_match_node(bcm2835_dma_of_match, pdev->dev.of_node);
> > +	if (!of_id) {
> > +		dev_err(&pdev->dev, "Failed to match compatible string\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	cfg_data = of_id->data;
> 
> We've had of_device_get_match_data() for nearly 9 years now, and even a
> generic device_get_match_data() for 6 ;)
> 
> > +
> >   	if (!pdev->dev.dma_mask)
> >   		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> 
> [ Passing nit: that also really shouldn't be there, especially since
> cdfee5623290 ]
> 
> > -	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +	rc = dma_set_mask_and_coherent(&pdev->dev, cfg_data->dma_mask);
> 
> Wait, does chan_40bit_mask mean that you still have some channels which
> *can't* address this full mask? If so this can't work properly. You may well
> need to redesign a bit further to have a separate DMA device for each
> channel such they can each have different masks.
>

It seems that the original intention here was to create a device for each value of dma_mask in
hw descriptors. That is, for 2711 which has 32 and 40 bit channels, the DT should look something
like this:

	dma: dma-controller@7e007000 {
		interrupts = <...>;
		brcm,dma-channel-mask = <0x7f5>;
		compatible = "brcm,bcm2835-dma";
		interrupt-names = "...";
		reg = <0x7e007000 0xb00>;
		#dma-cells = <0x01>;
	};      

	dma40: dma-controller@7e007b00 {
		interrupts = <...>;     
		brcm,dma-channel-mask = <0x3000>;
		compatible = "brcm,bcm2711-dma";
		interrupt-names = "...";
		reg = <0x00 0x7e007b00 0x00 0x400>;
		#dma-cells = <0x01>;
	};

Two devices dma0 and dma1 will be created, each one serving a different mask and the call
to dma_set_mask_and_coherent(..., dma_mask) on the specific device will be consistent. Please
note that of course "brcm,dma-channel-mask" from DT only refers to what channels are available
to be used in the kernel, while dma_mask parameter of the aforementioned dma_set_mask_and_coherent()
call is the addressing mask enforced by the driver, and its the same for each specific device
(dma0 or dma1).

Many thanks,
Andrea

