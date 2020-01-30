Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67DC14DC89
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 15:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA3OKL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 09:10:11 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6196 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3OKL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 09:10:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32e3b40000>; Thu, 30 Jan 2020 06:09:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 06:10:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 06:10:10 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 14:10:07 +0000
Subject: Re: [PATCH v6 16/16] dmaengine: tegra-apb: Support COMPILE_TEST
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-17-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <59dc7519-ff04-2b78-b3b9-c113b03b3f58@nvidia.com>
Date:   Thu, 30 Jan 2020 14:10:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130043804.32243-17-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580393396; bh=HchWEFrd3rSOe3Gf5cPIwdld/q7cAqUVRLlHx4ro+kQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Hc32rXbBM5pHJ1Umg9XFyRVO9oPdqJk5wzVhX9KBhQXca3xUpHHKb0y9Ur92/wzne
         u4XZYGNzAd3gaV4Rhk4nOq9Jmy1JbgUoAzjTI8WsgbuYkNnDsgl2kf66PbNzSWVPfu
         H0SWZIfIFASGSJv/s9uVpscoVSYM6lwGKscPz2FIovP6i1ZiIgf0uSrwwg0EtZuz9/
         yMJsETvFX+cvs4mxWNoUBtFxN6ttKNFRiI+C3TUMgq4V31qPpRpto4ZmHkgd7NZzDM
         dgxrHTPefKWo93oRYPJtTBAlg+kC0hWOFs9UmFgUsVStn/purMZXDsp2tXS5GlZ+VP
         ds59zb1SXNKGA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 04:38, Dmitry Osipenko wrote:
> There is nothing arch-specific in the driver's code, so let's enable
> compile-testing for the driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 98daf3aafdcc..7fc725d928b2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -617,7 +617,7 @@ config TXX9_DMAC
>  
>  config TEGRA20_APB_DMA
>  	tristate "NVIDIA Tegra20 APB DMA support"
> -	depends on ARCH_TEGRA
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	select DMA_ENGINE
>  	help
>  	  Support for the NVIDIA Tegra20 APB DMA controller driver. The

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
