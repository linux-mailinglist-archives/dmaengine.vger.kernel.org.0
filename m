Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D6B13BD1C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 11:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgAOKLQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 05:11:16 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4171 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAOKLQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 05:11:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ee52e0000>; Wed, 15 Jan 2020 02:10:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 02:11:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 02:11:15 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 10:11:12 +0000
Subject: Re: [PATCH v4 14/14] dmaengine: tegra-apb: Remove MODULE_ALIAS
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-15-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7cd815b6-00ac-bf81-440d-0d8100e2948f@nvidia.com>
Date:   Wed, 15 Jan 2020 10:11:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-15-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579083054; bh=yzYDzTFyG50kJxkGdOKiuHxNRIM6a+aLyPatw2yMdY0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KllFPKS9lWkqou1o4uCj4XSkw77RpluZsrr27SLXl2G+pWNQ+eQVQv46XBeD8E7+I
         UR4afFnze+MbhH7LwVax1iBNLIa4fiRrMjzthTsoUAMhRRW9HUiO/uJT78EuPRJ5+w
         BHZj9ccfsokOCubdQUDRP9IOsaRCBd4LFY9nKBAQRVsl2mVrVEYOw2W+MOs4gUDVKz
         EfMi0IBp1L2JObGZyk/cePsuhpPcSh/UyEdYS96Gkfj7HtALDb1Ti1lD7IQTexr1C3
         eE2rdRCCydRpHAVBFtiwgJlDaSdO5c+RtNy91JU/MV/Or3YEABVonVDucDPIZQBAWP
         3MbOxYsHamaag==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:30, Dmitry Osipenko wrote:
> Tegra APB DMA driver is an Open Firmware driver and thus it uses OF alias
> naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS does
> nothing and could be removed safely.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index fbbb6a60901e..0a45dd77618c 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1688,7 +1688,6 @@ static struct platform_driver tegra_dmac_driver = {
>  
>  module_platform_driver(tegra_dmac_driver);
>  
> -MODULE_ALIAS("platform:tegra20-apbdma");
>  MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
>  MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
>  MODULE_LICENSE("GPL v2");

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
