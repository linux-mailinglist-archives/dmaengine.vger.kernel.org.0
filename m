Return-Path: <dmaengine+bounces-1108-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC303862CCE
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E8F283260
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB217997;
	Sun, 25 Feb 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sw-optimization.com header.i=@sw-optimization.com header.b="edXJWmE/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D72D2FE;
	Sun, 25 Feb 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892593; cv=none; b=eQ1vZPPQVFDQ0jaWQRgYmN/l82v+BEiy8ERQHdXz9O/qzEOGbjVENJhWgziABrPpVDrIUtbQzWpRwfaFueVcP55q9Tra04DkfaJiK0UnP17RtPiCX9Eu1mjtPsyHWjPYqjpXv7Z5IGWf5QMFiXpTEE20BoLZ6XDpazYaEmssUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892593; c=relaxed/simple;
	bh=yW/+obWtXZSHaK0Je1F5WkuDWcXhnWjrtjf+VbTL55I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mMfQ0Kw9Fgrt13u/s3V54YjJBMhtVI+Ibd6X8dVlVUaGNEFB1MnhOW7aa67VHK5XeU4wBHOunin0TAlhr1YbkYW29MLcAOOjMFmIhDJS3v2nyESOkaEVhYm0OwoB3II55i1smKtOWBzvxC8VUq0SYKfESKSu4yD9YCvfvULXoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sw-optimization.com; spf=pass smtp.mailfrom=sw-optimization.com; dkim=pass (1024-bit key) header.d=sw-optimization.com header.i=@sw-optimization.com header.b=edXJWmE/; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sw-optimization.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sw-optimization.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ECMTj4d0RwuHIR6RVnxKDJNLLn5ad3xX9dN37q8WZfk=; b=edXJWmE/j2+9KN6qSnOzuJ2cHo
	cotC8/3KLRovQiwfhhrdtKZClEeOFBhE2BtXx/BKrsE4vJ240ZAiffmNmJ618+l++GnK7ap42JQqz
	OR+84dsQPF5WezZHAjkVd3uBM35J0UXLrIJAYU+L2JNsLO/BbKJNB/dLOTu1qv3BoSnk=;
Received: from [82.194.150.36] (helo=[192.168.0.145])
	by mx11lb.world4you.com with esmtpa (Exim 4.96.2)
	(envelope-from <eas@sw-optimization.com>)
	id 1reKkj-0006le-1n;
	Sun, 25 Feb 2024 21:05:37 +0100
Message-ID: <245a848c-5bbc-463d-b7e1-b82cea2c4dba@sw-optimization.com>
Date: Sun, 25 Feb 2024 21:05:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
From: Eric Schwarz <eas@sw-optimization.com>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
 <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
 <ZQyWsvcQCJgmG5aO@freebase>
 <8d18106d-444e-9346-26cc-3767540df5d8@sw-optimization.com>
 <ZQ3B9NWVmLvaVhJX@freebase>
 <5e2404d4-f36c-7718-c0fc-d226aefdf2f6@sw-optimization.com>
Content-Language: de-DE
In-Reply-To: <5e2404d4-f36c-7718-c0fc-d226aefdf2f6@sw-optimization.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

Hello Olivier,

just a ping on getting the patches / fixes below mainline. - Were you 
able to get hardware for testing?

Many thanks
Eric


