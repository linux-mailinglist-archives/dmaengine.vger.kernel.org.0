Return-Path: <dmaengine+bounces-9872-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAt+KAajzmlZpAYAu9opvQ
	(envelope-from <dmaengine+bounces-9872-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 19:10:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193C238C658
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 619F630B27B6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53A3E714F;
	Thu,  2 Apr 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt66HtXv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB573B9DA9
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149539; cv=none; b=JYLikvQ1j836vGdaAXa2YU5eQkWwTt0EidY+Uhbl07a4seFEauOy62aKJglAFvI/lKQN881C6nofSYGUYzb0iIT3x8iru+V8iuzNWJq2BVgzili631odsgOEMD2ZxQ2WZlaYE6LLKJOiIPeSzueMW7GgaALG0bpkiB5NJSuFzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149539; c=relaxed/simple;
	bh=GIQXrZr1nnQrpqZWB7GXkB0+Yem6mD0APgzHQjuCI1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3dRgAY63h4zWc1EmLktEEJbkp214u8ymIfDXY4CgcWD6uVC/A1dXW6wz0JCmtv5Kq98Mz3iFs5HGDVs8/aNaLalRBvp2BuSISoQXY5E+bTvc6ZaqscHGPGth50ujzbmzZZMgZ+dbCUqiPfPog9MXbuN+2tS9PO9tG9h3v8/JsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pt66HtXv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48704db565eso12032785e9.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775149527; x=1775754327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UbeM/FQjvfnyZyfZDUgMuFpjxFYOXAZW4C71gFUk/XM=;
        b=pt66HtXvRyPvy33VpQYr7aMKtkZ7Qyu90xcuin7AkDXu4ZiSjtWlc/xj1nlcw/rdPQ
         rZHmcg2pQFGRq1/b4e3Cotf2YGVnBCcE2mK0rND8LitYAuAUEpEE1SH8Mznlo728vuLk
         zXn0lu2p0lTrQNyMGNUNxdn3J1OTPicQzZrIuWnKHnrf3GYV6j1kbob8KzXiz5qkUWfc
         6hIfmYgyp8JCLbiDm9lXfW84C7fJ+al1J7TvpjW+BbTQjt8YG9uhTUfFWN1/xZtKI8ru
         5jdbWoJ2AwmoZl01K3QuG/iq8m902pndRJUfNcbzJO9VxFofNy329J/QpYYWxWSDAg0T
         3N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149528; x=1775754328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbeM/FQjvfnyZyfZDUgMuFpjxFYOXAZW4C71gFUk/XM=;
        b=QR1UIv30FL7Up6NAwMQ8Ba1lh8XIx+tMYEb8vLbWDSIYCAgmJC8UnlGYNV4liQv3cT
         fUt+sHAZMhfkLrhztrrxnoC2hh+NN//xlSm3NGnDyBjnSiRP4ciPLzJ0Sy59QQAWF3lg
         wgUxXh3NHW7TcukscF487+pDv1YvFrvduCE2Nu6sW4Xk3HyrnS2dHhQnM20w0AJD43sJ
         023RwrofQBc0I+mVlCWtpi7i45LRP7CnIB+L/Td21pe6jT/vh1vDj99nP0YMnt6/g+/k
         sFzKlwmRpwyq7Ec5BYDWvxjR7fjwURZV/P5ZuuoZb44s6MlSuh5yrK0GdlSiGUWHGL6N
         ChRw==
X-Forwarded-Encrypted: i=1; AJvYcCXkacZoaiMpTTaiQQDn8VPpxK/5F3jBs7L9TwlBqfcgsCiJC2HdIrP/sQJlVHhpoI90jCmr7RGxJpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYCMvJB55J28EK7pakuZU6I0kTNQcUzBtMEJSeuZ9GkcTkBqg
	Pcm8BV8Z1HfkupNamsd8RsMYNEoTmcZLs5rj5+RSlUDuNJ+EUey9kysi
X-Gm-Gg: ATEYQzybKoMuIZEyOaCRvq1v4hb0IneCtrSnB4EjJ4HWAsnX9IOPTc4f64pwVKE8Uj+
	p96MxANVuUAhKhNjRme9wN9cWIEQqSnxyCz26xaYBaAD1ZpzMx51XzJ+Y1RGimL6nkraTq4R2yK
	OqEV+A6QJmeuFQSm8PzZoIAhJO/dtOFFmcTA+5GdMvjpjoB57cFaEGYiWI3fsaNPXbcNia4hJHp
	G+oYSKgHnYbUKNNWkbJNvfBLU3Qzc59KKoc7x0O1ouJOJQ+89ytGu+c5yaQgvsLO+IZLu3pSFlN
	rajqoHLfyL+3qUxtA9GJoYzSN2FliXSRzm2UyqJ3tBoKP6CvudLaLUet/ScQCmeGx7oHDvVPwZT
	otmKr1+zwrslix+bh3qe88V6zWc+pIXCMXpnMN3+H/f1rSB8BfnC5wtSvWpgv8ngVlK3K9JVWve
	hno8ZSt7NjbkSsZQ==
X-Received: by 2002:a05:600c:4507:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-4888b6eab29mr70964955e9.2.1775149527292;
        Thu, 02 Apr 2026 10:05:27 -0700 (PDT)
Received: from nsa ([185.128.9.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm180398885e9.0.2026.04.02.10.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:05:26 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:06:14 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <ac6hxtrjxoRsiW1b@nsa>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
 <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
 <acuJ-Girr0ozQHh2@nsa>
 <acvXKYJkXID9qiqM@lizhi-Precision-Tower-5810>
 <acvmNkDwLsdJCvWa@nsa>
 <ac1C8VdYXe3pMu0B@nsa>
 <ac2bzkImYBdujGPS@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2bzkImYBdujGPS@lizhi-Precision-Tower-5810>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9872-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 193C238C658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 06:27:26PM -0400, Frank Li wrote:
> On Wed, Apr 01, 2026 at 05:14:16PM +0100, Nuno Sá wrote:
> > On Tue, Mar 31, 2026 at 04:21:06PM +0100, Nuno Sá wrote:
> > > On Tue, Mar 31, 2026 at 10:16:09AM -0400, Frank Li wrote:
> > > > On Tue, Mar 31, 2026 at 09:53:45AM +0100, Nuno Sá wrote:
> > > > > On Mon, Mar 30, 2026 at 11:24:34AM -0400, Frank Li wrote:
> > > > > > On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> > > > > > > From: Eliza Balas <eliza.balas@analog.com>
> > > > > > >
> > > > > > > This IP core can be used in architectures (like Microblaze) where DMA
> > > > > > > descriptors are allocated with vmalloc().
> > > > > >
> > > > > > strage, why use vmalloc()?
> > > > >
> > > > > It's just one of the paths in dma_alloc_coherent(). It should be
> > > > > architecture dependant.
> > > >
> > > > Which architectures, this may common problem, dma_alloc/free_coherent() is
> > > > quite common at other dma-engine driver.
> > >
> > > I'll double check this but I believe this was triggered on microblaze
> > > where we also use this IP. Will come back with confirmation!
> > >
> >
> > Hi Frank,
> >
> > I now went to the bottom of the issue! The problem is that for archs
> > like microblaze and arm64 we have DMA_DIRECT_REMAP which means that when
> > calling dma_alloc_coherent() in [1] we will get into the code path in
> > [2]. Now I did some research and we might have other solution for this
> > that does not involve this refcount craziness plus async work. But I
> > need to test it. FYI, what I have in mind is similar to the what
> > loongson2-apb-dma.c does. This means, using the dma pool API. IIUC, with
> > the pool we only actually free the memory (dma_free_coherent()) in the
> > .terminate_all() callback (when destroying the pool) which should not
> > happen in interrupt context right?
> 
> I think so. If your dma engineer descriptor is link-list, suggest use dma
> pool. If it is cicylic buffer, suggest pre-alloc enough descriptors when
> apply channel.

Yeah, I ran some tests and dma pool seems to work just fine. I'll still
ask a colleague to test my patch in the platform that triggered the
BUG().

- Nuno Sá

> 
> Frank
> >
> > [1]: https://elixir.bootlin.com/linux/v7.0-rc6/source/drivers/dma/dma-axi-dmac.c#L549
> > [2]: https://elixir.bootlin.com/linux/v7.0-rc6/source/kernel/dma/direct.c#L278
> >
> > - Nuno Sá
> >
> > > - Nuno Sá
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > - Nuno Sá
> > > > >
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > >  Hence, given that freeing the
> > > > > > > descriptors happen in softirq context, vunmpap() will BUG().
> > > > > > >
> > > > > > > To solve the above, we setup a work item during allocation of the
> > > > > > > descriptors and schedule in softirq context. Hence, the actual freeing
> > > > > > > happens in threaded context.
> > > > > > >
> > > > > > > Also note that to account for the possible race where the struct axi_dmac
> > > > > > > object is gone between scheduling the work and actually running it, we
> > > > > > > now save and get a reference of struct device when allocating the
> > > > > > > descriptor (given that's all we need in axi_dmac_free_desc()) and
> > > > > > > release it in axi_dmac_free_desc().
> > > > > > >
> > > > > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > > > > Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > ---
> > > > > > >  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
> > > > > > >  1 file changed, 37 insertions(+), 13 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > > index 70d3ad7e7d37..46f1ead0c7d7 100644
> > > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > > @@ -25,6 +25,7 @@
> > > > > > >  #include <linux/regmap.h>
> > > > > > >  #include <linux/slab.h>
> > > > > > >  #include <linux/spinlock.h>
> > > > > > > +#include <linux/workqueue.h>
> > > > > > >
> > > > > > >  #include <dt-bindings/dma/axi-dmac.h>
> > > > > > >
> > > > > > > @@ -133,6 +134,9 @@ struct axi_dmac_sg {
> > > > > > >  struct axi_dmac_desc {
> > > > > > >  	struct virt_dma_desc vdesc;
> > > > > > >  	struct axi_dmac_chan *chan;
> > > > > > > +	struct device *dev;
> > > > > > > +
> > > > > > > +	struct work_struct sched_work;
> > > > > > >
> > > > > > >  	bool cyclic;
> > > > > > >  	bool cyclic_eot;
> > > > > > > @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> > > > > > >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > > >  }
> > > > > > >
> > > > > > > +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > > > > +{
> > > > > > > +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > > > > +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > > > > +
> > > > > > > +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > > > > +			  hw, hw_phys);
> > > > > > > +	put_device(desc->dev);
> > > > > > > +	kfree(desc);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> > > > > > > +{
> > > > > > > +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> > > > > > > +						  sched_work);
> > > > > > > +
> > > > > > > +	axi_dmac_free_desc(desc);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static struct axi_dmac_desc *
> > > > > > >  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > > > >  {
> > > > > > > @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > > > >  		return NULL;
> > > > > > >  	desc->num_sgs = num_sgs;
> > > > > > >  	desc->chan = chan;
> > > > > > > +	desc->dev = get_device(dmac->dma_dev.dev);
> > > > > > >
> > > > > > >  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> > > > > > >  				&hw_phys, GFP_ATOMIC);
> > > > > > > @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > > > >  	/* The last hardware descriptor will trigger an interrupt */
> > > > > > >  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
> > > > > > >
> > > > > > > +	/*
> > > > > > > +	 * We need to setup a work item because this IP can be used on archs
> > > > > > > +	 * that rely on vmalloced memory for descriptors. And given that freeing
> > > > > > > +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> > > > > > > +	 * Hence, setup the worker so that we can queue it and free the
> > > > > > > +	 * descriptor in threaded context.
> > > > > > > +	 */
> > > > > > > +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> > > > > > > +
> > > > > > >  	return desc;
> > > > > > >  }
> > > > > > >
> > > > > > > -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > > > > -{
> > > > > > > -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> > > > > > > -	struct device *dev = dmac->dma_dev.dev;
> > > > > > > -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > > > > -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > > > > -
> > > > > > > -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > > > > -			  hw, hw_phys);
> > > > > > > -	kfree(desc);
> > > > > > > -}
> > > > > > > -
> > > > > > >  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > > > > > >  	enum dma_transfer_direction direction, dma_addr_t addr,
> > > > > > >  	unsigned int num_periods, unsigned int period_len,
> > > > > > > @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
> > > > > > >
> > > > > > >  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> > > > > > >  {
> > > > > > > -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> > > > > > > +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> > > > > > > +
> > > > > > > +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> > > > > > > +	schedule_work(&desc->sched_work);
> > > > > > >  }
> > > > > > >
> > > > > > >  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> > > > > > >
> > > > > > > --
> > > > > > > 2.53.0
> > > > > > >

