Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD79C61F437
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 14:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiKGNXW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 08:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKGNXV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 08:23:21 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CA31C41E;
        Mon,  7 Nov 2022 05:23:20 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A7DNFYi102192;
        Mon, 7 Nov 2022 07:23:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667827395;
        bh=jzboITK7Wb0XVXubjpJtUn2rXNJZJ9vNCV/qB95ry50=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GWEtIyZd8pK1XKxkXTBHOMWPHXNrufmgiwEbt2fsIZWuEnfOuQ5QvLuJmdgsZ1Cd1
         4+O92B6lWK0Q8j20DsIpMCT7QOcqha9wTX/oyV42hZFFHruzyF8KbsLfoWkMNughPf
         bMHAvVP+YBiPjvbEGdqyL3kiHbYifjDowknDAVAs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A7DNFm7063269
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 07:23:15 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 7 Nov
 2022 07:23:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 7 Nov 2022 07:23:15 -0600
Received: from [10.250.135.52] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A7DN9Sr059466;
        Mon, 7 Nov 2022 07:23:10 -0600
Message-ID: <4d82c447-f957-5595-e5d2-f8a0dd629921@ti.com>
Date:   Mon, 7 Nov 2022 15:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] dmaengine: k3-udma: Add system suspend/resume support
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20221103203021.83929-1-g-vlaev@ti.com>
 <be967357-6ecb-5ecf-c860-5265e1527b2a@gmail.com>
Content-Language: en-US
From:   Georgi Vlaev <g-vlaev@ti.com>
In-Reply-To: <be967357-6ecb-5ecf-c860-5265e1527b2a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 11/5/22 20:49, Péter Ujfalusi wrote:
> 
> 
> On 03/11/2022 22:30, Georgi Vlaev wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> The K3 platforms configure the DMA resources with the
>> help of the TI's System Firmware's Device Manager(DM)
>> over TISCI. The group of DMA related Resource Manager[1]
>> TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
>> This configuration however, does not persist in the DM
>> after leaving from Suspend-to-RAM state. We have to restore
>> the DMA channel configuration over TISCI for all configured
>> channels when returning from suspend.
>>
>> The TISCI resource management calls for each DMA type (UDMA,
>> PKTDMA, BCDMA) happen in device_free_chan_resources() and
>> device_alloc_chan_resources(). In pm_suspend() we store
>> the current udma_chan_config for channels that still have
>> attached clients and call device_free_chan_resources().
>> In pm_resume() restore the udma_channel_config from backup
>> and call device_alloc_chan_resources() for those channels.
>> Drivers like CPSW can do their own DMA resource management,
>> so use the late system suspend/resume hooks.
> 
> It is wrong to push the DMA context store/restore task to a client driver (cpsw or icss), it has to be done by the glue layer.
> 
> With this patch the DMAengine side of the UDMA/BCDMA/PKTDMA will support suspend/resume while the networking will remain broken, right?

The CPSW suspend/resume patch [0] releases the DMA resources in
suspend() and this one follows up in suspend_late() to deal with
what's left. The order is reversed when we resume back from suspend. 

> 
> I can not test this atm since my setup relies solely on NFS rootfs via cpsw, I might be able to check with a USB-ethernet dongle..
> 

In this case you'll probably need CPSW suspend/resume patches [0]
and apply this one on top of that sequence.

> Please do a followup for the glue layer support.
> 

Okay, will do. This may have some effect on the cpsw sequence though.

> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> 

Thanks.

[0] https://lore.kernel.org/netdev/20221104132310.31577-1-rogerq@kernel.org/

>> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> [g-vlaev@ti.com: Add patch description and config backup]
>> [g-vlaev@ti.com: Supend only channels with clients]
>> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>> ---
>> Changes:
>>
>> v2:
>> * Update the commit message
>> * Use list_for_each_entry() to iterate over the channel list.
>>
>>   drivers/dma/ti/k3-udma.c | 54 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index ce8b80bb34d7..29844044132c 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -304,6 +304,8 @@ struct udma_chan {
>>         /* Channel configuration parameters */
>>       struct udma_chan_config config;
>> +    /* Channel configuration parameters (backup) */
>> +    struct udma_chan_config backup_config;
>>         /* dmapool for packet mode descriptors */
>>       bool use_dma_pool;
>> @@ -5491,11 +5493,63 @@ static int udma_probe(struct platform_device *pdev)
>>       return ret;
>>   }
>>   +static int udma_pm_suspend(struct device *dev)
>> +{
>> +    struct udma_dev *ud = dev_get_drvdata(dev);
>> +    struct dma_device *dma_dev = &ud->ddev;
>> +    struct dma_chan *chan;
>> +    struct udma_chan *uc;
>> +
>> +    list_for_each_entry(chan, &dma_dev->channels, device_node) {
>> +        if (chan->client_count) {
>> +            uc = to_udma_chan(chan);
>> +            /* backup the channel configuration */
>> +            memcpy(&uc->backup_config, &uc->config,
>> +                   sizeof(struct udma_chan_config));
>> +            dev_dbg(dev, "Suspending channel %s\n",
>> +                dma_chan_name(chan));
>> +            ud->ddev.device_free_chan_resources(chan);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int udma_pm_resume(struct device *dev)
>> +{
>> +    struct udma_dev *ud = dev_get_drvdata(dev);
>> +    struct dma_device *dma_dev = &ud->ddev;
>> +    struct dma_chan *chan;
>> +    struct udma_chan *uc;
>> +    int ret;
>> +
>> +    list_for_each_entry(chan, &dma_dev->channels, device_node) {
>> +        if (chan->client_count) {
>> +            uc = to_udma_chan(chan);
>> +            /* restore the channel configuration */
>> +            memcpy(&uc->config, &uc->backup_config,
>> +                   sizeof(struct udma_chan_config));
>> +            dev_dbg(dev, "Resuming channel %s\n",
>> +                dma_chan_name(chan));
>> +            ret = ud->ddev.device_alloc_chan_resources(chan);
>> +            if (ret)
>> +                return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops udma_pm_ops = {
>> +    SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
>> +};
>> +
>>   static struct platform_driver udma_driver = {
>>       .driver = {
>>           .name    = "ti-udma",
>>           .of_match_table = udma_of_match,
>>           .suppress_bind_attrs = true,
>> +        .pm = &udma_pm_ops,
>>       },
>>       .probe        = udma_probe,
>>   };
>>
>> base-commit: 81214a573d19ae2fa5b528286ba23cd1cb17feec
> 

-- 
Regards,
Georgi
