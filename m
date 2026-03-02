Return-Path: <dmaengine+bounces-9204-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J2kHy8cpmmeKQAAu9opvQ
	(envelope-from <dmaengine+bounces-9204-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:24:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E61111E693D
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB8630B54D0
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97272D73BD;
	Mon,  2 Mar 2026 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJp7/Njg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8C282F04;
	Mon,  2 Mar 2026 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492217; cv=none; b=ey/SJR8xpPH9nuCI5cWNQvs2Aj1u+A4/snoRk3WnfcOb5CeKle0PZeC+LPhpi8GzxDUslFAwvbs5bzZhXAdZEj5z/2Nlt/Zu7iVMJqJcu7olvDSDfRlcbe91SIJz+JOBBgINcdTqzLNxzVFT8XRbKorOZ+xY/TqRP6NgliqTYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492217; c=relaxed/simple;
	bh=CduD1jcClP9jv1yrNJVgxGtKoIyueC1Cn+GdwJ4QKEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzHW0Gm+Rx3mh8OkF2eC66ovrTYuQVjBqL3azYRG9CtxLBPNXIEnYkwx2tx8lzwZBqIuaCZKS0k9Qs/1hfj3ZAxejJJBs3GL3kgPzIEF/2C3xmdnAYdAT/hh00cLARd6B/TaR4tcurFwhYQfn00/lp2WPL97ACoU2LJeO6PvirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJp7/Njg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772492216; x=1804028216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CduD1jcClP9jv1yrNJVgxGtKoIyueC1Cn+GdwJ4QKEU=;
  b=FJp7/NjgYo+eDi/KO2TRwT+FA4+Ydwob5oMLrdn7BkNN6zQ4sm7m1awr
   MNoDmgvGQxSWTncViIYXRTl7S/xFbyxmIgO/93tSHJhDFeOkL3z2ZRVye
   kZ3hnWZuaFz209gIzsz+t66Oqmy7Dy2AOT9bqe9UvqVvwA/ibX07rCkt1
   moKG/iaNyDx+9KqNTs42XWwNG0ie3mklts8L3g6GWDK0RNsNJNM3VbejY
   2EzZCnifzeSZXnU12trg78C5+YJuD4ngBAjtmrogSakMmVr2Nujch8OVV
   akQLMvrmUHyAp2FqsaqYGlUFQxZz0qFiVuxvzoua8yQSa/b1xkIm7x8te
   Q==;
X-CSE-ConnectionGUID: HBNwVDg3QQCa7AuAyuXqKQ==
X-CSE-MsgGUID: 7Cjf+9FMQQ21jIjlkr11AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="61085120"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="61085120"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:56:54 -0800
X-CSE-ConnectionGUID: 6Kgs+gX5SrqCcFrO9FkOdg==
X-CSE-MsgGUID: sp4eTKLrSx+944sEw4py3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="222790143"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.99]) ([10.125.108.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:56:54 -0800
Message-ID: <e6ea8219-8a40-43d9-b604-1a6b1673cb6a@intel.com>
Date: Mon, 2 Mar 2026 15:56:52 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dmaengine: ioatdma: make some sysfs structures static
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
 <20260302-sysfs-const-ioat-v1-1-1229ee1c83f3@weissschuh.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260302-sysfs-const-ioat-v1-1-1229ee1c83f3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E61111E693D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9204-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action



On 3/2/26 3:15 PM, Thomas Weißschuh wrote:
> These structures are only used in sysfs.c, where are defined.
> 
> Make them static and remove them from the header.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/dma.h   | 3 ---
>  drivers/dma/ioat/sysfs.c | 6 +++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 12a4a4860a74..27d2b411853f 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -195,9 +195,6 @@ struct ioat_ring_ent {
>  	struct ioat_sed_ent *sed;
>  };
>  
> -extern const struct sysfs_ops ioat_sysfs_ops;
> -extern struct ioat_sysfs_entry ioat_version_attr;
> -extern struct ioat_sysfs_entry ioat_cap_attr;
>  extern int ioat_pending_level;
>  extern struct kobj_type ioat_ktype;
>  extern struct kmem_cache *ioat_cache;
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index 168adf28c5b1..5da9b0a7b2bb 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -26,7 +26,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>  
>  }
> -struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> +static struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
>  
>  static ssize_t version_show(struct dma_chan *c, char *page)
>  {
> @@ -36,7 +36,7 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	return sprintf(page, "%d.%d\n",
>  		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
> -struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
> +static struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>  
>  static ssize_t
>  ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
> @@ -67,7 +67,7 @@ const char *page, size_t count)
>  	return entry->store(&ioat_chan->dma_chan, page, count);
>  }
>  
> -const struct sysfs_ops ioat_sysfs_ops = {
> +static const struct sysfs_ops ioat_sysfs_ops = {
>  	.show	= ioat_attr_show,
>  	.store  = ioat_attr_store,
>  };
> 


