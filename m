Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53E13BD14
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 11:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgAOKKI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 05:10:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3069 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAOKKI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 05:10:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ee4eb0001>; Wed, 15 Jan 2020 02:09:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 02:10:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 02:10:07 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 10:10:05 +0000
Subject: Re: [PATCH v4 12/14] dmaengine: tegra-apb: Add missing
 of_dma_controller_free
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-13-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4640ae6d-f278-37eb-e3a3-dc7cffddbf10@nvidia.com>
Date:   Wed, 15 Jan 2020 10:10:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-13-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579082987; bh=f25AUNUD7LZB8cYg8h5c12nKxa5lW7SPBiHVoN/+dg0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=T0osaxYp7tIDOXKDEdYCtvnbD/1//Jlu4DHPVuD1qX5j6onpIciHf8OxB1DxhgsEx
         IXhwRdpPGamDpOHB5YJEjbKh5sTOoNszcV5PRTauvyRPPG+Ua1cgX7FQqy6QwbeBaq
         FwHxdlcxDb6gRxahdAwGoiQWDlyet+JDTuXAVOXjb1/ehr2ug7UGZFTPoWvOMY/97X
         Nz/fIvwb6UQEqI3dPNAEuJ8lGcJfjN4uoJua3kZV9jmuu2x2wX2WxnYUXHdHNIyNnM
         jMo/cBBa2SSOP/ezAdyT/LIRXHK8a+KabkdXF0cmi6kRYYFDTyH1ahzDjWSdAMDxID
         rnJwRNDq9GzTw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:30, Dmitry Osipenko wrote:
> The DMA controller shall be released on driver's removal.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 398a0e1d6506..fbbb6a60901e 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1586,6 +1586,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  {
>  	struct tegra_dma *tdma = platform_get_drvdata(pdev);
>  
> +	of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&tdma->dma_dev);
>  
>  	if (!pm_runtime_enabled(&pdev->dev))
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
