Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12455643B5
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2019 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfGJImT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jul 2019 04:42:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9818 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfGJImS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Jul 2019 04:42:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d25a4e80000>; Wed, 10 Jul 2019 01:42:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Jul 2019 01:42:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Jul 2019 01:42:17 -0700
Received: from [10.26.11.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 08:42:15 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: mark PM funtions as
 __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Sameer Pujar <spujar@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190709185703.3298951-1-arnd@arndb.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b61434c4-12e6-0c50-79cc-ac15f19d23e6@nvidia.com>
Date:   Wed, 10 Jul 2019 09:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709185703.3298951-1-arnd@arndb.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562748136; bh=bi8N7CWE6lC4ARXtO4s5ldFSbTpMxdLou7FJCsAXw/g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dM7LIw5R5ylXOhzW7mX5YFFXLcuvsULHmfWDylGOu7R2idV8m+fe5i6lVbdXziTmt
         lqhaTZ/NWO60TlT8fC2OHRJt7dAdywrZijioqw0pAkIFfsbTVluMrFlVZOIwbenK0l
         56ILcowl4HYCus1m+41Z9Hh35zCmZTQ2EF0ErdQbiUpUxUvT9Y3r4Zuf+JZSzG8Of4
         765Li784TLcym31p4M5Xtn6vovxEn8nvwFK9kvc/ahuDdhu2J10a7o0pw4BcRA5l9w
         tQGPVdqssQJNtIGNNQyXc5AV5kRojetcQg8cHOSiSdOGTJUFee/G/YInxROcNunNOw
         M2U8whkNj7pIg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/07/2019 19:56, Arnd Bergmann wrote:
> Without the CONFIG_PM_CLK dependency, we can now build this file
> in kernels that don't have CONFIG_PM at all, resulting in a harmless
> warning from code that was always there since it got merged:
> 
> drivers/dma/tegra210-adma.c:747:12: error: 'tegra_adma_runtime_resume' defined but not used [-Werror=unused-function]
>  static int tegra_adma_runtime_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/dma/tegra210-adma.c:715:12: error: 'tegra_adma_runtime_suspend' defined but not used [-Werror=unused-function]
>  static int tegra_adma_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Mark them __maybe_unused to let the compiler silently drop
> those two functions.
> 
> Fixes: 3145d73e69ba ("dmaengine: tegra210-adma: remove PM_CLK dependency")
> Fixes: f46b195799b5 ("dmaengine: tegra-adma: Add support for Tegra210 ADMA")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/tegra210-adma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 2805853e963f..2b4be5557b37 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -712,7 +712,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
>  	return chan;
>  }
>  
> -static int tegra_adma_runtime_suspend(struct device *dev)
> +static __maybe_unused int tegra_adma_runtime_suspend(struct device *dev)
>  {
>  	struct tegra_adma *tdma = dev_get_drvdata(dev);
>  	struct tegra_adma_chan_regs *ch_reg;
> @@ -744,7 +744,7 @@ static int tegra_adma_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tegra_adma_runtime_resume(struct device *dev)
> +static __maybe_unused int tegra_adma_runtime_resume(struct device *dev)
>  {
>  	struct tegra_adma *tdma = dev_get_drvdata(dev);
>  	struct tegra_adma_chan_regs *ch_reg;
> 

Thanks Arnd, but looks like Yue has beaten you to it again ;-)

https://www.lkml.org/lkml/2019/7/9/209

Cheers
Jon

-- 
nvpublic
