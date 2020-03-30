Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7629A1974C2
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgC3G7f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 02:59:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728489AbgC3G7e (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 02:59:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0189230DE2128303A08;
        Mon, 30 Mar 2020 14:59:15 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 14:59:09 +0800
Subject: Re: [PATCH -next] dmaengine: hisilicon: Fix build error without
 PCI_MSI
To:     Zhou Wang <wangzhou1@hisilicon.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>, <qiuzhenfa@hisilicon.com>
References: <20200328114133.17560-1-yuehaibing@huawei.com>
 <5E815BDD.8050908@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <16ccc33f-d394-b59a-b3ee-65488595580f@huawei.com>
Date:   Mon, 30 Mar 2020 14:59:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5E815BDD.8050908@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/3/30 10:39, Zhou Wang wrote:
> On 2020/3/28 19:41, YueHaibing wrote:
>> If PCI_MSI is not set, building fais:
>>
>> drivers/dma/hisi_dma.c: In function ‘hisi_dma_free_irq_vectors’:
>> drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function ‘pci_free_irq_vectors’;
>>  did you mean ‘pci_alloc_irq_vectors’? [-Werror=implicit-function-declaration]
>>   pci_free_irq_vectors(data);
>>   ^~~~~~~~~~~~~~~~~~~~
>>
>> Make HISI_DMA depends on PCI_MSI to fix this.
> 
> In ARM64, it will appear this compile error if PCI disables.
> How about adding depends on PCI && PCI_MSI here?

PCI_MSI depends on PCI， while PCI is not set, PCI_MSI will never be set

so depends on PCI_MSI is enough.

> 
> Best,
> Zhou
> 
>>
>> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/dma/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 092483644315..023db6883d05 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -241,7 +241,8 @@ config FSL_RAID
>>  
>>  config HISI_DMA
>>  	tristate "HiSilicon DMA Engine support"
>> -	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
>> +	depends on ARM64 || COMPILE_TEST
>> +	depends on PCI_MSI
>>  	select DMA_ENGINE
>>  	select DMA_VIRTUAL_CHANNELS
>>  	help
>>
> 
> 
> .
> 

