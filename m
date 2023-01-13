Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DA66A11D
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjAMRtg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAMRs6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:48:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D8278B524;
        Fri, 13 Jan 2023 09:40:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE592FEC;
        Fri, 13 Jan 2023 09:41:29 -0800 (PST)
Received: from [10.57.76.81] (unknown [10.57.76.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B9B3F67D;
        Fri, 13 Jan 2023 09:40:44 -0800 (PST)
Message-ID: <8984a6ee-9066-bd2e-761f-96a8dd7875b6@arm.com>
Date:   Fri, 13 Jan 2023 17:40:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 24/25] PCI: bt1: Set 64-bit DMA-mask
Content-Language: en-GB
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-25-Sergey.Semin@baikalelectronics.ru>
 <Y8FI3m0Yare5gCeM@lpieralisi>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y8FI3m0Yare5gCeM@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023-01-13 12:04, Lorenzo Pieralisi wrote:
> On Thu, Dec 15, 2022 at 02:53:04AM +0300, Serge Semin wrote:
>> The DW PCIe RC IP-core is synthesized with the 64-bits AXI address bus.
>> Since the device is also equipped with the eDMA engine we need to
>> explicitly set the device DMA-mask so the DMA-engine clients would be able
>> to allocate the data buffers from the DMA-able memory space.
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>
>> ---
>>
>> Changelog v7:
>> - This is a new patch added on v7 stage of the series. (@Robin)
>> ---
>>   drivers/pci/controller/dwc/pcie-bt1.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Hi Robin,
> 
> are you OK with this change ? I think that's the last (PCI) bit we
> need to take the series.

Yup, having gone and double-checked the context this seems fine too - 
I've slightly lost track of all the circles we've been round in by now, 
but it looks like the way things all end up after v8 (and now v9) should 
be uncontentious.

Thanks,
Robin.

> 
> Thanks,
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
>> index 8b6c7d544d9a..04aa58348aa5 100644
>> --- a/drivers/pci/controller/dwc/pcie-bt1.c
>> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
>> @@ -583,6 +583,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
>>   	struct device *dev = &btpci->pdev->dev;
>>   	int ret;
>>   
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +	if (ret)
>> +		return ret;
>> +
>>   	btpci->dw.version = DW_PCIE_VER_460A;
>>   	btpci->dw.dev = dev;
>>   	btpci->dw.ops = &bt1_pcie_ops;
>> -- 
>> 2.38.1
>>
>>
