Return-Path: <dmaengine+bounces-9757-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DSdOQWMy2kuIwYAu9opvQ
	(envelope-from <dmaengine+bounces-9757-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:55:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA645366853
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1988303D29D
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19073E0C6B;
	Tue, 31 Mar 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh4Yggzj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0483DEAE9
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946752; cv=none; b=oCxIIhzxbBIrScvBtMTgJpreMe54BVN/GM+edQegMt+GdGEJ1ZY0mSIk+Fx49b92GgIVLMTq8AKxVjdO9VOGW6EDdURKWMGaXNwqfomADmNMCkIT87rUzT6FsHGzlmGSgd6zhy2KTrm9RV6zzLMaaZ+yKubCXFLelumKYB7vwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946752; c=relaxed/simple;
	bh=O0yM7XuRJP5G60ySmr2EGl5SOM6KAgYuY7taUORfZhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPpHSDkIfDDzzythRhTfl9rbCTrZvJ3iyy6aTuJaX2NxF5ezbJ1yXvMZVyCUT1WyCSyO/coSlvRT1yK4150YeqhVvlVgSg98fOSuSP2EQtWw5uHDZBMZnv7Q0N9xzt/lCCgyChE7gmoZx35zSGdU+ghU7J3EkF/Ni06BQMMCWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh4Yggzj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486507134e4so62348545e9.0
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946749; x=1775551549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HtDaHUAWiDkq+2zyDNr4VypANemvXrePJQ+g8Y/BMcE=;
        b=Uh4YggzjWSSK425r26BEb4C8+7+hyir0MzFrNMJtglUZlZLT4DCbyATOP1zsommSsa
         XIGy3/DJ65bufVqn9dkxZVYgFYTk/HxUeJHVH+CQpIe8jvEHM8r60yBH9BJpD5I3BgAI
         0k0QDNrM//OERPWai3zSPN4bRlo0BLK8De/lNUGdegRtec2Tw9h7VgiolcCLbGNSl5Hs
         epch5CWZQBFwNgW/pkkcZNuXxYfaSADPWynUIzzEizNUmtK4ZWVispD+T3nB48ies1nX
         FVrX42r6THl5nPTcWypDs6UQmgx5BDnR9vGwo0mix1RkvO/uhBwXF+9odeQSud+vt4OV
         naSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946749; x=1775551549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtDaHUAWiDkq+2zyDNr4VypANemvXrePJQ+g8Y/BMcE=;
        b=nuXdIojn3fauy5XyY2+uLPg2ZlkAcN3n44ni8O8fzn/VBNv/1O9ccsThcESaEVj7ET
         11AAzGqWbciuU3mV4ED6egLj1pqJJG/0Nv8I6D2E7uslu++sOGwyEEapijZwjXQef6dw
         Bk9+eTMl3tyEJ5JUqxAHU1hT32QecZ5bwwoKtvQpRXEGNT5WcbTC/7bTPZ0IBNXCqfYM
         6iT0DP0teufa253n7MtqLnS+gnzJreoFHciAXrlXStTMTVXSpUooaRyXRX++OnN36H2X
         l8Vz8xg1Uzk0xB1DCXlT61PMxx6TpnySjr9DK9UCCOXqsPglQKdeJG6BlIdSiUWV1b/1
         /EUA==
X-Forwarded-Encrypted: i=1; AJvYcCUkd8vJcOKKbov6g9+r8gKjlebns9yzejmDNLzI2kRdmjFAaMyS0CCz+W0SWhXLWNO1Jqeh8HJu6BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+J4i5K7EGKOHlK+7zV1OvkT+R4DBIAKRykwqYE37aj80zrR9
	49f4ZjN3kn5XLAmhnULt51rbAD60+ITQahRQ2mJDavO5swOfj8qSqeLN
X-Gm-Gg: ATEYQzwwBaSDVD7WytNd2xnJzu9MPn8opy3Udx8/jZDmx1fjwLvMfMzJgQAVPmqH+x/
	026a/5u26Nr5qFWl8RspscHBmpufYtfRbf46zAhMdmX1zaYf9nOvnr5DZD143YS49zv3LZukBVp
	vixh6wADwTg6C6EEuZNgR+1dGxjklTJoC5EuASudJGnv1aMFBvpmLv21rQ7YtZIl7rKogWrmWZk
	mOE3EcmJabdPJwW7b6kytNqt2xS75WyKag092bhkmDVF/SUtbuaHCxcN3TFb6Bvy40vnSBjK3o2
	XAQ0zHFBM0PJcepyZTFd5uvVOIrFoThCPUs9n4XFNawF9ZukViSjDSAMBeqO1LekYTHHXBBiT3I
	3+8pA+JB/Wk7u/qMY/vU/mGA8C2XE4wxzX79E+vrIykX8d4iKT1i+eL/vLAXDcZUeU0maV9FEVE
	okcc0uzRQEjhWR
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-48727d5a313mr264087635e9.6.1774946749239;
        Tue, 31 Mar 2026 01:45:49 -0700 (PDT)
Received: from nsa ([185.128.9.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80140esm18687875e9.4.2026.03.31.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:45:48 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:46:35 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 3/4] dmaengine: dma-axi-dmac: fix use-after-free on
 unbind
Message-ID: <acuI7MOEMmAgGwve@nsa>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-3-021f95f0e87b@analog.com>
 <acqVIrUwtIM5AaG3@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acqVIrUwtIM5AaG3@lizhi-Precision-Tower-5810>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9757-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA645366853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:22:10AM -0400, Frank Li wrote:
> On Fri, Mar 27, 2026 at 04:58:40PM +0000, Nuno Sá wrote:
> > The DMA device lifetime can extend beyond the platform driver unbind if
> > DMA channels are still referenced by client drivers. This leads to
> > use-after-free when the devm-managed memory is freed on unbind but the
> > DMA device callbacks still access it.
> >
> > Fix this by:
> >  - Allocating axi_dmac with kzalloc_obj() instead of devm_kzalloc() so
> > its lifetime is not tied to the platform device.
> >  - Implementing the device_release callback that so that we can free
> > the object when reference count gets to 0 (no users).
> >  - Adding an 'unbound' flag protected by the vchan lock that is set
> > during driver removal, preventing MMIO accesses after the device has been
> > unbound.
> >
> > While at it, explicitly include spinlock.h given it was missing.
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> 
> Not sure if it similar with
> https://lore.kernel.org/dmaengine/20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de/
> 
> It looks like miss device link between comsumer and provider.

Well, it surely it's related. I mean, if we ensure the consumers are
gone through devlinks and nothing is left behind, then this patch is basically unneeded.
 
But, FWIW, my 2cents would also go into questioning if AUTOREMOVE is
really want we want in every situation? Might be to harsh to assume that
a DMA channel consumer is useless even if DMA is gone. Anyways, is there
a v2 already? I would be interested in following this one...

- Nuno Sá

> 
> Frank
> 
> >  drivers/dma/dma-axi-dmac.c | 70 +++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 60 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index 127c3cf80a0e..70d3ad7e7d37 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > +#include <linux/spinlock.h>
> >
> >  #include <dt-bindings/dma/axi-dmac.h>
> >
> > @@ -174,6 +175,8 @@ struct axi_dmac {
> >
> >  	struct dma_device dma_dev;
> >  	struct axi_dmac_chan chan;
> > +
> > +	bool unbound;
> >  };
> >
> >  static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
> > @@ -182,6 +185,11 @@ static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
> >  		dma_dev);
> >  }
> >
> > +static struct axi_dmac *dev_to_axi_dmac(struct dma_device *dev)
> > +{
> > +	return container_of(dev, struct axi_dmac, dma_dev);
> > +}
> > +
> >  static struct axi_dmac_chan *to_axi_dmac_chan(struct dma_chan *c)
> >  {
> >  	return container_of(c, struct axi_dmac_chan, vchan.chan);
> > @@ -614,7 +622,12 @@ static int axi_dmac_terminate_all(struct dma_chan *c)
> >  	LIST_HEAD(head);
> >
> >  	spin_lock_irqsave(&chan->vchan.lock, flags);
> > -	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> > +	/*
> > +	 * Only allow the MMIO access if the device is live. Otherwise still
> > +	 * go for freeing the descriptors.
> > +	 */
> > +	if (!dmac->unbound)
> > +		axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> >  	chan->next_desc = NULL;
> >  	vchan_get_all_descriptors(&chan->vchan, &head);
> >  	list_splice_tail_init(&chan->active_descs, &head);
> > @@ -642,9 +655,12 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> >  	if (chan->hw_sg)
> >  		ctrl |= AXI_DMAC_CTRL_ENABLE_SG;
> >
> > -	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
> > -
> >  	spin_lock_irqsave(&chan->vchan.lock, flags);
> > +	if (dmac->unbound) {
> > +		spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > +		return;
> > +	}
> > +	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
> >  	if (vchan_issue_pending(&chan->vchan))
> >  		axi_dmac_start_transfer(chan);
> >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > @@ -1184,6 +1200,14 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
> >  	return 0;
> >  }
> >
> > +static void axi_dmac_release(struct dma_device *dma_dev)
> > +{
> > +	struct axi_dmac *dmac = dev_to_axi_dmac(dma_dev);
> > +
> > +	put_device(dma_dev->dev);
> > +	kfree(dmac);
> > +}
> > +
> >  static void axi_dmac_tasklet_kill(void *task)
> >  {
> >  	tasklet_kill(task);
> > @@ -1194,16 +1218,27 @@ static void axi_dmac_free_dma_controller(void *of_node)
> >  	of_dma_controller_free(of_node);
> >  }
> >
> > +static void axi_dmac_disable(void *__dmac)
> > +{
> > +	struct axi_dmac *dmac = __dmac;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dmac->chan.vchan.lock, flags);
> > +	dmac->unbound = true;
> > +	spin_unlock_irqrestore(&dmac->chan.vchan.lock, flags);
> > +	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> > +}
> > +
> >  static int axi_dmac_probe(struct platform_device *pdev)
> >  {
> >  	struct dma_device *dma_dev;
> > -	struct axi_dmac *dmac;
> > +	struct axi_dmac *__dmac;
> >  	struct regmap *regmap;
> >  	unsigned int version;
> >  	u32 irq_mask = 0;
> >  	int ret;
> >
> > -	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> > +	struct axi_dmac *dmac __free(kfree) = kzalloc_obj(struct axi_dmac);
> >  	if (!dmac)
> >  		return -ENOMEM;
> >
> > @@ -1251,6 +1286,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >  	dma_dev->dev = &pdev->dev;
> >  	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> >  	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > +	dma_dev->device_release = axi_dmac_release;
> >  	dma_dev->directions = BIT(dmac->chan.direction);
> >  	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> >  	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > @@ -1285,12 +1321,21 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	/*
> > +	 * From this point on, our dmac object has it's lifetime bounded with
> > +	 * dma_dev. Will be freed when dma_dev refcount goes to 0. That means,
> > +	 * no more automatic kfree(). Also note that dmac is now NULL so we
> > +	 * need __dmac.
> > +	 */
> > +	__dmac = no_free_ptr(dmac);
> > +	get_device(&pdev->dev);
> > +
> >  	/*
> >  	 * Put the action in here so it get's done before unregistering the DMA
> >  	 * device.
> >  	 */
> >  	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
> > -				       &dmac->chan.vchan.task);
> > +				       &__dmac->chan.vchan.task);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -1304,13 +1349,18 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
> > -			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
> > +	/* So that we can mark the device as unbound and disable it */
> > +	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_disable, __dmac);
> >  	if (ret)
> >  		return ret;
> >
> > -	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
> > -		 &axi_dmac_regmap_config);
> > +	ret = devm_request_irq(&pdev->dev, __dmac->irq, axi_dmac_interrupt_handler,
> > +			       IRQF_SHARED, dev_name(&pdev->dev), __dmac);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regmap = devm_regmap_init_mmio(&pdev->dev, __dmac->base,
> > +				       &axi_dmac_regmap_config);
> >
> >  	return PTR_ERR_OR_ZERO(regmap);
> >  }
> >
> > --
> > 2.53.0
> >

