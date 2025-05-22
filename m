Return-Path: <dmaengine+bounces-5249-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89245AC0F10
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B9C3AF990
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CC528DF28;
	Thu, 22 May 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix8W6dSZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B928D8EA;
	Thu, 22 May 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925772; cv=none; b=sDL8rhjA71HGes6fwih7EVKJUKYPvWYbt6cAzdYmRnjWQuW6M7ZYYKcPBUmVvqiNg+MfsZSv7ik+1h+OtVWBtbHLA8M1psrZQu6jFEzC+VSk1tbn9POVl5eQ2zDm9qNC4uktXTAOfH8xpI+d35j1awr6th5PK1Zd4dVf8vta5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925772; c=relaxed/simple;
	bh=dZHIIDhqm9nZ+x3B+rtajd86G+T0nUTtkK6BFfND6js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRTo+VnZjMiar0f0f3HlffUqFLwMO1xQJr3dVVwRhqfjYmE55UEGL1ii2X1izF2rHw9+cVcL8W2bC/9ooVBSjktFMl+aIstX+iREwbfmS+gh6r5uKJ6HVhWOzQFz9GsRo5rtxnkG/28IzAja1XQNJjY2vBn1JS2K91DxF/TWbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix8W6dSZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747925770; x=1779461770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dZHIIDhqm9nZ+x3B+rtajd86G+T0nUTtkK6BFfND6js=;
  b=Ix8W6dSZa5GPBPNC3V9srgfcRtVJGoG1DyGUF7Auh5C5rcncQoPhTG8U
   cYYaWK0YGNvmOOuZCZFOb2tUUP/YYD4tvVLAjbO2EKML9p4oVX05pK/LB
   Oy92IHalBtQtZBGYii60iuJm0mhzkme+giLPwaiHUk+I/CwCSuRAdVjGk
   +Vsi3rvQn+ZD43iPFMdkxX0OFK3bJHmbAkQoMM2lcvKyx4WW7UjOTz1VB
   CXhix1w5HHslIIKxnYHVshKba/pcHCaCHGmq/13Ead9uL++LwCJLWkckW
   aXcgIYff0zR0g/Epj1f5w4bXPnZisnOf0YKHZkcyz2pl5YsWM63hhIPIa
   g==;
X-CSE-ConnectionGUID: rqdygQ1JQ9KB88+PFqfVCA==
X-CSE-MsgGUID: cjS53z/kQDu+HvZcVQnRoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50062179"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50062179"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:56:10 -0700
X-CSE-ConnectionGUID: dr1zABMeQLCDx5wSh1xk8w==
X-CSE-MsgGUID: 9tKOSiqxQn+XdsXw1ipVsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145502844"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.122]) ([10.125.109.122])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:56:09 -0700
Message-ID: <19668a72-c523-42ab-87ac-990a4baac214@intel.com>
Date: Thu, 22 May 2025 07:56:08 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dmaengine: idxd: fix potential NULL pointer
 dereference on wq setup error path
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-3-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250522063329.51156-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 11:33 PM, Shuai Xue wrote:
> If wq allocation fails during the initial iteration of the loop,
> `conf_dev` is still NULL.  However, the existing error handling via
> `goto err` would attempt to call `put_device(conf_dev)`, leading to a
> NULL pointer dereference.
> 
> This issue occurs because there's no dedicated error label for the WQ
> allocation failure case, causing it to fall through to an incorrect
> error path.
> 
> Fix this by introducing a new error label `err_wq`, ensuring that we
> only invoke `put_device(conf_dev)` when `conf_dev` is valid.
> 
> Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
> Cc: stable@vger.kernel.org
> Reported-by: Colin King <colin.i.king@gmail.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 760b7d81fcd8..bf57ad30d613 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -196,7 +196,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>  		if (!wq) {
>  			rc = -ENOMEM;
> -			goto err;
> +			goto err_wq;
>  		}
>  
>  		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
> @@ -246,6 +246,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  	put_device(conf_dev);
>  	kfree(wq);
>  
> +err_wq:
>  	while (--i >= 0) {
>  		wq = idxd->wqs[i];
>  		if (idxd->hw.wq_cap.op_config)


