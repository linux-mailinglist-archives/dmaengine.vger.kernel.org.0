Return-Path: <dmaengine+bounces-5963-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA3B1CAA7
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ADA623DFB
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1B29E118;
	Wed,  6 Aug 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHIUHEEz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAC29AB1D;
	Wed,  6 Aug 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501100; cv=none; b=kDbRh7ZXGaDEV0famL3ffvz69VdL+/32nHZ/1Jn970Dhiu8UOrKowvj0u77qb0rtlKV2PdG6VcynHI68TqPNo8p6yHdtDIVRkKTgA3u266nTp9KApgWLrlaWnQKE2ks1YYyyelLmCyYXs+Our/DcCjnF8+f8fYGhozOTvPTnvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501100; c=relaxed/simple;
	bh=COI2LJctOZLLHvLHYvhF5RUTz87myCz+2OWpBbTQbmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuRMZmSw6DmMtqn4sbqWJ/ou61q8D3eNL2a5GMvs962OzWDbAdHd8qVMe4G3JcMOqm09+YNWPRNPvNPWFSN7gmsB0DW2soU8XQnnDIH+EAbdvZFbHE8QOh9zQvCZk74jzuleHKxCzOip/8wt0qcspUH3T4Wsbbt+ZptT7vgsWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHIUHEEz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754501097; x=1786037097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=COI2LJctOZLLHvLHYvhF5RUTz87myCz+2OWpBbTQbmI=;
  b=eHIUHEEz/U4u1H6E+9jrkfBf+uCUGRLt8ShuwRH8E5jxIAO3ou3FVkBq
   WSBcNmCQiEkwCBc2TRrID6eZ20O/1w93lzXFSxKc5nXa9MMlWoxdoG4oA
   G/MrICwMExFyNA0kHAK2kXC3ZP+TuJdM0wuVV3QvMEyOvZ9kpqe2OQH94
   RXxnIlu/wBa5cRX8vycwKfiNtIquEqbFYrIVJ1NqK+0GVgN5dvThOLTAc
   1aM75DXV4Px+G0MX5mk6qk3L67sl1ypaMOii415RE4qHO7WPfbqetEq5/
   Wy8BxzOr5wZido/xFW07DFHs2AXhHduYaWreK7a9caii3fbDeg/xeFkfu
   g==;
X-CSE-ConnectionGUID: G/+Bw6t2SQ26nNvwSFBjfQ==
X-CSE-MsgGUID: 2GRZxtm0QjycQfq4mr6EyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44419856"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44419856"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:24:57 -0700
X-CSE-ConnectionGUID: V6e8U2sRRfS9SZ2oH99MBQ==
X-CSE-MsgGUID: ZCEHe7hsRFi39X1/NvqWUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170099130"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:24:53 -0700
Message-ID: <7f9d3dc5-4800-4032-ad0d-1ec8f88209f0@intel.com>
Date: Wed, 6 Aug 2025 10:24:48 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] dmaengine: idxd: Fix not releasing workqueue on
 .release()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-6-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-6-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> The workqueue associated with an DSA/IAA device is not released when
> the object is freed.
> 
> Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 9f0701021af0e6fbe3c3c04a0e336ee9cd094641..cdd7a59140d90c80f5837473962017114cd00b13 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1812,6 +1812,7 @@ static void idxd_conf_device_release(struct device *dev)
>  {
>  	struct idxd_device *idxd = confdev_to_idxd(dev);
>  
> +	destroy_workqueue(idxd->wq);
>  	kfree(idxd->groups);
>  	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);
> 


