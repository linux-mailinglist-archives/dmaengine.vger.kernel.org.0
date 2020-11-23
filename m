Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643B62C1064
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 17:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgKWQaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Nov 2020 11:30:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:64668 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbgKWQ37 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Nov 2020 11:29:59 -0500
IronPort-SDR: GQJbhIJXVvWTWdlfVDbu7Kn9QV9J2chki3MhHuJQwUOR63wQiOR8b9yDMfpfx82hKDi79VBtsT
 QBKbCW1ICPUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159564429"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="159564429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 08:29:57 -0800
IronPort-SDR: bmT4DAEcfMXLYMDchubGv+etGp7J+9wPFvVZiPUJmlzSY6Yq/05tYfjyjJIrHBB/N/BfANLGaZ
 mhrRA6t1Cnxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="370097202"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2020 08:29:55 -0800
Received: from [10.213.137.103] (mreddy3x-MOBL.gar.corp.intel.com [10.213.137.103])
        by linux.intel.com (Postfix) with ESMTP id E8F8A580638;
        Mon, 23 Nov 2020 08:29:52 -0800 (PST)
Subject: Re: [PATCH v9 2/2] Add Intel LGM SoC DMA support.
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <67be905aa3bcb9faac424f2a134e88d076700419.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <20201118173840.GW50232@vkoul-mobl>
 <a4ea240f-b121-5bc9-a046-95bbcff87553@linux.intel.com>
 <20201121121701.GB8403@vkoul-mobl>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <dc8c5f27-bce6-d276-af0b-93c6e63e85a1@linux.intel.com>
Date:   Tue, 24 Nov 2020 00:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201121121701.GB8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for your valuable review comments. Please see my comments inline.

