Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C64F95EB
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKLQpP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 11:45:15 -0500
Received: from ale.deltatee.com ([207.54.116.67]:45114 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLQpP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 11:45:15 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iUZHv-0006ul-FF; Tue, 12 Nov 2019 09:45:13 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
Date:   Tue, 12 Nov 2019 09:45:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112055540.GY952516@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-11-11 10:56 p.m., Vinod Koul wrote:
> On 11-11-19, 09:50, Logan Gunthorpe wrote:
>>
>>
>> On 2019-11-09 10:18 a.m., Vinod Koul wrote:
>>> Hi Logan,
>>>
>>> Sorry for delay in reply!
>>>
>>> On 22-10-19, 15:46, Logan Gunthorpe wrote:
>>>> dma_chan_to_owner() dereferences the driver from the struct device to
>>>> obtain the owner and call module_[get|put](). However, if the backing
>>>> device is unbound before the dma_device is unregistered, the driver
>>>> will be cleared and this will cause a NULL pointer dereference.
>>>
>>> Have you been able to repro this? If so how..?
>>>
>>> The expectation is that the driver shall unregister before removed.
>>
>> Yes, with my new driver, if I do a PCI unbind (which unregisters) while
>> the DMA engine is in use, it panics. The point is the underlying driver
>> can go away before the channel is removed.
> 
> and in your driver remove you do not unregister? When unbind is invoked
> the driver remove is invoked by core and you should unregister whatever
> you have registered in your probe!
>
> Said that, if someone is using the dmaengine at that point of time, it
> is not a nice thing to do and can cause issues, but on idle it should
> just work!

But that's the problem. We can't expect our users to be "nice" and not
unbind when the driver is in use. Killing the kernel if the user
unexpectedly unbinds is not acceptable.

>> I suspect this is less of an issue for most devices as they wouldn't
>> normally be unbound while in use (for example there's really no reason
>> to ever unbind IOAT seeing it's built into the system). Though, the fact
>> is, the user could unbind these devices at anytime and we don't want to
>> panic if they do.
> 
> There are many drivers which do modules so yes I am expecting unbind and
> even a bind following that to work

Except they will panic if they unbind while in use, so that's a
questionable definition of "work".

Logan

