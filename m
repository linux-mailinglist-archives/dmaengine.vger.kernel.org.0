Return-Path: <dmaengine+bounces-1734-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19768973E7
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D580284832
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91314A0A2;
	Wed,  3 Apr 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkbUqREC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8D149C68;
	Wed,  3 Apr 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157804; cv=none; b=bugUgHKyPOYKgTP1naIgZtE5SB4Q5YTYCuUr02Jiy4PwmBZkNqMZPcl2pBxV5H/qI2EcqKmIzRV9fVy9j0hL4CucSW0kVSqloiI9TY1jCbVSsL8QGE9eYyvvTIMF3SuzvjT+bxnbiwy6rUSlxUySSfIM19Ruv5MmEr8sV2mx8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157804; c=relaxed/simple;
	bh=S+1UnRrVrgjaiRYOjs79CGuuwGNW3bJjK9mfZBIQj7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXIX8jePSX0k1PMLchg3sZDaMoGXp6FyN7YzccD9Ihwl/f6W79NZ7P5iizqKcmmnikjFgQ6nQgf/tjKkdyJcN4+LFUokE4qz/mYhIcvS4iuL//yKuWi9gTsoJhxckbH7tavoGbnxei9czAx8Sdis3BAd7TawPzUwiFoIKV11WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkbUqREC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712157803; x=1743693803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S+1UnRrVrgjaiRYOjs79CGuuwGNW3bJjK9mfZBIQj7o=;
  b=MkbUqRECuneTEbPC8IUQtqM2umkRFkhPTQ4ks0FbI6NrwGn2DmCxi/CP
   wA+4aCiM0QA0a8WYJjYr1/ttVh7VqlnZcbrZKIrkYSJYPbgb+bMEg6G8q
   SlJUoeV08D9JDDytUpn7jRtvgq4MWdWSa/kfiSqTKb9oRptwkS6gcNqWH
   5DhEpgnxqhrHpblotgENVeRe57g5fdXLMaFfEo+2Rzf/oDa7zhZrc0zi3
   7hNGT2axc/7DcDQYYIoQt9QedsoXV+mT/ey/NMfq1pxP0Au0XNhhzwTK5
   jdi21hZcoh9n/wWivGZnlwkJoo6EYH3wHLfTIuppTPuMrKGUtK2/mcrfN
   g==;
X-CSE-ConnectionGUID: 15ogyAEuSS+L+YRbN3nQXQ==
X-CSE-MsgGUID: 4SVIzPAzR7+G4+8E0f9Mgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18847187"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18847187"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:23:22 -0700
X-CSE-ConnectionGUID: R/MTNPAnRY+18zpVaiNo8Q==
X-CSE-MsgGUID: A/9/9iVOQ2yZlb5TitRCTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="49437019"
Received: from vly-mobl.amr.corp.intel.com (HELO [10.213.162.81]) ([10.213.162.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:23:21 -0700
Message-ID: <9a07a658-dbd4-47e5-bc36-598a456fceca@intel.com>
Date: Wed, 3 Apr 2024 08:23:20 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Check for driver name match before sva
 user feature
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403050710.2874197-1-jsnitsel@redhat.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240403050710.2874197-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/24 10:07 PM, Jerry Snitselaar wrote:
> Currenty if the user driver is probed on a workqueue configured for
> another driver with SVA not enabled on the system, it will print
> out a number of probe failing messages like the following:
> 
>     [   264.831140] user: probe of wq13.0 failed with error -95
> 
> On some systems, such as GNR, the number of messages can
> reach over 100.
> 
> Move the SVA feature check to be after the driver name match
> check.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Seems reasonable. Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/cdev.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 8078ab9acfbc..a4b771781afc 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -517,6 +517,14 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>  	if (idxd->state != IDXD_DEV_ENABLED)
>  		return -ENXIO;
>  
> +	mutex_lock(&wq->wq_lock);
> +
> +	if (!idxd_wq_driver_name_match(wq, dev)) {
> +		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
> +		rc = -ENODEV;
> +		goto wq_err;
> +	}
> +
>  	/*
>  	 * User type WQ is enabled only when SVA is enabled for two reasons:
>  	 *   - If no IOMMU or IOMMU Passthrough without SVA, userspace
> @@ -532,14 +540,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>  		dev_dbg(&idxd->pdev->dev,
>  			"User type WQ cannot be enabled without SVA.\n");
>  
> -		return -EOPNOTSUPP;
> -	}
> -
> -	mutex_lock(&wq->wq_lock);
> -
> -	if (!idxd_wq_driver_name_match(wq, dev)) {
> -		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
> -		rc = -ENODEV;
> +		rc = -EOPNOTSUPP;
>  		goto wq_err;
>  	}
>  

