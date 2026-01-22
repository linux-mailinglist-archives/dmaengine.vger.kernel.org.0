Return-Path: <dmaengine+bounces-8458-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JamC58+cmnpfAAAu9opvQ
	(envelope-from <dmaengine+bounces-8458-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 16:13:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181FC687F3
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D8E130000A0
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B336828A;
	Thu, 22 Jan 2026 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKHQS1se"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6A352F95;
	Thu, 22 Jan 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094807; cv=none; b=IQu6qjy3EsAhBbEWqZKSlEAgM2YjqT+1jIbmEeyUgK1DZnU2MQFaQEWG75ACWEmMo/VbufMKJ/T4r8Bc+HsTUH902/lWKnDTBbigEKanbx9Mjru9qleeKnPY6b1NetksiiO1pC2fVRisI7IS6mxDcWey6HP2fsETaP+K3U/3weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094807; c=relaxed/simple;
	bh=DEwa5W4b7aGUrjxBwSNa6yO5TAOLBTo4Q4Y820Y2pOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa6Dh3c3kFSBvkMt5NjW0nyWMNP+Ns+GnP3ZfLqcAvgY9mUUp/HJ4Ps5mI3ywwWH4cRv+jBnDRAVcpR2sjvU6rhZmWM8/BiZnQRnF+Ysh4iN4fjcw5hY3sGI4fUna+3ZZMjc/SDKwPMKy3SVSDydHWux8ghOE5Xt/Sgfxcm8OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKHQS1se; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094805; x=1800630805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DEwa5W4b7aGUrjxBwSNa6yO5TAOLBTo4Q4Y820Y2pOo=;
  b=VKHQS1sejXxJDkYzYsS8pYZty8zCGvYiBmHj9btfpkh5fU25j7u3aHNr
   DyRJ6mOCJUWEktjBlqwekYLmfT3IElSe2Fwy3xCBdw4rJUhPpvAGKIzJf
   hjl4eAs+IpjtMoT7IIXJ7/FkMq5Ief7WivAmVgLr4Q1SQv/I58eGPDLrK
   fp18Mka2eDPMdxtE5+GbyCpFK0dnlwNGFlx5gmTl74TzMK2NfUccrkKgM
   svGylAvOj+JKnoXnEBLV8arJnN5ejFewdjGnKMNdd8aLJoh3yqy5GRxoR
   e1mB/u4gtlUW3xbK1fZQvMF/qnt8//5RY+GWhZg5VONtXFhtPgoGB9C5+
   A==;
X-CSE-ConnectionGUID: nYaYG0nmTbGwZRxlChrdBw==
X-CSE-MsgGUID: HNofY2MmS8G9kKQJ/HvMjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74191456"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74191456"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:13:24 -0800
X-CSE-ConnectionGUID: 65ZBNQwfRteoVOUOC83gIQ==
X-CSE-MsgGUID: edH5xkS6S+2nyJt00Bw8+w==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.157]) ([10.125.108.157])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:13:23 -0800
Message-ID: <92c6e6c7-24ff-46a6-8a8d-309d151fffb4@intel.com>
Date: Thu, 22 Jan 2026 08:13:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] dmaengine: idxd: Flush kernel workqueues on
 Function Level Reset
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
 <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-4-7ed70658a9d1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-4-7ed70658a9d1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8458-lists,dmaengine=lfdr.de];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 181FC687F3
X-Rspamd-Action: no action



On 1/21/26 11:34 AM, Vinicius Costa Gomes wrote:
> When a Function Level Reset (FLR) happens, terminate the pending
> descriptors that were issued by in-kernel users and disable the
> interrupts associated with those. They will be re-enabled after FLR
> finishes.
> 
> idxd_wq_flush_desc() is declared on idxd.h because it's going to be
> used in by the DMA backend in a future patch.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/device.c | 22 ++++++++++++++++++++++
>  drivers/dma/idxd/idxd.h   |  1 +
>  drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5265925f3076..5e890b6771cb 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1339,6 +1339,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>  
>  	free_irq(ie->vector, ie);
>  	idxd_flush_pending_descs(ie);
> +
> +	/* The interrupt might have been already released by FLR */
> +	if (ie->int_handle == INVALID_INT_HANDLE)
> +		return;
> +
>  	if (idxd->request_int_handles)
>  		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
>  	idxd_device_clear_perm_entry(idxd, ie);
> @@ -1347,6 +1352,23 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>  	ie->pasid = IOMMU_PASID_INVALID;
>  }
>  
> +void idxd_wq_flush_descs(struct idxd_wq *wq)
> +{
> +	struct idxd_irq_entry *ie = &wq->ie;
> +	struct idxd_device *idxd = wq->idxd;
> +
> +	guard(mutex)(&wq->wq_lock);
> +
> +	if (wq->state != IDXD_WQ_ENABLED || wq->type != IDXD_WQT_KERNEL)
> +		return;
> +
> +	idxd_flush_pending_descs(ie);
> +	if (idxd->request_int_handles)
> +		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
> +	idxd_device_clear_perm_entry(idxd, ie);
> +	ie->int_handle = INVALID_INT_HANDLE;
> +}
> +
>  int idxd_wq_request_irq(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index ea8c4daed38d..ce78b9a7c641 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -803,6 +803,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq);
>  int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
>  void idxd_wq_free_irq(struct idxd_wq *wq);
>  int idxd_wq_request_irq(struct idxd_wq *wq);
> +void idxd_wq_flush_descs(struct idxd_wq *wq);
>  
>  /* submission */
>  int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 1107db3ce0a3..8d0eaf5029fa 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -397,6 +397,17 @@ static void idxd_device_flr(struct work_struct *work)
>  		dev_err(&idxd->pdev->dev, "FLR failed\n");
>  }
>  
> +static void idxd_wqs_flush_descs(struct idxd_device *idxd)
> +{
> +	int i;
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		struct idxd_wq *wq = idxd->wqs[i];
> +
> +		idxd_wq_flush_descs(wq);
> +	}
> +}
> +
>  static irqreturn_t idxd_halt(struct idxd_device *idxd)
>  {
>  	union gensts_reg gensts;
> @@ -415,6 +426,11 @@ static irqreturn_t idxd_halt(struct idxd_device *idxd)
>  		} else if (gensts.reset_type == IDXD_DEVICE_RESET_FLR) {
>  			idxd->state = IDXD_DEV_HALTED;
>  			idxd_mask_error_interrupts(idxd);
> +			/* Flush all pending descriptors, and disable
> +			 * interrupts, they will be re-enabled when FLR
> +			 * concludes.
> +			 */
> +			idxd_wqs_flush_descs(idxd);
>  			dev_dbg(&idxd->pdev->dev,
>  				"idxd halted, doing FLR. After FLR, configs are restored\n");
>  			INIT_WORK(&idxd->work, idxd_device_flr);
> 


