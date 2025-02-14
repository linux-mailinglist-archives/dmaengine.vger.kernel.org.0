Return-Path: <dmaengine+bounces-4472-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DEA363C2
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0C1188B41E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA6267AF2;
	Fri, 14 Feb 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lESRtWbE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06E26773C;
	Fri, 14 Feb 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552403; cv=none; b=fU3oqkXwus6FDFFvW9WYjNpIrw3A9kHx8usZiHQQ3zhiSnT3xcmOzhqfQMi2mF6Anok12YyNu36r8AThBLVCdbSOMVWyXEfhGuJIgflCqh38q/I/CVkgTUdFFNnyfahb7blx6+PgTm4XxndcDyLfKoDjfT+AzZfHZbjDKK1zgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552403; c=relaxed/simple;
	bh=nTq7ASiz3LROI1BYo6zeSczj0JH3zZBRbtLTyoS8miw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7CrrswC5HpJaKu1ojgsAve2MR3BuQGAUozOmce8CRdx2oOXsOavYtJGPorQyVNevhDtEAc4JR2W0QOlkfaYGCWIZdJR/9H8bZm9GcGRQ41cVtiG0iv8Wqi3JB35eoMjJ0EfKj+Lk/DWK55JD961f5nK6VTxBKNgVE3KmihoD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lESRtWbE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739552402; x=1771088402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nTq7ASiz3LROI1BYo6zeSczj0JH3zZBRbtLTyoS8miw=;
  b=lESRtWbEob4sPH8+JrKT/fTospnFBIDWB9LLOmLdv5x8+MCGEcPf8yyc
   4OXize+ChJOIvdYCB3Fz8CfvVC7U2YC+LM2RqTW9qs48uZWzmFxh5G8ts
   cFYNQQuUcx3vIccOubMNkzHu7PbkIg7LAfBMwfOq1RAkHreKr4X3O2LOM
   SR+n6DCX5081JO1l7hjIMaPjhe3Tr7BWS96OOgJOHPkjyeVEtH0f9uHUJ
   3gmv+Szqh8VBM/KOaOBrVhL5jcWjWFsG/06HujC7891wKy/8mLGQny643
   TDTE70v3bqnW6mOPsgBD8/Cwmi/RhiNlSyBnJcmHlr5aejltjuy73ZWLv
   w==;
X-CSE-ConnectionGUID: 9K3T4xIxRCSJSR1HhEwsLw==
X-CSE-MsgGUID: 844xPhTCROWtAVfphCFLrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40169158"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40169158"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:59:06 -0800
X-CSE-ConnectionGUID: s+v5sZKpTMu33S42KwGBvQ==
X-CSE-MsgGUID: mbw52K+YSwqH/j9avgAswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113368333"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:59:04 -0800
Message-ID: <cbe17c26-7631-494f-83d8-ff50481093ec@intel.com>
Date: Fri, 14 Feb 2025 09:59:03 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] dmaengine: idxd: fix memory leak in error handling
 path of idxd_alloc
To: Shuai Xue <xueshuai@linux.alibaba.com>, vkoul@kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-5-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250110082237.21135-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/25 1:22 AM, Shuai Xue wrote:
> Memory allocated for idxd is not freed if an error occurs during
> idxd_alloc(). To fix it, free the allocated memory in the reverse order
> of allocation before exiting the function in case of an error.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 04a7d7706e53..f0e3244d630d 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -565,28 +565,34 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>  	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
>  	if (idxd->id < 0)
> -		return NULL;
> +		goto err_ida;
>  
>  	idxd->opcap_bmap = bitmap_zalloc_node(IDXD_MAX_OPCAP_BITS, GFP_KERNEL, dev_to_node(dev));
> -	if (!idxd->opcap_bmap) {
> -		ida_free(&idxd_ida, idxd->id);
> -		return NULL;
> -	}
> +	if (!idxd->opcap_bmap)
> +		goto err_opcap;
>  
>  	device_initialize(conf_dev);
>  	conf_dev->parent = dev;
>  	conf_dev->bus = &dsa_bus_type;
>  	conf_dev->type = idxd->data->dev_type;
>  	rc = dev_set_name(conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
> -	if (rc < 0) {
> -		put_device(conf_dev);
> -		return NULL;
> -	}
> +	if (rc < 0)
> +		goto err_name;
>  
>  	spin_lock_init(&idxd->dev_lock);
>  	spin_lock_init(&idxd->cmd_lock);
>  
>  	return idxd;
> +
> +err_name:
> +	put_device(conf_dev);
> +	bitmap_free(idxd->opcap_bmap);
> +err_opcap:
> +	ida_free(&idxd_ida, idxd->id);
> +err_ida:
> +	kfree(idxd);
> +
> +	return NULL;
>  }
>  
>  static int idxd_enable_system_pasid(struct idxd_device *idxd)


