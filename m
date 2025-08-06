Return-Path: <dmaengine+bounces-5962-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C133AB1CA8B
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87ED1682CE
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FC1EE7B9;
	Wed,  6 Aug 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZbHJGML"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775991E0083;
	Wed,  6 Aug 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500633; cv=none; b=P03inSmStWXa3ky32BVyLpHkDMroEoZANoUkC92QCcO03F+XebFCOVqbYrvEOA11qHtdDWQ0H+JrThu8qFplFn1Ue3wjJCm2la+PNMUfik4cpW4/B2h9w7Jk1hDcl+5TxMgU/hDXyi9q/lnx4uwATMr9PJ/fTyuUg67egs4QDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500633; c=relaxed/simple;
	bh=45DWFsBRadUm05dMAooPXmnKscrZwCQvvaxvHpq52GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEKHv2MdxTLF/U4nuZuVO+VL95qUs+7aDzp80Si62MLNXae6UA+xYwe1luIQlRXPYO/PIjUCFjikIZcYQ/oy6b3cug3ygF889NoRGz/6LV34ivzAAOULljaEKcC7seIjbtUdXtxcffILm3Hqm3zPVOwaZU1Km0q7pjd5bRWdk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZbHJGML; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754500631; x=1786036631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=45DWFsBRadUm05dMAooPXmnKscrZwCQvvaxvHpq52GA=;
  b=DZbHJGMLsNtC+hTPpbhoDnv9r5K5grRmtZfZufT3JZTVVnvpys4Yphua
   Oz7U9nEVXWBJGAridZ2m6UZt0z1iGRypTREiw36XgM+BnMhIYT5o1H4s7
   7ut4FMXkL0xp6HHDd8TTq5/45nkYB+b+kDf3anOUohKP+rZihT+VjYoGH
   vYjm/T03SH+Z2kmUdkYCxWJ3+E3sqTGuoc4QCBJQfiqsXBCMQdnlEplJj
   kW9VQBAa9lky5Sg/6xYZNXBPki9Gp5mdsnsfNFkYEUKQfIMVCzhUV1F/t
   byky5f3D5tLPvGjY6SIousNCdL58l4meshgRTpj4t1on3jk5EaFfVgZOB
   Q==;
X-CSE-ConnectionGUID: BHBWzOklQqiC2NorPIedmw==
X-CSE-MsgGUID: UodEBMLdTTuelo4ktge8Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56744189"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56744189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:17:11 -0700
X-CSE-ConnectionGUID: PVfecHeJQSq/HtMcYjRMLA==
X-CSE-MsgGUID: 36b6tu75ToOR7cglTewgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164738714"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:17:07 -0700
Message-ID: <006d3386-36ef-4c14-9373-7f6594a800f1@intel.com>
Date: Wed, 6 Aug 2025 10:17:02 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] dmaengine: idxd: Allow DMA clients to empty the
 pending queue
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-5-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-5-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> Send a request to drain all pending commands from the hardware queue
> when the DMA clients request.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/dma/idxd/dma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index dbecd699237e3ac5a73b49ed2097a897abc9a043..10356a00cbdfc2ddfeea629aa749c40e7eec0a56 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -194,6 +194,15 @@ static void idxd_dma_release(struct dma_device *device)
>  	kfree(idxd_dma);
>  }
>  
> +static int idxd_dma_terminate_all(struct dma_chan *c)
> +{
> +	struct idxd_wq *wq = to_idxd_wq(c);
> +
> +	idxd_wq_drain(wq);

Definition in include/linux/dmaengine.h is "Aborts all transfers on a channel." So instead of drain, I think we need to abort and clean up all the pending descriptors on the irq list as well. Perhaps drain may be only for ->device_synchronize()?

DJ

> +
> +	return 0;
> +}
> +
>  int idxd_register_dma_device(struct idxd_device *idxd)
>  {
>  	struct idxd_dma_dev *idxd_dma;
> @@ -224,6 +233,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>  	dma->device_issue_pending = idxd_dma_issue_pending;
>  	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
> +	dma->device_terminate_all = idxd_dma_terminate_all;
>  
>  	rc = dma_async_device_register(dma);
>  	if (rc < 0) {
> 


