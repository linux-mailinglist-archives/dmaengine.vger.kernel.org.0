Return-Path: <dmaengine+bounces-8316-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88172D38B1E
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 02:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9240B3058BCD
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 01:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27843239E9B;
	Sat, 17 Jan 2026 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFMb0f0d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A300231842;
	Sat, 17 Jan 2026 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612694; cv=none; b=rEJ3Do6/ibPpPFex+4sG/DhiUH4O09TnbxSrw37MKzmuQ+jK1Q5bcm+2JAccdhscRFj/nR/syqsylZ9T+X2BgLogv+fsqV7/rNY9MUQMe830yc87pmf39tacZHo3CxUT1x9EIhNYol/bQUN5XSLtUfePKL5QRLCAIMSPE7JsPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612694; c=relaxed/simple;
	bh=nDOGUr+2T8YO4xczRY71lWe0pABze8aXvmW2eTMbf4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Da1pDpB2aytGTIT1WdXg29dL5d4xQchWBuU0Usl5YEfkf0fNMarbbIKsPYIqPXVx6HBSsX26vPFTk/j/OBHnWmzFyoKif3LiE6QCRaraAlS8qJN4dXhSIT8Fxf1zuQGgkhLq8F0l6lokAEjYpokbAnOKXuCbeVs7V+mC1XaW+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFMb0f0d; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768612693; x=1800148693;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nDOGUr+2T8YO4xczRY71lWe0pABze8aXvmW2eTMbf4c=;
  b=YFMb0f0dickhgladYwdhmJ/Lz/LtS/1WxiJ61nrb4X2eeHn6KqfxtH1Y
   LEoge6uO4NCESsx7MFYz8uwfHSLY0z2u2C5zeOZd4BMfRlPDnEi7f4Y9X
   L91y/GjP8jzQZuplwZ2utWFdmnBU1C8Ci9tkuEbsbJstL35WET8NMKhS/
   64uOq/xbKyTrLgs/imSN+i6d3+n6RkuWk6MzJZxWd3Nq2N98jC7W16rYT
   Z4iBYGcJnvZtMC/e1PkVTekCvRuMY9gLwFg1aYOR0TN4xxD+1eaMUzl4j
   7hOmf/I5jwLZQ7iZUr+AoVKU7EZWFFKHzZeOpjfDZiZ0iD/u1vNbLksTV
   w==;
X-CSE-ConnectionGUID: BSd6k2s4TDiW7ZslFKqv1Q==
X-CSE-MsgGUID: aY+adAiCTXufqfBlkHnvYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81373631"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="81373631"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 17:18:13 -0800
X-CSE-ConnectionGUID: GlCjVvABRmywNpslifnpyQ==
X-CSE-MsgGUID: hJyVtfOkT0qhAWBSs0XkMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="205279038"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.111.169])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 17:18:11 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 04/10] dmaengine: idxd: Flush kernel
 workqueues on Function Level Reset
In-Reply-To: <8cded3aa-c152-4db2-859d-4835155a0a6a@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
 <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-4-59e106115a3e@intel.com>
 <8cded3aa-c152-4db2-859d-4835155a0a6a@intel.com>
Date: Fri, 16 Jan 2026 17:18:10 -0800
Message-ID: <87v7h16nql.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Jiang <dave.jiang@intel.com> writes:

> On 1/15/26 3:47 PM, Vinicius Costa Gomes wrote:
>> When a Function Level Reset (FLR) happens, terminate the pending
>> descriptors that were issued by in-kernel users and disable the
>> interrupts associated with those. They will be re-enabled after FLR
>> finishes.
>> 
>> idxd_wq_flush_desc() is declared on idxd.h because it's going to be
>> used in by the DMA backend in a future patch.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  drivers/dma/idxd/device.c | 20 ++++++++++++++++++++
>>  drivers/dma/idxd/idxd.h   |  1 +
>>  drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
>>  3 files changed, 37 insertions(+)
>> 
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 5265925f3076..b8422dc7d2ca 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -1339,6 +1339,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>>  
>>  	free_irq(ie->vector, ie);
>>  	idxd_flush_pending_descs(ie);
>> +
>> +	/* The interrupt might have been already released by FLR */
>> +	if (ie->int_handle == INVALID_INT_HANDLE)
>> +		return;
>> +
>>  	if (idxd->request_int_handles)
>>  		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
>>  	idxd_device_clear_perm_entry(idxd, ie);
>> @@ -1347,6 +1352,21 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>>  	ie->pasid = IOMMU_PASID_INVALID;
>>  }
>>  
>> +void idxd_wq_flush_descs(struct idxd_wq *wq)
>> +{
>> +	struct idxd_irq_entry *ie = &wq->ie;
>> +	struct idxd_device *idxd = wq->idxd;
>> +
> Should it take a wq lock for this function?
>

Good catch. Will take a another look and see if I am missing any locks
elsewhere.


Cheers,
-- 
Vinicius

