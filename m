Return-Path: <dmaengine+bounces-5965-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE35B1CAC1
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E895418C4CDB
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EECE25B305;
	Wed,  6 Aug 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WurARD/D"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC799EEA6;
	Wed,  6 Aug 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501269; cv=none; b=eepLV2TN7UIKG0+WMcrTRst6KcSyh2rLabTrqGlEPOKgZ7p1afF2dh+/eyFj8nBTgywht6JJZ8lOnnTFuAST7XXfjoE0bJVSZifHWQk2fYTQAXl8BhdvM4xKUbeP19o+9i7eqYi0GCOn3LcfvS43BmtWPARsc692kyaqk41Q0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501269; c=relaxed/simple;
	bh=qINxFNOSNV/nP03Q/5LwI2yjA97EIhoqWLjHbd4WtHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT/+Fj+af11hPmfl0v+7fXl7zA419wG9wS+RM/OdFW0dHZ1G8huyostlzqpwvhg8av9PoGPPLNp4/XIb26pRsGyctEOci9EaT3DgBaholl5E/7u7Bwcm7mY5yelHhgIiRADFeuznb++QVB6W/VmrFBHjchVfu3sDneR68qZ6eoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WurARD/D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754501268; x=1786037268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qINxFNOSNV/nP03Q/5LwI2yjA97EIhoqWLjHbd4WtHc=;
  b=WurARD/DJX0LtJOTINkdIjYpqxVG9Lg7i/e9W0AMnHT44ZUybDY7eSZY
   rYyNmU9j375MK6shT0ugTu7FsfQr3/nTB5ioak3e1Ci7g1PsvuSRsMvrE
   3J8wovMA/LOSKQIRff6eJPOmRoLSuusuuqsC9qYs0BzVAekTLB0MatOoc
   x+JEFgoEaQtpC1hWG33bF62Z2nlSqu3M1Y2BsSvZskmTjkBTPX+XRff+c
   7e1DldCDLmNO9ZtLr2++MXaDVNkrSD1j8i0PsXNEwr08aF6nhULxqquhQ
   IgWt4AyCvSHv520/E4HFCPO9gKPIZ8Eduh/ZYMPgAIATzK1gVo6GfBZFU
   g==;
X-CSE-ConnectionGUID: xtDuG6uIR/qZS6RWYmR4Bg==
X-CSE-MsgGUID: KMMhyYqSTy2AFxTaIgxsog==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56745444"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56745444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:27:47 -0700
X-CSE-ConnectionGUID: c9QjsHL/Sumkn0rQcFTqkQ==
X-CSE-MsgGUID: PlD+IWDcQTa1TZ0KTRHOLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164847977"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:27:44 -0700
Message-ID: <7972e017-ec4a-4fe4-a11f-bc0a1ff9b6f7@intel.com>
Date: Wed, 6 Aug 2025 10:27:38 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dmaengine: idxd: Fix freeing the allocated ida too
 late
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-8-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-8-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> It can happen that when the cdev .release() is called, the driver
> already called ida_destroy(). Move ida_free() to the _del() path.
> 
> We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
> unbind.
> 
> Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/cdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 7e4715f927732702416d917f34ab0a83f575d533..4105688cf3f060704b851ee17467c135c170326e 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -158,11 +158,7 @@ static const struct device_type idxd_cdev_file_type = {
>  static void idxd_cdev_dev_release(struct device *dev)
>  {
>  	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
> -	struct idxd_cdev_context *cdev_ctx;
> -	struct idxd_wq *wq = idxd_cdev->wq;
>  
> -	cdev_ctx = &ictx[wq->idxd->data->type];
> -	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
>  	kfree(idxd_cdev);
>  }
>  
> @@ -582,11 +578,15 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
>  
>  void idxd_wq_del_cdev(struct idxd_wq *wq)
>  {
> +	struct idxd_cdev_context *cdev_ctx;
>  	struct idxd_cdev *idxd_cdev;
>  
>  	idxd_cdev = wq->idxd_cdev;
>  	wq->idxd_cdev = NULL;
>  	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
> +
> +	cdev_ctx = &ictx[wq->idxd->data->type];
> +	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
>  	put_device(cdev_dev(idxd_cdev));
>  }
>  
> 


