Return-Path: <dmaengine+bounces-5156-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CFAB57AF
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36A419E408F
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1B20E002;
	Tue, 13 May 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR97ayt8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8399D287507;
	Tue, 13 May 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148074; cv=none; b=mpuQzGLN5r4wQIpKlvXTGk2Dl7J3jJwHYCly8Stu8YjTYALQVxcR5xM3ssn04pS3sjDcxFeN5lCGnmClApU7GCqSJlVj7HSBodEZIevmteAVVKF0REdx5oDjzLnJ96o01teMF4QzbMKpx/niRhDy0Q2onbEdqgrYatmPZZ4oNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148074; c=relaxed/simple;
	bh=xIuJma3lPg/VjYHrr6P9tzY+idSnQ6idgT7KFt0+r0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Saf1CftYQjh7DRfA7ObEQD7GLnA0IGgZiBlhAZjjADImk21uxtVTqY6d4oo9Kwz6b2JgAVwkjw3J0f/BrnPIV3+s5sWMEjsMj2evscZjm3HrQ9Thu5xgvd/pyx0aDl1yuHc1/9+ZtOdULsGtV+0Px1XjMgmpGEBEVrgrfaK9rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR97ayt8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747148073; x=1778684073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIuJma3lPg/VjYHrr6P9tzY+idSnQ6idgT7KFt0+r0E=;
  b=QR97ayt8SSk4L65dSNXhGgSQJDuoaTCf229f4mc2BSMjggvIbgfYWPiP
   rt4jl9+2Bk9Yh+jyfKVHu7xJynDfZGxnIgqjKVlibLb3lIg/ubh/4jPl7
   8/xVabepQcOsr+7Ri4V/chIuGsdSaRDHVN/9KFRqOA0GqP0huvt09U89F
   GtTvMIgpVf9gfTNO1B2B4wHaRXum90b6KBsRf8ApqKHB9AxCxY7qrVczF
   feKHzkVKe4QGTZw0DEEnIHbMNeq49whRnLLfa/pfFyt/1fFXeo81nUC5/
   mnteVzwPBKC4KSgb/CuxOjmJPnB+rySV2Ikb3rQgafLJI+zWJs+pu67q/
   A==;
X-CSE-ConnectionGUID: h5xl6AatRD2E9NHIHomOQA==
X-CSE-MsgGUID: +XxtSqeqQxWwKR4RbfMP+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52660890"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52660890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:54:31 -0700
X-CSE-ConnectionGUID: RJMXIlQGR2GJb5iKZRQo7Q==
X-CSE-MsgGUID: Ryz3NEegQzav+JP7RHGd6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137617493"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.111]) ([10.247.119.111])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:54:26 -0700
Message-ID: <1538e3d7-49fe-4d9f-b6d8-5e211a5afbfe@intel.com>
Date: Tue, 13 May 2025 07:54:21 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] dmaengine: idxd: Add missing cleanups in cleanup
 internals
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
 <20250404120217.48772-6-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250404120217.48772-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/4/25 5:02 AM, Shuai Xue wrote:
> The idxd_cleanup_internals() function only decreases the reference count
> of groups, engines, and wqs but is missing the step to release memory
> resources.
> 
> To fix this, use the cleanup helper to properly release the memory
> resources.
> 
> Fixes: ddf742d4f3f1 ("dmaengine: idxd: Add missing cleanup for early error out in probe call")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index a40fb2fd5006..f8129d2d53f1 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -407,14 +407,9 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  
>  static void idxd_cleanup_internals(struct idxd_device *idxd)
>  {
> -	int i;
> -
> -	for (i = 0; i < idxd->max_groups; i++)
> -		put_device(group_confdev(idxd->groups[i]));
> -	for (i = 0; i < idxd->max_engines; i++)
> -		put_device(engine_confdev(idxd->engines[i]));
> -	for (i = 0; i < idxd->max_wqs; i++)
> -		put_device(wq_confdev(idxd->wqs[i]));
> +	idxd_clean_groups(idxd);
> +	idxd_clean_engines(idxd);
> +	idxd_clean_wqs(idxd);
>  	destroy_workqueue(idxd->wq);
>  }
>  


