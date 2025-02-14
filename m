Return-Path: <dmaengine+bounces-4473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58042A363CF
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E119A3B232B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5F267391;
	Fri, 14 Feb 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYrBvQDW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA42676E5;
	Fri, 14 Feb 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552478; cv=none; b=WNj3znwo/sRJhcIgtyqCvdGQIUMox267//BvBW7H0MsaeAqKRnrRFEsje4vDlM7zAhw3FG9whSyXdXFDFdixHoAfJzfpU4EviRF5B875aSEx2HSviYLfdvixEgOHbW8QG9eQMhvcUIgYbOYIxSSsCH7+gn7VzdYoEqwLeumFd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552478; c=relaxed/simple;
	bh=8msMDKhq8tjBEoCwkw9xd2vU5VG31x8YNvm+bAjiz7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4urrV/chBRRLdfwMyDwE67QIDXHjxmjnqhXNgJ6tStb+qR8/k3/cOKq+x5E6UuNcfNfQJ+PBzJARYlNqFhdAyR8nr5SX/F8mZuwMz/3D4aK7xE6P+1iRGfjAWdbYWRe88E9j5C6Hcek+gqiv1myO2iJQCjW9bw6IVSFiiMOws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYrBvQDW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739552477; x=1771088477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8msMDKhq8tjBEoCwkw9xd2vU5VG31x8YNvm+bAjiz7U=;
  b=KYrBvQDWGh4jwTjf42E5OhQyCyBiqRe7hPvDd5mEj0p+uDXeiI3rVvkw
   hLSgOz28kwkZhyjt4I4+zqMAmbmXqdSL7vL9YQwpx0XhW+4qDLfkC9FS8
   jePeb6N/zG6fNsmiWYvOnL3FncknfBinAw1ztq4DJiIT1rfAEHL0PxOw5
   lf0XNTpBJ6IFARmVPuXqmtH/Cm5MonVAmpPern2pL1GR9lqZbILngSDDG
   /dQQhS//ux7W8BkJislwf+FYwBoETk7ZjB2B5OJEcRpLKKDGXn8FoPoIz
   3rICrBx63/29TGbCMRE0i3UkA3xPKVTcnSYHsfq2JXsQIZAJ8CzptQXAl
   Q==;
X-CSE-ConnectionGUID: 7Ht153g/TEivaQyz8negXw==
X-CSE-MsgGUID: ntofDSiWSI+rMSJl+f2wDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="62776187"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="62776187"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:01:16 -0800
X-CSE-ConnectionGUID: VCtXwB5lRoODUJDUfaq5kQ==
X-CSE-MsgGUID: hNe5GBT7SCWjLHLm7u9iOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136735658"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:01:14 -0800
Message-ID: <5fa82b64-ac38-4d4d-9ff9-a2083a3d92a4@intel.com>
Date: Fri, 14 Feb 2025 10:01:11 -0700
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


