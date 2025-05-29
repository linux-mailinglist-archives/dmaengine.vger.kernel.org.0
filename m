Return-Path: <dmaengine+bounces-5278-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1AAC8168
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 19:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3E91884E2F
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5401E2858;
	Thu, 29 May 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYd7b2ZD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80453CA5A;
	Thu, 29 May 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538277; cv=none; b=r6GEq87qv9rbIHlY822D6nMFhBQIb4tGJtHEHwmeu07GXXjbECk/5CHo90icA9qoETCvapSAdJ4W4IfLU9Mx17oxVmVXPZQwRu6siqnoeoO6hSJ678SAWxmcbKVc7OZg2557534n47Gi7rtvHU/AqH+ZCLr578cK8FlZfaskkiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538277; c=relaxed/simple;
	bh=nCMEdot2ocyVIIdZkuS9+WOu9Ulp8GIFm/Pow4usGxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQqHuZagVwqwykinqa3hnr9QiVzoK4k5gZKHUkJ+da90RZr57aBWZWuUujNEFZ1puzeRckRhcV/6WBOmmEtIlJHYI/MouV+8ar5lxPQDgeV0LnwDu8u1QoinlRA0xs0KLin8OxLaCu/2rDP+DwRrpMHqWPKkSIP7Pkk4unmc+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYd7b2ZD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748538276; x=1780074276;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nCMEdot2ocyVIIdZkuS9+WOu9Ulp8GIFm/Pow4usGxk=;
  b=PYd7b2ZDoERjsqIVHDToxGwp83KTEHnKbX47Pqu8ZQqMqAe46yK9caOE
   l0celLYPrJbSHRQfJOn8aPj0sF31SrybxIGqZc8mIFbgnfpCZv6wDg+Rx
   8kz6qcj2BUuowbemDTXHWDyaGBvUfT9QI2Pbbq6nbmJYXKcEHAQPKGIUE
   eJJRnCuF4yVP3ZLqiYamGbmDADyWPkEN/sU3TZ1CKDWe8ERBOyQ0Rgbiw
   2a1OtHw0xMnpZBL9Pb65pYVdCp7DyPdGP+MtWrpxwAp7w6i+NgJSz82m2
   HkR+se/3k5JcpTuigwe3RzGBOavvCV9ywBeGyTJPXOc4Q18SvbhRG0AMT
   g==;
X-CSE-ConnectionGUID: l9AKdx32Ry+LLFvL7jMPOA==
X-CSE-MsgGUID: pPG5FivcSpiE5vLIy/4suA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54414793"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="54414793"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 10:04:34 -0700
X-CSE-ConnectionGUID: 196T469sTIiRbBNazHztvQ==
X-CSE-MsgGUID: DSeJEqp2RgGU/Fv9Z8OFdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="144607543"
Received: from jjgreens-desk15.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.186])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 10:04:34 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com, xueshuai@linux.alibaba.com, gordon.jin@intel.com
Subject: Re: [PATCH 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
In-Reply-To: <20250529153431.1160067-2-yi.sun@intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <20250529153431.1160067-2-yi.sun@intel.com>
Date: Thu, 29 May 2025 10:04:33 -0700
Message-ID: <87msav9wm6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Sun <yi.sun@intel.com> writes:

> A recent refactor introduced a misplaced put_device() call, resulting in
> reference count underflow when the module is unloaded.
>
> Expand the idxd_cleanup() function to handle proper cleanup, and remove
> idxd_cleanup_internals() as it was not part of the driver unload path.
>

'idxd_cleanup_internals()' frees a bunch of stuff. I would expect an
explanation of when those things are being free'd now that removed that
call.

> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
> Signed-off-by: Yi Sun <yi.sun@intel.com>
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 504aca0fd597..a5eabeb6a8bd 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1321,7 +1321,12 @@ static void idxd_remove(struct pci_dev *pdev)
>  	device_unregister(idxd_confdev(idxd));
>  	idxd_shutdown(pdev);
>  	idxd_device_remove_debugfs(idxd);
> -	idxd_cleanup(idxd);
> +	perfmon_pmu_remove(idxd);
> +	idxd_cleanup_interrupts(idxd);
> +	if (device_pasid_enabled(idxd))
> +		idxd_disable_system_pasid(idxd);
> +	if (device_user_pasid_enabled(idxd))
> +		idxd_disable_sva(idxd->pdev);
>  	pci_iounmap(pdev, idxd->reg_base);
>  	put_device(idxd_confdev(idxd));
>  	pci_disable_device(pdev);
> -- 
> 2.43.0
>

-- 
Vinicius

