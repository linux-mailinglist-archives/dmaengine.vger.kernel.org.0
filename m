Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14B78C313
	for <lists+dmaengine@lfdr.de>; Tue, 29 Aug 2023 13:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjH2LGM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Aug 2023 07:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjH2LFt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Aug 2023 07:05:49 -0400
Received: from mx13lb.world4you.com (mx13lb.world4you.com [81.19.149.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF424C3;
        Tue, 29 Aug 2023 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AVKM9TQcJHZjLSeImIKY0Cx/V5t5iQPA+TrX7lfEi8w=; b=v1XJxS/sy4RB3zhamrj60YsFoF
        SPKYrpYHzsOFA91V71dLb5Yi+mvtzfoMjSMqUAJgBgB6kVdzu97abbi+88veDmFLXL35o74OApSB5
        BkVhk9UixRRimbA2CKQ1ff2KUVvJYOVLPH91hMvsrjgmm57e98r5Z0AMrbYKM38fi+Ek=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx13lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qawXW-0004OW-1Z;
        Tue, 29 Aug 2023 13:05:42 +0200
Message-ID: <b3be5738-8c40-bb82-296f-aa401d1fc1df@sw-optimization.com>
Date:   Tue, 29 Aug 2023 13:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
Content-Language: de-DE
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.jaillet@wanadoo.fr, vkoul@kernel.org,
        logang@deltatee.com
References: <20230729175952.4068-1-dg573847474@gmail.com>
 <3545b782-756a-3d2a-d192-8b224a783c13@sw-optimization.com>
 <CAAo+4rWW67VSpdwo_dstqAb-FiKeoK3YmaNgiX7vXBerqEWBkA@mail.gmail.com>
From:   Eric Schwarz <eas@sw-optimization.com>
In-Reply-To: <CAAo+4rWW67VSpdwo_dstqAb-FiKeoK3YmaNgiX7vXBerqEWBkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Chengfeng,

Am 29.08.2023 um 05:10 schrieb Chengfeng Ye:
> Hi Eric,
> 
> Thank you for your interest in it.

Thanks for getting back to me.

> For a dynamic detection solution, then the answer is yes.
> Lockdep, which should be enabled by CONFIG_DEBUG_SPINLOCK,
> has the ability to detect such deadlocks. But the problem is that the detection
> requires input and exact thread interleaving to trigger the bug, otherwise
> the bugs would be buried and cannot be detected.
> 
> For static analysis, I think the answer is no. Smatch, like other
> static deadlock detection algorithms in CBMC[1] and Infer[2], should be
> designed to reason thread interaction but not interrupts, which requires
> new algorithms that I am working on.

Will you publish your work later on e.g. on github?
Actually maybe it would even make sense to integrate your work into 
scripts/checkpatch.pl of the Linux kernel (or the like).
Basically if a patch to be committed fails locking it should not be 
committed anyway.
IMHO the quality standard one could expect from the code should always 
be the same. So adding it to a mandatory check procedure (script which 
must be executed before committing patches) and/or to "0-DAY CI Kernel 
Test Service" [5] would definitely be worth a thought.

> Besides, may I ask a question that I have sent some patches[3][4] weeks
> ago, but have not yet got a reply. Would reviewers check the patches
> later or should I ping them again?

You never have a guarantee who will when review your patch on the 
mailing list. It is kind of best effort based system mainly of volunteers.
Just give people a bit of time since it is currently also holiday time.
You may ping the maintainer of the subsystem when some time has passed 
since he is responsible for the patches to be administered.
BTW, I think you already pinged indirectly w/ your e-mail.

> [1] http://www.cprover.org/deadlock-detection/
> [2] https://github.com/facebook/infer
> [3] https://lore.kernel.org/lkml/20230726062313.77121-1-dg573847474@gmail.com/
> [4] https://lore.kernel.org/lkml/20230726051727.64088-1-dg573847474@gmail.com/

[5] https://github.com/intel/lkp-tests/wiki

Cheers
Eric
