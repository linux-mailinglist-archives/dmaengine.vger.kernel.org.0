Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0384F19729A
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 04:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgC3Cjk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Mar 2020 22:39:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbgC3Cjk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 29 Mar 2020 22:39:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B868078E2C4DE649DC3C;
        Mon, 30 Mar 2020 10:39:35 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 10:39:25 +0800
Subject: Re: [PATCH -next] dmaengine: hisilicon: Fix build error without
 PCI_MSI
To:     YueHaibing <yuehaibing@huawei.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>, <qiuzhenfa@hisilicon.com>
References: <20200328114133.17560-1-yuehaibing@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E815BDD.8050908@hisilicon.com>
Date:   Mon, 30 Mar 2020 10:39:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200328114133.17560-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/3/28 19:41, YueHaibing wrote:
> If PCI_MSI is not set, building fais:
> 
> drivers/dma/hisi_dma.c: In function ‘hisi_dma_free_irq_vectors’:
> drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function ‘pci_free_irq_vectors’;
>  did you mean ‘pci_alloc_irq_vectors’? [-Werror=implicit-function-declaration]
>   pci_free_irq_vectors(data);
>   ^~~~~~~~~~~~~~~~~~~~
>
> Make HISI_DMA depends on PCI_MSI to fix this.

In ARM64, it will appear this compile error if PCI disables.
How about adding depends on PCI && PCI_MSI here?

Best,
Zhou

> 
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 092483644315..023db6883d05 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -241,7 +241,8 @@ config FSL_RAID
>  
>  config HISI_DMA
>  	tristate "HiSilicon DMA Engine support"
> -	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
> +	depends on ARM64 || COMPILE_TEST
> +	depends on PCI_MSI
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> 