On 11/21/2020 8:17 PM, Vinod Koul wrote:
> On 20-11-20, 19:30, Reddy, MallikarjunaX wrote:
>> Hi Vinod,
>>
>> Thanks for the review. My comments inline.
>>
>> On 11/19/2020 1:38 AM, Vinod Koul wrote:
>>> On 12-11-20, 13:38, Amireddy Mallikarjuna reddy wrote:
>>>> Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
>>>>
>>>> The main function of the DMA controller is the transfer of data from/to any
>>>> peripheral to/from the memory. A memory to memory copy capability can also
>>>> be configured.
>>>>
>>>> This ldma driver is used for configure the device and channnels for data
>>>> and control paths.
>>>>
>>>> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
>>>> ---
>>>> v1:
>>>> - Initial version.
>>> You have a cover letter, use that to keep track of these changes
>> ok.
>>>> +++ b/drivers/dma/lgm/Kconfig
>>>> @@ -0,0 +1,9 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +config INTEL_LDMA
>>>> +	bool "Lightning Mountain centralized low speed DMA and high speed DMA controllers"
>>> Do we have any other speeds :D
>> No other speeds :-)
> Right, so possibly drop the speed characterization here!
"Lightning Mountain centralized DMA controller"
>
>>>> +++ b/drivers/dma/lgm/lgm-dma.c
>>>> @@ -0,0 +1,1742 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Lightning Mountain centralized low speed and high speed DMA controller driver
>>>> + *
>>>> + * Copyright (c) 2016 ~ 2020 Intel Corporation.
>>> I think you mean 2016 - 2020, a dash which refers to duration
>> ok.
>>>> +struct dw2_desc {
>>>> +	struct {
>>>> +		u32 len		:16;
>>>> +		u32 res0	:7;
>>>> +		u32 bofs	:2;
>>>> +		u32 res1	:3;
>>>> +		u32 eop		:1;
>>>> +		u32 sop		:1;
>>>> +		u32 c		:1;
>>>> +		u32 own		:1;
>>>> +	} __packed field;
>>> Another one, looks like folks adding dmaengine patches love this
>>> approach, second one for the day..
>>>
>>> Now why do you need the bit fields, why not use register defines and
>>> helpers in bitfield.h to help configure the fields See FIELD_GET,
>>> FIELD_PREP etc
>> Let me check on this...
>>>> +struct dma_dev_ops {
>>>> +	int (*device_alloc_chan_resources)(struct dma_chan *chan);
>>>> +	void (*device_free_chan_resources)(struct dma_chan *chan);
>>>> +	int (*device_config)(struct dma_chan *chan,
>>>> +			     struct dma_slave_config *config);
>>>> +	int (*device_pause)(struct dma_chan *chan);
>>>> +	int (*device_resume)(struct dma_chan *chan);
>>>> +	int (*device_terminate_all)(struct dma_chan *chan);
>>>> +	void (*device_synchronize)(struct dma_chan *chan);
>>>> +	enum dma_status (*device_tx_status)(struct dma_chan *chan,
>>>> +					    dma_cookie_t cookie,
>>>> +					    struct dma_tx_state *txstate);
>>>> +	struct dma_async_tx_descriptor *(*device_prep_slave_sg)
>>>> +		(struct dma_chan *chan, struct scatterlist *sgl,
>>>> +		unsigned int sg_len, enum dma_transfer_direction direction,
>>>> +		unsigned long flags, void *context);
>>>> +	void (*device_issue_pending)(struct dma_chan *chan);
>>>> +};
>>> Heh! why do you have a copy of dmaengine ops here?
>> Ok, i will remove the ops and update the code accordingly.
>>>> +static int ldma_chan_desc_cfg(struct ldma_chan *c, dma_addr_t desc_base,
>>>> +			      int desc_num)
>>>> +{
>>>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +
>>>> +	if (!desc_num) {
>>>> +		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
>>>> +			c->nr);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (desc_num > DMA_MAX_DESC_NUM) {
>>>> +		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
>>>> +			c->nr, desc_num);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
>>>> +
>>>> +	c->flags |= DMA_HW_DESC;
>>>> +	c->desc_cnt = desc_num;
>>>> +	c->desc_phys = desc_base;
>>> So you have a custom API which is used to configure this flag, a number
>>> and an address. The question is why, can you please help explain this?
>> LDMA used as general purpose dma(ver == DMA_VER22) and also supports DMA
>> capability for GSWIP in their network packet processing.( ver > DMA_VER22)
> Whats GSWIP?
>
>> Each Ingress(IGP) & Egress(EGP) ports of CQM use a dma channel.
> CQM?
GSWIP stands for  Gigabit Switch IP, and CQM is Central Queue Manager.

GSWIP & CQM are the clients for the DMA. These are used in networking 
purpose to increase transfer rates for peripheral like the GSWIP LAN switch.
>
>> desc needs to be configure for each dma channel and the remapped address of
>> the IGP & EGP is desc base adress.
> Why should this address not passed as src_addr/dst_addr?
src_addr/dst_addr is the data pointer. Data pointer indicates address 
pointer of data buffer.

ldma_chan_desc_cfg() carries the descriptor address.

The descriptor list entry contains the data pointer, which points to the 
data section in the memory.

So we should not use src_addr/dst_addr as desc base address.
>
>> CQM client is using ldma_chan_desc_cfg() to configure the descriptior.
>>>> +static void dma_issue_pending(struct dma_chan *chan)
>>>> +{
>>>> +	struct ldma_chan *c = to_ldma_chan(chan);
>>>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +	unsigned long flags;
>>>> +
>>>> +	if (d->ver == DMA_VER22) {
>>> why is this specific to this version?
>> Only dma0 instance (ver == DMA_VER22) is used as a general purpose slave
>> DMA. we set both control and datapath here.
>> Other instances (ver > DMA_VER22) we set only control path. data path is
>> taken care by dma client(GSWIP).
>> Only thing needs to do is get the channel, set the descriptor and just 'ON'
>> the channel.
>>
>> CQM is highly low level register configurable/programmable take care about
>> the the packet processing through the register configurations.
> DMAengine fwk take care of channel management for clients and
> transaction management, if you not going to do transactions then why
> bother with dmaengine ?
dma0 instance (ver == DMA_VER22) uses DMAengine framework for both 
channel management and transaction management.

Other instances (ver > DMA_VER22) uses DMAengine mainly for channel 
management.
To initiate the transaction client needs to ON the corresponding 
channel, So dmaengine ops are using to 'ON'  and 'OFF' the channels.
