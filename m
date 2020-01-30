Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3314DC7D
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 15:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgA3OI7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 09:08:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6109 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3OI7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 09:08:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32e36b0001>; Thu, 30 Jan 2020 06:08:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 06:08:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Jan 2020 06:08:58 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 14:08:55 +0000
Subject: Re: [PATCH v6 09/16] dmaengine: tegra-apb: Remove unneeded
 initialization of tdc->config_init
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-10-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1743d334-8b15-a8bb-8203-6cb6a93986a9@nvidia.com>
Date:   Thu, 30 Jan 2020 14:08:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130043804.32243-10-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580393324; bh=bO238qLr9iP11nC2WiJDgAePmlDNUjLv3zxpkjYVkuE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FdniFdJJFuYiMNSlkqtE/2lpegmvUchUq4btD33vtk99VCarqRZUOzmCF/UuU0yjE
         HLatuevw68VE5z++tvjQeFlx3NL4oYVVNGs+SLBsuwOUKLMgj+NNSkelvMChvn7Jcl
         nUBHZU5g4An4Jdtuocmtse46FbcGimp7nG5AjyDdmF1sW8L5nfUY1wSvvrGDFvMMD3
         Xdz2GFsHLFp28GWk4KRRPGTQQceq13wKSlRgPt6cTe+HWv9AQweh5kiBP5Qeb2UJNQ
         zdyUkPwjd7hDkTy/R8T6zXBKIjLwFXQ0wY9x0ujUdb0vTK8R+IVz21qJqfQeEklWSo
         0eUO309r4OZHw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 04:37, Dmitry Osipenko wrote:
> There is no need to re-initialize the already initialized variables.
> The tdc->config_init=false after driver's probe and after channel's
> freeing, so there is no need to re-initialize it on the channel's
> allocation.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index b4535b3a07ce..7158bd3145c4 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1284,7 +1284,6 @@ static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
>  	int ret;
>  
>  	dma_cookie_init(&tdc->dma_chan);
> -	tdc->config_init = false;
>  
>  	ret = pm_runtime_get_sync(tdma->dev);
>  	if (ret < 0)
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
