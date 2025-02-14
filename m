Return-Path: <dmaengine+bounces-4469-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5AA36340
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA0C1897710
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773C267703;
	Fri, 14 Feb 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfCors0/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E27E0ED;
	Fri, 14 Feb 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550840; cv=none; b=VQi8XWqKth8f99qdfDH/2BevNPqQZYfclAGnJigzYcFR2cWkAwgnF2h7d1ceCKnbq2HBvNG2/sQMCTiH+5dTlCgcoQylmX0NQImZkP4AlMJguHUVSa6xiBuuQr1gVj/HTYvbQqsTIF5InF0vNj9Mh6KP4V2zIN9YqnPLUveFA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550840; c=relaxed/simple;
	bh=vrqTB4+ICaBW4Z+0D/sKuGHjCSB6CunXPwqXMI/Y1DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3WRtr9dFFeGJrfnyg2XA2HEE8uSxSHarkP8sns5WbZFz7arwVuHi0+sbaXfz5tkoESFUiXEgllZQAFCUkR9cUzXHD1XLeK4uNX6Xm6nN9/LyS5zlydt+Jk9hElUnqwHs2HNC0siXF01nmSq5zZ8Ns+V75ENI+RBzMTfkjUcBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfCors0/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739550839; x=1771086839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vrqTB4+ICaBW4Z+0D/sKuGHjCSB6CunXPwqXMI/Y1DY=;
  b=JfCors0/XGb5Ha3Q9aGILslyhZwQAPQb2sVkBEn1KCnqFIX+Ij4tPKK2
   LnKKK1cI+3SZcqCgXDabjdnwkaiylFOfvsmE8JpnZgMoKnm+tJbqNO5S7
   SnUIYcSXilnQiX9TB7RD5NnAWhtghzEbxnQEfH17XFlsAeWLG/aFuL5b0
   9vxUzm8HIKpGBpLalxX1+wolCzH9Or/sgVpkewrOi6zfQsEoGnrJEzWTu
   Fl/Fc/pUfXTuA9UWQ0YGMVhTNhSsgyfNBpb5nztTVP4gHCbAw7j/rWCM/
   Uko3mH2AuyTnLYXkMdJL6XxGBpmI7zn92/gK54cf0pNHVHos0ZCQ8g2ZS
   w==;
X-CSE-ConnectionGUID: Zwuksd3KRXCImcg2gk8MUA==
X-CSE-MsgGUID: GnzpRRJ+T5iqKlADmPUzhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57711767"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57711767"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:33:59 -0800
X-CSE-ConnectionGUID: gtwMTw4LQd20LAb0Z5FL9Q==
X-CSE-MsgGUID: UFH8Q20xT0yLo6bvq4Br+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114011033"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:33:58 -0800
Message-ID: <6c8ac7d8-aca7-4d1c-8c0d-0016cd3114fe@intel.com>
Date: Fri, 14 Feb 2025 09:33:57 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
To: Shuai Xue <xueshuai@linux.alibaba.com>, vkoul@kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250110082237.21135-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/25 1:22 AM, Shuai Xue wrote:
> Memory allocated for wqs is not freed if an error occurs during
> idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 234c1c658ec7..6772d9251cd7 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -167,8 +167,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  
>  	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>  	if (!idxd->wq_enable_map) {
> -		kfree(idxd->wqs);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto err_bitmap;
>  	}
>  
>  	for (i = 0; i < idxd->max_wqs; i++) {
> @@ -189,6 +189,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
>  		if (rc < 0) {
>  			put_device(conf_dev);
> +			kfree(wq);
>  			goto err;
>  		}
>  
> @@ -202,6 +203,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>  		if (!wq->wqcfg) {
>  			put_device(conf_dev);
> +			kfree(wq);
>  			rc = -ENOMEM;
>  			goto err;
>  		}
> @@ -209,7 +211,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		if (idxd->hw.wq_cap.op_config) {
>  			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>  			if (!wq->opcap_bmap) {
> +				kfree(wq->wqcfg);
>  				put_device(conf_dev);
> +				kfree(wq);
>  				rc = -ENOMEM;
>  				goto err;
>  			}
> @@ -223,11 +227,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  	return 0;
>  
>   err:
> -	while (--i >= 0) {
> +	while (i-- > 0) {
>  		wq = idxd->wqs[i];
> +		if (idxd->hw.wq_cap.op_config)
> +			bitmap_free(wq->opcap_bmap);
> +		kfree(wq->wqcfg);
>  		conf_dev = wq_confdev(wq);
>  		put_device(conf_dev);
> +		kfree(wq);
> +
>  	}
> +	bitmap_free(idxd->wq_enable_map);
> +
> +err_bitmap:
> +	kfree(idxd->wqs);
> +
>  	return rc;
>  }
>  


