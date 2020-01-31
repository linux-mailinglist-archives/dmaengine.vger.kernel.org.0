Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE614E9E3
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgAaJFr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 04:05:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3813 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAaJFr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 04:05:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e33edd50001>; Fri, 31 Jan 2020 01:05:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jan 2020 01:05:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 Jan 2020 01:05:46 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 09:05:43 +0000
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-12-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1b7dd052-20f0-7b38-9578-44967eca1770@nvidia.com>
Date:   Fri, 31 Jan 2020 09:05:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130043804.32243-12-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580461525; bh=BuOEIlbunk7DCg4cTZ3hlSTaa7xG8buVShKe71iVBmQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k/JTHwA+ZPbXyAPIaXapcZO+zRym95tsMi+ep9eF4W9lfzOG8Y06NARftq85MOHVP
         Lr6IyrwUWnGPWk6hcySr55nBl+xo5E0DxYNYl5lcqsvtDMi7Pyp5NPZLSFdShVwy/J
         ikNQgBb0HASbDZwN+8FIXiXULXt5SpotCdZRYGF4v9MrMrSVkgdaoG05xLdlHYAlM4
         o+dtJOQfxMdutQLJoVsx8YDu3F7eFlX09gHJLwwQqiMegRxNQp9zeOCmGbFvy69zpD
         LAkrbDqiAdPy4eYuoXvBYojxIM+XRrvpY2AKM/424qEnzYo79Kr5KAw7gH7watJZRj
         TYtMakNWvDvtg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 04:37, Dmitry Osipenko wrote:
> It's a bit impractical to enable hardware's clock at the time of DMA
> channel's allocation because most of DMA client drivers allocate DMA
> channel at the time of the driver's probing, and thus, DMA clock is kept
> always-enabled in practice, defeating the whole purpose of runtime PM.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 47 ++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 22b88ccff05d..0ee28d8e3c96 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -436,6 +436,8 @@ static void tegra_dma_stop(struct tegra_dma_channel *tdc)
>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
>  	}
>  	tdc->busy = false;
> +
> +	pm_runtime_put(tdc->tdma->dev);

There are only 3 places where tegra_dma_stop is called, does it simplify
the code if we move the pm_runtime_put() outside of tegra_dma_stop? In
other words, everywhere there is a tegra_dma_stop, afterwards we then
call pm_runtime_put?

This would allow us to get rid of the extra pm_runtime_get in
terminate_all.

Jon

-- 
nvpublic
