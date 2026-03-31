Return-Path: <dmaengine+bounces-9758-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A87ORGMy2kuIwYAu9opvQ
	(envelope-from <dmaengine+bounces-9758-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:55:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332C36686A
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94C71300C902
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A393EAC75;
	Tue, 31 Mar 2026 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bptLvaVs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4043E5ED1
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947182; cv=none; b=osG3m9VYEswAGRw/b3URHYRvxXlea5qxcgAPwGSJczNFM+4spTqPe4heD5beV+/zUV4Mq1VQCkWDH5w0kuT613KPf8owW/mRznvPklrvDbY9h57nHz0XKAnfpFWd8y/t4weVGdFlBJ9Gx7p6u4gy4aJ4goLNrfjo/A35zq2snks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947182; c=relaxed/simple;
	bh=bvpIgjVtWto+oCm8koGMwWa89oZXZ1C/QAMVAFUla7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4gAHiktGIxjavTrmx2LSBeGj2mhIUx9tGX6t73bSWT/2b6RuiTL2e092r47lI4sLNXMOwQt3gV6QSRK4DIO7n5caIpOeKbQ3rojkIHnK9W9wf82US8jf/SxkwZ5pPwUq57Jqkm0bu4H/3NkNeUDVIPyrDyU9WD7ojHf5rocpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bptLvaVs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2677862f8f.2
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774947180; x=1775551980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9rs97qkXzEMvETg8cotvloOAYk66/huh+GVzhQWn0U=;
        b=bptLvaVsut6O49Z5pQK3uJtnt4XFC+/v43Ihuk2SSBELMs3kAhoFJ9Ehkyg53bMTxY
         O0WWPUnmsoSuzUV0eZpDngRVs08+j5JbE0Rm8jz8+ojbgX4zmDpQbsbrvOCgwEjgR3p9
         56nmtfpDQGA3IJVX6ACSH5vO9A5wYgkSVgSXwDQ9yEnqkoV7CWiQpNlRGY05j3a1xR97
         j6OHdZOTrupjGbLKVbp4FmY3PgseVPPg99+oL3OODo/CwrnOqyvKYanj++X34CTuUrpX
         GGCKhjj8U+tLplWmRsHlUXW5aI48mKWaynufPk+YpT8Dk3UUnfTNe5Vl6IzF8wlKENTm
         78fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947180; x=1775551980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9rs97qkXzEMvETg8cotvloOAYk66/huh+GVzhQWn0U=;
        b=i859PfNz5vnAnXKqRG05gJOtfxvP66+T6htyeVcisXdW+Or2Rv+Z5PDwzOMT3he3SW
         LiUwKf7Cyoy3G57RLn42H48W5Hx38GElrfepFFrV6n6p3iFnWuRhEfTjh6HY0uQq1uYB
         Txc/QMoZmMAmC7TrBFRfeEFh9AJYMRGR1OIUr4zz/xw0NYLjJ01P2PX6RcNQerXfikq+
         j/T5jQVTKJQI3z6dx3ARe0kQ4w/l7OjGqjQMrPn60Iet5icVf8gUt/BVROIlald3f1Qp
         KXSRhzbR3LUPyB+4OVkYzA1C2d0XNHkoU5ly+ewfYFzfcRO12H/srXT3wKtqMZg0RLDN
         bIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8EqIAMo3EacxnPCOjYMkIFqSp01r//JAZBXnE/mSVmctSCIX7un+H1A3zIPPS02QY9GESIFSh1QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEY6q7134SiMn01SHUnPKdYrEOpk3W66aLcYCEj3NdLYkOjMq
	/haYY4JXSOTuagdjBde5adef+kSsL3JZX38bWTTmcF7nBWsDNsFsl/o1
X-Gm-Gg: ATEYQzzl+f2L2zvCDJ05pel4RWNjHMia3FwrNu35uiQyiPvWpCAwrjbxvTpBR4LAjA0
	3dJWhx2g2QIkVsP4riCVptQXbmVEo+NrP/H1kj5DXVijokcmbhBubtMgWO7nICIexKy8YWb3WUg
	QedLR3TuW6zLcZfDQbERce+vgSSCg04Q6zdOSojNWHKeNI64GRWIjn+BV3yy8skb/3tGPAUHs3c
	YsNrbYiCq++pu6lw4a5aZ+NzOLDqq3oAEgoj3CaOzuCS48XUwiQuOHF1ETkBsg9OO/kqMa1IBqe
	fuEk2cpjtKAo/JTDTxlOdBNhonR+shkh7MuNh2obTN/IXFDainzHuFoTIL3vheRuPVLLhk/WRTM
	ir+lD2aF0BLWstlq+b8T7QTjGUack46/CLhQjh9XO+aqMQcPyHpTjWwUmdEyDZkx1+gEWbumaeL
	pC6kLmjoZDtr0K
X-Received: by 2002:a05:6000:1445:b0:43b:8806:be32 with SMTP id ffacd0b85a97d-43b9e9d59dcmr27940529f8f.7.1774947179370;
        Tue, 31 Mar 2026 01:52:59 -0700 (PDT)
Received: from nsa ([185.128.9.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2628sm28428947f8f.6.2026.03.31.01.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:52:58 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:53:45 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <acuJ-Girr0ozQHh2@nsa>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
 <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9758-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4332C36686A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:24:34AM -0400, Frank Li wrote:
> On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> > From: Eliza Balas <eliza.balas@analog.com>
> >
> > This IP core can be used in architectures (like Microblaze) where DMA
> > descriptors are allocated with vmalloc().
> 
> strage, why use vmalloc()?

It's just one of the paths in dma_alloc_coherent(). It should be
architecture dependant.

- Nuno Sá

> 
> Frank
> 
> >  Hence, given that freeing the
> > descriptors happen in softirq context, vunmpap() will BUG().
> >
> > To solve the above, we setup a work item during allocation of the
> > descriptors and schedule in softirq context. Hence, the actual freeing
> > happens in threaded context.
> >
> > Also note that to account for the possible race where the struct axi_dmac
> > object is gone between scheduling the work and actually running it, we
> > now save and get a reference of struct device when allocating the
> > descriptor (given that's all we need in axi_dmac_free_desc()) and
> > release it in axi_dmac_free_desc().
> >
> > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 37 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index 70d3ad7e7d37..46f1ead0c7d7 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/workqueue.h>
> >
> >  #include <dt-bindings/dma/axi-dmac.h>
> >
> > @@ -133,6 +134,9 @@ struct axi_dmac_sg {
> >  struct axi_dmac_desc {
> >  	struct virt_dma_desc vdesc;
> >  	struct axi_dmac_chan *chan;
> > +	struct device *dev;
> > +
> > +	struct work_struct sched_work;
> >
> >  	bool cyclic;
> >  	bool cyclic_eot;
> > @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> >  }
> >
> > +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > +{
> > +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > +
> > +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > +			  hw, hw_phys);
> > +	put_device(desc->dev);
> > +	kfree(desc);
> > +}
> > +
> > +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> > +{
> > +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> > +						  sched_work);
> > +
> > +	axi_dmac_free_desc(desc);
> > +}
> > +
> >  static struct axi_dmac_desc *
> >  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> >  {
> > @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> >  		return NULL;
> >  	desc->num_sgs = num_sgs;
> >  	desc->chan = chan;
> > +	desc->dev = get_device(dmac->dma_dev.dev);
> >
> >  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> >  				&hw_phys, GFP_ATOMIC);
> > @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> >  	/* The last hardware descriptor will trigger an interrupt */
> >  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
> >
> > +	/*
> > +	 * We need to setup a work item because this IP can be used on archs
> > +	 * that rely on vmalloced memory for descriptors. And given that freeing
> > +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> > +	 * Hence, setup the worker so that we can queue it and free the
> > +	 * descriptor in threaded context.
> > +	 */
> > +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> > +
> >  	return desc;
> >  }
> >
> > -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > -{
> > -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> > -	struct device *dev = dmac->dma_dev.dev;
> > -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > -
> > -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > -			  hw, hw_phys);
> > -	kfree(desc);
> > -}
> > -
> >  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> >  	enum dma_transfer_direction direction, dma_addr_t addr,
> >  	unsigned int num_periods, unsigned int period_len,
> > @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
> >
> >  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> >  {
> > -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> > +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> > +
> > +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> > +	schedule_work(&desc->sched_work);
> >  }
> >
> >  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> >
> > --
> > 2.53.0
> >

