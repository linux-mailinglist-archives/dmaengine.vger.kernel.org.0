Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59F24D2A6
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFTQDA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 12:03:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17456 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTQDA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 12:03:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bae320002>; Thu, 20 Jun 2019 09:02:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 09:02:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 09:02:58 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 16:02:56 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: remove PM_CLK dependency
To:     Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1561046059-15821-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1f21a03d-4cb9-c0e3-588e-8183d6f31cae@nvidia.com>
Date:   Thu, 20 Jun 2019 17:02:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561046059-15821-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561046578; bh=0Ntl9wXX/ebpdrixzUWIW9WAp/z6HujFLE4v4TlwHa8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YdVqj/hs2fmiN09Zbl38MHF5SibnKEbTHwpTqMaDVFXziQ7cES0PCQIqUQ89NY3pg
         Uej2bFOUHoBotNtvzja0zlJf7m3ygt+rnQyLqrT49JOhPKy15W1nn1e/m+iHfaTWOU
         xRGP0jXSmRp492N6X0VwO5cz5Xm+phO0t7KpgUmIyYwdNhz1bbyGtOyntzf/cgh1Jt
         H1tkVqoxn3AMLPCAtOZiFReMfOrdqkYgzUI4pXFv0T7DXo68eyAwesHK88ZCgbwGyO
         4k8XE/lmRhD0Y6ldIK5hcIMJT5yjTgkDLufzasfOXGDYVL0sMkDTDhjd1qJTjwVqk3
         vcPn2TlaG0jqQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 20/06/2019 16:54, Sameer Pujar wrote:
> Tegra ADMA does not use pm-clk interface now and hence the dependency
> is removed from Kconfig.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 703275c..ba660e2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -584,7 +584,7 @@ config TEGRA20_APB_DMA
>  
>  config TEGRA210_ADMA
>  	tristate "NVIDIA Tegra210 ADMA support"
> -	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST) && PM_CLK
> +	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST)
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help

Thanks. We should probably populate the 'Fixes:' tag for this to show
which commit this fixes. Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
