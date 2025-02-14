Return-Path: <dmaengine+bounces-4471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B04CDA3634D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471247A5800
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B1026738E;
	Fri, 14 Feb 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuvHwFnq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF538635A;
	Fri, 14 Feb 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551258; cv=none; b=eLdog/w3IUgMqZRdLcBoaanVqme55XBokV6DTJv5Zix4fhUPWBovnMg5XcD2kUyldHeJxWaXOFa1lo5NdjU8YbiSWB7KehHLIzCGAAnH2TS6wIiUjRud+K9MpP0qVAN37byoGp/sVjgMSLtF3iwfQyQMKvvmAd1ZG2qxTKi94vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551258; c=relaxed/simple;
	bh=/y7JAaYrGInoVscQnRHBfAri7jMrt1aiFJaMRA8uESk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHxLnoeb/8qZY+JD0gjLUIWdy6jckI+/uqto8bSKC2vN9w/ZrO89qyJlNbLDJ0p23j3xmHlMxZ4ee9vdTHgq4tQwYLEDvHSqIk+Erp+/kAa4n+/8mh/3+li6gN7ProOy/mdm2NQjxCKFAHGdKYbVxxMySSR6Qp+a+dAq2WTNoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuvHwFnq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739551257; x=1771087257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/y7JAaYrGInoVscQnRHBfAri7jMrt1aiFJaMRA8uESk=;
  b=nuvHwFnqA5n/djh9oXrGzbjGUk7tcNz9pioYBXGrQd5Q3Pjcm6nkzpLF
   +oBsKhWwdkhtur7epOl51zE8pmNXc2exBVG5kYQvyYxgLq3vZuFGxcDBS
   48fTpmR2mbOLqKJHZq1uI4gye3Ak5S7/ZRFbq/b2kjysrlQVAholTTYOA
   MRLOb6/7u+9PKkyXYf+wgv0zP+3c5gdMqDKAzMiu4+K81h5W0BPYkKk3b
   uCh0DuyFmk6YwohYiyg5Z8pTtxlVqeH1epPbTFZ41XRk6Io6BWcwOPbi/
   udncH/wfw0URMUABLOfUq1XQP+1DMNPzGBrMyy40XX0rumZDK+GWMAjjO
   A==;
X-CSE-ConnectionGUID: eZ7zCmU5QfWglN5d08LlBA==
X-CSE-MsgGUID: Ssxe9efKRc2paWHUMCdC6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50517758"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50517758"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:40:56 -0800
X-CSE-ConnectionGUID: n3gj9s/0STSvKFmRAm98cw==
X-CSE-MsgGUID: Sn/k8tdVQnyi4Cfc/dDVZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114139844"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:40:55 -0800
Message-ID: <c5116977-a10b-4a56-a8f1-fed337a5bb9c@intel.com>
Date: Fri, 14 Feb 2025 09:40:54 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_groups
To: Shuai Xue <xueshuai@linux.alibaba.com>, vkoul@kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250110082237.21135-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/25 1:22 AM, Shuai Xue wrote:
> Memory allocated for groups is not freed if an error occurs during
> idxd_setup_groups(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 12df895dcbe9..04a7d7706e53 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -326,6 +326,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>  		if (rc < 0) {
>  			put_device(conf_dev);
> +			kfree(group);
>  			goto err;
>  		}
>  
> @@ -350,7 +351,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  	while (--i >= 0) {
>  		group = idxd->groups[i];
>  		put_device(group_confdev(group));
> +		kfree(group);
>  	}
> +	kfree(idxd->groups);
> +
>  	return rc;
>  }
>  


