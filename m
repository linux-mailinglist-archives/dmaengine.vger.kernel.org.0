Return-Path: <dmaengine+bounces-6117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821AB309E0
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA78A1D00200
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB12C0299;
	Thu, 21 Aug 2025 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDmP5J1T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992822CBD9;
	Thu, 21 Aug 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817954; cv=none; b=TQHw2YU/U28J4G4sWGXf/dLycMiZBA89yfnF/FoWADp/0GA9krLMPtjz/MYk7r8ik9xzk8jar8+JPPy1IKO4nXI1zBzxO38PGcgY31WaALs45jwxCjIpLksv3YvL6TdJIDXvymXkuG95s7g3Cwsmc2w0bvPyxKS2wFWL1XFf/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817954; c=relaxed/simple;
	bh=InPF/UyU3iS2NFVCZwmCP2oQN/XyYdw3vKjciUtW5BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNok2mErUz6r83hXm2vqndU2ih4XUqtT8oF0LReJHthamdq+ohwTsBPmJqDKMRJCGmyLrgqK36GpXj5nxvj+Y1YO5bHczk84ht6ff9KWAy2SLpqvI43hKbwHnmC1WF5hvcn1wewUZC47ePzZyXZ1wDEtvIPvs12sVBbH4Nu/rxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDmP5J1T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817953; x=1787353953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=InPF/UyU3iS2NFVCZwmCP2oQN/XyYdw3vKjciUtW5BI=;
  b=CDmP5J1T8f0disQNBCtx0KI3diUh3ERl+DO2+i97V0rSyHBD9+dAyr0h
   q5kD9jC6O5xps+GSMLYDzneJh4tQoV8UQfHrHq11Hs9Uyir+WQ0GPNfIH
   4KUnW+v8WEuPzlIFuawwRHllVQYnq/VempDNnFAnzq2MaZ4UJ0QdpM9sv
   aC6V6QDO4TegkdVim4QaApokr2mkxQ5EYMZMT/ZvHuDtXrjzqESTRP3uD
   ccEiyXnr9bKuWmCDLAnLAvFBWuw2GdCJTk5tWduFMCV0gz1Or3ZcUgtYh
   DqT+7KIRmOl8d0sBkuVnCTtg9S4LDBYTQEUWMYTaZZ956Qp6GpgP6l7aF
   g==;
X-CSE-ConnectionGUID: NrDB0o7NTViBy+DbX1vtFA==
X-CSE-MsgGUID: 1/elu3riSQqXdOiU+f8kDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61957363"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61957363"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:12:33 -0700
X-CSE-ConnectionGUID: ofmcVSNFSjqtc7p0MhJBjw==
X-CSE-MsgGUID: VO+IX6GxSYGHJddH3pCqPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168764912"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.210]) ([10.247.119.210])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:12:29 -0700
Message-ID: <5c20e01c-e858-4ff7-aef9-05ecd17f9c99@intel.com>
Date: Thu, 21 Aug 2025 16:12:23 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] dmaengine: idxd: Flush kernel workqueues on
 Function Level Reset
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
 <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-4-595d48fa065c@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-4-595d48fa065c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 3:59 PM, Vinicius Costa Gomes wrote:
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
>  drivers/dma/idxd/device.c | 20 ++++++++++++++++++++
>  drivers/dma/idxd/idxd.h   |  1 +
>  drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 02bda8868e24..c62808e30417 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1319,6 +1319,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
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
> @@ -1327,6 +1332,21 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>  	ie->pasid = IOMMU_PASID_INVALID;
>  }
>  
> +void idxd_wq_flush_descs(struct idxd_wq *wq)
> +{
> +	struct idxd_irq_entry *ie = &wq->ie;
> +	struct idxd_device *idxd = wq->idxd;
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
> index 74e6695881e6..fb7f570e002b 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -784,6 +784,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq);
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


