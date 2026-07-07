Return-Path: <dmaengine+bounces-12077-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ChTTHAwuTWrgwAEAu9opvQ
	(envelope-from <dmaengine+bounces-12077-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:49:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14971E00E
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:49:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dTyE2jHP;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12077-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12077-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA8F301A1F6
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA722541C;
	Tue,  7 Jul 2026 16:48:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EC25A655
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:48:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442895; cv=none; b=tKzvpPmpzD2YFU2ThrjT8n20pBBW8t4SJwC6fKYV8GQLLouOuvPfWcHbVgq+RI3ZXZ+86z0r+KZ5ti/KIKCY/+Ln+F32UXw4anUFCrOHA+gpyxbvCv44E7UDOIymC7wDDZ9GijCCYmd1XQ3hOWr/WIVu1TP2CJqq4dYEaYuWSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442895; c=relaxed/simple;
	bh=nOIebKwntvtOQ2Tr9hO94L7WjGwwMxVjvBAHv948Znw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLjcjspQzE0q2E6HrraLona0G9Sg30AIyQnh1IBSFlR4Nj+GszqoIUWgNO4UMW6UUyd5NaBlQHC4CFh40qOUB5M0fy8FetJ7lpfm4hDl4VY/up/IHz8qVJ4W+S1Dycv4dsbfiN5J8iwOnb2qFR5nJU1o9wU/itrED5jAMe73xG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTyE2jHP; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783442893; x=1814978893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nOIebKwntvtOQ2Tr9hO94L7WjGwwMxVjvBAHv948Znw=;
  b=dTyE2jHP9rCvPysNKkffNxXhwW8AkqowAYSyOeH7Ro8l9Gw9r7Nq8PaD
   iTU26YXzil3/XBFgEmNaENmrYFpLIIrBjlMpIjcYTkrGxLYI8Zq+sVsMf
   bjXwi8+0KJRcRzcmc0xx9Qdx6UHI0FL9Rt/xB+hYFV6VtpRmWW9xMdp8H
   /ZLnkJmXDkc73EhWMa5q0bec0p7jQH4g1+HqzPwJ9jHFRyV8S+0La/gdH
   9lbL4rIXLfCkATdmO1qRj0j0a63J47HlQIgs8frMcrPaHiCbRFAHIiYwv
   KfLqiU1YGOARb38SQEcQyHbhiwdsssGEXr0dl+LxA43qLHxIO9boB2SzX
   g==;
X-CSE-ConnectionGUID: UwbIL8OOTZOos1+AgTmzRA==
X-CSE-MsgGUID: j8AAUg6KRVqq/MX0g2UmRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83968815"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83968815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:48:13 -0700
X-CSE-ConnectionGUID: 9Ir3bDt4QU+g/EzOZ8TEsw==
X-CSE-MsgGUID: 9XgzCzfWRzKJc84xkT5j0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278410774"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:48:12 -0700
Message-ID: <266fa964-6022-4661-a151-102549d0d0eb@intel.com>
Date: Tue, 7 Jul 2026 09:48:11 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] dmaengine: ioatdma: use common channel sysfs
 attribute creation
To: Logan Gunthorpe <logang@deltatee.com>, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Kelvin Cao <kelvin.cao@microchip.com>
References: <20260707162045.23910-1-logang@deltatee.com>
 <20260707162045.23910-3-logang@deltatee.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260707162045.23910-3-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12077-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,infradead.org,wanadoo.fr,weissschuh.net,microchip.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:logang@deltatee.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.li@nxp.com,m:hch@infradead.org,m:christophe.jaillet@wanadoo.fr,m:linux@weissschuh.net,m:kelvin.cao@microchip.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC14971E00E



