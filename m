Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B0638D7B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Nov 2022 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKYPcd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Nov 2022 10:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYPcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Nov 2022 10:32:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E16582DCE;
        Fri, 25 Nov 2022 07:32:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271CE2B;
        Fri, 25 Nov 2022 07:32:37 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03DB13F587;
        Fri, 25 Nov 2022 07:32:27 -0800 (PST)
Message-ID: <8b7ce195-27b7-a27f-bf4e-fd5f20f2a83b@arm.com>
Date:   Fri, 25 Nov 2022 15:32:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Content-Language: en-GB
To:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
 <20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru>
 <20221107211134.wxaqi2sew6aejxne@mobilestation>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221107211134.wxaqi2sew6aejxne@mobilestation>
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

On 2022-11-07 21:11, Serge Semin wrote:
> On Tue, Nov 08, 2022 at 12:04:36AM +0300, Serge Semin wrote:
>> DW eDMA doesn't perform any translation of the traffic generated on the
>> CPU/Application side. It just generates read/write AXI-bus requests with
>> the specified addresses. But in case if the dma-ranges DT-property is
>> specified for a platform device node, Linux will use it to create a
>> mapping the PCIe-bus regions into the CPU memory ranges. This isn't what
>> we want for the eDMA embedded into the locally accessed DW PCIe Root Port
>> and End-point. In order to work that around let's set the chan_dma_dev
>> flag for each DW eDMA channel thus forcing the client drivers to getting a
>> custom dma-ranges-less parental device for the mappings.
>>
>> Note it will only work for the client drivers using the
>> dmaengine_get_dma_device() method to get the parental DMA device.
> 
> @Robin, we particularly need you opinion on this patch. I did as you
> said: call *_dma_configure() method to initialize the child device and
> set the DMA-mask here instead of the platform driver.

Apologies, I've been busy and this series got buried in my inbox before 
I'd clocked it as something I was supposed to be looking at.

> @Vinoud, @Manivannan I had to drop your tags from this patch since its
> content had been significantly changed.
> 
> -Sergey
> 
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>
>> ---
>>
>> Changelog v2:
>> - Fix the comment a bit to being clearer. (@Manivannan)
>>
>> Changelog v3:
>> - Conditionally set dchan->dev->device.dma_coherent field since it can
>>    be missing on some platforms. (@Manivannan)
>> - Remove Manivannan' rb and tb tags since the patch content has been
>>    changed.
>>
>> Changelog v6:
>> - Directly call *_dma_configure() method on the child device used for
>>    the DMA buffers mapping. (@Robin)
>> - Explicitly set the DMA-mask of the child device in the channel
>>    allocation proecedure. (@Robin)
>> - Drop @Manivannan and @Vinod rb- and ab-tags due to significant patch
>>    content change.
>> ---
>>   drivers/dma/dw-edma/dw-edma-core.c | 44 ++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>> index e3671bfbe186..846518509753 100644
>> --- a/drivers/dma/dw-edma/dw-edma-core.c
>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
>> @@ -6,9 +6,11 @@
>>    * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>    */
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/module.h>
>>   #include <linux/device.h>
>>   #include <linux/kernel.h>
>> +#include <linux/of_device.h>
>>   #include <linux/dmaengine.h>
>>   #include <linux/err.h>
>>   #include <linux/interrupt.h>
>> @@ -711,10 +713,52 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
>>   static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>>   {
>>   	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	struct device *dev = chan->dw->chip->dev;
>> +	int ret;
>>   
>>   	if (chan->status != EDMA_ST_IDLE)
>>   		return -EBUSY;
>>   
>> +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
>> +	 * controlled from the CPU/Application side since in that case
>> +	 * the local memory address is left untranslated.
>> +	 */
>> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>> +		ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
>> +						   DMA_BIT_MASK(64));
>> +		if (ret) {

Setting a 64-bit mask should never fail, especially on any platform that 
will actually run this code.

>> +			ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
>> +							   DMA_BIT_MASK(32));
>> +			if (ret)
>> +				return ret;
>> +		}
>> +
>> +		if (dev_of_node(dev)) {
>> +			struct device_node *node = dev_of_node(dev);
>> +
>> +			ret = of_dma_configure(&dchan->dev->device, node, true);
>> +		} else if (has_acpi_companion(dev)) {

Can this can ever happen? AFAICS there's no ACPI binding to match and 
probe the DWC driver, at best it could only probe as a standard PNP0A08 
host bridge which wouldn't know anything about eDMA anyway.

>> +			struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
>> +
>> +			ret = acpi_dma_configure(&dchan->dev->device,
>> +						 acpi_get_dma_attr(adev));
>> +		} else {
>> +			ret = -EINVAL;
>> +		}
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (dchan->dev->device.dma_range_map) {
>> +			kfree(dchan->dev->device.dma_range_map);
>> +			dchan->dev->device.dma_range_map = NULL;
>> +		}

Ugh, I guess this is still here because now you're passing the channel 
device to of_dma_configure() such that it looks like a PCI child :(

Can we just set "chan->dev->device.of_node = dev->of_node;" beforehand 
so it works as expected (with f1ad5338a4d5 in place) and we don't need 
to be messing with the dma_range_map details at all? Note that that 
isn't as hacky as it might sound - it's a relatively well-established 
practice in places like I2C and SPI, and in this case it seems perfectly 
appropriate semantically as well.

(And there should be no need to bother with of_node refcounting, since 
the lifetime of the eDMA driver is bounded by the lifetime of the PCIe 
driver, thus the lifetime of the DMA channel devices is bounded by the 
lifetime of the PCIe platform device, which already holds a reference 
from of_device_alloc().)

Thanks,
Robin.

>> +
>> +		dchan->dev->chan_dma_dev = true;
>> +	} else {
>> +		dchan->dev->chan_dma_dev = false;
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.38.0
>>
>>
