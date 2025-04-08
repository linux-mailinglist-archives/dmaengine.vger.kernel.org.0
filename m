Return-Path: <dmaengine+bounces-4860-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24DA818FE
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 00:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750463A69C1
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247D255247;
	Tue,  8 Apr 2025 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQIu6jXx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02617A312;
	Tue,  8 Apr 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152477; cv=none; b=q7/Nl2RU3ZW7oD7yMpzu+5ohpSlj2At1J7H5W7AR6Gm5rDm0ui8rQbmXBTvLPcJBhyVwRjY3PhRqX0bryDD42zLOqUfJau+AQYNDBKbs+66lJerLW4BikTaN/VhaznUQdfQQXFmSJhHJVPZ2nKGBnPpPOydlebAQdyfcTIRSnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152477; c=relaxed/simple;
	bh=fIPtBiRc85KglBFHKIkn/4MssQypTUE6fovGzmUBKxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g2tOP+eyAtT3WaGLtCozqQhvD7Lm0P+bQ5f0bJiE/G0n+hq1vZIt+bkqTDTy4UXkMOSGlD6tb6IWZwbGp0M6FXYnBIptTtdOCf7kNhRxyJLQt9/rXPBO+pt01/Q1lVdkHxex7jeYAkmb1q9SHBzWP0kXVDJn42pHgPga3N86OTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQIu6jXx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744152476; x=1775688476;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fIPtBiRc85KglBFHKIkn/4MssQypTUE6fovGzmUBKxY=;
  b=gQIu6jXx6U0MJGA0qROTgL6RU08Hqxez68HC8xbsanZDXfEyiRLSQNnr
   feNkvmwkeqSrWBaFyxu0dow5zh3VSgodhRGDjedWfCbJf8WnTGGkOtrPp
   5zNBX5VKrOjipp/X1ipuQkiMoSjXYteJMEIVQJ4r0gEdVt88Sbuu1Lhew
   ilss/5e1HI1gGwGwaq1WCg5qMX13lJlYICX0RRC366qcSgpL/GzPA4AkM
   Zvfs366JD2hQHHmr83CjUeCrXmYCof2spr3YjAtHXVmf706TU9rBNTJah
   9CET2y9V6PVMOFFbCJQU2wvW1j247xiUzuxHxKo9pD1/gN23Tm43E69oA
   A==;
X-CSE-ConnectionGUID: ppOAjYwSRRuC9v57qDcElA==
X-CSE-MsgGUID: VbZEqYN7RgmmRXb9wVa3ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45769860"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45769860"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 15:47:55 -0700
X-CSE-ConnectionGUID: gU55Fw/hSTSiCWlCrwOF9A==
X-CSE-MsgGUID: 0/EaaJv0SnyWHXKS3yu+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="132531294"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.111.184]) ([10.125.111.184])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 15:47:54 -0700
Message-ID: <a1a54ff1-8b14-4bd0-aba6-c23d8261fd9c@intel.com>
Date: Tue, 8 Apr 2025 15:47:52 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Remove unused pointer and macro
To: Eder Zulian <ezulian@redhat.com>, vinicius.gomes@intel.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408173829.892317-1-ezulian@redhat.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250408173829.892317-1-ezulian@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 10:38 AM, Eder Zulian wrote:
> The pointer 'extern struct kmem_cache *idxd_desc_pool' and the macro
> '#define IDXD_ALLOCATED_BATCH_SIZE 128U' were introduced in commit
> bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data
> accelerators") but they were never used.
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/idxd.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 214b8039439f..74e6695881e6 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -19,7 +19,6 @@
>  
>  #define IDXD_DRIVER_VERSION	"1.00"
>  
> -extern struct kmem_cache *idxd_desc_pool;
>  extern bool tc_override;
>  
>  struct idxd_wq;
> @@ -171,7 +170,6 @@ struct idxd_cdev {
>  
>  #define DRIVER_NAME_SIZE		128
>  
> -#define IDXD_ALLOCATED_BATCH_SIZE	128U
>  #define WQ_NAME_SIZE   1024
>  #define WQ_TYPE_SIZE   10
>  


