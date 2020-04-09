Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2386C1A2D74
	for <lists+dmaengine@lfdr.de>; Thu,  9 Apr 2020 03:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIB5g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 21:57:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgDIB5g (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Apr 2020 21:57:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0F458CA7414E7270DFF8;
        Thu,  9 Apr 2020 09:57:34 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 09:57:25 +0800
Subject: Re: [PATCH] dmaengine: hisilicon: fix PCI_MSI dependency
To:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
References: <20200408200559.4124238-1-arnd@arndb.de>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E8E8104.5060307@hisilicon.com>
Date:   Thu, 9 Apr 2020 09:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200408200559.4124238-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/4/9 4:05, Arnd Bergmann wrote:
> The dependency is phrased incorrectly, so on arm64, it is possible
> to build with CONFIG_PCI disabled, resulting a build failure:
> 
> drivers/dma/hisi_dma.c: In function 'hisi_dma_free_irq_vectors':
> drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'pci_alloc_irq_vectors'? [-Werror=implicit-function-declaration]
>   138 |  pci_free_irq_vectors(data);
>       |  ^~~~~~~~~~~~~~~~~~~~
>       |  pci_alloc_irq_vectors
> drivers/dma/hisi_dma.c: At top level:
> drivers/dma/hisi_dma.c:605:1: warning: data definition has no type or storage class
>   605 | module_pci_driver(hisi_dma_pci_driver);
>       | ^~~~~~~~~~~~~~~~~
> drivers/dma/hisi_dma.c:605:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
> drivers/dma/hisi_dma.c:605:1: warning: parameter names (without types) in function declaration
> drivers/dma/hisi_dma.c:599:26: error: 'hisi_dma_pci_driver' defined but not used [-Werror=unused-variable]
>   599 | static struct pci_driver hisi_dma_pci_driver = {
> 
> Change it so we always depend on PCI_MSI, even on ARM64
> 
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 98ae15c82a30..c19e25b140c5 100644
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

Hi Arnd,

There was a fix from Haibing: https://lkml.org/lkml/2020/3/28/158
Maybe Vinod will review and take it later :)

Best,
Zhou

