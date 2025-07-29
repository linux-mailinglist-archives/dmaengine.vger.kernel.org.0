Return-Path: <dmaengine+bounces-5881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF49B147F9
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 08:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B8189DE3D
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 06:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89ED253925;
	Tue, 29 Jul 2025 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bFEGekQl"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6F1FDA8E;
	Tue, 29 Jul 2025 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768882; cv=none; b=ca5lYoIf6pTxhBooc+kTi73mwqnoA+N6gl9PnJmENWJg60Y04gaHEBZtyMtchbSmgy09865kfn5trGj0phvWSbac0izr+Qe4kDsgX4W5RHeBpbOkKhOu8bfJcDVcnYV8gJQjvu31jiJlvhhfWlhIKxwl+x7/zurWh/9UVsf1zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768882; c=relaxed/simple;
	bh=Z8MsEdjorS5R2dYvNToEWiAXS/lCzOOXVdvtjOLy1To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoMEjKhVg/e59sdJE2A6ySeBpGgEsmSmI2BdXFcaH3G375t9gBWjweal1LNmIJ6Dy2yDGrqNsHOihR1u+UV9cDpzuHvmOe1Oiq4q9Sg0dPceAZ3kIFLttDX1baX11kVpqBanWU5KxJPSaU1l7UL7utj/AMBuRMHwpOoA7lgBPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bFEGekQl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753768869; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aym7ZX6Nlzx1PBl7at6QAb/4ruzAS4EjDQT1X8Ky7Pc=;
	b=bFEGekQlyQt15wcamtbRWORpuIjc81EclaBNmEENsHBZulzsXL7ZMi/gqAPxtpeJVmKK9y2jUE66xgZGo9A9FbTosjX3Vrk+Yi1B9PoJ3dD5rwv6xZwb6AHmnjfY/5i9Bgbz98rWaZffYaT+ENN36J5CsBiXimEM+RCF3buLGDc=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkOpiIZ_1753768867 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Jul 2025 14:01:08 +0800
Message-ID: <1064beba-4904-47f9-983f-8f7c56c6d7e3@linux.alibaba.com>
Date: Tue, 29 Jul 2025 14:01:07 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: idxd: fix potential NULL pointer
 dereference on wq setup error path
To: vinicius.gomes@intel.com, dave.jiang@intel.com, fenghuay@nvidia.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
References: <20250607034532.92512-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250607034532.92512-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/7 11:45, Shuai Xue 写道:
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
> Closes: https://lore.kernel.org/dmaengine/aDQt3_rZjX-VuHJW@stanley.mountain
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> changes since v1:
> - add Reviewed-by tag from Dave Jiang
> - add Reported-by tag from Dan Carpenter and its Closes link
> ---
>   drivers/dma/idxd/init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 80355d03004d..a818d4799770 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -196,7 +196,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>   		if (!wq) {
>   			rc = -ENOMEM;
> -			goto err;
> +			goto err_wq;
>   		}
>   
>   		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
> @@ -246,6 +246,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   	put_device(conf_dev);
>   	kfree(wq);
>   
> +err_wq:
>   	while (--i >= 0) {
>   		wq = idxd->wqs[i];
>   		if (idxd->hw.wq_cap.op_config)

Hi, Vinod,

Gentle Ping.

Thanks.
Shuai

