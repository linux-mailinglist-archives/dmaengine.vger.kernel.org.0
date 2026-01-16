Return-Path: <dmaengine+bounces-8311-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76DD38757
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C94D321BDA8
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 20:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6E3A4AAD;
	Fri, 16 Jan 2026 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzFG8AQG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FF3A35C9;
	Fri, 16 Jan 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594591; cv=none; b=RRum6IlGcWitmj6XWO69WkPmPRuW2QS2jb8g+uruREG1CkHTyRGRSXXquDu9uwU1XqJ+h1St6RWM088dqjApvHLtCZk+MdMOqoAdKuvVPYMxJ/HqumGy8jGKARpdFdJj+HfFEcYwAmYwO+nHEiiGILGEH4jDLL+Mp2TRa86Q6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594591; c=relaxed/simple;
	bh=1/S/UzPPP0bCR7VS+CP+lfLzyEXlpBEQN56lJgsVA04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGu6KdaQAUh5/k2ez0wnsOaHQ1aCqlSl9rifslFtn9+AvyWq/A9iFhPo6a/kSP1GG1pOPoQmBzyTi0WbW9Rr0/XyGq93nIB0GDoI1ez+XLiBZSLWqgQQKYKndnwUJNp9/ecCr/kTNxyxBQEXhyaL433REe0WupvBSr/X7frHSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzFG8AQG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768594590; x=1800130590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1/S/UzPPP0bCR7VS+CP+lfLzyEXlpBEQN56lJgsVA04=;
  b=HzFG8AQGRdRVEtAm5EUm8b9UkyDZUCR0p3qoTr+ySBaKPUumfQkJFgk0
   DuRiYB1KlPgoluMn5DstmgObizfvh5Qg6Psbh0AyPDxIIVqPXn/gp7nLJ
   A5MtPsopPwgyQkF+1uXRKNJKlbNVE0c9CXTCvDEGgKznN9dOdGsgvf9M/
   icLXEjUhNWIDuO8YHOHOhTah3CcdIFO75KE2p2w5CmJtjBHUykBeDUaQt
   zkHJAJ0l1mOo2upOXIzzyvfgqyEhsDAhmdpiy1JLL9ANiUqgVyzIRM8FG
   3dgx4giKOhBE2tgjevQacdFZJpP01v0zT34xfPucMbokMP6k3udETATpm
   A==;
X-CSE-ConnectionGUID: lZhnUC5SSomsxv2JbYQHdQ==
X-CSE-MsgGUID: saNxxy3aTqO1gvt8npC4RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="73766787"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="73766787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:16:29 -0800
X-CSE-ConnectionGUID: FhlQglx4SJmvIqWzlf1Y6g==
X-CSE-MsgGUID: gymsrZQbTB+2QSd0IAurxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="205386334"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:16:29 -0800
Message-ID: <8cded3aa-c152-4db2-859d-4835155a0a6a@intel.com>
Date: Fri, 16 Jan 2026 13:16:28 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 04/10] dmaengine: idxd: Flush kernel workqueues
 on Function Level Reset
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
 <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-4-59e106115a3e@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-4-59e106115a3e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 3:47 PM, Vinicius Costa Gomes wrote:
> When a Function Level Reset (FLR) happens, terminate the pending
> descriptors that were issued by in-kernel users and disable the
> interrupts associated with those. They will be re-enabled after FLR
> finishes.
> 
> idxd_wq_flush_desc() is declared on idxd.h because it's going to be
> used in by the DMA backend in a future patch.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/dma/idxd/device.c | 20 ++++++++++++++++++++
>  drivers/dma/idxd/idxd.h   |  1 +
>  drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5265925f3076..b8422dc7d2ca 100644
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
> @@ -1347,6 +1352,21 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>  	ie->pasid = IOMMU_PASID_INVALID;
>  }
>  
> +void idxd_wq_flush_descs(struct idxd_wq *wq)
> +{
> +	struct idxd_irq_entry *ie = &wq->ie;
> +	struct idxd_device *idxd = wq->idxd;
> +
Should it take a wq lock for this function?

DJ

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


