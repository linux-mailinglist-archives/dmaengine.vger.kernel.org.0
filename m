Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5B2C7E2C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Nov 2020 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgK3GW2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Nov 2020 01:22:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:54715 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgK3GW1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Nov 2020 01:22:27 -0500
IronPort-SDR: 2VSjGSOs/S2KyzIfmfjFoLpDD9my70Slsi5Rwdu2yX77N5+QbTwrTUpimfuOoSs8S2V8zhjg8k
 nL8jiyp6T9Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="152420868"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="152420868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 22:20:46 -0800
IronPort-SDR: Krr3AKvXUs6qVabHOv/HaoRzR7w2qTJsFvdlnWhM04sWM4Jo9AVdwY2UiUjIzukiSF1COyQXA6
 1NR05iQ6DQjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="314458633"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2020 22:20:46 -0800
Received: from [10.215.249.62] (mreddy3x-MOBL.gar.corp.intel.com [10.215.249.62])
        by linux.intel.com (Postfix) with ESMTP id 74B8A580515;
        Sun, 29 Nov 2020 22:20:43 -0800 (PST)
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
 <dc8c5f27-bce6-d276-af0b-93c6e63e85a1@linux.intel.com>
 <20201124172149.GT8403@vkoul-mobl>
 <ee275d37-5dda-205a-a897-7a61ad13b536@linux.intel.com>
 <20201126045035.GI8403@vkoul-mobl>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <1900dc8f-acd1-54a2-1666-cd73bdc4888b@linux.intel.com>
Date:   Mon, 30 Nov 2020 14:20:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126045035.GI8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for your valuable comments. My reply inline.

On 11/26/2020 12:50 PM, Vinod Koul wrote:
> On 25-11-20, 18:39, Reddy, MallikarjunaX wrote:
>
>>>>>> desc needs to be configure for each dma channel and the remapped address of
>>>>>> the IGP & EGP is desc base adress.
>>>>> Why should this address not passed as src_addr/dst_addr?
>>>> src_addr/dst_addr is the data pointer. Data pointer indicates address
>>>> pointer of data buffer.
>>>>
>>>> ldma_chan_desc_cfg() carries the descriptor address.
>>>>
>>>> The descriptor list entry contains the data pointer, which points to the
>>>> data section in the memory.
>>>>
>>>> So we should not use src_addr/dst_addr as desc base address.
>>> Okay sounds reasonable. why is this using in API here?
>> descriptor base address needs to be write into the dma register (DMA_CDBA).
> Why cant descriptor be allocated by damenegine driver, passed to client
> as we normally do in prep_* callbacks ? Why do you need a custom API
1)
client needs to set the descriptor base address and also number of 
descriptors used in the descriptor list.
reg DMA_CDBA used to configure descriptor base address and reg DMA_CDLEN 
used to configure number of descriptors used in the descriptor list.

In case of (ver > DMA_VER22) all descriptor fields and data pointer will 
be set by client, so we just need to write desc base and num desc length 
in to corresponding registers from the driver side.

dma_async_tx_descriptor * data is not really needed from driver to 
client side , so i am not planned to return 'struct 
dma_async_tx_descriptor *'.

because of this reason i used custom API (return -Ve for error and ZERO 
for success) instead of standard dmaengine_prep_slave_sg() callback 
(return 'struct dma_async_tx_descriptor *' descriptor)

2)
We can also use the dmaengine_prep_slave_sg( ) to pass desc base addr & 
desc number from client.
In that case we have to use (sg)->dma_address as desc base address and 
(sg)->length as desc length.

dmaengine prep_* callback return 'struct dma_async_tx_descriptor *, this 
can be used on client side as to check  prep_* callback SUCCESS/FAIL.

Example:
/* code snippet */

static struct dma_async_tx_descriptor *
ldma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
                   unsigned int sglen, enum dma_transfer_direction dir,
                   unsigned long flags, void *context)
{

.....

     if (d->ver > DMA_VER22)
         return ldma_chan_desc_cfg(chan, sgl->dma_address, sglen);

.....

}

static struct dma_async_tx_descriptor *
ldma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base, int 
desc_num)
{
         struct ldma_chan *c = to_ldma_chan(chan);
         struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
         struct dma_async_tx_descriptor *tx;
         struct dw2_desc_sw *ds;

         if (!desc_num) {
                 dev_err(d->dev, "Channel %d must allocate descriptor 
first\n",
                         c->nr);
                 return NULL;
         }

         if (desc_num > DMA_MAX_DESC_NUM) {
                 dev_err(d->dev, "Channel %d descriptor number out of 
range %d\n",
                         c->nr, desc_num);
                 return NULL;
         }

         ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
         c->flags |= DMA_HW_DESC;
         c->desc_cnt = desc_num;
         c->desc_phys = desc_base;

         ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
         if (!ds)
                 return NULL;

         tx = &ds->vdesc.tx;
         dma_async_tx_descriptor_init(tx, chan);

         return tx;
}
Please let me know if this is OK, So that i will include in the next patch.
>
