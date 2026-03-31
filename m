Return-Path: <dmaengine+bounces-9784-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAHlIJzny2myMQYAu9opvQ
	(envelope-from <dmaengine+bounces-9784-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 17:26:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B836BA39
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22466306B9E7
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382ED1DF748;
	Tue, 31 Mar 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Tc7X5p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC893D8114
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970424; cv=none; b=W4aPpcJCpRUkdCNSg1U/EswyB0Vq3jEWIcd9emm65glsKUqYS2YnIAXopg6VOJUaDpn0veAhlZZLxDEWFql+SleY82yWoow2yJmBfSk/LF7UUN9Z+TmW1Id/K18kmZSoD7CqDVm8B9lEqfE0+ETKeDdSVhw1L5ikpTJc+Hmj39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970424; c=relaxed/simple;
	bh=l0LlDkyfvY8y3McluW/DvtUp/NGA9DqtzzZt/NcX++Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr62XW+jIrDrcRzSa/NiHboAKkrnMAYCC8VM6QlLrGqNnJHxO5f/Nxqkyle1VLDPxrj4NSunOlGquoecL0N7/grEb7kml9nPbeXLSTalFlptj0lmeYejNZj2ySTrvnvE8vXzAb4e4c/KP7tpFi0KXj+MnpdRw7XSM8C/C7FHVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Tc7X5p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso10675865e9.1
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970421; x=1775575221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pe9dJRCGIOyBk6tQN/a+uxmJvmi9jHnWQcAWjuN5jZY=;
        b=M/Tc7X5p634rjXveDYdjx0CiIlu8/pz8SbSEtO+eahN0eCNi2XqojTOucjGVM7NjHI
         KdJeW/OblaeAePgSbvYIZIR6GnrJHLgZyguVlIC/OxrJrJqL9HT03+cDTikdE17Px2du
         SPbmsanBuFgRisfFUZ37BsIEFMtn9ee0LGe7w+f7MqxZsNJTE4PLlhXofUW8k4fyr+gY
         Ci+0UAu/SDSHVnqr29fbvZT8ONvdFZetWHnZkcENcWplE4/9HWueVjmb7UuzxvlmQP7P
         /4shLyGYpV4/rW1Ju5T32xAYVK+702zpno+F6NIt+OO/6sjj6ujV0xskDaiZ0XcUjBQI
         vIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970421; x=1775575221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe9dJRCGIOyBk6tQN/a+uxmJvmi9jHnWQcAWjuN5jZY=;
        b=r5wAwCrWJ+jTnu1vq5CMXIKqXa5ObdDEA8oExBQxq0oEdklj3TerIyHcGinopNOjKv
         noSmNpV7uHILanWKC9PhgP9PVy5qUJFyQg9JwFc8uqUXIzdJrO0FFCRptzVlaO/kIG2k
         T5Si3bPX2o3mHVeDENpE5DAmW5k4ufQmqklsqGuVOY/l1E6zHVz6/use338RQLwaf5gs
         xNytYUW6W3BFdh/H1Dz/H7aYtkglgpAn1FkqmlAu1JQOQhvUQcVbsQRJbGQ0EZviGpi9
         CEzAsaEDKTwcQoW6hn/xsvMsykYSExPBOs7XIx6Df0aj5NSNgkEQC8gQP3Rw8aWm/FTv
         suBg==
X-Forwarded-Encrypted: i=1; AJvYcCVTrVWtPPExc1a53kJ4qEpEOCqTj5cBjS7TkR9kF7BH5CY5I/QcRtYljrwndgLkXjJddzAs1Dt99Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ke8MUq0YtKGcxmvH3I0MmuMo1eI+w8coVSKQ55Z6I3PAdGbi
	Zik+uvJvwvdd4d0Ix1KcCx9ACM+4LOQ+gyiU1kg5mvi9ci6S4NW4Q1ip
X-Gm-Gg: ATEYQzzkAdPxvdy0AfZsKW2udgmOzr/sLkiRKDkVMC2Gf6vU6SE9rs9ePVnNTltZxjr
	unPSBJfGcrcHW8cA1Xmsk6ANfCpKMxvrIH6aTW4rKVpYG+BJQbXC1pbYKiisw8kyk49FjGp6tnv
	WN2HpX4CTncZx7l8LkzcQCWrFgzM09LSNXlZ/GHDTgu7b8nqACyuhKYJ6/FQfzf1urGFw/tIHae
	xEeriWBWmqJhJpTsDnrmXwFckZw1IsnCmjOQ4YDSuufaQh5WfwuA+CTO+qdCnTpoz/g60tx94eh
	irb2J+cBNJpC0WD9jj+niA5pb+hd10Nqnq7jrUXVPoq0hL2WzE/qUAxPPteJk1ZtauUH/ne5jfF
	aZ27HN0jO5foF1e2/6ShM9pFkJ5KKLlH4GUi2hMpcAK6PKPlLPFPviICjT5uDGFehnFo1F1YBJz
	i80xe2oK95sE4ysWx7y7ngRWM=
X-Received: by 2002:a05:600c:83c4:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48727d8816amr287097545e9.13.1774970420588;
        Tue, 31 Mar 2026 08:20:20 -0700 (PDT)
Received: from nsa ([185.128.9.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c9250afsm18816885e9.36.2026.03.31.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:20:20 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:21:06 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <acvmNkDwLsdJCvWa@nsa>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
 <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
 <acuJ-Girr0ozQHh2@nsa>
 <acvXKYJkXID9qiqM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acvXKYJkXID9qiqM@lizhi-Precision-Tower-5810>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9784-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E89B836BA39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:16:09AM -0400, Frank Li wrote:
> On Tue, Mar 31, 2026 at 09:53:45AM +0100, Nuno Sá wrote:
> > On Mon, Mar 30, 2026 at 11:24:34AM -0400, Frank Li wrote:
> > > On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> > > > From: Eliza Balas <eliza.balas@analog.com>
> > > >
> > > > This IP core can be used in architectures (like Microblaze) where DMA
> > > > descriptors are allocated with vmalloc().
> > >
> > > strage, why use vmalloc()?
> >
> > It's just one of the paths in dma_alloc_coherent(). It should be
> > architecture dependant.
> 
> Which architectures, this may common problem, dma_alloc/free_coherent() is
> quite common at other dma-engine driver.

I'll double check this but I believe this was triggered on microblaze
where we also use this IP. Will come back with confirmation!

- Nuno Sá
> 
> Frank
> 
> >
> > - Nuno Sá
> >
> > >
> > > Frank
> > >
> > > >  Hence, given that freeing the
> > > > descriptors happen in softirq context, vunmpap() will BUG().
> > > >
> > > > To solve the above, we setup a work item during allocation of the
> > > > descriptors and schedule in softirq context. Hence, the actual freeing
> > > > happens in threaded context.
> > > >
> > > > Also note that to account for the possible race where the struct axi_dmac
> > > > object is gone between scheduling the work and actually running it, we
> > > > now save and get a reference of struct device when allocating the
> > > > descriptor (given that's all we need in axi_dmac_free_desc()) and
> > > > release it in axi_dmac_free_desc().
> > > >
> > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 37 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > index 70d3ad7e7d37..46f1ead0c7d7 100644
> > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/spinlock.h>
> > > > +#include <linux/workqueue.h>
> > > >
> > > >  #include <dt-bindings/dma/axi-dmac.h>
> > > >
> > > > @@ -133,6 +134,9 @@ struct axi_dmac_sg {
> > > >  struct axi_dmac_desc {
> > > >  	struct virt_dma_desc vdesc;
> > > >  	struct axi_dmac_chan *chan;
> > > > +	struct device *dev;
> > > > +
> > > > +	struct work_struct sched_work;
> > > >
> > > >  	bool cyclic;
> > > >  	bool cyclic_eot;
> > > > @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> > > >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > >  }
> > > >
> > > > +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > +{
> > > > +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > +
> > > > +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > +			  hw, hw_phys);
> > > > +	put_device(desc->dev);
> > > > +	kfree(desc);
> > > > +}
> > > > +
> > > > +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> > > > +{
> > > > +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> > > > +						  sched_work);
> > > > +
> > > > +	axi_dmac_free_desc(desc);
> > > > +}
> > > > +
> > > >  static struct axi_dmac_desc *
> > > >  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > >  {
> > > > @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > >  		return NULL;
> > > >  	desc->num_sgs = num_sgs;
> > > >  	desc->chan = chan;
> > > > +	desc->dev = get_device(dmac->dma_dev.dev);
> > > >
> > > >  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> > > >  				&hw_phys, GFP_ATOMIC);
> > > > @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > >  	/* The last hardware descriptor will trigger an interrupt */
> > > >  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
> > > >
> > > > +	/*
> > > > +	 * We need to setup a work item because this IP can be used on archs
> > > > +	 * that rely on vmalloced memory for descriptors. And given that freeing
> > > > +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> > > > +	 * Hence, setup the worker so that we can queue it and free the
> > > > +	 * descriptor in threaded context.
> > > > +	 */
> > > > +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> > > > +
> > > >  	return desc;
> > > >  }
> > > >
> > > > -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > -{
> > > > -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> > > > -	struct device *dev = dmac->dma_dev.dev;
> > > > -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > -
> > > > -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > -			  hw, hw_phys);
> > > > -	kfree(desc);
> > > > -}
> > > > -
> > > >  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > > >  	enum dma_transfer_direction direction, dma_addr_t addr,
> > > >  	unsigned int num_periods, unsigned int period_len,
> > > > @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
> > > >
> > > >  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> > > >  {
> > > > -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> > > > +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> > > > +
> > > > +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> > > > +	schedule_work(&desc->sched_work);
> > > >  }
> > > >
> > > >  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> > > >
> > > > --
> > > > 2.53.0
> > > >

