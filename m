Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0945E643A8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2019 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGJIim (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jul 2019 04:38:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9701 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfGJIim (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Jul 2019 04:38:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d25a4100000>; Wed, 10 Jul 2019 01:38:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Jul 2019 01:38:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Jul 2019 01:38:41 -0700
Received: from [10.26.11.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 08:38:39 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix unused function warnings
To:     YueHaibing <yuehaibing@huawei.com>, <ldewangan@nvidia.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20190709083258.57112-1-yuehaibing@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5cda4486-d875-4f66-c7f9-0ed11e35d44c@nvidia.com>
Date:   Wed, 10 Jul 2019 09:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709083258.57112-1-yuehaibing@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562747920; bh=1FBvMektmbZBOzVKmJaAz9QLeVX25uyKcUKzcf9Hdc0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=T9Pms+Zrm7JkZZNSCGxO4a298/jArN10Cp+rQr/lxgrDM70EAU2KYkR93A75VFXt+
         jkpj0A2Wi4y87LlBNCvQhpvkGAd00yzdVgoVZOODKI30WznCPPTAfIuog2S3rdQaA1
         ynXq3sE1v0nDpuBTPN1iAB0ll8oZtrDULou9vNS5Z/Xu2v/ffM80aLF+OAz3GUd8vt
         m8mmYL4ZnfZvgbJxQ/CZJBAD4TfjZlHMuEzX2UdYdT740Jb4GPpPgl9REDRRURXhj/
         EiSTaumDmU19T8kN2qFDMFn39Km2YtALrYTwYWu6qBNsB2jzmTB2RpbhMeykYWsIW/
         KNJbEG5qKWldw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/07/2019 09:32, YueHaibing wrote:
> If CONFIG_PM is not set, build warnings:
> 
> drivers/dma/tegra210-adma.c:747:12: warning: tegra_adma_runtime_resume defined but not used [-Wunused-function]
>  static int tegra_adma_runtime_resume(struct device *dev)
> drivers/dma/tegra210-adma.c:715:12: warning: tegra_adma_runtime_suspend defined but not used [-Wunused-function]
>  static int tegra_adma_runtime_suspend(struct device *dev)
> 
> Mark the two function as __maybe_unused.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/tegra210-adma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 2805853..b33cf6e 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -712,7 +712,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
>  	return chan;
>  }
>  
> -static int tegra_adma_runtime_suspend(struct device *dev)
> +static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
>  {
>  	struct tegra_adma *tdma = dev_get_drvdata(dev);
>  	struct tegra_adma_chan_regs *ch_reg;
> @@ -744,7 +744,7 @@ static int tegra_adma_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tegra_adma_runtime_resume(struct device *dev)
> +static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
>  {
>  	struct tegra_adma *tdma = dev_get_drvdata(dev);
>  	struct tegra_adma_chan_regs *ch_reg;
> 

Thanks!

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
