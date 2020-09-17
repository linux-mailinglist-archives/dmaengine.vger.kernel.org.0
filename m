Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B926DA09
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIQLWL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 07:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgIQLWG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 07:22:06 -0400
Received: from localhost (unknown [136.185.111.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49F221655;
        Thu, 17 Sep 2020 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600341718;
        bh=alahQ8Etr15Ff3L++TiTdgtdIGmaE5wLSVhlcoflxFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCZV/VURIVxL/UU8ySNM/zmdxuZZVrUFoEkfHhtpYmVPJ+OzGPZtjOfRkwR97E3Tz
         S8IowtqqC0ler49zuR38yczySGcf+r1OU4pkjDefbULLQCO9gPWCkvk15PSMJ/26By
         m3yR1j+4MyHBIinq4H8Mq/p+Y5/N4SBMQWlDM1B4=
Date:   Thu, 17 Sep 2020 16:51:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Qilong Zhang <zhangqilong3@huawei.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: ti: k3-udma: use
 devm_platform_ioremap_resource_byname
Message-ID: <20200917112154.GA2968@vkoul-mobl>
References: <20200917074457.52748-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917074457.52748-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-09-20, 15:44, Qilong Zhang wrote:
> From: Zhang Qilong <zhangqilong3@huawei.com>
> 
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/dma/ti/k3-udma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index de7bfc02a2de..eb29fdc9ffc1 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3157,13 +3157,11 @@ static const struct soc_device_attribute k3_soc_devices[] = {
>  
>  static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
>  {
> -	struct resource *res;
>  	int i;
>  
>  	for (i = 0; i < MMR_LAST; i++) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -						   mmr_names[i]);
> -		ud->mmrs[i] = devm_ioremap_resource(&pdev->dev, res);
> +		ud->mmrs[i] = devm_platform_ioremap_resource_byname(pdev,
> +								    mmr_names[i]);

One line please ;)

>  		if (IS_ERR(ud->mmrs[i]))
>  			return PTR_ERR(ud->mmrs[i]);
>  	}
> -- 
> 2.17.1

-- 
~Vinod
