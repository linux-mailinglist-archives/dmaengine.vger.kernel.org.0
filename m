Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A64F7A38
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKRuU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 12:50:20 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42502 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfKKRuU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 12:50:20 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iUDpR-0000Z8-Ls; Mon, 11 Nov 2019 10:50:19 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-4-logang@deltatee.com>
 <20191109173510.GG952516@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ff43b1f9-c620-17eb-fc6c-4c7d7577250b@deltatee.com>
Date:   Mon, 11 Nov 2019 10:50:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191109173510.GG952516@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,LR_URI_NUMERIC_ENDING,MYRULES_FREE autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 3/5] dmaengine: plx-dma: Introduce PLX DMA engine PCI
 driver skeleton
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-11-09 10:35 a.m., Vinod Koul wrote:
> On 22-10-19, 15:46, Logan Gunthorpe wrote:
>> +static irqreturn_t plx_dma_isr(int irq, void *devid)
>> +{
>> +	return IRQ_HANDLED;
> 
> ??

Yes, sorry this is more of an artifact of how I chose to split the
patches up. The ISR is filled-in in patch 4.


>> +	 */
>> +	schedule_work(&plxdev->release_work);
>> +}
>> +
>> +static void plx_dma_put(struct plx_dma_dev *plxdev)
>> +{
>> +	kref_put(&plxdev->ref, plx_dma_release);
>> +}
>> +
>> +static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
>> +
>> +	kref_get(&plxdev->ref);
> 
> why do you need to do this?

This has to do with being able to probably unbind while a channel is in
use. If we don't hold a reference to the struct plx_dma_dev between
alloc_chan_resources() and free_chan_resources() then it will panic if a
call back is called after plx_dma_remove(). The way I've done it, once a
device is removed, subsequent calls to dma_prep_memcpy() will fail (see
ring_active).

struct plx_dma_dev needs to be alive between plx_dma_probe() and
plx_dma_remove(), and between calls to alloc_chan_resources() and
free_chan_resources(). So we use a reference count to ensure this.

>> +}
>> +
>> +static void plx_dma_release_work(struct work_struct *work)
>> +{
>> +	struct plx_dma_dev *plxdev = container_of(work, struct plx_dma_dev,
>> +						  release_work);
>> +
>> +	dma_async_device_unregister(&plxdev->dma_dev);
>> +	put_device(plxdev->dma_dev.dev);
>> +	kfree(plxdev);
>> +}
>> +
>> +static void plx_dma_release(struct kref *ref)
>> +{
>> +	struct plx_dma_dev *plxdev = container_of(ref, struct plx_dma_dev, ref);
>> +
>> +	/*
>> +	 * The dmaengine reference counting and locking is a bit of a
>> +	 * mess so we have to work around it a bit here. We might put
>> +	 * the reference while the dmaengine holds the dma_list_mutex
>> +	 * which means we can't call dma_async_device_unregister() directly
>> +	 * here and it must be delayed.
>
> why is that, i have not heard any complaints about locking, can you
> elaborate on why you need to do this?

Per the above explanation, we need to call plx_dma_put() in
plx_dma_free_chan_resources(); and plx_dma_release() is when we can call
dma_async_device_unregister() (seeing that's when we know there are no
longer any active channels).

However, dma_chan_put() (which calls device_free_chan_resources()) holds
the dma_list_mutex and dma_async_device_unregister() tries to take the
dma_list_mutex so, if we call unregister inside free_chan_resources we
would deadlock.

I suspect that most dmaengine drivers will WARN[1] and then panic if
they are unbound while in use. The locking, reference counting and
structure of the API didn't seem to consider it and required extra
reference counts and workarounds to make it work correctly at all.

This is the mess I'm referring to and would require some significant
restructuring to fix generally.

Logan

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/dma/dmaengine.c#L1119


