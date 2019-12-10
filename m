Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05C7118F26
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLJRjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 12:39:10 -0500
Received: from ale.deltatee.com ([207.54.116.67]:37918 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbfLJRjK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 12:39:10 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iejTY-0006ZR-AV; Tue, 10 Dec 2019 10:39:09 -0700
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl>
 <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
 <20191122052010.GO82508@vkoul-mobl>
 <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
 <CAPcyv4iOjSX=Diw3Gs0Xnpe4HmVZ0xxD_13aQcCMomqUJWr58A@mail.gmail.com>
 <dd40f8ff-62bb-648c-eb65-7e335cde6138@deltatee.com>
 <CAPcyv4gnvQsAen0DUW3o4Kv1WPW28Q00+mxBowUN8yMy6Kmgvw@mail.gmail.com>
 <3ae58ea7-5cab-23f9-512f-bec30410ff6f@intel.com>
 <20191210095327.GA2536@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <27c40d72-ab83-f2a4-7b98-55d16e602a1e@deltatee.com>
Date:   Tue, 10 Dec 2019 10:39:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210095327.GA2536@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, vkoul@kernel.org
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



On 2019-12-10 2:53 a.m., Vinod Koul wrote:
> On 22-11-19, 14:42, Dave Jiang wrote:
>>
>>
>> On 11/22/19 2:01 PM, Dan Williams wrote:
>>> On Fri, Nov 22, 2019 at 12:56 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2019-11-22 1:50 p.m., Dan Williams wrote:
>>>>> On Fri, Nov 22, 2019 at 8:53 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 11/21/19 10:20 PM, Vinod Koul wrote:
>>>>>>> On 14-11-19, 10:03, Logan Gunthorpe wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2019-11-13 9:55 p.m., Vinod Koul wrote:
>>>>>>>>>> But that's the problem. We can't expect our users to be "nice" and not
>>>>>>>>>> unbind when the driver is in use. Killing the kernel if the user
>>>>>>>>>> unexpectedly unbinds is not acceptable.
>>>>>>>>>
>>>>>>>>> And that is why we review the code and ensure this does not happen and
>>>>>>>>> behaviour is as expected
>>>>>>>>
>>>>>>>> Yes, but the current code can kill the kernel when the driver is unbound.
>>>>>>>>
>>>>>>>>>>>> I suspect this is less of an issue for most devices as they wouldn't
>>>>>>>>>>>> normally be unbound while in use (for example there's really no reason
>>>>>>>>>>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
>>>>>>>>>>>> is, the user could unbind these devices at anytime and we don't want to
>>>>>>>>>>>> panic if they do.
>>>>>>>>>>>
>>>>>>>>>>> There are many drivers which do modules so yes I am expecting unbind and
>>>>>>>>>>> even a bind following that to work
>>>>>>>>>>
>>>>>>>>>> Except they will panic if they unbind while in use, so that's a
>>>>>>>>>> questionable definition of "work".
>>>>>>>>>
>>>>>>>>> dmaengine core has module reference so while they are being used they
>>>>>>>>> won't be removed (unless I complete misread the driver core behaviour)
>>>>>>>>
>>>>>>>> Yes, as I mentioned in my other email, holding a module reference does
>>>>>>>> not prevent the driver from being unbound. Any driver can be unbound by
>>>>>>>> the user at any time without the module being removed.
>>>>>>>
>>>>>>> That sounds okay then.
>>>>>>
>>>>>> I'm actually glad Logan is putting some work in addressing this. I also
>>>>>> ran into the same issue as well dealing with unbinds on my new driver.
>>>>>
>>>>> This was an original mistake of the dmaengine implementation that
>>>>> Vinod inherited. Module pinning is distinct from preventing device
>>>>> unbind which ultimately can't be prevented. Longer term I think we
>>>>> need to audit dmaengine consumers to make sure they are prepared for
>>>>> the driver to be removed similar to how other request based drivers
>>>>> can gracefully return an error status when the device goes away rather
>>>>> than crashing.
> 
> Right finally wrapping my head of static dmaengine devices! we can
> indeed have devices going away, but me wondering why this should be
> handled in subsystems! Should the driver core not be doing this instead?
> Would it be not a safe behaviour for unplug to unload the driver and
> thus give a chance to unbind from subsystems too...

Yes, I think it should be in the core. I was just worried about breaking
older drivers. But I'll see if I can move a bit more of the logic for a
v3 series.

Thanks,

Logan
