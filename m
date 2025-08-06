Return-Path: <dmaengine+bounces-5968-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F86B1CD76
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 22:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A00188D2D1
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6972222C0;
	Wed,  6 Aug 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U39cQimA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D221D5B5;
	Wed,  6 Aug 2025 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512216; cv=none; b=LDBhWR/IepCTpoOTrrF/vOBtCZwFRFAx4NcsO104LteVPByC8RJTWqUN8ojEWa2AAihbAIvgK5GcC57sZ2wT7n5wC5l5nUNVclcG3rbFeKOfQarhw7GF2TB4Coxx82gHe8ryGdKebV9ZgGcVo3bTlbe3S7S0oQhfAJhGRFPMoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512216; c=relaxed/simple;
	bh=mVq7P95o9LBD+rMqDOIVBdPVLeu5/lxeJaH+NFPx8oA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4c0lSgN76PpsE5yjV8STj+t0Hh0iVjA11YTwAMylRjtZpJF1maEx3deKF1W4sHpaMlm8918INwNUG80RwezKwPV26hnYLRfJ+B8Hnz9hzb7m0IefFWh2zatOI2oxKm9qYeod26tLDT8eKGNugUPLtSOb3Hm7jZnJ6me8Fd74LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U39cQimA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512215; x=1786048215;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mVq7P95o9LBD+rMqDOIVBdPVLeu5/lxeJaH+NFPx8oA=;
  b=U39cQimAyVk/mW8cT3O2krMgHttWwApZpK3E4hqGwtJJN9niZJ+rePY0
   ZdhhDs04G4T6NHzAyrBPApTGt3jOAcfh1WhQ9zP41ULU621e5MGBHxGRK
   y1VJJZ8bx9oVptsZWSnH6kQIvieD2CM7+VKc6MZBF1EiDBDSCX2iXWuRX
   v5jNhtdOBSe8CzLLYtAEqUxLLEwitfMoQpPzpz21/gkMd/G/dB/Mn+pVo
   lnkm0HBi9XyLrCkGNTGBnPfpSf9ZDxUGVVNP+LR9cyaVfbiLlLR36YO94
   8c2RR0bExUzrO2wJVNnhDKp699atODX3f1xET3GP9igN7ZGmqqHMKZEbH
   w==;
X-CSE-ConnectionGUID: WbGF+LnXTzCFzyV0Gdxe+Q==
X-CSE-MsgGUID: JZem/DS0RTenw6RS6Pp/zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74302434"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74302434"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:30:14 -0700
X-CSE-ConnectionGUID: iRR9qoEdTv69gu4OvxEKQQ==
X-CSE-MsgGUID: OKHQKwcpS/q7NkezN09NDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164387880"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.98.32.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:30:14 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] dmaengine: idxd: Allow DMA clients to empty the
 pending queue
In-Reply-To: <006d3386-36ef-4c14-9373-7f6594a800f1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-5-4e020fbf52c1@intel.com>
 <006d3386-36ef-4c14-9373-7f6594a800f1@intel.com>
Date: Wed, 06 Aug 2025 13:30:13 -0700
Message-ID: <87qzxotcq2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Jiang <dave.jiang@intel.com> writes:

> On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
>> Send a request to drain all pending commands from the hardware queue
>> when the DMA clients request.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  drivers/dma/idxd/dma.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
>> index dbecd699237e3ac5a73b49ed2097a897abc9a043..10356a00cbdfc2ddfeea629aa749c40e7eec0a56 100644
>> --- a/drivers/dma/idxd/dma.c
>> +++ b/drivers/dma/idxd/dma.c
>> @@ -194,6 +194,15 @@ static void idxd_dma_release(struct dma_device *device)
>>  	kfree(idxd_dma);
>>  }
>>  
>> +static int idxd_dma_terminate_all(struct dma_chan *c)
>> +{
>> +	struct idxd_wq *wq = to_idxd_wq(c);
>> +
>> +	idxd_wq_drain(wq);
>
> Definition in include/linux/dmaengine.h is "Aborts all transfers on a
> channel." So instead of drain, I think we need to abort and clean up
> all the pending descriptors on the irq list as well. Perhaps drain may
> be only for ->device_synchronize()?

I was considering more the documentation in dmaengine_terminate_async().
But will check again for the expectations of the "core" dmaengine, I
could be missing something. Thanks for checking this.

>
> DJ
>
>> +
>> +	return 0;
>> +}
>> +
>>  int idxd_register_dma_device(struct idxd_device *idxd)
>>  {
>>  	struct idxd_dma_dev *idxd_dma;
>> @@ -224,6 +233,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>>  	dma->device_issue_pending = idxd_dma_issue_pending;
>>  	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
>>  	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
>> +	dma->device_terminate_all = idxd_dma_terminate_all;
>>  
>>  	rc = dma_async_device_register(dma);
>>  	if (rc < 0) {
>> 
>

Cheers,
-- 
Vinicius

