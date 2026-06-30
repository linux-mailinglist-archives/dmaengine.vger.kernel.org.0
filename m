Return-Path: <dmaengine+bounces-11900-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Y1tN1kvRGreqAoAu9opvQ
	(envelope-from <dmaengine+bounces-11900-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 23:04:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A46E7FE8
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 23:04:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nCfdYVyP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11900-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11900-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8DDE3037DDC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16C2F8EB8;
	Tue, 30 Jun 2026 21:00:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79628000F
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 21:00:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853248; cv=none; b=OQJaJzFmPCBvszSjuQSEpr8Ko+YdArul7ApqD4TAk/pnH4B7JHO9dQm2PA7AS9aRKshpd2i0/MczNhiRgPWJkReoFnj2FdTuUzFCXj8dDuVqAFzPfcerTw3m/UjpCBIVM6pj+YgNgqQ0hYHs+d0VHhsTEu2ov/L3eiaLY4Om/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853248; c=relaxed/simple;
	bh=/AtII+nQ/mtZfVzSGI6/dSsXyw92XdhX00/4p2rR+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLK/vjhs28OhQJuMnP4K6WrVOZ/++rYmZ29gWQz2sifU9TB++Hr+49VanBY4KGScOeQipkE8mVPe8rLNhMB7a4tNGxVZbCxP5PoKsMZjIxKnC6NGwlwoU0nb676H9jtsEWEjIzAGGcvvJF4UPSthEV57tDLRxXfJCxfgiF9fpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCfdYVyP; arc=none smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e501244f5so150782985a.1
        for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853246; x=1783458046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9TexMUsTMAbS8it8WaFvlrCqT4rsw90jOJV1JjeB4E=;
        b=nCfdYVyPgOgLQS1/PmWy1dONQsG5PUrJlG9pkMGzZb1dDt6AM3k7RGr+h4wrnsxmPN
         tyLw2y+DziHn34hL5/Rqfrz69izq58q4X5JYjtgK7xBfg2sq43wv4h6yhahKjy4FJ/XP
         Nr6PBfh7KD5PdDbw4J5PWWSwbfgaI52PB+DR3V+x/xq1E+VAtwTnZaWtHVMDCoNgOg1G
         WHHjrZgVUgJ1Cz01yl3zrzIcricn7S37rSOnkmxsfV2fEv4Je2L56Bv1flw+1Fn+w1ui
         fYob26O71xHA/UkTja+xfyJFmgM2lfrl98mcrNOMcb75v/t0XUE42brvVcZNRhOBC3Ta
         JS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853246; x=1783458046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9TexMUsTMAbS8it8WaFvlrCqT4rsw90jOJV1JjeB4E=;
        b=ANeFyyyLD/xya/faImeU795QzbdoOOMkIo864le7YceN02salPsMEm7hJsnneVAlYT
         IY9ZfLToB8L6D/GYMpkXRLHhW+YdzfoRU435AR4wPZsyyqg1jviZraBRAFefxhqG+6w7
         6hy5PMIaA5Sc4Pah3Sbm2tXV6Gi7sFD2/8mFegJozuRR2Tix7N3YRg+RdGAeisHBV6Cc
         cH63h5ZoNCkJ6ri70gmeJkjYcOjb42TjhGU0hi71J4yUG7T1dpLVR+OhA0tRz2He/k06
         ZLXzpX0ws4IrB5T3YXmsMYy1K5sfextrUWWkEvRMIYv93M369CBwBrDbwvtUbZtmgSk6
         0byg==
X-Forwarded-Encrypted: i=1; AFNElJ+Zkjqpeq/dUBIZ5jRm5fKEJ9EbRz1yFU5fY9O9bpQV+PIdqehCdFJq6iLKbXGMju7mvr5IvE0vkSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JKXmNpufPFd8mJcSgcgrsT+1NfieS/F56Cwig+2ndwoyVI9l
	MD2e6oU1fP3RIu1DymGof1q6/yoD+8E+Z30GA0tZVcpjQn3XDwgKcZiA
X-Gm-Gg: AfdE7ck5ECKEuX5Dc+qyLg3osf84qdCuv/+Ck3NIsSj2MkfErfq1CrRrIFj/URv82wC
	Za8k3Uf9w55nz9cT/ZaRamBH3O0NpS9ZUKRVoZKt8qiymOJHNEspRxFhuS1TNAq85Ya493oKAUV
	56IHbPgT3d4+DkPI3+NeRJxr8obxq/VNnwQPRrOUX2y4d+MUZluWrtcdPOezJxZzfkoe7mlQIYV
	h9iihbln3tp7OOGJObAkvtFZKPj52G007fUQ1mwkut/d6DiR61WKksbh2xgcOM3CSlzHdbLCCXy
	OUSIWfJEuQHhk1Iypsl0O9GtDFsQ3crW7N+NZNEWnD4ZBihD5TTuqzjRvPuf0Jas1GUuohMqK9X
	ZxwJiPmyYw+X5gWD0jHVZOAAt3ALCwXeFHswgmIYG6FHq4jIM5zRSjWn/PJtYovRrCKWQ0c8VHt
	p7k1O0tq9oHZv2/w==
X-Received: by 2002:a05:620a:4805:b0:92a:a400:df70 with SMTP id af79cd13be357-92e62673174mr898729285a.47.1782853245056;
        Tue, 30 Jun 2026 14:00:45 -0700 (PDT)
Received: from b82beb281c41 ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6218fa27sm327885585a.16.2026.06.30.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:00:44 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:00:41 +0000
From: Yuanshen Cao <alex.caoys@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: conor+dt@kernel.org, mripard@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, samuel@sholland.org, wens@kernel.org,
	jernej.skrabec@gmail.com, Frank.Li@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Message-ID: <akQuefaUpt6OPNSo@b82beb281c41>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
 <20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com>
 <20260629003505.18f0053d@ryzen.lan>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629003505.18f0053d@ryzen.lan>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11900-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andre.przywara@arm.com,m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@nxp.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,sholland.org,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 282A46E7FE8

On Mon, Jun 29, 2026 at 12:35:05AM +0200, Andre Przywara wrote:
> On Mon, 22 Jun 2026 01:36:23 +0000
> Yuanshen Cao <alex.caoys@gmail.com> wrote:
> 
> Hi,
> 
> first, many thanks for sending this, also for structuring the changes
> nicely, so that they remain reviewable!
> 
> > Refactor to support the Allwinner A733 DMA controller. Currently, the
> > `sun6i-dma` driver has several functions related to interrupt handling
> > (reading/writing interrupt enable and status registers) and register
> > dumping that are hardcoded.
> > 
> > To support the A733, which has different register layouts and interrupt
> > handling logic, these functions are being moved into the
> > `sun6i_dma_config` structure as function pointers.
> 
> So I see that this driver already makes use of per-device function
> pointer, though personally I don't like this approach very much, as it
> decreases the readability, and suggests significant differences between
> the SoC generations that are not really there: each function just reads
> or write an MMIO register, it's just the offset that differs.

Yes, I considered to do this but since the original mainline code and
BSP code all use function-pointer so I impelement this the same way.

> 
> So I think it's better to express the differences through data
> entries in the config struct, for the IRQ enable/stat functions I think
> this should be something like this:
> 
> struct sun6i_dma_config {
> 	...
> 	u32	irq_stride;
> 	u32	irq_en_offset;
> 	u32	irq_stat_offset;
> 	...
> };
> 
> -	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
> +	irq_val = readl(sdev->base + sdev->cfg->irq_en_offset + irq_reg * sdev->cfg->irq_stride);
> 
> the existing configs set .stride to 0x04, and .en_offset to 0x0, the
> A733 later uses .stride = 0x40 and .en_offset = 0x134.
> Maybe we still move that now longish line into a helper function, but
> not a config specific one. 
> 
> I think that's more readable, and avoids unnecessary redirections and
> potential pipeline stalls.
> 
> dump_com_regs is a different story, since the two instances of that
> function are significantly different.
> 
> What do you think?

I am okay to change this one but should we do the same for the other
function pointers as well? Just to keep them aligned. Let me know what
do you think.

> > This allows the
> > driver to use a polymorphic approach where the specific implementation
> > is determined by the hardware configuration assigned during device
> > probing.
> > 
> > Changes:
> > - Added function pointers to `struct sun6i_dma_config` for:
> 
> By the way: the preferred style to list changes in commit messages in
> imperative mood [1], not in past tense. Think about you ask the
> code base what to change:
> 
> Add function pointers to ...
> Implement generic functions ...

Thanks for the advice! I'll make sure to follow them in the future.

Best,
Alex

> Cheers,
> Andre
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n94
> 
> >     - `dump_com_regs`
> >     - `read_irq_en`
> >     - `write_irq_en`
> >     - `read_irq_stat`
> >     - `write_irq_stat`
> > - Implemented generic `sun6i_read/write_irq_*` functions for existing
> >   hardware.
> > - Added a macro and updated existing `sun6i_dma_config` instances (A31,
> >   A23, H3, A64, A100, H6, V3S) to use these new function pointers.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> > ---
> >  drivers/dma/sun6i-dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index a9a254dbf8cb..ef3052c4ab36 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -138,6 +138,11 @@ struct sun6i_dma_config {
> >  	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
> >  	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
> >  	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> > +	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
> > +	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg);
> > +	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val);
> > +	u32 (*read_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg);
> > +	void (*write_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status);
> >  	u32 src_burst_lengths;
> >  	u32 dst_burst_lengths;
> >  	u32 src_addr_widths;
> > @@ -347,6 +352,26 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> >  		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
> >  }
> >  
> > +static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg)
> > +{
> > +	return readl(sdev->base + DMA_IRQ_EN(irq_reg));
> > +}
> > +
> > +static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val)
> > +{
> > +	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> > +}
> > +
> > +static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg)
> > +{
> > +	return readl(sdev->base + DMA_IRQ_STAT(irq_reg));
> > +}
> > +
> > +static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status)
> > +{
> > +	writel(status, sdev->base + DMA_IRQ_STAT(irq_reg));
> > +}
> > +
> >  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
> >  {
> >  	struct sun6i_desc *txd = pchan->desc;
> > @@ -460,16 +485,16 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
> >  
> >  	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
> >  
> > -	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
> > +	irq_val = sdev->cfg->read_irq_en(sdev, irq_reg);
> >  	irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
> >  			(irq_offset * DMA_IRQ_CHAN_WIDTH));
> >  	irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
> > -	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> > +	sdev->cfg->write_irq_en(sdev, irq_reg, irq_val);
> >  
> >  	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
> >  	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
> >  
> > -	sun6i_dma_dump_com_regs(sdev);
> > +	sdev->cfg->dump_com_regs(sdev);
> >  	sun6i_dma_dump_chan_regs(sdev, pchan);
> >  
> >  	return 0;
> > @@ -549,14 +574,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
> >  	u32 status;
> >  
> >  	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
> > -		status = readl(sdev->base + DMA_IRQ_STAT(i));
> > +		status = sdev->cfg->read_irq_stat(sdev, i);
> >  		if (!status)
> >  			continue;
> >  
> >  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
> >  			str_high_low(i), status);
> >  
> > -		writel(status, sdev->base + DMA_IRQ_STAT(i));
> > +		sdev->cfg->write_irq_stat(sdev, i, status);
> >  
> >  		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
> >  			pchan = sdev->pchans + j;
> > @@ -1101,6 +1126,13 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
> >  	}
> >  }
> >  
> > +#define SUN6I_DMA_IRQ_A31_COMMON_OPS	\
> > +	.dump_com_regs    = sun6i_dma_dump_com_regs,	\
> > +	.read_irq_en      = sun6i_read_irq_en,	\
> > +	.write_irq_en     = sun6i_write_irq_en,	\
> > +	.read_irq_stat    = sun6i_read_irq_stat,	\
> > +	.write_irq_stat   = sun6i_write_irq_stat,
> > +
> >  /*
> >   * For A31:
> >   *
> > @@ -1132,6 +1164,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
> >  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  /*
> > @@ -1155,6 +1188,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
> >  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
> > @@ -1173,6 +1207,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
> >  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  /*
> > @@ -1200,6 +1235,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
> >  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  /*
> > @@ -1221,6 +1257,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
> >  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  /*
> > @@ -1244,6 +1281,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
> >  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> >  	.has_high_addr = true,
> >  	.has_mbus_clk = true,
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  /*
> > @@ -1266,6 +1304,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> >  	.has_mbus_clk = true,
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  /*
> > @@ -1289,6 +1328,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
> >  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> > +	SUN6I_DMA_IRQ_A31_COMMON_OPS
> >  };
> >  
> >  static const struct of_device_id sun6i_dma_match[] = {
> > 
> 

