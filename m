Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07121079AE
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVU4T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 15:56:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60378 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVU4S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 15:56:18 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iYFyR-00036v-Tt; Fri, 22 Nov 2019 13:56:17 -0700
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl>
 <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
 <20191122052010.GO82508@vkoul-mobl>
 <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
 <CAPcyv4iOjSX=Diw3Gs0Xnpe4HmVZ0xxD_13aQcCMomqUJWr58A@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dd40f8ff-62bb-648c-eb65-7e335cde6138@deltatee.com>
Date:   Fri, 22 Nov 2019 13:56:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iOjSX=Diw3Gs0Xnpe4HmVZ0xxD_13aQcCMomqUJWr58A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-11-22 1:50 p.m., Dan Williams wrote:
> On Fri, Nov 22, 2019 at 8:53 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 11/21/19 10:20 PM, Vinod Koul wrote:
>>> On 14-11-19, 10:03, Logan Gunthorpe wrote:
>>>>
>>>>
>>>> On 2019-11-13 9:55 p.m., Vinod Koul wrote:
>>>>>> But that's the problem. We can't expect our users to be "nice" and not
>>>>>> unbind when the driver is in use. Killing the kernel if the user
>>>>>> unexpectedly unbinds is not acceptable.
>>>>>
>>>>> And that is why we review the code and ensure this does not happen and
>>>>> behaviour is as expected
>>>>
>>>> Yes, but the current code can kill the kernel when the driver is unbound.
>>>>
>>>>>>>> I suspect this is less of an issue for most devices as they wouldn't
>>>>>>>> normally be unbound while in use (for example there's really no reason
>>>>>>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
>>>>>>>> is, the user could unbind these devices at anytime and we don't want to
>>>>>>>> panic if they do.
>>>>>>>
>>>>>>> There are many drivers which do modules so yes I am expecting unbind and
>>>>>>> even a bind following that to work
>>>>>>
>>>>>> Except they will panic if they unbind while in use, so that's a
>>>>>> questionable definition of "work".
>>>>>
>>>>> dmaengine core has module reference so while they are being used they
>>>>> won't be removed (unless I complete misread the driver core behaviour)
>>>>
>>>> Yes, as I mentioned in my other email, holding a module reference does
>>>> not prevent the driver from being unbound. Any driver can be unbound by
>>>> the user at any time without the module being removed.
>>>
>>> That sounds okay then.
>>
>> I'm actually glad Logan is putting some work in addressing this. I also
>> ran into the same issue as well dealing with unbinds on my new driver.
> 
> This was an original mistake of the dmaengine implementation that
> Vinod inherited. Module pinning is distinct from preventing device
> unbind which ultimately can't be prevented. Longer term I think we
> need to audit dmaengine consumers to make sure they are prepared for
> the driver to be removed similar to how other request based drivers
> can gracefully return an error status when the device goes away rather
> than crashing.

Yes, but that will be a big project because there are a lot of drivers.
But I think the dmaengine common code needs to support removal properly,
which essentially means changing how all the drivers allocate and free
their structures, among other things.

The one saving grace is that most of the drivers are for SOCs which
can't be physically removed and there's really no use-case for the user
to call unbind.

Logan

