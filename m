Return-Path: <dmaengine+bounces-5155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB27AB57AA
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F111D3B819E
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB01A83E2;
	Tue, 13 May 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAAWDGVm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41972155342;
	Tue, 13 May 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148050; cv=none; b=oEJhegUYwUKex4uPhP7c700r5VqNfY9jv4H2OD+ILzsnq/sStjqjcdwx+/TTt1tm5krYERs7IPP0XFF+z7VL3w4fPIrfO42Mxyrq8PW5s38huTiBngetUHTXxI5i8WbAXDHOXa+B9Aw4SOnZyr1DfVZZkWYWMCieZNjKTIOvF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148050; c=relaxed/simple;
	bh=Fq5P2CN4C3OJjWFvDD5KD4Uc4czfDLE8MuywZtilO5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKAeBKn6KD9SXTwXDXEhNx/nHPEUOWJhM0TjyBySHoFFvhzMHjEwbZxxSdaBg4Y0FEFh//wHOamMY2VYio9YbUOzp29ysf0EjRV9phSs8xzdZrJsxI5cDrwFpJTCPdqVc9ZNsEM3txWvztcvmRrQ3MeMelLNuSDiwHQABXM1g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAAWDGVm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747148049; x=1778684049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fq5P2CN4C3OJjWFvDD5KD4Uc4czfDLE8MuywZtilO5g=;
  b=UAAWDGVm/rG9nV25aoQqSoesPicDMoJbBHTDJ6yvTu+2g3u8ov3NdINU
   EdXG1OKJR3LDCuFjfFGh77bVQO4Zdd0ZJAPKkxC5HdA+j6TpODQTA+/N6
   GHrUTx0eoCZln3Utvyw9vSG+hYC4yGkGnFQu0leaipZYQU82CKXCxOUn4
   krQjoGVW2igRY/t9iYWDAKgTaNnn1wLBLYlRAjmXOck6zczMbgpKEhrq1
   /Ul8WdVJfyS/Mc5giqwU5TvlPUE+JlYdWOzHyNombVFI0l7g80uZ2mTlc
   LafHmWOOC1rTnl+AA72+w//cXbuTi1R2Pg0tB3grmvu9JNj5dBM7uwk8e
   Q==;
X-CSE-ConnectionGUID: uE++dHtfQqeeDfdm18lX2g==
X-CSE-MsgGUID: PCNVCqWzQ8i72kd1Bp6NSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52660876"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52660876"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:54:08 -0700
X-CSE-ConnectionGUID: 2k+8q9uUTGStZcg40p4d2w==
X-CSE-MsgGUID: oMpdI91KSwa9s+ztn3J69g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137617478"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.111]) ([10.247.119.111])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:53:57 -0700
Message-ID: <5b13fa5b-9c48-45f9-9ad1-36c32ab1552a@intel.com>
Date: Tue, 13 May 2025 07:53:49 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] dmaengine: idxd: Add missing cleanup for early
 error out in idxd_setup_internals
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
 <20250404120217.48772-5-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250404120217.48772-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/4/25 5:02 AM, Shuai Xue wrote:
> The idxd_setup_internals() is missing some cleanup when things fail in
> the middle.
> 
> Add the appropriate cleanup routines:
> 
> - cleanup groups
> - cleanup enginces
> - cleanup wqs
> 
> to make sure it exits gracefully.
> 
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Cc: stable@vger.kernel.org
> Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 58 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 7f0a26e2e0a5..a40fb2fd5006 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -155,6 +155,25 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
>  	pci_free_irq_vectors(pdev);
>  }
>  
> +static void idxd_clean_wqs(struct idxd_device *idxd)
> +{
> +	struct idxd_wq *wq;
> +	struct device *conf_dev;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		wq = idxd->wqs[i];
> +		if (idxd->hw.wq_cap.op_config)
> +			bitmap_free(wq->opcap_bmap);
> +		kfree(wq->wqcfg);
> +		conf_dev = wq_confdev(wq);
> +		put_device(conf_dev);
> +		kfree(wq);
> +	}
> +	bitmap_free(idxd->wq_enable_map);
> +	kfree(idxd->wqs);
> +}
> +
>  static int idxd_setup_wqs(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> @@ -245,6 +264,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  	return rc;
>  }
>  
> +static void idxd_clean_engines(struct idxd_device *idxd)
> +{
> +	struct idxd_engine *engine;
> +	struct device *conf_dev;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_engines; i++) {
> +		engine = idxd->engines[i];
> +		conf_dev = engine_confdev(engine);
> +		put_device(conf_dev);
> +		kfree(engine);
> +	}
> +	kfree(idxd->engines);
> +}
> +
>  static int idxd_setup_engines(struct idxd_device *idxd)
>  {
>  	struct idxd_engine *engine;
> @@ -296,6 +330,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>  	return rc;
>  }
>  
> +static void idxd_clean_groups(struct idxd_device *idxd)
> +{
> +	struct idxd_group *group;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_groups; i++) {
> +		group = idxd->groups[i];
> +		put_device(group_confdev(group));
> +		kfree(group);
> +	}
> +	kfree(idxd->groups);
> +}
> +
>  static int idxd_setup_groups(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> @@ -410,7 +457,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
>  static int idxd_setup_internals(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> -	int rc, i;
> +	int rc;
>  
>  	init_waitqueue_head(&idxd->cmd_waitq);
>  
> @@ -441,14 +488,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>   err_evl:
>  	destroy_workqueue(idxd->wq);
>   err_wkq_create:
> -	for (i = 0; i < idxd->max_groups; i++)
> -		put_device(group_confdev(idxd->groups[i]));
> +	idxd_clean_groups(idxd);
>   err_group:
> -	for (i = 0; i < idxd->max_engines; i++)
> -		put_device(engine_confdev(idxd->engines[i]));
> +	idxd_clean_engines(idxd);
>   err_engine:
> -	for (i = 0; i < idxd->max_wqs; i++)
> -		put_device(wq_confdev(idxd->wqs[i]));
> +	idxd_clean_wqs(idxd);
>   err_wqs:
>  	return rc;
>  }


