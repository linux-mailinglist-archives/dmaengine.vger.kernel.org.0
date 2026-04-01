Return-Path: <dmaengine+bounces-9812-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLm9Bo9KzWn4bQYAu9opvQ
	(envelope-from <dmaengine+bounces-9812-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 18:40:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9AE37E09A
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFD43305F7BB
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81F472762;
	Wed,  1 Apr 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF59w76/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6945BD4B
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060014; cv=none; b=iONY1BfDkdZP+QI/G4a3JrjreqOCPAwO2id64Y4d/8QcKBqOjWIcEjqLwxvQAm8PR9rcI95Cul+LB6P8etL+z0iqAsuihcmjd21Os2idJsGsWsSRsneM9U87sklrn5QO0ILLjYZDOFKMmOb5m4RpTR7/4g+Cgz2lRmgLRc3U/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060014; c=relaxed/simple;
	bh=cnK6EEPHajF0pbqfPzN+z3vn0QShkKkn4JXq6163h3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1sISDK+2BBNViHlrpHIPyzBNwUHZu1/n+sbgcge8CDdwbMZiBzAE855mfHSmehQToWay9oLsKUbf5ucmlZy8UL+dJ8gyf9xtKxP6ohPVwdGsWsTs0ug8YX7mTDb8pr6XnMPc2//MszX8G0uxKLhlaqdCrT5sQkpW1tFYzmc1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF59w76/; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6500040f172so9602165d50.1
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060011; x=1775664811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7CaeRefHVdJqe/blozX5Q0mpA6fFJRjORc2uH8uvuo=;
        b=AF59w76/f8xlogYR+1wDAZa7DrC03nhlxPFj/+Dl1VvSfv9LVX+yaB5YNL5oXYF0PR
         jX/a6R/FZxvfZbUs+6PPmRrjYSO/om0hYu/GHP59rpVJiTqHYDtbkQytGQK4hkj1xAE6
         Z+S8+SSTgJGq3VVpjhTmusKnwhzhWzW6SheL8oV/St1jRygpwhrTbyq8WBwi+f3uLGnv
         sNZD0mnAcSfLl1zWJA439sba7+m6jEimyLiu5Qy8ikDIOD6roY3fNDpUDFym4MRjESmy
         o0lzGSsakoIB/7vqO3fKAElPEgRwLPwE7NNgjlQnltuzw2Dy7IEO1tBazDS+lEVNnJrb
         XMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060011; x=1775664811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7CaeRefHVdJqe/blozX5Q0mpA6fFJRjORc2uH8uvuo=;
        b=R/B/JruedvdOsIxPBwbSh5+QfExv00cInGayX6ATJMOc7Vh+v/W+Hsc7jGZb56nDkh
         HKs1qTU6rL+GRx0j7WM8hJ8t35pzEOg4xLZ8I82lh90rvjx1yHBvgHEYn5f2sAF5ZSyK
         LqPt1amBTsy0PxSoGj6SqNlA69aauW4Rg5Fo0KGAYuba2Hx1PhISD390qOXLuG7W2741
         RpZ7zCUN8Ng3c1WAxsqwgYgMGuKuGWi+bZKBOJ/LvziAIT4BZP96ImQbrxajT9lTdNd4
         adwhKmShZc+w9b7Bj577lU73OEGYQTWQVwPl41eYz95sDJ7+O/C74118K8ImV5n2hlj6
         SLow==
X-Forwarded-Encrypted: i=1; AJvYcCUaE4ph6e383saPZ1IaUPv2SHSxUOEH4aXiMKA0MnD2aOGVLfBLkxP2uNahqElCPvV49fJ5Pi7fADQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZPEVd5TTPbfNNGrCojpAYMZ2MsA1TlxnH+iDKX2mmWuKYkFe
	NNhvvSky4GaeB2bcktNJum8glKfbY9hk4XzaAN3C+zAdgZ8kLscCs3VM
X-Gm-Gg: ATEYQzwdKue9uOdH5maaMxoVUFMv8BofnPYnko3DUELAkOIpz2hlRnmsklGdMy3jaNF
	NuuNpr5cOZnFkzGx2uxwA6ZIXQFP6UOtbsujuWZi9pQ43KpyIdKDClszm8ja64IVmWindRSJKh6
	Ebu5NlTL4bIJlZQyZDVIp6b27MM9s5HxXWB5g+lQPgc3L+r/Uc3AxsSQUqqMI3N56YMGc5MR0HE
	AJNwoJzAgfD9JVd0P4hUMNSZm7HutU9m/rdk2g6ITQNINWM626HD9/s7LYbDH6+SyiloLriwH+t
	WLl8Ghq2sZRrDcMiqv8bEHVlVnZMCcfe+MjW9Ii713xlQnlbiZXQpUxt2/JiED6nckvRm72659J
	AXXN79zvh4zGcGi9vKuCINbGtmyFAe45Z0enVtsUMeASQrlu2mr+gNR9//H+LsB2M89zS7vs7J3
	XaqLuxBsLMh1IBtw==
X-Received: by 2002:a05:690e:144a:b0:650:314f:110d with SMTP id 956f58d0204a3-650314f13c5mr3348992d50.57.1775060011460;
        Wed, 01 Apr 2026 09:13:31 -0700 (PDT)
Received: from nsa ([45.94.208.239])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9b34f7sm100224d50.16.2026.04.01.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:13:30 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:14:16 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <ac1C8VdYXe3pMu0B@nsa>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
 <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
 <acuJ-Girr0ozQHh2@nsa>
 <acvXKYJkXID9qiqM@lizhi-Precision-Tower-5810>
 <acvmNkDwLsdJCvWa@nsa>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acvmNkDwLsdJCvWa@nsa>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9812-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1F9AE37E09A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:21:06PM +0100, Nuno Sá wrote:
> On Tue, Mar 31, 2026 at 10:16:09AM -0400, Frank Li wrote:
> > On Tue, Mar 31, 2026 at 09:53:45AM +0100, Nuno Sá wrote:
> > > On Mon, Mar 30, 2026 at 11:24:34AM -0400, Frank Li wrote:
> > > > On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> > > > > From: Eliza Balas <eliza.balas@analog.com>
> > > > >
> > > > > This IP core can be used in architectures (like Microblaze) where DMA
> > > > > descriptors are allocated with vmalloc().
> > > >
> > > > strage, why use vmalloc()?
> > >
> > > It's just one of the paths in dma_alloc_coherent(). It should be
> > > architecture dependant.
> > 
> > Which architectures, this may common problem, dma_alloc/free_coherent() is
> > quite common at other dma-engine driver.
> 
> I'll double check this but I believe this was triggered on microblaze
> where we also use this IP. Will come back with confirmation!
> 

Hi Frank,

I now went to the bottom of the issue! The problem is that for archs
like microblaze and arm64 we have DMA_DIRECT_REMAP which means that when
calling dma_alloc_coherent() in [1] we will get into the code path in
[2]. Now I did some research and we might have other solution for this
that does not involve this refcount craziness plus async work. But I
need to test it. FYI, what I have in mind is similar to the what 
loongson2-apb-dma.c does. This means, using the dma pool API. IIUC, with
the pool we only actually free the memory (dma_free_coherent()) in the
.terminate_all() callback (when destroying the pool) which should not
happen in interrupt context right?

[1]: https://elixir.bootlin.com/linux/v7.0-rc6/source/drivers/dma/dma-axi-dmac.c#L549
[2]: https://elixir.bootlin.com/linux/v7.0-rc6/source/kernel/dma/direct.c#L278

- Nuno Sá

> - Nuno Sá
> > 
> > Frank
> > 
> > >
> > > - Nuno Sá
> > >
> > > >
> > > > Frank
> > > >
> > > > >  Hence, given that freeing the
> > > > > descriptors happen in softirq context, vunmpap() will BUG().
> > > > >
> > > > > To solve the above, we setup a work item during allocation of the
> > > > > descriptors and schedule in softirq context. Hence, the actual freeing
> > > > > happens in threaded context.
> > > > >
> > > > > Also note that to account for the possible race where the struct axi_dmac
> > > > > object is gone between scheduling the work and actually running it, we
> > > > > now save and get a reference of struct device when allocating the
> > > > > descriptor (given that's all we need in axi_dmac_free_desc()) and
> > > > > release it in axi_dmac_free_desc().
> > > > >
> > > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > > Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
> > > > >  1 file changed, 37 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > index 70d3ad7e7d37..46f1ead0c7d7 100644
> > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > @@ -25,6 +25,7 @@
> > > > >  #include <linux/regmap.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/spinlock.h>
> > > > > +#include <linux/workqueue.h>
> > > > >
> > > > >  #include <dt-bindings/dma/axi-dmac.h>
> > > > >
> > > > > @@ -133,6 +134,9 @@ struct axi_dmac_sg {
> > > > >  struct axi_dmac_desc {
> > > > >  	struct virt_dma_desc vdesc;
> > > > >  	struct axi_dmac_chan *chan;
> > > > > +	struct device *dev;
> > > > > +
> > > > > +	struct work_struct sched_work;
> > > > >
> > > > >  	bool cyclic;
> > > > >  	bool cyclic_eot;
> > > > > @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> > > > >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > >  }
> > > > >
> > > > > +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > > +{
> > > > > +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > > +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > > +
> > > > > +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > > +			  hw, hw_phys);
> > > > > +	put_device(desc->dev);
> > > > > +	kfree(desc);
> > > > > +}
> > > > > +
> > > > > +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> > > > > +{
> > > > > +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> > > > > +						  sched_work);
> > > > > +
> > > > > +	axi_dmac_free_desc(desc);
> > > > > +}
> > > > > +
> > > > >  static struct axi_dmac_desc *
> > > > >  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > >  {
> > > > > @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > >  		return NULL;
> > > > >  	desc->num_sgs = num_sgs;
> > > > >  	desc->chan = chan;
> > > > > +	desc->dev = get_device(dmac->dma_dev.dev);
> > > > >
> > > > >  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> > > > >  				&hw_phys, GFP_ATOMIC);
> > > > > @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > > > >  	/* The last hardware descriptor will trigger an interrupt */
> > > > >  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
> > > > >
> > > > > +	/*
> > > > > +	 * We need to setup a work item because this IP can be used on archs
> > > > > +	 * that rely on vmalloced memory for descriptors. And given that freeing
> > > > > +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> > > > > +	 * Hence, setup the worker so that we can queue it and free the
> > > > > +	 * descriptor in threaded context.
> > > > > +	 */
> > > > > +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> > > > > +
> > > > >  	return desc;
> > > > >  }
> > > > >
> > > > > -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > > > -{
> > > > > -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> > > > > -	struct device *dev = dmac->dma_dev.dev;
> > > > > -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > > > -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > > > -
> > > > > -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > > > -			  hw, hw_phys);
> > > > > -	kfree(desc);
> > > > > -}
> > > > > -
> > > > >  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > > > >  	enum dma_transfer_direction direction, dma_addr_t addr,
> > > > >  	unsigned int num_periods, unsigned int period_len,
> > > > > @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
> > > > >
> > > > >  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> > > > >  {
> > > > > -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> > > > > +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> > > > > +
> > > > > +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> > > > > +	schedule_work(&desc->sched_work);
> > > > >  }
> > > > >
> > > > >  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> > > > >
> > > > > --
> > > > > 2.53.0
> > > > >

