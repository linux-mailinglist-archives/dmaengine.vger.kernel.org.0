Return-Path: <dmaengine+bounces-9202-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCuhKEMbpmmeKQAAu9opvQ
	(envelope-from <dmaengine+bounces-9202-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:20:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D51E6872
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44B8231D623D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5FE2C21ED;
	Mon,  2 Mar 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AG8D0q0l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D8282F0E;
	Mon,  2 Mar 2026 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491779; cv=none; b=TIGDpH/a+6ZjZswkXB44Clq5pmZJ+5xmro5L4I53E1Jwh+YxXBx3Xa8r+T4QzGycMMp9HWg5mkPqzhn7IL4HsQQojbPut4yVjeE0nBHx+0hFbrzARe9Tj4I6LW8dVnj7NA3ugh2UynWLzmTtLTKHvRx0dohct09hQmmjjdqBSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491779; c=relaxed/simple;
	bh=U/FFxJij7srXOgSSS7vFDvc3r0HFPe011NKtx94JcPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHKfnt9Lw9Ek7oIv2wItf7mjUrtTMMaPFFgSAwdt/NYrAGgZ/KL5EPwjfyO7zvMwegP4JiK/4JHJgDQrANr8e07PVIY7lBslSyWaBLtLM9HJddZt6ILEs9tUqKfGNa9qdKH/Vb3XtSesU805CTQCjVoQkkwOqgryQv/GdZn3VaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AG8D0q0l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772491766; x=1804027766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U/FFxJij7srXOgSSS7vFDvc3r0HFPe011NKtx94JcPQ=;
  b=AG8D0q0lrlm5Y2PVOaoGApFkzoh6XsgUvuppThMLdBTPfJlxPKDo73Rw
   p3l2ShFmdayyjVNgILbdrS9BkTfMK9Nro80eve0FTP3wwE4ivktixgn64
   0o6X9fACC1mD0afcTO8x1kBtmuSpT8NaZffO4hPAdE/8oOrOB++kPDaWe
   dYHlwAgnKKjptik3vdVdGirmmvMiTl8I6AE6yoOzv9446cyclTKdE/wnJ
   hikJov5MMr5yQQCm76PiijlQwloKmdlKbGFmLuETCF9n6rjPW14tiQT00
   QpVmS6OHkM7/oKVEE/JNLpk9LictVaL8bjYYNDKcC+6dmmZZ3/N03YNnn
   w==;
X-CSE-ConnectionGUID: kRxNy/YiTo+X1aHeaItu1w==
X-CSE-MsgGUID: u/PDUhSFTwe4T7zDFGgNlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73419931"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73419931"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:49:25 -0800
X-CSE-ConnectionGUID: PFg6IHmoTayp84G2tnNAhw==
X-CSE-MsgGUID: 04xvrRywQIakdbWc1AIbqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="222787756"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.99]) ([10.125.108.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:49:24 -0800
Message-ID: <b5a8b80b-5559-4e79-bb50-c58096b4090a@intel.com>
Date: Mon, 2 Mar 2026 15:49:23 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dmaengine: ioatdma: make ioat_ktype const
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
 <20260302-sysfs-const-ioat-v1-3-1229ee1c83f3@weissschuh.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260302-sysfs-const-ioat-v1-3-1229ee1c83f3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B8D51E6872
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
	TAGGED_FROM(0.00)[bounces-9202-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,weissschuh.net:email]
X-Rspamd-Action: no action



On 3/2/26 3:15 PM, Thomas Weißschuh wrote:
> This structure is never modified, mark is as read-only.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/dma/ioat/dma.h   | 4 ++--
>  drivers/dma/ioat/sysfs.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index e187f3a7e968..e8a880f338c6 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -190,7 +190,7 @@ struct ioat_ring_ent {
>  };
>  
>  extern int ioat_pending_level;
> -extern struct kobj_type ioat_ktype;
> +extern const struct kobj_type ioat_ktype;
>  extern struct kmem_cache *ioat_cache;
>  extern struct kmem_cache *ioat_sed_cache;
>  
> @@ -393,7 +393,7 @@ void ioat_issue_pending(struct dma_chan *chan);
>  /* IOAT Init functions */
>  bool is_bwd_ioat(struct pci_dev *pdev);
>  struct dca_provider *ioat_dca_init(struct pci_dev *pdev, void __iomem *iobase);
> -void ioat_kobject_add(struct ioatdma_device *ioat_dma, struct kobj_type *type);
> +void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type);
>  void ioat_kobject_del(struct ioatdma_device *ioat_dma);
>  int ioat_dma_setup_interrupts(struct ioatdma_device *ioat_dma);
>  void ioat_stop(struct ioatdma_chan *ioat_chan);
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index 709d672bae51..da616365fef5 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -78,7 +78,7 @@ static const struct sysfs_ops ioat_sysfs_ops = {
>  	.store  = ioat_attr_store,
>  };
>  
> -void ioat_kobject_add(struct ioatdma_device *ioat_dma, struct kobj_type *type)
> +void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type)
>  {
>  	struct dma_device *dma = &ioat_dma->dma_dev;
>  	struct dma_chan *c;
> @@ -166,7 +166,7 @@ static struct attribute *ioat_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ioat);
>  
> -struct kobj_type ioat_ktype = {
> +const struct kobj_type ioat_ktype = {
>  	.sysfs_ops = &ioat_sysfs_ops,
>  	.default_groups = ioat_groups,
>  };
> 


