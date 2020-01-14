Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8406913ADE6
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 16:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANPoJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 10:44:09 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15257 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPoJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 10:44:09 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1de1b40000>; Tue, 14 Jan 2020 07:43:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:44:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 14 Jan 2020 07:44:08 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:44:06 +0000
Subject: Re: [PATCH v4 06/14] dmaengine: tegra-apb: Use
 devm_platform_ioremap_resource
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-7-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9f717ebf-4fcb-0579-ad23-7fb17ed3a941@nvidia.com>
Date:   Tue, 14 Jan 2020 15:44:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-7-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579016628; bh=QaYaLajjzBFd4/+d0+SO9JuQXoLCbFcPXQ9ZCmjLPeI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JwmG0NA93WbKDmrwK8dugvaPFNZm3Rbcosf3uiOWt+akGq+0Ve2cfEJBZUkXivAp0
         6lHOmmp3Wf/oK3LGL6x76UXkl903oYLNVGrybHzJRr6lILSITeWwf6zJ4czacSsaYP
         6sxu+IpEkh5XlacYcAEtmxflz0RuF2JPv7jmAmxHQaYQ9rrpQG75KE5MFqY0g5JUBI
         Jh1nDeumt2ap3DlZQEtWWdwjPsux3uGMqnEPv7tZrjpS8Nh+MIRH9b5bcJCXymV3C8
         8aPOyk+RHCLH4hzYwZsbEablccU63R7kIRRW3rZpa7arTwIDpbUyW7a82n5DJRLr0E
         /hCeN9deORJMA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> Use devm_platform_ioremap_resource to keep code cleaner a tad.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index aafad50d075e..f44291207928 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1402,8 +1402,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	tdma->chip_data = cdata;
>  	platform_set_drvdata(pdev, tdma);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
> +	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(tdma->base_addr))
>  		return PTR_ERR(tdma->base_addr);
>  

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
