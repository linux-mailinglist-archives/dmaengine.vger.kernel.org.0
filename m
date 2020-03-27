Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E008195E6A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2020 20:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgC0TPl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Mar 2020 15:15:41 -0400
Received: from foss.arm.com ([217.140.110.172]:51708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0TPl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Mar 2020 15:15:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A9430E;
        Fri, 27 Mar 2020 12:15:40 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4563F71E;
        Fri, 27 Mar 2020 12:15:38 -0700 (PDT)
Subject: Re: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        BOUGH CHEN <haibo.chen@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Ludovic Barre <ludovic.barre@st.com>
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
 <VI1PR04MB504097B40CE0B804FA60D67A90CF0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB5040FFADA4F780422E208AC390CC0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAPDyKFr_yOmZ2MMvp=1krHejCRDRfhC0B+1icYR5xuZfhKy_ag@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2b2f1b1e-d186-e60f-baa9-3223ad4101f0@arm.com>
Date:   Fri, 27 Mar 2020 19:15:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr_yOmZ2MMvp=1krHejCRDRfhC0B+1icYR5xuZfhKy_ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020-03-27 3:34 pm, Ulf Hansson wrote:
> On Fri, 27 Mar 2020 at 04:02, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: BOUGH CHEN
>>> Sent: 2020年3月26日 12:41
>>> To: Ulf Hansson <ulf.hansson@linaro.org>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>;
>>> linux-kernel@vger.kernel.org
>>> Cc: Arnd Bergmann <arnd@arndb.de>; Christoph Hellwig <hch@lst.de>;
>>> Russell King <linux@armlinux.org.uk>; Linus Walleij <linus.walleij@linaro.org>;
>>> Vinod Koul <vkoul@kernel.org>; Ludovic Barre <ludovic.barre@st.com>;
>>> linux-arm-kernel@lists.infradead.org; dmaengine@vger.kernel.org
>>> Subject: RE: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
>>>
>>>> -----Original Message-----
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Sent: 2020年3月25日 19:34
>>>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rafael J .
>>>> Wysocki <rafael@kernel.org>; linux-kernel@vger.kernel.org
>>>> Cc: Arnd Bergmann <arnd@arndb.de>; Christoph Hellwig <hch@lst.de>;
>>>> Russell King <linux@armlinux.org.uk>; Linus Walleij
>>>> <linus.walleij@linaro.org>; Vinod Koul <vkoul@kernel.org>; BOUGH CHEN
>>>> <haibo.chen@nxp.com>; Ludovic Barre <ludovic.barre@st.com>;
>>>> linux-arm-kernel@lists.infradead.org; dmaengine@vger.kernel.org; Ulf
>>>> Hansson <ulf.hansson@linaro.org>
>>>> Subject: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus
>>>> level
>>>>
>>>> It's currently the amba/platform driver's responsibility to initialize
>>>> the pointer, dma_parms, for its corresponding struct device. The
>>>> benefit with this approach allows us to avoid the initialization and
>>>> to not waste memory for the struct device_dma_parameters, as this can
>>>> be decided on a case by case basis.
>>>>
>>>> However, it has turned out that this approach is not very practical.
>>>> Not only does it lead to open coding, but also to real errors. In
>>>> principle callers of
>>>> dma_set_max_seg_size() doesn't check the error code, but just assumes
>>>> it succeeds.
>>>>
>>>> For these reasons, this series initializes the dma_parms from the
>>>> amba/platform bus at the device registration point. This also follows
>>>> the way the PCI devices are being managed, see pci_device_add().
>>>>
>>>> If it turns out that this is an acceptable solution, we probably also
>>>> want the changes for stable, but I am not sure if it applies without conflicts.
>>>>
>>>> The series is based on v5.6-rc7.
>>>>
>>>
>>> Hi Ulf,
>>>
>>> Since i.MXQM SMMU related code still not upstream yet, so I apply your
>>> patches on our internal Linux branch based on v5.4.24, and find it do not work
>>> on my side. Maybe for platform core drivers, there is a gap between v5.4.24
>>> and v5.6-rc7 which has the impact.
>>> I will try to put our SMMU related code into v5.6-rc7, then do the test again.
>>>
>>>
>>
>> Hi Ulf,
>>
>> On the latest Linux-next branch, the top commit 89295c59c1f063b533d071ca49d0fa0c0783ca6f (tag: next-20200326), after add your two patches, I just add the simple debug code as following in the /driver/mmc/core/queue.c, but seems still not work as our expect, logically, it should work, so can you or anyone test on other platform? This seems weird.
> 
> You are right, this doesn't work for platform devices being added
> through the OF path.
> 
> In other words, of_platform_device_create_pdata() manually allocates
> the platform device and assigns it the &platform_bus_type, but without
> calling platform_device_add().
> 
> For amba, it works fine, as in that OF path, amba_device_add() is called. Hmm.
> 
> I re-spin this, to address the problem. Perhaps we simply need to use
> the ->probe() path.

FWIW we already have setup_pdev_dma_masks(), so it might be logical to 
include dma_parms in there too.

Robin.

> 
> Kind regards
> Uffe
> 
>>
>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>> index 25bee3daf9e2..f091280f7ffb 100644
>> --- a/drivers/mmc/core/queue.c
>> +++ b/drivers/mmc/core/queue.c
>> @@ -403,6 +403,13 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>>                  blk_queue_max_segment_size(mq->queue,
>>                          round_down(host->max_seg_size, block_size));
>>
>> +       pr_err("###### the max segment size is %d\n", queue_max_segment_size(mq->queue));
>> +       if (host->parent->dma_parms) {
>> +                      pr_err("######### the dma parms has value\n");
>> +       } else if (!(host->parent->dma_parms)) {
>> +                      pr_err("######## the dma parms is zero!!\n");
>> +       }
>> +
>>          dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
>>
>>          INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>>
>> Here is the log I got when system run, even after your patch, the dev->dma_parms is still NULL.
>> [    0.989853] mmc0: new HS400 MMC card at address 0001
>> [    0.995708] sdhci-esdhc-imx 30b50000.mmc: Got CD GPIO
>> [    0.999374] ###### the max segment size is 65024
>> [    1.008594] ######## the dma parms is zero!!
>> [    1.012875] mmcblk0: mmc0:0001 IB2932 29.2 GiB
>> [    1.017569] ###### the max segment size is 65024
>> [    1.022195] ######## the dma parms is zero!!
>> [    1.026479] mmcblk0boot0: mmc0:0001 IB2932 partition 1 4.00 MiB
>> [    1.032541] ###### the max segment size is 65024
>> [    1.035198] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
>> [    1.037169] ######## the dma parms is zero!!
>> [    1.048493] mmcblk0boot1: mmc0:0001 IB2932 partition 2 4.00 MiB
>> [    1.054531] mmcblk0rpmb: mmc0:0001 IB2932 partition 3 4.00 MiB, chardev (234:0)
>>
>>
>> Regards
>> Haibo Chen
>>> Best Regards
>>> Haibo Chen
>>>
>>>> Kind regards
>>>> Ulf Hansson
>>>>
>>>> Ulf Hansson (2):
>>>>    driver core: platform: Initialize dma_parms for platform devices
>>>>    amba: Initialize dma_parms for amba devices
>>>>
>>>>   drivers/amba/bus.c              | 2 ++
>>>>   drivers/base/platform.c         | 1 +
>>>>   include/linux/amba/bus.h        | 1 +
>>>>   include/linux/platform_device.h | 1 +
>>>>   4 files changed, 5 insertions(+)
>>>>
>>>> --
>>>> 2.20.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
