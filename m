Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32A107606
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVQxY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 11:53:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:27190 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKVQxY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 11:53:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="205519460"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2019 08:53:23 -0800
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
To:     Vinod Koul <vkoul@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl>
 <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
 <20191122052010.GO82508@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
Date:   Fri, 22 Nov 2019 09:53:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122052010.GO82508@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/21/19 10:20 PM, Vinod Koul wrote:
> On 14-11-19, 10:03, Logan Gunthorpe wrote:
>>
>>
>> On 2019-11-13 9:55 p.m., Vinod Koul wrote:
>>>> But that's the problem. We can't expect our users to be "nice" and not
>>>> unbind when the driver is in use. Killing the kernel if the user
>>>> unexpectedly unbinds is not acceptable.
>>>
>>> And that is why we review the code and ensure this does not happen and
>>> behaviour is as expected
>>
>> Yes, but the current code can kill the kernel when the driver is unbound.
>>
>>>>>> I suspect this is less of an issue for most devices as they wouldn't
>>>>>> normally be unbound while in use (for example there's really no reason
>>>>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
>>>>>> is, the user could unbind these devices at anytime and we don't want to
>>>>>> panic if they do.
>>>>>
>>>>> There are many drivers which do modules so yes I am expecting unbind and
>>>>> even a bind following that to work
>>>>
>>>> Except they will panic if they unbind while in use, so that's a
>>>> questionable definition of "work".
>>>
>>> dmaengine core has module reference so while they are being used they
>>> won't be removed (unless I complete misread the driver core behaviour)
>>
>> Yes, as I mentioned in my other email, holding a module reference does
>> not prevent the driver from being unbound. Any driver can be unbound by
>> the user at any time without the module being removed.
> 
> That sounds okay then.

I'm actually glad Logan is putting some work in addressing this. I also 
ran into the same issue as well dealing with unbinds on my new driver.

>>
>> Essentially, at any time, a user can do this:
>>
>> echo 0000:83:00.4 > /sys/bus/pci/drivers/plx_dma/unbind
>>
>> Which will call plx_dma_remove() regardless of whether anyone has a
>> reference to the module, and regardless of whether the dma channel is
>> currently in use. I feel it is important that drivers support this
>> without crashing, and my plx_dma driver does the correct thing here.
>>
>> Logan
> 
