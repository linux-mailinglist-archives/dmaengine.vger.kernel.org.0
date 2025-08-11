Return-Path: <dmaengine+bounces-5984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E5BB210DA
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A8A188B1AB
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47192E284D;
	Mon, 11 Aug 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+NxTh1g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADC2E11B9;
	Mon, 11 Aug 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927012; cv=none; b=Rtfjgr+gM0hMlEuWVuGPxEYVO7dyZPN++tK2AZuD3Bw42WIE4ktniAbel1W2llWy7FnYbOv5Kisw/sjHi4Lg9tEaqmA0jQ2HAcVNSvJb+9g1A69Ss4/gg8aKY+Smfsfq5YUDBUb1qr9x81yqF8TKDIjuyJFcTPEvR1TopcSDDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927012; c=relaxed/simple;
	bh=zn5cZPHQng1+vLuHAuE53HdPsvAXlQnQCgdIZD5dKtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ45iidAm6G+9wMT/hNZrb93f8Yw3ZehlzRey5ndsUWM8klPmVtEkDjLbyEle8MjYKtdvzzicvlf7ZDEBchaDlamcTAFhxGvZamQxATY/hhR79RBVGelIShTnVTAvYz9bpx9XMPw3lLudBxK2kXemEZBToV+UtFdn5A4XammzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+NxTh1g; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754927011; x=1786463011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zn5cZPHQng1+vLuHAuE53HdPsvAXlQnQCgdIZD5dKtA=;
  b=V+NxTh1gTbyu6xoS6V1i1yaC56QI2I+Cyn7P35IZozS9Ui2trKNmW85R
   p0tvFDHYe0sj3r3UhdR0HTZXl5AcoQxFBS9w0m9Wky603hjh+jtj9NXzi
   DIycvDtfU17RrcuQF1FOxKmTQ0JHOj3PKAoTq2QaHYDMFwmOPzzKDX9pB
   iMLrBesP7oGCNM2QhCqEKO8gF25a7b1u2PekmJEsmWt0kv9cXCtv+tLST
   JWYbIrld1rMXuAfxAp/eEsbTw9ZA9FxhTP+7xhJ0Q+FApMiksv6TOfXSt
   NnWURERhk4pwFoxTkEGfD8zv9CemSBXvZRRfH126Z1fdYUE2etbiupnDT
   g==;
X-CSE-ConnectionGUID: qRc3l+MNSy+PzjQd3r2o/Q==
X-CSE-MsgGUID: lQeBHIipRpC0B0677qEYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68552730"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68552730"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:43:30 -0700
X-CSE-ConnectionGUID: cI3IyOMDREil4zsmPROvqw==
X-CSE-MsgGUID: ir+pQLLkSHq+DT8Jxm9fEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166301427"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.140]) ([10.247.119.140])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:43:24 -0700
Message-ID: <5f44acad-0049-45d5-b1d9-1b4cd803c860@intel.com>
Date: Mon, 11 Aug 2025 08:43:19 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Fix double free in idxd_setup_wqs()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Colin Ian King <colin.i.king@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aJnJW3iYTDDCj9sk@stanley.mountain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aJnJW3iYTDDCj9sk@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/25 3:43 AM, Dan Carpenter wrote:
> The clean up in idxd_setup_wqs() has had a couple bugs because the error
> handling is a bit subtle.  It's simpler to just re-write it in a cleaner
> way.  The issues here are:
> 
> 1) If "idxd->max_wqs" is <= 0 then we call put_device(conf_dev) when
>    "conf_dev" hasn't been initialized.
> 2) If kzalloc_node() fails then again "conf_dev" is invalid.  It's
>    either uninitialized or it points to the "conf_dev" from the
>    previous iteration so it leads to a double free.
> 
> It's better to free partial loop iterations within the loop and then
> the unwinding at the end can handle whole loop iterations.  I also
> renamed the labels to describe what the goto does and not where the goto
> was located.
> 
> Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
> Reported-by: Colin Ian King <colin.i.king@gmail.com>
> Closes: https://lore.kernel.org/all/20250811095836.1642093-1-colin.i.king@gmail.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 35bdefd3728b..dda01a4398e1 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -189,27 +189,30 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>  	if (!idxd->wq_enable_map) {
>  		rc = -ENOMEM;
> -		goto err_bitmap;
> +		goto err_free_wqs;
>  	}
> 
>  	for (i = 0; i < idxd->max_wqs; i++) {
>  		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>  		if (!wq) {
>  			rc = -ENOMEM;
> -			goto err;
> +			goto err_unwind;
>  		}
> 
>  		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
>  		conf_dev = wq_confdev(wq);
>  		wq->id = i;
>  		wq->idxd = idxd;
> -		device_initialize(wq_confdev(wq));
> +		device_initialize(conf_dev);
>  		conf_dev->parent = idxd_confdev(idxd);
>  		conf_dev->bus = &dsa_bus_type;
>  		conf_dev->type = &idxd_wq_device_type;
>  		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
> -		if (rc < 0)
> -			goto err;
> +		if (rc < 0) {
> +			put_device(conf_dev);
> +			kfree(wq);
> +			goto err_unwind;
> +		}
> 
>  		mutex_init(&wq->wq_lock);
>  		init_waitqueue_head(&wq->err_queue);
> @@ -220,15 +223,20 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>  		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>  		if (!wq->wqcfg) {
> +			put_device(conf_dev);
> +			kfree(wq);
>  			rc = -ENOMEM;
> -			goto err;
> +			goto err_unwind;
>  		}
> 
>  		if (idxd->hw.wq_cap.op_config) {
>  			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>  			if (!wq->opcap_bmap) {
> +				kfree(wq->wqcfg);
> +				put_device(conf_dev);
> +				kfree(wq);
>  				rc = -ENOMEM;
> -				goto err_opcap_bmap;
> +				goto err_unwind;
>  			}
>  			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
>  		}
> @@ -239,13 +247,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
> 
>  	return 0;
> 
> -err_opcap_bmap:
> -	kfree(wq->wqcfg);
> -
> -err:
> -	put_device(conf_dev);
> -	kfree(wq);
> -
> +err_unwind:
>  	while (--i >= 0) {
>  		wq = idxd->wqs[i];
>  		if (idxd->hw.wq_cap.op_config)
> @@ -254,11 +256,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		conf_dev = wq_confdev(wq);
>  		put_device(conf_dev);
>  		kfree(wq);
> -
>  	}
>  	bitmap_free(idxd->wq_enable_map);
> 
> -err_bitmap:
> +err_free_wqs:
>  	kfree(idxd->wqs);
> 
>  	return rc;
> --
> 2.47.2


