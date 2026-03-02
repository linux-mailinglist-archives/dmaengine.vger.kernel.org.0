Return-Path: <dmaengine+bounces-9203-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOF5CzQbpmmeKQAAu9opvQ
	(envelope-from <dmaengine+bounces-9203-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:20:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3DA1E6862
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628773148E14
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C229A312;
	Mon,  2 Mar 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgdOLQci"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183FA282F1A;
	Mon,  2 Mar 2026 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491809; cv=none; b=PSNSvMyokogNN7iSaJv93rT4IzQfSEO6pihi7NwuML1RSmjOeiQcvSV0cd4R968+DZRbxnnwcLiQRbRO6VH0z4MvzUJ4hxaTFn3oYC+62NRMSOz0Vh/wp17R1s3BIkz9s3CbgKGww0lI0/5q0fNJJabreCB9lbXfqZjJqRTWPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491809; c=relaxed/simple;
	bh=Khu5WZXLpn9xTGIr3xPxweBQmF3kMz6Qd0sJVb5eZ1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Btk8aucRJ+8K332dEGDtCRjdtW2BvAGgNbtbc6hzQ305qsqdmdHF8I5st7PiztBQNaqWpwx7/chnK4mPzZN6z2bfYyJ6CqDLeamXbe5dEmnHykwTi6i0Gpn1rex1egpjqKbrQz1wggdAssln2n5ipaG/pnU5h/grIqFjBjBjKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgdOLQci; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772491804; x=1804027804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Khu5WZXLpn9xTGIr3xPxweBQmF3kMz6Qd0sJVb5eZ1w=;
  b=IgdOLQcihfbGW3ljgSxdQ9pfG+ZZhh3vzQeFB5fsvAiwzA1OINYfhSXx
   QwflV4WJXtqO1b3kqpLOwDTtnajGPDimTEr6YrYedtS4orxe1YsXikxIp
   QJ7iTOIxOTbKGs26a2dtp2ruJXFpYk0ua4t2FWd9TIHmoOAK5btYjWUgw
   dbOmufsDXCJCKG4/Xa+kiDiZzB8bjruBJ+Tx8QiYyW/04Y1ZSqaG+21bC
   8VT9Si/slmky+5tU4dgqTjjUpnFOesVVkJzTF5YCVoXtu/Qiul+BK/qd+
   vJ36IMJ2vOSaGmqQsz989lmy1/t4SEjY6gHT+nrJV8tUiy/R4wPkIX7Ds
   A==;
X-CSE-ConnectionGUID: S48IxnuXSTip/0d6ggcidw==
X-CSE-MsgGUID: LhIv3Un9SDCw1zE0tY83LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73419973"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73419973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:50:03 -0800
X-CSE-ConnectionGUID: AFBGGc6pQFymXIkgT3FFEg==
X-CSE-MsgGUID: B+T3mmFsSv+t3dS1uBbOJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="222788036"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.99]) ([10.125.108.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:50:04 -0800
Message-ID: <276a4ab4-55fc-44a0-8e67-728620eb4a3c@intel.com>
Date: Mon, 2 Mar 2026 15:50:02 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dmaengine: ioatdma: make sysfs attributes const
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
 <20260302-sysfs-const-ioat-v1-4-1229ee1c83f3@weissschuh.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260302-sysfs-const-ioat-v1-4-1229ee1c83f3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC3DA1E6862
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9203-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:email]
X-Rspamd-Action: no action



On 3/2/26 3:15 PM, Thomas Weißschuh wrote:
> These structures are never modified, mark them as read-only.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Acked-by: Dave Jiang <dave.jiang@intel.com>



> ---
>  drivers/dma/ioat/sysfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index da616365fef5..e796ddb5383f 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -32,7 +32,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>  
>  }
> -static struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> +static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
>  
>  static ssize_t version_show(struct dma_chan *c, char *page)
>  {
> @@ -42,15 +42,15 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	return sprintf(page, "%d.%d\n",
>  		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
> -static struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
> +static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>  
>  static ssize_t
>  ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
>  {
> -	struct ioat_sysfs_entry *entry;
> +	const struct ioat_sysfs_entry *entry;
>  	struct ioatdma_chan *ioat_chan;
>  
> -	entry = container_of(attr, struct ioat_sysfs_entry, attr);
> +	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
>  	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
>  
>  	if (!entry->show)
> @@ -62,10 +62,10 @@ static ssize_t
>  ioat_attr_store(struct kobject *kobj, struct attribute *attr,
>  const char *page, size_t count)
>  {
> -	struct ioat_sysfs_entry *entry;
> +	const struct ioat_sysfs_entry *entry;
>  	struct ioatdma_chan *ioat_chan;
>  
> -	entry = container_of(attr, struct ioat_sysfs_entry, attr);
> +	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
>  	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
>  
>  	if (!entry->store)
> @@ -120,7 +120,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
>  
>  	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
>  }
> -static struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
> +static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
>  
>  static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  {
> @@ -129,7 +129,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
>  	/* ...taken outside the lock, no need to be precise */
>  	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
>  }
> -static struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
> +static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
>  
>  static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
>  {
> @@ -154,9 +154,9 @@ size_t count)
>  	return count;
>  }
>  
> -static struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
> +static const struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
>  
> -static struct attribute *ioat_attrs[] = {
> +static const struct attribute *const ioat_attrs[] = {
>  	&ring_size_attr.attr,
>  	&ring_active_attr.attr,
>  	&ioat_cap_attr.attr,
> 


