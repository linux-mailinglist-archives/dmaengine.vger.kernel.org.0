Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1FC41AFD
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 06:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfFLEVt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 00:21:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfFLEVt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 00:21:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1A88FE90DD79A3EAE088;
        Wed, 12 Jun 2019 12:21:45 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 12:21:44 +0800
Subject: Re: [PATCH] dmaengine: dw-edma: Fix build error without
 CONFIG_PCI_MSI
To:     <gustavo.pimentel@synopsys.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
References: <20190612041801.18300-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <48bc5e67-c501-eb97-325a-f2693736e682@huawei.com>
Date:   Wed, 12 Jun 2019 12:21:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190612041801.18300-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Pls ignore this, will fix patch title and resend

On 2019/6/12 12:18, YueHaibing wrote:
> If CONFIG_PCI_MSI is not set, building with CONFIG_DW_EDMA
> fails:
> 
> drivers/dma/dw-edma/dw-edma-core.c: In function dw_edma_irq_request:
> drivers/dma/dw-edma/dw-edma-core.c:784:21: error: implicit declaration of function pci_irq_vector; did you mean rcu_irq_enter? [-Werror=implicit-function-declaration]
>    err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
>                      ^~~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/dw-edma/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
> index c0838ce..7ff17b2 100644
> --- a/drivers/dma/dw-edma/Kconfig
> +++ b/drivers/dma/dw-edma/Kconfig
> @@ -2,6 +2,7 @@
>  
>  config DW_EDMA
>  	tristate "Synopsys DesignWare eDMA controller driver"
> +	depends on PCI && PCI_MSI
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> 

