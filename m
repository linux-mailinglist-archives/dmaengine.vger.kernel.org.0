Return-Path: <dmaengine+bounces-5961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E3B1CA57
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7140166934
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE0729A9FE;
	Wed,  6 Aug 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICP9dNR4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930D27FB1B;
	Wed,  6 Aug 2025 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500331; cv=none; b=Z76DyNqa9ubeOtCmR2P6zXQmJxz1VbskynHfXs4UN+ouHb0JxZ3WE3IXJuTFj08JgzhgvU8AaGYgvmDK09+aUw2NgWeEKIVdLQKE4HyAM8ohHa/GTuMF7XfRePZXtfwHlGwoHinivTzYiMQPLEh5jz6o8ogBBR8uCr5bVTv1p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500331; c=relaxed/simple;
	bh=58Xff+YfPpEecPo403tXukV8PAcxoY083yMvOgVF2SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJaxTzVMc63QJQwkxbP2xw5GnX2c6Y7WuMH4jagQkGT8avUG/It6R9Ifu7z82QTGcxY3dST5MMyP/g0Xsxt8XboJpaB9bxiqDQYbB0GkPfPLdZLF4fJA0LyqF2O4PZRN6YxQGckPQutvUQ1wmQjGmxYMg1EGRNMeyyY3J4HFLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICP9dNR4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754500330; x=1786036330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=58Xff+YfPpEecPo403tXukV8PAcxoY083yMvOgVF2SY=;
  b=ICP9dNR4mZGAkUgUhLzWUlTQpvlLiURJs6cSL3DjmgN6DcM0sigAb3Gw
   jRfxBc2Laz1cWHbAibt4dR4HJqsfEO3qCCjiz3WpbNgfIUanLRZg3Iu5e
   IQTG4O1zblDWD0ge8wAsUxSts97PR1VBtPxenRZ6ZJ70dl7CoomJRqRPL
   DNEeiYqOwSc93PgtDEQOz9SJCDR4VNY6XWU9076invr2/jGemFojcr7dv
   BHbP2yG5GjcyU/90gg9f02m/p8zX0eTtvUNtFkobWBi6GyZEJ4zLtTDV1
   MDjb9l10ZgUB+3cRqTCOE9byBT4tvrKrvyyBFRygpsfUtOPid8uRY9K/v
   g==;
X-CSE-ConnectionGUID: 7r3+51NTRBK0zctU5RZNuw==
X-CSE-MsgGUID: jfzuw3GlS3ujWnspVYL2Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56905276"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56905276"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:12:09 -0700
X-CSE-ConnectionGUID: 50jEJsOsS9SSczH2AjY9oA==
X-CSE-MsgGUID: MHurXFj5RY2RWEfFx6IjUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169002597"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:12:05 -0700
Message-ID: <0814df45-15b2-4dc3-98fd-8f30befc800a@intel.com>
Date: Wed, 6 Aug 2025 10:12:00 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] dmaengine: idxd: Flush kernel workqueues on Field
 Level Reset
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-4-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-4-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> When a Field Level Reset (FLR) happens terminate the pending
> descriptors that were issued by in-kernel users and disable the
> interrupts associated with those. They will be re-enabled after FLR
> finishes.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c | 24 ++++++++++++++++++++++++
>  drivers/dma/idxd/idxd.h   |  1 +
>  drivers/dma/idxd/irq.c    |  5 +++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index c599a902767ee9904d75a0510a911596e35a259b..287cf3bf1f5a2efdc9037968e9a4eed506e489c3 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1315,6 +1315,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
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
> @@ -1323,6 +1328,25 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>  	ie->pasid = IOMMU_PASID_INVALID;
>  }
>  
> +void idxd_wqs_flush_descs(struct idxd_device *idxd)
> +{
> +	struct idxd_wq *wq;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		wq = idxd->wqs[i];
> +		if (wq->state == IDXD_WQ_ENABLED && wq->type == IDXD_WQT_KERNEL) {
> +			struct idxd_irq_entry *ie = &wq->ie;
> +
> +			idxd_flush_pending_descs(ie);
> +			if (idxd->request_int_handles)
> +				idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
> +			idxd_device_clear_perm_entry(idxd, ie);
> +			ie->int_handle = INVALID_INT_HANDLE;
> +		}
> +	}
> +}
> +
>  int idxd_wq_request_irq(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 74e6695881e6f1684512601ca2c2ee241aaf0a78..6ccca3c56556dbffe0a7c983a2f11f6c73ff2bfd 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -737,6 +737,7 @@ static inline void idxd_desc_complete(struct idxd_desc *desc,
>  int idxd_register_devices(struct idxd_device *idxd);
>  void idxd_unregister_devices(struct idxd_device *idxd);
>  void idxd_wqs_quiesce(struct idxd_device *idxd);
> +void idxd_wqs_flush_descs(struct idxd_device *idxd);
>  bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>  void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
>  int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 74059fe43fafeb930f58db21d3824f62b095b968..26547586fcfaa1b9d244b678bf8e209b7b14d35a 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -417,6 +417,11 @@ static irqreturn_t idxd_halt(struct idxd_device *idxd)
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


