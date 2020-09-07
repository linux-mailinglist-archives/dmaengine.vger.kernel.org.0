Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2F25F40F
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIGHcj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 03:32:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:55265 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgIGHcj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 03:32:39 -0400
IronPort-SDR: Zfn3ExIAhhKEdLvRXE3qU2CbqZ6cGy5zfeUaD+P8zmVK0PermJJl7G5rFLxv0SQBBRkKf5ZGag
 Hs7lb5qjCZKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155466886"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="155466886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 00:32:38 -0700
IronPort-SDR: 0pwMbpUPRkBd3Hey23CGZq12sE7O/saFwQ3HqGgmI/S9ogTEou1oMLMPEYM8u+PMaPWyLv2Qpj
 Y81Sc60nvU5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="285476112"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2020 00:32:38 -0700
Received: from [10.214.170.27] (mreddy3x-MOBL.gar.corp.intel.com [10.214.170.27])
        by linux.intel.com (Postfix) with ESMTP id 1D44A5805A3;
        Mon,  7 Sep 2020 00:32:34 -0700 (PDT)
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
 <6a2e572e-c169-21d5-d36f-23972a24cc54@linux.intel.com>
 <331db01b-ceea-64bd-0eff-5c75134a603b@ti.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <ce7d2dfb-c59c-3fe1-fb43-c48af59e3f7c@linux.intel.com>
Date:   Mon, 7 Sep 2020 15:32:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <331db01b-ceea-64bd-0eff-5c75134a603b@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,
Thanks for the review, please see my comment inline..

On 9/4/2020 2:31 PM, Peter Ujfalusi wrote:
>
> On 31/08/2020 11.07, Reddy, MallikarjunaX wrote:
>> On 8/28/2020 7:17 PM, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> On 27/08/2020 17.41, Reddy, MallikarjunaX wrote:
>>>>>>>> +
>>>>>>>> +    dma_dev->device_alloc_chan_resources =
>>>>>>>> +        d->inst->ops->device_alloc_chan_resources;
>>>>>>>> +    dma_dev->device_free_chan_resources =
>>>>>>>> +        d->inst->ops->device_free_chan_resources;
>>>>>>>> +    dma_dev->device_terminate_all =
>>>>>>>> d->inst->ops->device_terminate_all;
>>>>>>>> +    dma_dev->device_issue_pending =
>>>>>>>> d->inst->ops->device_issue_pending;
>>>>>>>> +    dma_dev->device_tx_status = d->inst->ops->device_tx_status;
>>>>>>>> +    dma_dev->device_resume = d->inst->ops->device_resume;
>>>>>>>> +    dma_dev->device_pause = d->inst->ops->device_pause;
>>>>>>>> +    dma_dev->device_config = d->inst->ops->device_config;
>>>>>>>> +    dma_dev->device_prep_slave_sg =
>>>>>>>> d->inst->ops->device_prep_slave_sg;
>>>>>>>> +    dma_dev->device_synchronize = d->inst->ops->device_synchronize;
>>>>>>>> +
>>>>>>>> +    if (d->ver == DMA_VER22) {
>>>>>>>> +        dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>>>>>> +        dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>>>>>> +        dma_dev->directions = BIT(DMA_MEM_TO_DEV) |
>>>>>>>> +                      BIT(DMA_DEV_TO_MEM);
>>>>>>>> +        dma_dev->residue_granularity =
>>>>>>>> +                    DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>>>>>>>> +    }
>>>>>>> So, if version is != DMA_VER22, then you don't support any direction?
>>>>>>> Why register the DMA device if it can not do any transfer?
>>>>>> Only dma0 instance (intel,lgm-cdma) is used as a general purpose slave
>>>>>> DMA. we set both control and datapath here.
>>>>>> Other instances we set only control path. data path is taken care
>>>>>> by dma
>>>>>> client(GSWIP).
>>>>> How the client (GSWIP) can request a channel from intel,lgm-* ? Don't
>>>>> you need some capabilities for the DMA device so core can sort out the
>>>>> request?
>>>> client request channel by name, dma_request_slave_channel(dev, name);
>>> clients should use dma_request_chan(dev, name);
>>>
>>> If the channel can be requested via DT or ACPI then we don't check the
>>> capabilities at all, so yes, that could work.
>>>
>>>>>> Only thing needs to do is get the channel, set the descriptor and just
>>>>>> on the channel.
>>>>> How do you 'on' the channel?
>>>> we on the channel in issue_pending.
>>> Right.
>>> Basically you only prep_slave_sg/single for the DMA_VER22? Or do you
>>> that for the others w/o direction support?
>> Yes. prep_slave_sg/single only for the DMA_VER22.
> So, you place the transfers to DMA_VER22's channel
>
>>> For the intel,lgm-* DMAs you only call issue_pending() and probably
>>> terminate_all?
>> Yes, correct.
> and issue_pending on a channel which does not have anything pending?
> How client knows which of the 'only need to be ON' channel to enable
> when it placed a transfer to another channel?
>
> How would the client driver (and the IP) would be integrated with
> different system DMA which have standard channel management?
>
> If DMA_VER22 knows which intel,lgm-* it should place the transfer then
> with virt-dma you can handle that just fine?
In the version point of view, "intel,lgm-cdma" dma instance support 
DMA_VER22. and other "intel,lgm-*" dma instances support  > DMA_VER22 .

The channels registered to kernel from "intel,lgm-cdma" dma instance 
used as a general purpose dma. The clients are SPI, ebu_nand etc..
It uses standard dmaengine calls dma_request_chan(), 
dmaengine_slave_config(), dmaengine_prep_slave_sg() & 
dma_async_issue_pending()..

and other dma instances the clients are GSWIP & CQM (Central Queue 
manager) which uses the DMA in their packet processing.
Each dma dma2tx, dma1rx, dma1tx, dma0tx and dma3 had channels 16, 8, 
16,16 and 16 respectively and these channels are used by GSWIP & CQM as 
part of
ingress(IGP) and egress(EGP) ports. and each of the dma port uses a dma 
channel. This is one to one mapping.

The GSWIP & CQM talk to the dma controller driver via dmaengine to get 
the dma channels using dma_request_slave_channel().
Configures the descriptor base address using intel_dma_chan_desc_cfg() 
which is EXPORT API from dma driver(this desc base address is the 
register address(descriptor) of the IGP/EGP), and ON the channel using 
dma_async_issue_pending.

GSWIP & CQM is highly low level register configurable/programmable take 
care about the the packet processing through the register configurations.
>
> Do you have public documentation for the DMA?
Unfortunately we dont have public documentation for this DMA IP.
>   It sounds a bit like TI's
> EDMA which is in essence is a two part  setup:
> CC: Channel Controller - to submit transfers (like your DMA_VER22)
> TC: Transfer Controller - it executes the transfers submitted by the CC
>
> One CC can be backed by multiple TCs. I don't have direct control over
> the TC (can not start/stop), it is controlled by the CC.
>
> Documentation/devicetree/bindings/dma/ti-edma.txt
>
> Or is it a different setup?
This is different setup. Explain above. Transfer control is directly 
controlled by client.
>
> - Péter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
