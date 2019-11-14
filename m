Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0FFCB5A
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNRDK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 12:03:10 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34164 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfKNRDK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 Nov 2019 12:03:10 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iVIWS-0004VR-61; Thu, 14 Nov 2019 10:03:09 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
Date:   Thu, 14 Nov 2019 10:03:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114045555.GJ952516@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
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



On 2019-11-13 9:55 p.m., Vinod Koul wrote:
>> But that's the problem. We can't expect our users to be "nice" and not
>> unbind when the driver is in use. Killing the kernel if the user
>> unexpectedly unbinds is not acceptable.
> 
> And that is why we review the code and ensure this does not happen and
> behaviour is as expected

Yes, but the current code can kill the kernel when the driver is unbound.

>>>> I suspect this is less of an issue for most devices as they wouldn't
>>>> normally be unbound while in use (for example there's really no reason
>>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
>>>> is, the user could unbind these devices at anytime and we don't want to
>>>> panic if they do.
>>>
>>> There are many drivers which do modules so yes I am expecting unbind and
>>> even a bind following that to work
>>
>> Except they will panic if they unbind while in use, so that's a
>> questionable definition of "work".
> 
> dmaengine core has module reference so while they are being used they
> won't be removed (unless I complete misread the driver core behaviour)

Yes, as I mentioned in my other email, holding a module reference does
not prevent the driver from being unbound. Any driver can be unbound by
the user at any time without the module being removed.

Essentially, at any time, a user can do this:

echo 0000:83:00.4 > /sys/bus/pci/drivers/plx_dma/unbind

Which will call plx_dma_remove() regardless of whether anyone has a
reference to the module, and regardless of whether the dma channel is
currently in use. I feel it is important that drivers support this
without crashing, and my plx_dma driver does the correct thing here.

Logan