On 7/7/26 9:20 AM, Logan Gunthorpe wrote:
> Instead of manually creating and adding sysfs attributes to each channel
> use the common dma_chan_kobject_add() facility.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/dma.h   |  2 -
>  drivers/dma/ioat/init.c  |  4 +-
>  drivers/dma/ioat/sysfs.c | 88 +++-------------------------------------
>  3 files changed, 7 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index e8a880f338c6..bea2a0101ede 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -393,8 +393,6 @@ void ioat_issue_pending(struct dma_chan *chan);
>  /* IOAT Init functions */
>  bool is_bwd_ioat(struct pci_dev *pdev);
>  struct dca_provider *ioat_dca_init(struct pci_dev *pdev, void __iomem *iobase);
> -void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type);
> -void ioat_kobject_del(struct ioatdma_device *ioat_dma);
>  int ioat_dma_setup_interrupts(struct ioatdma_device *ioat_dma);
>  void ioat_stop(struct ioatdma_chan *ioat_chan);
>  #endif /* IOATDMA_H */
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 737496391109..82f76fd0ccc1 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -541,8 +541,6 @@ static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
>  
>  	ioat_disable_interrupts(ioat_dma);
>  
> -	ioat_kobject_del(ioat_dma);
> -
>  	dma_async_device_unregister(dma);
>  }
>  
> @@ -1174,7 +1172,7 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
>  	if (err)
>  		goto err_disable_interrupts;
>  
> -	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +	dma_chan_kobject_add(&ioat_dma->dma_dev, &ioat_ktype, "quickdata");
>  
>  	if (dca)
>  		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f..4dc61fdddb21 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -14,12 +14,6 @@
>  
>  #include "../dmaengine.h"
>  
> -struct ioat_sysfs_entry {
> -	struct attribute attr;
> -	ssize_t (*show)(struct dma_chan *, char *);
> -	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> -};
> -
>  static ssize_t cap_show(struct dma_chan *c, char *page)
>  {
>  	struct dma_device *dma = c->device;
> @@ -32,7 +26,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>  
>  }
> -static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> +static const struct dma_chan_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
>  
>  static ssize_t version_show(struct dma_chan *c, char *page)
>  {
> @@ -42,77 +36,7 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	return sprintf(page, "%d.%d\n",
>  		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
> -static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
> -
> -static ssize_t
> -ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
> -{
> -	const struct ioat_sysfs_entry *entry;
> -	struct ioatdma_chan *ioat_chan;
> -
> -	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
> -	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
> -
> -	if (!entry->show)
> -		return -EIO;
> -	return entry->show(&ioat_chan->dma_chan, page);
> -}
> -
> -static ssize_t
> -ioat_attr_store(struct kobject *kobj, struct attribute *attr,
> -const char *page, size_t count)
> -{
> -	const struct ioat_sysfs_entry *entry;
> -	struct ioatdma_chan *ioat_chan;
> -
> -	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
> -	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
> -
> -	if (!entry->store)
> -		return -EIO;
> -	return entry->store(&ioat_chan->dma_chan, page, count);
> -}
> -
> -static const struct sysfs_ops ioat_sysfs_ops = {
> -	.show	= ioat_attr_show,
> -	.store  = ioat_attr_store,
> -};
> -
> -void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type)
> -{
> -	struct dma_device *dma = &ioat_dma->dma_dev;
> -	struct dma_chan *c;
> -
> -	list_for_each_entry(c, &dma->channels, device_node) {
> -		struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
> -		struct kobject *parent = &c->dev->device.kobj;
> -		int err;
> -
> -		err = kobject_init_and_add(&ioat_chan->kobj, type,
> -					   parent, "quickdata");
> -		if (err) {
> -			dev_warn(to_dev(ioat_chan),
> -				 "sysfs init error (%d), continuing...\n", err);
> -			kobject_put(&ioat_chan->kobj);
> -			set_bit(IOAT_KOBJ_INIT_FAIL, &ioat_chan->state);
> -		}
> -	}
> -}
> -
> -void ioat_kobject_del(struct ioatdma_device *ioat_dma)
> -{
> -	struct dma_device *dma = &ioat_dma->dma_dev;
> -	struct dma_chan *c;
> -
> -	list_for_each_entry(c, &dma->channels, device_node) {
> -		struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
> -
> -		if (!test_bit(IOAT_KOBJ_INIT_FAIL, &ioat_chan->state)) {
> -			kobject_del(&ioat_chan->kobj);
> -			kobject_put(&ioat_chan->kobj);
> -		}
> -	}
> -}
> +static const struct dma_chan_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>  
>  static ssize_t ring_size_show(struct dma_chan *c, char *page)
>  {
> @@ -120,7 +44,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
>  
>  	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
>  }
> -static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
> +static const struct dma_chan_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
>  
>  static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  {
> @@ -129,7 +53,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  	/* ...taken outside the lock, no need to be precise */
>  	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
>  }
> -static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
> +static const struct dma_chan_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
>  
>  static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
>  {
> @@ -154,7 +78,7 @@ size_t count)
>  	return count;
>  }
>  
> -static const struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
> +static const struct dma_chan_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
>  
>  static const struct attribute *const ioat_attrs[] = {
>  	&ring_size_attr.attr,
> @@ -167,6 +91,6 @@ static const struct attribute *const ioat_attrs[] = {
>  ATTRIBUTE_GROUPS(ioat);
>  
>  const struct kobj_type ioat_ktype = {
> -	.sysfs_ops = &ioat_sysfs_ops,
> +	.sysfs_ops = &dma_chan_sysfs_ops,
>  	.default_groups = ioat_groups,
>  };


