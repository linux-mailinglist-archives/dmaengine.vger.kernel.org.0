Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FF7B1575
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjI1H53 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1H53 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:57:29 -0400
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50495;
        Thu, 28 Sep 2023 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DYJJ/f0DO0/HVh4TKtQmLwk9LeGhEBV9geBo5ZsEPos=; b=kJwk5jdgnw0aONE3O2JP7Xa6o8
        368m9vVnBvjhbMbeRLJbj7oFXvyGxH1muv6shFLiN9RNfkz05Zea8BO5dWIDyWcI2A4LU+SpBKBaK
        qaJKLogcmuDRELYNN8sdnWyPGXoSKto2vB0bXo8421s7TMhO9sKXm7DN/tOUt5qw0kqI=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx06lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qlltl-00021o-1q;
        Thu, 28 Sep 2023 09:57:25 +0200
Message-ID: <5e2404d4-f36c-7718-c0fc-d226aefdf2f6@sw-optimization.com>
Date:   Thu, 28 Sep 2023 09:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Eric Schwarz <eas@sw-optimization.com>
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
To:     Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
 <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
 <ZQyWsvcQCJgmG5aO@freebase>
 <8d18106d-444e-9346-26cc-3767540df5d8@sw-optimization.com>
 <ZQ3B9NWVmLvaVhJX@freebase>
Content-Language: de-DE
In-Reply-To: <ZQ3B9NWVmLvaVhJX@freebase>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Olivier,

Am 22.09.2023 um 18:33 schrieb Olivier Dautricourt:
> Hi Eric,
> 
> On Fri, Sep 22, 2023 at 09:49:59AM +0200, Eric Schwarz wrote:
>> Hello Olivier,
>>
>>>> Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
>>>>> Sparse complains because we first take the lock in msgdma_tasklet -> move
>>>>> locking to msgdma_chan_desc_cleanup.
>>>>> In consequence, move calling of msgdma_chan_desc_cleanup outside of the
>>>>> critical section of function msgdma_tasklet.
>>>>>
>>>>> Use spin_unlock_irqsave/restore instead of just spinlock/unlock to keep
>>>>> state of irqs while executing the callbacks.
>>>>
>>>> What about the locking in the IRQ handler msgdma_irq_handler() itself? -
>>>> Shouldn't spin_unlock_irqsave/restore() be used there as well instead of
>>>> just spinlock/unlock()?
>>>
>>> IMO no:
>>> It is covered by [1]("Locking Between Hard IRQ and Softirqs/Tasklets")
>>> The irq handler cannot be preempted by the tasklet, so the
>>> spin_lock/unlock version is ok. However the tasklet could be interrupted
>>> by the Hard IRQ hence the disabling of irqs with save/restore when
>>> entering critical section.
>>>
>>> It should not be needed to keep interrupts locally disabled while invoking
>>> callbacks, will add this to the commit description.
>>>
>>> [1] https://www.kernel.org/doc/Documentation/kernel-hacking/locking.rst
>>
>> Thanks for the link. I have read differently here [2] w/ special emphasis on
>> "Lesson 3: spinlocks revisited.".
>>
>> [2] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
>>
> 
> This chapter [2] says that our code must use irq versions of spin_lock
> because our handler does indeed play with the lock. However this
> requirement does not apply to the irq handler itself, as we know that the
> interrupt line is disabled during the execution of the handler (and our
> handler is not shared with another irq).

"... as we know that the interrupt line is disabled during the execution 
of the handler (and our handler is not shared with another irq)."

That was the point I wanted to be sure about. So if the IRQ handler 
cannot be called twice ensured by architecture neither on single or 
multi CPU systems (SMP or others) I am fine.
Thanks for your response on that. Appreciated.

Because you take the effort to set up hardware and environment again you 
may also test following fixes/improvements from zynqmp driver which 
could then be merged into altera-msgdma driver. Please check yourself:

f2b816a1dfb8 ("dmaengine: zynqmp_dma: Add device_synchronize support")
# Caught by your patchset
#9558cf4ad07e ("dmaengine: zynqmp_dma: fix lockdep warning in tasklet")
# Caught by your patchset
#16ed0ef3e931 ("dmaengine: zynqmp_dma: cleanup after completing all 
descriptors")
# Caught by your patchset - For the altera-msgdma driver it is a real 
fix not an optimization.
#48594dbf793a ("dmaengine: zynqmp_dma: Use list_move_tail instead of 
list_del/list_add_tail")
5ba080aada5e ("dmaengine: zynqmp_dma: Fix race condition in the probe")

Note: If the sequence is applied in reverse order the log would be 
comparable to zynqmp driver's log.

IMHO your patchset could/should be extended by two more patches and 
split into small junks as mentioned. Then history would stay intact to 
be compared to zynqmp driver.

Note: Take care about "Developer’s Certificate of Origin 1.1". IMHO 
"Signed-off-by" tags from the other patches might/must be copied at 
least for most of the patches then, which would make it easier to get it 
into mainline.

Btw, some cosmetic changes could be made in the mainlined driver:

30s/implements/Implements/
31s/data/Data/
32s/data/Data/
33s/the/The/
39s/data/Data/
40s/data/Data/
41s/characteristics/Characteristics/
109s/response/Response/
154s/implements/Implements/
154s/sw\ /SW\ /
155s/support/Support/
155s/api/API/
156s/assosiated/Associated/
157s/node\ /Node\ /
158s/transmit/Transmit/
259s/Hw/HW/
291s/Hw/HW/
322s/prepare/Prepare/
327s/transfer/Transfer/
378s/prepare/Prepare/
384s/transfer/Transfer/
385s/transfer/Transfer/
502s/its/it\'s/
514s/oder/order/
530s/copy\ /Copy\ /
680s/sSGDMA/mSGDMA/
723s/Interrupt/interrupt/
752s/\(\)//
921s/\(\)//

... and another patch, if that is taken into account.

Cheers
Eric
