Return-Path: <dmaengine+bounces-4869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1052A84D38
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 21:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB7F44838F
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0851E5206;
	Thu, 10 Apr 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkVmEw1A"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060328EA7C;
	Thu, 10 Apr 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314046; cv=none; b=aR1oPyBI7GkETkY6wN6HIsSlHGGN8shnVEkClVCh9VZ8FZ33+YotcsmLwHVLkC6FPMSGlpLFjnXcUDHMuIXS0Ba3C5FULX8xneRxgAB92SBuWXZTfKektbC+pBn/gqF7f1sgumRVF83LF8vEjIUY3qksNGYH+Mni0syJ0MzhBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314046; c=relaxed/simple;
	bh=21GnGBOlDb3ijueP6fmn90hI2DrRFV0ZRkWJ/3g2K3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CT15ZMS18MVW74Gj2jEl5MSf6fXqwr1qcBZln/Tejp2wy3HWFVHhgwlN3H0VAxJoqiLhX/IxxOEHg0e5j38qZ6kp4YNodRZcDkidm/bd12OzJ64q+HfSWuCVBygeT/DoGyc18aBtrJ5rtaoQ/B2b+mAHZm8f+MZV7OWP6g9wGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkVmEw1A; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744314045; x=1775850045;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=21GnGBOlDb3ijueP6fmn90hI2DrRFV0ZRkWJ/3g2K3k=;
  b=JkVmEw1A44rE9HJQDiaFnKAG3BFgSSW0LQ47Upk0SGnn6BuT80Mr5auu
   ZJ/UHO9FiyNUM/QO4nZxxY+SxbGI8rORsiWsniquR0QqF22EwmvD6sSj3
   SviGy+xZ72W0iNJICEvMwRUQDqCbT1M+p6cpA3wrlCBlpwUaAfBnqnr/8
   p9gCXX5ypwOS4cihrGZJCXBWjzkpZsSwhd7P5//bD9Q4L9OUKYcIQkgZJ
   Fu+Mr0EMquo7/b5s3Yh7aI2wZjQHSxR93zvrMTn1p1cH4h0OJeuaMBBU8
   8Jn3TRrVDywmeUplgmaYkL9KWrB/i2y5+yeRNLO2mtLXTaRF/AXpCf4PZ
   g==;
X-CSE-ConnectionGUID: yp2bZReYSx2L8klU4vsltg==
X-CSE-MsgGUID: ud9VQRt4SOWhqoFanI2WyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49509032"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="49509032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 12:40:41 -0700
X-CSE-ConnectionGUID: JrR4SO+jRpu8MveZoDKKLQ==
X-CSE-MsgGUID: FVcg+56HTlGiLnYvIgT4/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="166184417"
Received: from iweiny-desk3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 12:40:41 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, dave.jiang@intel.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Purva Yeshi
 <purvayeshi550@gmail.com>
Subject: Re: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in
 idxd_cdev_open
In-Reply-To: <20250410110216.21592-1-purvayeshi550@gmail.com>
References: <20250410110216.21592-1-purvayeshi550@gmail.com>
Date: Thu, 10 Apr 2025 12:40:40 -0700
Message-ID: <875xjb6c07.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Purva Yeshi <purvayeshi550@gmail.com> writes:

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

Optional: I would change this to only checking for the validity of
'sva', the other condition would be true if 'sva' is valid.

But for consistency with the condition above, I am not opposed to the
way this patch is written:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