Am 28.09.2023 um 09:57 schrieb Eric Schwarz:
> Hello Olivier,
> 
> Am 22.09.2023 um 18:33 schrieb Olivier Dautricourt:
>> Hi Eric,
>>
>> On Fri, Sep 22, 2023 at 09:49:59AM +0200, Eric Schwarz wrote:
>>> Hello Olivier,
>>>
>>>>> Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
>>>>>> Sparse complains because we first take the lock in msgdma_tasklet 
>>>>>> -> move
>>>>>> locking to msgdma_chan_desc_cleanup.
>>>>>> In consequence, move calling of msgdma_chan_desc_cleanup outside 
>>>>>> of the
>>>>>> critical section of function msgdma_tasklet.
>>>>>>
>>>>>> Use spin_unlock_irqsave/restore instead of just spinlock/unlock to 
>>>>>> keep
>>>>>> state of irqs while executing the callbacks.
>>>>>
>>>>> What about the locking in the IRQ handler msgdma_irq_handler() 
>>>>> itself? -
>>>>> Shouldn't spin_unlock_irqsave/restore() be used there as well 
>>>>> instead of
>>>>> just spinlock/unlock()?
>>>>
>>>> IMO no:
>>>> It is covered by [1]("Locking Between Hard IRQ and Softirqs/Tasklets")
>>>> The irq handler cannot be preempted by the tasklet, so the
>>>> spin_lock/unlock version is ok. However the tasklet could be 
>>>> interrupted
>>>> by the Hard IRQ hence the disabling of irqs with save/restore when
>>>> entering critical section.
>>>>
>>>> It should not be needed to keep interrupts locally disabled while 
>>>> invoking
>>>> callbacks, will add this to the commit description.
>>>>
>>>> [1] https://www.kernel.org/doc/Documentation/kernel-hacking/locking.rst
>>>
>>> Thanks for the link. I have read differently here [2] w/ special 
>>> emphasis on
>>> "Lesson 3: spinlocks revisited.".
>>>
>>> [2] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
>>>
>>
>> This chapter [2] says that our code must use irq versions of spin_lock
>> because our handler does indeed play with the lock. However this
>> requirement does not apply to the irq handler itself, as we know that the
>> interrupt line is disabled during the execution of the handler (and our
>> handler is not shared with another irq).
> 
> "... as we know that the interrupt line is disabled during the execution 
> of the handler (and our handler is not shared with another irq)."
> 
> That was the point I wanted to be sure about. So if the IRQ handler 
> cannot be called twice ensured by architecture neither on single or 
> multi CPU systems (SMP or others) I am fine.
> Thanks for your response on that. Appreciated.
> 
> Because you take the effort to set up hardware and environment again you 
> may also test following fixes/improvements from zynqmp driver which 
> could then be merged into altera-msgdma driver. Please check yourself:
> 
> f2b816a1dfb8 ("dmaengine: zynqmp_dma: Add device_synchronize support")
> # Caught by your patchset
> #9558cf4ad07e ("dmaengine: zynqmp_dma: fix lockdep warning in tasklet")
> # Caught by your patchset
> #16ed0ef3e931 ("dmaengine: zynqmp_dma: cleanup after completing all 
> descriptors")
> # Caught by your patchset - For the altera-msgdma driver it is a real 
> fix not an optimization.
> #48594dbf793a ("dmaengine: zynqmp_dma: Use list_move_tail instead of 
> list_del/list_add_tail")
> 5ba080aada5e ("dmaengine: zynqmp_dma: Fix race condition in the probe")
> 
> Note: If the sequence is applied in reverse order the log would be 
> comparable to zynqmp driver's log.
> 
> IMHO your patchset could/should be extended by two more patches and 
> split into small junks as mentioned. Then history would stay intact to 
> be compared to zynqmp driver.
> 
> Note: Take care about "Developer’s Certificate of Origin 1.1". IMHO 
> "Signed-off-by" tags from the other patches might/must be copied at 
> least for most of the patches then, which would make it easier to get it 
> into mainline.
> 
> Btw, some cosmetic changes could be made in the mainlined driver:
> 
> 30s/implements/Implements/
> 31s/data/Data/
> 32s/data/Data/
> 33s/the/The/
> 39s/data/Data/
> 40s/data/Data/
> 41s/characteristics/Characteristics/
> 109s/response/Response/
> 154s/implements/Implements/
> 154s/sw\ /SW\ /
> 155s/support/Support/
> 155s/api/API/
> 156s/assosiated/Associated/
> 157s/node\ /Node\ /
> 158s/transmit/Transmit/
> 259s/Hw/HW/
> 291s/Hw/HW/
> 322s/prepare/Prepare/
> 327s/transfer/Transfer/
> 378s/prepare/Prepare/
> 384s/transfer/Transfer/
> 385s/transfer/Transfer/
> 502s/its/it\'s/
> 514s/oder/order/
> 530s/copy\ /Copy\ /
> 680s/sSGDMA/mSGDMA/
> 723s/Interrupt/interrupt/
> 752s/\(\)//
> 921s/\(\)//
> 
> ... and another patch, if that is taken into account.
> 
> Cheers
> Eric

