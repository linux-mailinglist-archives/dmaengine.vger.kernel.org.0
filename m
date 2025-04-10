Return-Path: <dmaengine+bounces-4871-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046BA84EE6
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 23:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E5F1B63994
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA420ADF9;
	Thu, 10 Apr 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvbWSa00"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20F6EB79;
	Thu, 10 Apr 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318849; cv=none; b=JCFRVeLw9LmShWwyyk+LXNblSPo6Z4B9ufJifOgyvCqeWC6EFtVckfA1bpxlwH15SVg3nuELGwhOQfbFtOYe+s1wAxAOoQ8o4cGvYpI5nF72N2E4UZsiv8l5EFmgGMLzuhIpE/5BCWdVZrrTbsQNR1JdVm2NfuaVpFoh+cuPQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318849; c=relaxed/simple;
	bh=2q4oiu+LkAAuZEaxsutRWvuvTZcWjJ94eEw+xCfu1WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2wAIXXe6WQFBgHQs6smiPhYmOnSytH2gk8e51B5zKRnVAtjqBrBS+odSsbGe1unwCDU9VHsuOFwNLmtcsFsIoLd4QY5y3UTsmryQIDOwdyMp6KWIhVN9pP+rvGidceERBGmDQUT+PRlOCfHCS2w20GUhFrMXT74/fwQlZR97Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvbWSa00; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744318847; x=1775854847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2q4oiu+LkAAuZEaxsutRWvuvTZcWjJ94eEw+xCfu1WY=;
  b=KvbWSa00WpiYkypVNmu7YvcvdoUAOIJoQzGsFthj59F+XerSEJFv92CP
   7UmaRQzi1+hVETUe+XgxSXzaFAi1BOtEHBLJMtZMQkSPWpmYVRtD+nTvU
   QP5DUk68jqczOUh75oUE/DsPlU112xKjwQ6rn2CteuATvLI03da1q+ecI
   vhJrrVsjKAdBnbMiSqapD+9ljX+0MKDJPxRvFZF4nqhXoL/4B7q1oK+9l
   aa/FDEIb32t5cImpB2jS6pi5dqSuTnrXKrhwuysJ829BK65FjEC6UFAjL
   zWQ45asohHyNWRXJrps2CnVNFD9NeX6Iz72tURmFD7/n0Q/uNjGVpFuuS
   w==;
X-CSE-ConnectionGUID: eKUeMQ9SQfmtI5wOm6E6BQ==
X-CSE-MsgGUID: uo7DB1PQTF6CJQxPhfuKgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63402896"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="63402896"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 14:00:47 -0700
X-CSE-ConnectionGUID: p07NtAeDTUmTb2vT5fIZVw==
X-CSE-MsgGUID: KW6YNEIZQTOJ5qGqLluDkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134178741"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 14:00:46 -0700
Message-ID: <23417f4a-05fe-44d3-b257-7a5991d252cb@intel.com>
Date: Thu, 10 Apr 2025 14:00:42 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in
 idxd_cdev_open
To: Purva Yeshi <purvayeshi550@gmail.com>, vinicius.gomes@intel.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410110216.21592-1-purvayeshi550@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250410110216.21592-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 4:02 AM, Purva Yeshi wrote:
> Fix Smatch-detected issue:
> drivers/dma/idxd/cdev.c:321 idxd_cdev_open() error:
> uninitialized symbol 'sva'.
> 
> 'sva' pointer may be used uninitialized in error handling paths.
> Specifically, if PASID support is enabled and iommu_sva_bind_device()
> returns an error, the code jumps to the cleanup label and attempts to
> call iommu_sva_unbind_device(sva) without ensuring that sva was
> successfully assigned. This triggers a Smatch warning about an
> uninitialized symbol.
> 
> Initialize sva to NULL at declaration and add a check using
> IS_ERR_OR_NULL() before unbinding the device. This ensures the
> function does not use an invalid or uninitialized pointer during
> cleanup.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/cdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ff94ee892339..7bd031a60894 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -222,7 +222,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	struct idxd_wq *wq;
>  	struct device *dev, *fdev;
>  	int rc = 0;
> -	struct iommu_sva *sva;
> +	struct iommu_sva *sva = NULL;
>  	unsigned int pasid;
>  	struct idxd_cdev *idxd_cdev;
>  
> @@ -317,7 +317,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	if (device_user_pasid_enabled(idxd))
>  		idxd_xa_pasid_remove(ctx);
>  failed_get_pasid:
> -	if (device_user_pasid_enabled(idxd))
> +	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
>  		iommu_sva_unbind_device(sva);
>  failed:
>  	mutex_unlock(&wq->wq_lock);


