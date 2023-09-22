Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE13C7AAAC1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjIVHuM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjIVHuL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 03:50:11 -0400
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8F19C;
        Fri, 22 Sep 2023 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4cbMygGp9uogMxBbKSPpHm/fjDurwwZEgvsXEFU9RNA=; b=wEdMDiiNDDdZqiLCicthKEUI+0
        WTtV7XdnyB2Jq0z1Igwdaa64pw6JbaIoincNcfX4LgexUUoBirew/mSisrzfcX/8DxD7Hq8JBNyfA
        FWPywOSDVfMVYpBYpZgaWBFtypfTBC/rr961QllnOKIfCF/aq9FkuU04EHpSsj1HgjRU=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx12lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qjavJ-0001VD-2X;
        Fri, 22 Sep 2023 09:50:02 +0200
Message-ID: <8d18106d-444e-9346-26cc-3767540df5d8@sw-optimization.com>
Date:   Fri, 22 Sep 2023 09:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
To:     Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
 <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
 <ZQyWsvcQCJgmG5aO@freebase>
Content-Language: de-DE
From:   Eric Schwarz <eas@sw-optimization.com>
In-Reply-To: <ZQyWsvcQCJgmG5aO@freebase>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Olivier,

>> Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
>>> Sparse complains because we first take the lock in msgdma_tasklet -> move
>>> locking to msgdma_chan_desc_cleanup.
>>> In consequence, move calling of msgdma_chan_desc_cleanup outside of the
>>> critical section of function msgdma_tasklet.
>>>
>>> Use spin_unlock_irqsave/restore instead of just spinlock/unlock to keep
>>> state of irqs while executing the callbacks.
>>
>> What about the locking in the IRQ handler msgdma_irq_handler() itself? -
>> Shouldn't spin_unlock_irqsave/restore() be used there as well instead of
>> just spinlock/unlock()?
> 
> IMO no:
> It is covered by [1]("Locking Between Hard IRQ and Softirqs/Tasklets")
> The irq handler cannot be preempted by the tasklet, so the
> spin_lock/unlock version is ok. However the tasklet could be interrupted
> by the Hard IRQ hence the disabling of irqs with save/restore when
> entering critical section.
> 
> It should not be needed to keep interrupts locally disabled while invoking
> callbacks, will add this to the commit description.
> 
> [1] https://www.kernel.org/doc/Documentation/kernel-hacking/locking.rst

Thanks for the link. I have read differently here [2] w/ special 
emphasis on "Lesson 3: spinlocks revisited.".

[2] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt

Cheers
Eric
