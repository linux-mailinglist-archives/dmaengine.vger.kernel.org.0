Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB9147907
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 08:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgAXHiP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 02:38:15 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54874 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXHiP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jan 2020 02:38:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00O7cAdT118543;
        Fri, 24 Jan 2020 01:38:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579851490;
        bh=ccJs9REJRX44mQ5fS5GfUWEIY6tboyNxehCJ3hYHmQ4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=QxZbWeV2ZEUEdXkRxBhH0MMHjE1hdqnChvGZKyn66gbJ2dfUSZ1VdykkxIREyRo+V
         hftYWxKXrkVfbGluUeBI1gMv08EtMBM/mH0ZBfx46ilEj0WERKyb0IgIiBjqZiFCq9
         GczW/TX9gWuuhwRPYt8io+ENg04MJoiesOfk0DK0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00O7cAwD049516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jan 2020 01:38:10 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 01:38:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 01:38:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00O7c6Km111616;
        Fri, 24 Jan 2020 01:38:07 -0600
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <ded9c051-11f3-e61a-e0de-1cd54a8c85d5@ti.com>
Message-ID: <7216460c-799f-efc7-c8be-9dd9b9829d10@ti.com>
Date:   Fri, 24 Jan 2020 09:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ded9c051-11f3-e61a-e0de-1cd54a8c85d5@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/01/2020 9.20, Peter Ujfalusi wrote:
> Hi Laurent,
> 
> On 23/01/2020 14.23, Laurent Pinchart wrote:
>>>>> I think capture (camera) is another potential beneficiary of this.
>>
>> Possibly, although in the camera case I'd rather have the hardware stop
>> if there's no more buffer. Requiring a buffer to always be present is
>> annoying from a userspace point of view. For display it's different, if
>> userspace doesn't submit a new frame, the same frame should keep being
>> displayed on the screen.
>>
>>>>> So you don't need to terminate the running interleaved_cyclic and start
>>>>> a new one, but prepare and issue a new one, which would
>>>>> terminate/replace the currently running cyclic interleaved DMA?
>>
>> Correct.
>>
>>>> Why not explicitly terminate the transfer and start when a new one is
>>>> issued. That can be common usage for audio and display..
>>>
>>> Yes, this is what I'm asking. The cyclic transfer is running and in
>>> order to start the new transfer, the previous should stop. But in cyclic
>>> case it is not going to happen unless it is terminated.
>>>
>>> When one would want to have different interleaved transfer the display
>>> (or capture )IP needs to be reconfigured as well. The the would need to
>>> be terminated anyways to avoid interpreting data in a wrong way.
>>
>> The use case here is not to switch to a new configuration, but to switch
>> to a new buffer. If the transfer had to be terminated manually first,
>> the DMA engine would potentially miss a frame, which is not acceptable.
>> We need an atomic way to switch to the next transfer.
> 
> You have a special hardware in hand, most DMAs can not just replace a
> cyclic transfer in-flight and it also kind of violates the DMAengine
> principles.

Is there any specific reason why you need DMAengine driver for a display
DMA? Usually the drm drivers handle their DMA internally.

> If cyclic transfer is started then it is expected to run forever until
> it is terminated. Preparing and issuing a new transfer will not get
> executed when there is already a cyclic transfer in flight as your only
> option is to terminate_all, which will kill the running cyclic _and_
> will discard the issued and pending transfers.
> 
> So the use case is page flip when you have multiple framebuffers and you
> switch them to show the updated one, right?
> 
> There are things missing in DMAengine in API level for sure to do this,
> imho.
> The issue is that cyclic transfers will never complete, they run until
> terminated, but you want to replace the currently executing one with a
> another cyclic transfer without actually terminating the other.
> 
> It is like pause the 1st cyclic and continue with the 2nd one. Then at
> some point you pause the 2nd one and restart the 1st one.
> It is also crucial that the pause /switch happens when the executing one
> finished the interleaved round and not in the middle somewhere, right?
> 
> If you:
> desc_1 = dmaengine_prep_interleaved_cyclic(chan, );
> cookie_1 = dmaengine_submit(desc_1);
> desc_2 = dmaengine_prep_interleaved_cyclic(chan, );
> cookie_2 = dmaengine_submit(desc_1);
> 
> /* cookie_1/desc_1 is started */
> dma_async_issue_pending(chan);
> 
> /* When need to switch to cookie_2 */
> dmaengine_cyclic_set_active_cookie(chan, cookie_2);
> /*
>  * cookie_1 execution is suspended after it finished the running
>  * dma_interleaved_template or buffer in normal cyclic and cookie_2
>  * is replacing it.
>  */
> 
> /* Switch back to cookie_1 */
> dmaengine_cyclic_set_active_cookie(chan, cookie_1);
> /*
>  * cookie_2 execution is suspended after it finished the running
>  * dma_interleaved_template or buffer in normal cyclic and cookie_1
>  * is replacing it.
>  */
> 
> There should be a (yet another) capabilities flag got
> cyclic_set_active_cookie and the documentation should be strict on what
> is the expected behavior.
> 
> You can kill everything with terminate_all.
> There is another thing which is missing imho from DMAengine: to
> terminate a specific cookie, not the entire channel, which might be a
> good addition as you might spawn framebuffers and then delete them and
> you might want to release the corresponding cookie/descriptor as well.

This is a bit trickier as DMAengine's cookie is s32 and internally
treated as a running number and cookie status is checked against s32
numbers with < >, I think this will not like when someone kills a cookie
in the middle.

> 
> What do you think?
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
