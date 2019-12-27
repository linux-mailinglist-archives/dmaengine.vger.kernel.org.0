Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C114912B0ED
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 05:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfL0EQ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Dec 2019 23:16:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbfL0EQ6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Dec 2019 23:16:58 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DABC8C47F161E11503F3;
        Fri, 27 Dec 2019 12:16:55 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Dec 2019
 12:16:46 +0800
Subject: Re: [PATCH v2] dmaengine: hisilicon: Add Kunpeng DMA engine support
To:     Vinod Koul <vkoul@kernel.org>
References: <1575943997-164744-1-git-send-email-wangzhou1@hisilicon.com>
 <20191211105234.GG2536@vkoul-mobl> <5DF0D666.6060908@hisilicon.com>
 <20191211165458.GJ2536@vkoul-mobl>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E0585AE.3000405@hisilicon.com>
Date:   Fri, 27 Dec 2019 12:16:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191211165458.GJ2536@vkoul-mobl>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019/12/12 0:54, Vinod Koul wrote:
> On 11-12-19, 19:43, Zhou Wang wrote:
>> On 2019/12/11 18:52, Vinod Koul wrote:
>>> On 10-12-19, 10:13, Zhou Wang wrote:
> 
>>>> +static int hisi_dma_terminate_all(struct dma_chan *c)
>>>> +{
>>>> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
>>>> +	unsigned long flags;
>>>> +	LIST_HEAD(head);
>>>> +
>>>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>>>> +
>>>> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, true);
>>>> +	if (chan->desc) {
>>>> +		vchan_terminate_vdesc(&chan->desc->vd);
>>>> +		chan->desc = NULL;
>>>> +	}
>>>> +
>>>> +	vchan_get_all_descriptors(&chan->vc, &head);
>>>> +
>>>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>>>> +
>>>> +	vchan_dma_desc_free_list(&chan->vc, &head);
>>>> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, false);
>>>
>>> pause on terminate? Not DISABLE?
>>
>> here this function just aborts transfers on specific channel.
> 
> yeah and I would expect the channel to go into disable state right!
> 
>>>> +static struct pci_driver hisi_dma_pci_driver = {
>>>> +	.name		= "hisi_dma",
>>>> +	.id_table	= hisi_dma_pci_tbl,
>>>> +	.probe		= hisi_dma_probe,
>>>
>>> no .remove and kconfig has a tristate option!
>>
>> Use devres APIs in probe, so seems nothing should be done in remove :)
> 
> who will de-register from dmaengine, you have dangiling chan_tasklet
> which needs to be killed and you have isr which is still enabled, yeah
> what could go wrong!

I missed to do tasklet_kill when disabling qps. And also missed to do
pci_free_irq_vectors, which seems can be done by adding a devres callback
by devm_add_action_or_reset.

Here we use devres API to register to dmaengine, so no need to de-register
from it.

Thanks!
Zhou

> 
> Please, deregister from dmaengine, kill the vchan tasklet and make sur
> irq is disabled and tasklets killed
> 

