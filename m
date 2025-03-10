Return-Path: <dmaengine+bounces-4676-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8AA59A11
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C4E3AA528
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AC22A4E0;
	Mon, 10 Mar 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cht0o8MJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C21C68B6;
	Mon, 10 Mar 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620912; cv=none; b=CXb6SXraKvZuKxT0waOSWEONwXWuhh0TS/JpuJNARqeDnN7tDjr3rSCztfFStlFTqFN07rNpws8T9Nbd2hnVlNULIhlOHsRuwIxqaToKvBrWXuv1HzfZfRPFToGORRSNDGogjB4vrOxFYJEI+Ao821mhKEux2cyagzNRI4pkMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620912; c=relaxed/simple;
	bh=YBc4wXmjjp9v+OShbJ0k+LQ10xDxP7nWItPNwkXArdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3bi7bHq5/uaw0BxW6UHy8w8EfpeemCkK8Vwua4U2tUVkBmGMcYfZY9yS25s73DKOaSdSrOvO+hPMDp7EZfPJdByRIBO5aZiBcSJG0gLE1itDzPGmxNnaFUESKZWzSzH7p+RxqpzR6PiZukDyvVLRa4rFy3KOhoMTnGQpOqSpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cht0o8MJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741620911; x=1773156911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YBc4wXmjjp9v+OShbJ0k+LQ10xDxP7nWItPNwkXArdM=;
  b=cht0o8MJwxGP3SjosMgvGDNzFEKmSN9KZsi0T4fPDj6DC8Qtj5AKahew
   SqrJ4hQgKlpNxaSD2h5djAdE20mPsg/mqDXLTTZw5KhkUdRAfvcQ/TBh2
   XL27AZNH1Mn49F9ENDxHJUZXXgyE4rb/eevGVLGwWaum8hfYkHK/QFccK
   YS4GO6Iv2/yXa9XmfeEI0FWXXe6r2PxUt0oPcBUdLvtZInT5rBMWAmkpX
   VFXzXVOsrbuzceEgwe3R18cxlfb6dVigWOv+KCWIyn1GpNeDZ9W/aDr5n
   9Z6uEyG9apg+v4JQhemmwuKhpnvkQjdp3Ra98Hrx0618KvBAYdieX+6ue
   Q==;
X-CSE-ConnectionGUID: 0eecGrQ8StWve2YhlPQvNA==
X-CSE-MsgGUID: kyMOK5mUSqWhiUfJ1ksU2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41870381"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41870381"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:35:10 -0700
X-CSE-ConnectionGUID: EUVK3Ze7TOi/vKJvJifYsw==
X-CSE-MsgGUID: Fia2yn3LQFKygC2/3z+q6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150985736"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:35:09 -0700
Message-ID: <ff6de117-5c35-415a-92d8-bfd1d5399e09@intel.com>
Date: Mon, 10 Mar 2025 08:35:06 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] dmaengine: idxd: Add missing idxd cleanup to fix
 memory leak in remove call
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 Markus.Elfring@web.de, fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-9-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250309062058.58910-9-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/25 11:20 PM, Shuai Xue wrote:
> The remove call stack is missing idxd cleanup to free bitmap, ida and
> the idxd_device. Call idxd_free() helper routines to make sure we exit
> gracefully.
> 
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 890b2bbd2c5e..ecb8d534fac4 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1337,6 +1337,7 @@ static void idxd_remove(struct pci_dev *pdev)
>  	destroy_workqueue(idxd->wq);
>  	perfmon_pmu_remove(idxd);
>  	put_device(idxd_confdev(idxd));
> +	idxd_free(idxd);
>  }
>  
>  static struct pci_driver idxd_pci_driver = {


