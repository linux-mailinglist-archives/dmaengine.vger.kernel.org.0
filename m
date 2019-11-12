Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2ADF9702
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 18:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLRWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 12:22:53 -0500
Received: from ale.deltatee.com ([207.54.116.67]:45646 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfKLRWw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 12:22:52 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iUZsP-0007eS-RN; Tue, 12 Nov 2019 10:22:51 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-4-logang@deltatee.com>
 <20191109173510.GG952516@vkoul-mobl>
 <ff43b1f9-c620-17eb-fc6c-4c7d7577250b@deltatee.com>
 <20191112060919.GZ952516@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fc86a9de-a816-4bea-081e-bd106b945dbe@deltatee.com>
Date:   Tue, 12 Nov 2019 10:22:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112060919.GZ952516@vkoul-mobl>
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
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-11-11 11:09 p.m., Vinod Koul wrote:
> On 11-11-19, 10:50, Logan Gunthorpe wrote:
>>
>>
>> On 2019-11-09 10:35 a.m., Vinod Koul wrote:
>>> On 22-10-19, 15:46, Logan Gunthorpe wrote:
>>>> +static irqreturn_t plx_dma_isr(int irq, void *devid)
>>>> +{
>>>> +	return IRQ_HANDLED;
>>>
>>> ??
>>
>> Yes, sorry this is more of an artifact of how I chose to split the
>> patches up. The ISR is filled-in in patch 4.
> 
> lets move this code in all including isr registration in patch 4 then :)

Ok, I'll rework that for the next submission.

>>>> +	 */
>>>> +	schedule_work(&plxdev->release_work);
>>>> +}
>>>> +
>>>> +static void plx_dma_put(struct plx_dma_dev *plxdev)
>>>> +{
>>>> +	kref_put(&plxdev->ref, plx_dma_release);
>>>> +}
>>>> +
>>>> +static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
>>>> +
>>>> +	kref_get(&plxdev->ref);
>>>
>>> why do you need to do this?
>>
>> This has to do with being able to probably unbind while a channel is in
>> use. If we don't hold a reference to the struct plx_dma_dev between
>> alloc_chan_resources() and free_chan_resources() then it will panic if a
>> call back is called after plx_dma_remove(). The way I've done it, once a
> 
> which callback?

Any callback that tries to obtain the free'd plx_dma_dev structure. (So
plx_dma_free_chan_resources(), plx_dma_prep_memcpy(),
plx_dma_issue_pending(), plx_dma_tx_status()).

>> device is removed, subsequent calls to dma_prep_memcpy() will fail (see
>> ring_active).
>>
>> struct plx_dma_dev needs to be alive between plx_dma_probe() and
>> plx_dma_remove(), and between calls to alloc_chan_resources() and
>> free_chan_resources(). So we use a reference count to ensure this.
> 
> and that is why we hold module reference so we don't go away without
> cleanup

No, that's wrong. The module reference will prevent the module and the
functions within it from going away. It doesn't prevent the driver from
being unbound which normally causes the devices' structure from being
freed. Most drivers will free the structure containing the DMA engine on
the remove() call, so even if the module is still around, its functions
will still be called with a freed pointer. We're taking a reference on
the pointer to ensure it's not freed while dmaengine users still have a
reference to it.

>>>> +static void plx_dma_release_work(struct work_struct *work)
>>>> +{
>>>> +	struct plx_dma_dev *plxdev = container_of(work, struct plx_dma_dev,
>>>> +						  release_work);
>>>> +
>>>> +	dma_async_device_unregister(&plxdev->dma_dev);
>>>> +	put_device(plxdev->dma_dev.dev);
>>>> +	kfree(plxdev);
>>>> +}
>>>> +
>>>> +static void plx_dma_release(struct kref *ref)
>>>> +{
>>>> +	struct plx_dma_dev *plxdev = container_of(ref, struct plx_dma_dev, ref);
>>>> +
>>>> +	/*
>>>> +	 * The dmaengine reference counting and locking is a bit of a
>>>> +	 * mess so we have to work around it a bit here. We might put
>>>> +	 * the reference while the dmaengine holds the dma_list_mutex
>>>> +	 * which means we can't call dma_async_device_unregister() directly
>>>> +	 * here and it must be delayed.
>>>
>>> why is that, i have not heard any complaints about locking, can you
>>> elaborate on why you need to do this?
>>
>> Per the above explanation, we need to call plx_dma_put() in
>> plx_dma_free_chan_resources(); and plx_dma_release() is when we can call
>> dma_async_device_unregister() (seeing that's when we know there are no
>> longer any active channels).
>>
>> However, dma_chan_put() (which calls device_free_chan_resources()) holds
>> the dma_list_mutex and dma_async_device_unregister() tries to take the
>> dma_list_mutex so, if we call unregister inside free_chan_resources we
>> would deadlock.
> 
> yes as we are not expecting someone to unregister in
> device_free_chan_resources(), that is for freeing up resources.
> 
> You are expected to unregister in .remove!
> 
> Can you explain me why unregister cant be done in remove? I think I am
> still missing some detail for this case.

Because, if the user unbinds while there's a client of the dma channel,
then it panics the kernel. First there's the warning[1] I pointed out
previously, then the DMA channel users will cause a use after free
exception when they continue unaware that the memory they are using has
been freed.

For an example from a random driver:

1) owl_dma_probe() allocates it's struct owl_dma with devm_kzalloc()
2) Another driver calls dma_find_channel() and obtains a reference to
one of the channels
3) Asynchronously, the user unbinds the owl_dma driver using the sysfs
interface
4) owl_dma_remove() is called which calls dma_async_device_unregister()
which produces a WARN_ON because a channel is in use
5) The devm stack for this driver instance unwinds and the struct
owl_dma is freed
6) The client driver then calls dmaengine_prep_dma_memcpy() which calls
owl_dma_prep_memcpy(). The first thing that driver does is convert the
now invalid channel reference to an invalid struct owl_dma reference and
shortly thereafter dereferences the now freed memory. If KASAN is
enabled, the user will get a big use after free bug panic. If not, the
driver will read and write memory that may be used by some other random
process eventually causing other random fatal errors in the system. The
best case scenario is the process that allocates the already freed
memory zeros it, and thus the client driver would panic on a NULL
pointer dereference.

I think this is unacceptable for a driver to have happen and that's why
I wrote the plx driver such that it is not possible. This is especially
important for the PLX driver because it is a PCI device which can be
hotplugged so users may actually be randomly trying to unbind it.

Logan


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/dma/dmaengine.c#L1119
