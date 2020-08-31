Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8008B2574F3
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgHaIHi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 04:07:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:63312 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgHaIHf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 04:07:35 -0400
IronPort-SDR: r8tHsmEkoe1PPO1GFd2ok8HibGUAnccOp/P1FQuAZ8m2ThZBuCfqBc5vvc6WmZO0E6MhIyd1qu
 2WCIFJ4Mq3tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156930880"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="156930880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 01:07:34 -0700
IronPort-SDR: MiWim/TS860g5bef5EVAeDlZ5D121AhKj2ox6xZdszaQmZ3jbP8eyegM//Kg1juQhBlDVf/MG2
 QbJyMhx03R1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="501249961"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2020 01:07:33 -0700
Received: from [10.213.47.150] (mreddy3x-MOBL.gar.corp.intel.com [10.213.47.150])
        by linux.intel.com (Postfix) with ESMTP id D92D15803C5;
        Mon, 31 Aug 2020 01:07:30 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, malliamireddy009@gmail.com
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
 <bf3e4422-b023-4148-9aa6-60c4d74fe5a9@linux.intel.com>
 <3aea19e6-de96-12ba-495c-94b3b313074d@ti.com>
 <51ed096a-d211-9bab-bf1e-44f912b2a20e@linux.intel.com>
 <831fadff-8127-7634-32be-0000e69e0d94@ti.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <6a2e572e-c169-21d5-d36f-23972a24cc54@linux.intel.com>
Date:   Mon, 31 Aug 2020 16:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <831fadff-8127-7634-32be-0000e69e0d94@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/28/2020 7:17 PM, Peter Ujfalusi wrote:
> Hi,
>
> On 27/08/2020 17.41, Reddy, MallikarjunaX wrote:
>>>>>> +
>>>>>> +    dma_dev->device_alloc_chan_resources =
>>>>>> +        d->inst->ops->device_alloc_chan_resources;
>>>>>> +    dma_dev->device_free_chan_resources =
>>>>>> +        d->inst->ops->device_free_chan_resources;
>>>>>> +    dma_dev->device_terminate_all =
>>>>>> d->inst->ops->device_terminate_all;
>>>>>> +    dma_dev->device_issue_pending =
>>>>>> d->inst->ops->device_issue_pending;
>>>>>> +    dma_dev->device_tx_status = d->inst->ops->device_tx_status;
>>>>>> +    dma_dev->device_resume = d->inst->ops->device_resume;
>>>>>> +    dma_dev->device_pause = d->inst->ops->device_pause;
>>>>>> +    dma_dev->device_config = d->inst->ops->device_config;
>>>>>> +    dma_dev->device_prep_slave_sg =
>>>>>> d->inst->ops->device_prep_slave_sg;
>>>>>> +    dma_dev->device_synchronize = d->inst->ops->device_synchronize;
>>>>>> +
>>>>>> +    if (d->ver == DMA_VER22) {
>>>>>> +        dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>>>> +        dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>>>> +        dma_dev->directions = BIT(DMA_MEM_TO_DEV) |
>>>>>> +                      BIT(DMA_DEV_TO_MEM);
>>>>>> +        dma_dev->residue_granularity =
>>>>>> +                    DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>>>>>> +    }
>>>>> So, if version is != DMA_VER22, then you don't support any direction?
>>>>> Why register the DMA device if it can not do any transfer?
>>>> Only dma0 instance (intel,lgm-cdma) is used as a general purpose slave
>>>> DMA. we set both control and datapath here.
>>>> Other instances we set only control path. data path is taken care by dma
>>>> client(GSWIP).
>>> How the client (GSWIP) can request a channel from intel,lgm-* ? Don't
>>> you need some capabilities for the DMA device so core can sort out the
>>> request?
>> client request channel by name, dma_request_slave_channel(dev, name);
> clients should use dma_request_chan(dev, name);
>
> If the channel can be requested via DT or ACPI then we don't check the
> capabilities at all, so yes, that could work.
>
>>>> Only thing needs to do is get the channel, set the descriptor and just
>>>> on the channel.
>>> How do you 'on' the channel?
>> we on the channel in issue_pending.
> Right.
> Basically you only prep_slave_sg/single for the DMA_VER22? Or do you
> that for the others w/o direction support?
Yes. prep_slave_sg/single only for the DMA_VER22.
>
> For the intel,lgm-* DMAs you only call issue_pending() and probably
> terminate_all?
Yes, correct.
>
> Interesting setup ;)
>
> - Péter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
