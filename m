Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E804153036
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 12:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgBEL4H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 06:56:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56552 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgBEL4H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Feb 2020 06:56:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 015Bu2j0066397;
        Wed, 5 Feb 2020 05:56:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580903762;
        bh=MzDdnrxT/BvH2/pPYp/wBeBVfNcyUV9BruulfG+NqZw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bR9HsZVaFlZBSMj2+XFqJs+7my2X6Fmup+7CfVNyFpsG1V/+EhERc3f+r/VtpDNPf
         q9ZhhKYBGxUavdOsVpqJfLomhjV8q7EptOqZNGd6qqdX9cIACbnnUP9Q6D4JiI/r/t
         V8C7wtD/keOb1S9e1yLdAcyaKZtNBxMVDdUB2pFw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015Bu289010787;
        Wed, 5 Feb 2020 05:56:02 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 05:56:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 05:56:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015Bu05D006074;
        Wed, 5 Feb 2020 05:56:01 -0600
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Vinod Koul <vkoul@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <20200204062118.GS2841@vkoul-mobl>
 <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
 <20200205044352.GC2618@vkoul-mobl>
 <13dcf3d9-06ca-d793-525d-12f6d7cd27c1@ti.com>
 <20200205113155.GE2618@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7b8d9ab2-1734-d54b-ab6e-b620866ce0ce@ti.com>
Date:   Wed, 5 Feb 2020 13:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205113155.GE2618@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 05/02/2020 13.31, Vinod Koul wrote:
>> Looking at the commit which added it and I still don't get the point.
>> If any of the channel is in use then we should not allow the DMA driver
>> to go away at all.
> 
> Not really, if the device is already gone, we cant do much about it. We
> have to handle that gracefully rather than oopsing

Ah, I have not thought about that. True.

> The important part is that the device is gone. Think about a device on
> PCI card which is yanked off or a USB device unplugged. Device is
> already gone, you can't communicate with it anymore. So all we can do is
> handle the condition and exit, hence the new method to let driver know.

But for most devices this is not applicable, I also wondered what should
I do in order to silence the print. Just add an empty device_release?

>> Imho there should be a function to check if we can proceed with the
>> .remove of the driver and fail it if any of the channels are in use.
>>
>> Hrm, base/dd.c __device_release_driver() does not check the .remove's
>> return value, so it can not fail.
>>
>> What is expected if the .remove returns with OK but we still have
>> channels in use?
>>
>> After the remove all sorts of things got yanked which might makes the
>> still in use channels cause issues down the road.
>>
>> I'm curious why it is a good thing to remotely try to support unbind
>> when the driver is in use.
>> It is like one wants to support ext4 removal even when your rootfs is ext4.
>>
>> I think krefing the DMA driver for channel request/release is just fine,
>> if user wants to break the system we should not assist...
>>
>>>> It's not limited to that driver, but actually all I'm maintaining.
>>>>
>>>> Users are not happy!
>>>>
>>>> -- 
>>>> With Best Regards,
>>>> Andy Shevchenko
>>>
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
