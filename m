Return-Path: <dmaengine+bounces-219-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093147F7498
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349471C20AD0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69D286B2;
	Fri, 24 Nov 2023 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwRislTF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AD286B1
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 13:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F5EC433C7;
	Fri, 24 Nov 2023 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700831482;
	bh=8mSUBJxI783kfIzyz9GSZzzaCFUJHxcazdbjVcAVjms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwRislTFWoUpbIAeSU6Nl6zfJlA2hHazkpMHRWwk9xlfqdBST05qHkygTrB/KdI7r
	 51xlEdqbDAUWEftLQF/3StrTWDZhEKVJv82hnIxP5ECOZ6MbjW30FiQdz5rmcuhooV
	 JcWCIGIAAYF1nQp38YEyfqSo4WYAy0WYuKkjCqpwqztZXQ56Iq3aGGmkspuGQyUw90
	 uYnVOunwL5WwW6/9vu6Y5/ay0WbyuEFXLcftlXOBE3aX7IkFlkwD8DwEUexwQ5d2tE
	 VPkoeWLgPvjjhBLVXO8SbqczGhAz6cddyHhKytlzsa7TxKJSEVQ7W9Dew31et1jyBq
	 VN1baeDG7bQfw==
Date: Fri, 24 Nov 2023 18:41:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Kaiwei Liu <kaiwei.liu@unisoc.com>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kaiwei liu <liukaiwei086@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
Message-ID: <ZWCg9hmfvexyn7xK@matsya>
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102121623.31924-1-kaiwei.liu@unisoc.com>

On 02-11-23, 20:16, Kaiwei Liu wrote:
> From: "kaiwei.liu" <kaiwei.liu@unisoc.com>

Typo is subject line

> 
> In the probe of dma, it will allocate device memory and do some
> initalization settings. All operations are only at the software
> level and don't need the DMA hardware power on. It doesn't need
> to resume the device and set the device active as well. here
> delete unnecessary operation.

Don't you need to read or write to the device? Without enable that wont
work right?

Lastly patches appear disjoint, pls thread them properly

> 
> Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
> ---
>  drivers/dma/sprd-dma.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 08fcf1ec368c..8ab5a9082fc5 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1203,21 +1203,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, sdev);
> -	ret = sprd_dma_enable(sdev);
> -	if (ret)
> -		return ret;
> -
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -
> -	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> -		goto err_rpm;
>  
>  	ret = dma_async_device_register(&sdev->dma_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
> -		goto err_register;
> +		return ret;
>  	}
>  
>  	sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
> @@ -1226,16 +1216,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_of_register;
>  
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>  	return 0;
>  
>  err_of_register:
>  	dma_async_device_unregister(&sdev->dma_dev);
> -err_register:
> -	pm_runtime_put_noidle(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -err_rpm:
> -	sprd_dma_disable(sdev);
>  	return ret;
>  }
>  
> -- 
> 2.17.1

-- 
~Vinod

