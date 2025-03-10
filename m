Return-Path: <dmaengine+bounces-4674-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9E4A59A04
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C0E1888893
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0B22AE7C;
	Mon, 10 Mar 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHPPpJVv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795A22A4F9;
	Mon, 10 Mar 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620806; cv=none; b=OTU3AEPCvYs5fG8no2OTrV/HxNnILeN5RRsFDDrLjNd5fGU0XMRzT+3hn89FCbe8gIWkcBMXMB5/3s+7Go2QYaDtiTNUerrdXEvD5bVCDQ5zQlE7yGF1oBpbHGvaU/E8F5JnTIoByXN8IbxML6eQFYv+Is6Cf0dO5J/9EIQGqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620806; c=relaxed/simple;
	bh=x+mgQsK6hPenc9Rnvd2SIXFJfElf2q9FsfyuWlWFGCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuieuHYKznPpV3lzuuQ1SvaVJ9KdG/lAyeKpla5xJHVRXiemf795JVAqUBsk842MzKgXvJcoM0hq6QaeKcXbRUHp8yC+D3HVYJSY6/E9Jg9OmutxkvAguJ/Bjjc4MIx9sdhShknOhgOTLPUa+JS+kOH28AOwOciizzNYPXDQQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHPPpJVv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741620805; x=1773156805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+mgQsK6hPenc9Rnvd2SIXFJfElf2q9FsfyuWlWFGCE=;
  b=cHPPpJVvbpmWZjzj42H6pFnPgG672VDtJ+bIlaqaTEwsnW3Yy+jiXROe
   4BKauiyJxt4CsfakSvVhcu/7XfkWyVR2vss//GsxzJ7/iNEBeP3kyujpn
   Sm6g4h+baBi5Xymf7hYdAoV064VJHtdNWAGECY5ddSzimk3IKmu2DIiRk
   jgFmJ32aWMJGnvBDP0muvCx+04W8dPkqBylS9vjQtllvM8/UpyXVAh6Vi
   B7aurGMjh65PoyS/cLWS9JSXrO6h0ainWFPWnONl3Vpe18kw5jG53sWhU
   y4QcoQpLpWMv+DPbaZnSuSRVXZsT01bnmQYSVNvjXvg+BYqBxOtthNyl/
   g==;
X-CSE-ConnectionGUID: +rV39GPUROG6AE3PFfoaew==
X-CSE-MsgGUID: 5ceDASGaTDSEqoV49lM+Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41870194"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41870194"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:33:24 -0700
X-CSE-ConnectionGUID: 8QzC2O+sT9iyDTtS4KRR0w==
X-CSE-MsgGUID: UFsp8JFnR4eW4QSvKEAdnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150984487"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:33:23 -0700
Message-ID: <dcea5656-d0b7-4d19-8b84-6862a37191fc@intel.com>
Date: Mon, 10 Mar 2025 08:33:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dmaengine: idxd: Add missing cleanup for early
 error out in idxd_setup_internals
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 Markus.Elfring@web.de, fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-5-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250309062058.58910-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/25 11:20 PM, Shuai Xue wrote:
> The idxd_setup_internals() is missing some cleanup when things fail in
> the middle.
> 
> Add the appropriate cleanup routines:
> 
> - cleanup groups
> - cleanup enginces
> - cleanup wqs
> 
> to make sure it exits gracefully.
> 
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Cc: stable@vger.kernel.org
> Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 59 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index fe4a14813bba..7334085939dc 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -155,6 +155,26 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
>  	pci_free_irq_vectors(pdev);
>  }
>  
> +static void idxd_clean_wqs(struct idxd_device *idxd)
> +{
> +	struct idxd_wq *wq;
> +	struct device *conf_dev;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		wq = idxd->wqs[i];
> +		if (idxd->hw.wq_cap.op_config)
> +			bitmap_free(wq->opcap_bmap);
> +		kfree(wq->wqcfg);
> +		conf_dev = wq_confdev(wq);
> +		put_device(conf_dev);
> +		kfree(wq);
> +
> +	}
> +	bitmap_free(idxd->wq_enable_map);
> +	kfree(idxd->wqs);
> +}
> +
>  static int idxd_setup_wqs(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> @@ -245,6 +265,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  	return rc;
>  }
>  
> +static void idxd_clean_engines(struct idxd_device *idxd)
> +{
> +	struct idxd_engine *engine;
> +	struct device *conf_dev;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_engines; i++) {
> +		engine = idxd->engines[i];
> +		conf_dev = engine_confdev(engine);
> +		put_device(conf_dev);
> +		kfree(engine);
> +	}
> +	kfree(idxd->engines);
> +}
> +
>  static int idxd_setup_engines(struct idxd_device *idxd)
>  {
>  	struct idxd_engine *engine;
> @@ -296,6 +331,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>  	return rc;
>  }
>  
> +static void idxd_clean_groups(struct idxd_device *idxd)
> +{
> +	struct idxd_group *group;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_groups; i++) {
> +		group = idxd->groups[i];
> +		put_device(group_confdev(group));
> +		kfree(group);
> +	}
> +	kfree(idxd->groups);
> +}
> +
>  static int idxd_setup_groups(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> @@ -410,7 +458,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
>  static int idxd_setup_internals(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> -	int rc, i;
> +	int rc;
>  
>  	init_waitqueue_head(&idxd->cmd_waitq);
>  
> @@ -441,14 +489,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>   err_evl:
>  	destroy_workqueue(idxd->wq);
>   err_wkq_create:
> -	for (i = 0; i < idxd->max_groups; i++)
> -		put_device(group_confdev(idxd->groups[i]));
> +	idxd_clean_groups(idxd);
>   err_group:
> -	for (i = 0; i < idxd->max_engines; i++)
> -		put_device(engine_confdev(idxd->engines[i]));
> +	idxd_clean_engines(idxd);
>   err_engine:
> -	for (i = 0; i < idxd->max_wqs; i++)
> -		put_device(wq_confdev(idxd->wqs[i]));
> +	idxd_clean_wqs(idxd);
>   err_wqs:
>  	return rc;
>  }


