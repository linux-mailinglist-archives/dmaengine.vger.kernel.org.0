Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5B1478E3
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 08:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAXHTj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 02:19:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34796 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHTj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jan 2020 02:19:39 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00O7JXsd034060;
        Fri, 24 Jan 2020 01:19:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579850373;
        bh=K3ojjYFJc5hyubu7S16l6n5hDopFoplhfjpd9nAcnF0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FDd/9fLBiO8uHvWskVB7CFF0in1DOAd+3ssiw24WT1s8nAVNDzlF9OXEQmej4grY/
         MP2KccDEKsSsD5PBXacaBN6RLyrQLug5/L5DYXYzrsLwgDm2yd6EuV09H9uai551fj
         dKVUwCgIdpwc74i5adb9Bf5TkLJ6IZ61R+Zvnzyc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00O7JXu5109193;
        Fri, 24 Jan 2020 01:19:33 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 01:19:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 01:19:33 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00O7JVQ4061300;
        Fri, 24 Jan 2020 01:19:32 -0600
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ded9c051-11f3-e61a-e0de-1cd54a8c85d5@ti.com>
Date:   Fri, 24 Jan 2020 09:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123122304.GB13922@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 23/01/2020 14.23, Laurent Pinchart wrote:
>>>> I think capture (camera) is another potential beneficiary of this.
> 
> Possibly, although in the camera case I'd rather have the hardware stop
> if there's no more buffer. Requiring a buffer to always be present is
> annoying from a userspace point of view. For display it's different, if
> userspace doesn't submit a new frame, the same frame should keep being
> displayed on the screen.
> 
>>>> So you don't need to terminate the running interleaved_cyclic and start
>>>> a new one, but prepare and issue a new one, which would
>>>> terminate/replace the currently running cyclic interleaved DMA?
> 
> Correct.
> 
>>> Why not explicitly terminate the transfer and start when a new one is
>>> issued. That can be common usage for audio and display..
>>
>> Yes, this is what I'm asking. The cyclic transfer is running and in
>> order to start the new transfer, the previous should stop. But in cyclic
>> case it is not going to happen unless it is terminated.
>>
>> When one would want to have different interleaved transfer the display
>> (or capture )IP needs to be reconfigured as well. The the would need to
>> be terminated anyways to avoid interpreting data in a wrong way.
> 
> The use case here is not to switch to a new configuration, but to switch
> to a new buffer. If the transfer had to be terminated manually first,
> the DMA engine would potentially miss a frame, which is not acceptable.
> We need an atomic way to switch to the next transfer.

You have a special hardware in hand, most DMAs can not just replace a
cyclic transfer in-flight and it also kind of violates the DMAengine
principles.
If cyclic transfer is started then it is expected to run forever until
it is terminated. Preparing and issuing a new transfer will not get
executed when there is already a cyclic transfer in flight as your only
option is to terminate_all, which will kill the running cyclic _and_
will discard the issued and pending transfers.

So the use case is page flip when you have multiple framebuffers and you
switch them to show the updated one, right?

There are things missing in DMAengine in API level for sure to do this,
imho.
The issue is that cyclic transfers will never complete, they run until
terminated, but you want to replace the currently executing one with a
another cyclic transfer without actually terminating the other.

It is like pause the 1st cyclic and continue with the 2nd one. Then at
some point you pause the 2nd one and restart the 1st one.
It is also crucial that the pause /switch happens when the executing one
finished the interleaved round and not in the middle somewhere, right?

If you:
desc_1 = dmaengine_prep_interleaved_cyclic(chan, );
cookie_1 = dmaengine_submit(desc_1);
desc_2 = dmaengine_prep_interleaved_cyclic(chan, );
cookie_2 = dmaengine_submit(desc_1);

/* cookie_1/desc_1 is started */
dma_async_issue_pending(chan);

/* When need to switch to cookie_2 */
dmaengine_cyclic_set_active_cookie(chan, cookie_2);
/*
 * cookie_1 execution is suspended after it finished the running
 * dma_interleaved_template or buffer in normal cyclic and cookie_2
 * is replacing it.
 */

/* Switch back to cookie_1 */
dmaengine_cyclic_set_active_cookie(chan, cookie_1);
/*
 * cookie_2 execution is suspended after it finished the running
 * dma_interleaved_template or buffer in normal cyclic and cookie_1
 * is replacing it.
 */

There should be a (yet another) capabilities flag got
cyclic_set_active_cookie and the documentation should be strict on what
is the expected behavior.

You can kill everything with terminate_all.
There is another thing which is missing imho from DMAengine: to
terminate a specific cookie, not the entire channel, which might be a
good addition as you might spawn framebuffers and then delete them and
you might want to release the corresponding cookie/descriptor as well.

What do you think?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
