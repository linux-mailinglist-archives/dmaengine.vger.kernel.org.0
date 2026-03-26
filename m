Return-Path: <dmaengine+bounces-9677-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JN0F1JPxWkU8wQAu9opvQ
	(envelope-from <dmaengine+bounces-9677-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 16:22:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A769D337821
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C257A30D662A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF92ED866;
	Thu, 26 Mar 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99oVyku"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC93FFAD4
	for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538043; cv=none; b=m0tCIiqO8/IUDmq+zDivMH4IeVI8oIEz3oTTsFhXBryHPLbZabq5w+Uw5FVtnJgLeBm1FTGcUPI6kpflX2aHHrJ0bBXhR04NVuJgFGgFyJOb/MEHQhTJvJOoYTNUc9rxvlIrozAg3SX6qLbo6KmEV3R6o3C5PE5wH44I2KJwhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538043; c=relaxed/simple;
	bh=FWf1dB2Qon/UR2aHHejUdu+2XcfIQ/PGLiP3BnMrCfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbNieg8kcmCv43yPOstOJRVFQrS8yVUTXc0fi1wbLEYObRyzDzXAqv818qpW6CS454BcXteVdQKDQQSxIhAj4+0cPDBOOVQtDW/En5DDCAUz/CyZQv5nkQjg9R3R1H8h5HViT6rtYHf1/+/QYca1l5DzMa4+iYZAJLcNjkcKgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l99oVyku; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso10023435e9.1
        for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538040; x=1775142840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D0sYiHqQQkLdMu3GiNtAqjtuktge8TgQEH5jdZWb9i0=;
        b=l99oVykusxGbrlmrUJMDEc4Dmnr8V1cV12rAO9HrZhUPZnYnUOZxacr93UnPCWJ/Nn
         BPwaY2teM7cxO9gem+jV5nMTkHox4zlvNgAHNdzE8INmgcuUL0WWJN0/u0f1pFDbRiHq
         +GzS/M4hj0kKn7bRSdE8J7OQu4of2F3wGoPtgcutXFSG50ti7YnICZiKuq5Do6qYbyoO
         FfkYwPQ3Lx3Yazbhd51tGHQvGWMQnCTa+8WWEDSpqS/Q0v9tKN5DfI8RhfdI1n0MTLWz
         8qfB0pIYgqnVUuLf77fzFu59ob4i92u5CDk3/gXAw/2eBifTSo7GYsZiyPZ5cAB/4FN9
         q6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538040; x=1775142840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0sYiHqQQkLdMu3GiNtAqjtuktge8TgQEH5jdZWb9i0=;
        b=RA/e+QePHStq09mGv7M6noSFiWaEip0JTyIOZEWuB626XDBxqO7G1MytmvNtexuh3r
         R8SFGzXfq26bW+TjLJb3eYF5ZHasTcaHRCrTotYhVDAiEv8BHJ8vxoVY0ZNkv3hmEM1W
         Ob5m7UaHTgIhB4zpp50aO0AR0rX7KkkbH2GK4Hxj5CsF2R/c4qDeuZ8eOtoDo31HlGqF
         /YfHTU+aMVl7Ups1WwsSlSM+R7rPW6AHZORzGCOaelT5e8Z28YiolMLt+MXUtvvHg2VV
         bEvWcybwPJxiEqFQ+R0vvenS+5nXYUUTMSzMH2HGukKk6D78uhJuAaWIAqeNFmOPdXNL
         WX7w==
X-Gm-Message-State: AOJu0YxuVT/iy4T81NN7y1+kJUbpJE/HaOCi0C82K4Udv2jvH9UvzxDm
	qPY8Z4zzf+a9zfSaRWDExfHbErU5HLntQuixZ3hZbydmkZbJD0ncUXZX
X-Gm-Gg: ATEYQzwPyxnTgmg80Ubkm0w4Zf7bLVyoIQG225dNdugV1AW3cnaxo53JoTozC57MejV
	N50Q7V616s1G5X+3Xt8X05Da1+xQZAkKLBIFuqjzVvBYl+63IIEjykMdc6JXNHfHzyLbjx+9qWP
	gGbNOR/x53qDSb2+ElmsCAlbYxzsQRg1KLZ5RXJPp6CD/ZKgRENTCZnNoYjPQlLIlHzDsy9AAR3
	eVO0TBvFdTx8i0D3uoNRfs0jGbH4eQIopEYkULJQ6ccxoAi7vqRA04VMpcPSpOlEsAQ7l4l2gy4
	rTJmcCt58odMxeVac6MjgMliIn/gw+1sJuVVzzWD9Ybf+o9hxsozU4EFsw41cwBr+90mCjgadvZ
	KwGzK5uja/tQEPtMFWMNTz+UHboKOZAT7cbLbjfzPIRn7HJkOG6Ml1XidDTjYlPsqOwHLsN8ozP
	BYw8J7cttn7EK0tg==
X-Received: by 2002:a05:600c:8b6d:b0:485:3e20:4013 with SMTP id 5b1f17b1804b1-4871604b905mr125124305e9.28.1774538039577;
        Thu, 26 Mar 2026 08:13:59 -0700 (PDT)
Received: from nsa ([45.94.208.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872090fb74sm21045505e9.7.2026.03.26.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:13:59 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:14:44 +0000
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH 1/2] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <acVM8YwN3yoFYry2@nsa>
References: <20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com>
 <20260326-dma-dmac-handle-vunmap-v1-1-be3e46ffaf69@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326-dma-dmac-handle-vunmap-v1-1-be3e46ffaf69@analog.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9677-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: A769D337821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:37:35PM +0000, Nuno Sá wrote:
> From: Eliza Balas <eliza.balas@analog.com>
> 
> This IP core can be used in architectures (like Microblaze) where DMA
> descriptors are allocated with vmalloc(). Hence, given that freeing the
> descriptors happen in softirq context, vunmpap() will BUG().
> 
> To solve the above, we setup a work item during allocation of the
> descriptors and schedule in softirq context. Hence, the actual freeing
> happens in threaded context.
> 
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 45c2c8e4bc45..df2668064ea2 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -133,6 +133,8 @@ struct axi_dmac_desc {
>  	struct virt_dma_desc vdesc;
>  	struct axi_dmac_chan *chan;
>  
> +	struct work_struct sched_work;

Ahh, just realized that workqueue.h needs to be included. Will wait for
some feedback before v2.

- Nuno Sá

> +
>  	bool cyclic;
>  	bool cyclic_eot;
>  	bool have_partial_xfer;
> @@ -650,6 +652,26 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
>  
> +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> +{
> +	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> +	struct device *dev = dmac->dma_dev.dev;
> +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> +
> +	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> +			  hw, hw_phys);
> +	kfree(desc);
> +}
> +
> +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> +{
> +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> +						  sched_work);
> +
> +	axi_dmac_free_desc(desc);
> +}
> +
>  static struct axi_dmac_desc *
>  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  {
> @@ -687,21 +709,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  	/* The last hardware descriptor will trigger an interrupt */
>  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
>  
> +	/*
> +	 * We need to setup a work item because this IP can be used on archs
> +	 * that rely on vmalloced memory for descriptors. And given that freeing
> +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> +	 * Hence, setup the worker so that we can queue it and free the
> +	 * descriptor in threaded context.
> +	 */
> +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> +
>  	return desc;
>  }
>  
> -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> -{
> -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> -	struct device *dev = dmac->dma_dev.dev;
> -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> -
> -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> -			  hw, hw_phys);
> -	kfree(desc);
> -}
> -
>  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>  	enum dma_transfer_direction direction, dma_addr_t addr,
>  	unsigned int num_periods, unsigned int period_len,
> @@ -942,7 +961,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
>  
>  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
>  {
> -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> +
> +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> +	schedule_work(&desc->sched_work);
>  }
>  
>  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> 
> -- 
> 2.53.0
> 

