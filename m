Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5E765109
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jul 2023 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjG0K0B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jul 2023 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjG0KZa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jul 2023 06:25:30 -0400
X-Greylist: delayed 2371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 03:25:19 PDT
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4FF0;
        Thu, 27 Jul 2023 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/pKv/RqreGEhipF2ra3SsWRhlf0F70NtUCUJJE4t6mw=; b=aIP5nK5f7UjdM7um9EgLRMflYI
        3iXCai0wUWB0p0mSkD2AcsG3B7i8Q35pCpvBU8Zm4Rh12oeY7lPo05tbWG/sVYU+0H+XjHy16r2It
        i/R/DEUkGjb+vi5J9COU7MOrc1/qmOTp/07KcAPB9uMeIi0LfeFY+rpq/1cATcT6ev1Y=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx12lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qOxZ0-0003CD-1x;
        Thu, 27 Jul 2023 11:45:42 +0200
Message-ID: <46ceea13-c8ba-8d67-604e-b761feabc50c@sw-optimization.com>
Date:   Thu, 27 Jul 2023 11:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
Content-Language: de-DE
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, Yunbo Yu <yuyunbo519@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
References: <20230726104827.60382-1-dg573847474@gmail.com>
 <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
 <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr>
 <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
 <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com>
From:   Eric Schwarz <eas@sw-optimization.com>
In-Reply-To: <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Am 27.07.2023 um 08:48 schrieb Chengfeng Ye:
> Hi Logan and Christophe,
> 
> Thanks much for the reply and reminder, and yes, spin_lock_bh() should
> be better.
> 
> When I wrote the patch I thought the spin_lock_bh() cannot be nested,
> and afraid that if some outside callers called .dma_tx_status() callback
> with softirq already disable, then spin_unlock_bh() would unintentionally
> re-enable softirq(). spin_lock_irqsave() is always safer in general thus I
> used it.
> 
> But I just check the document [1] about these API and found that _bh()
> can be nested. Then use spin_lock_bh() should be better due to
> performance concern.
> 
> 
>> So perhaps we should just revert 1d05a0bdb420?
> Then for this one I think revert 1d05a0bdb420 should be enough. May I
> ask to revert that patch, should I do anything further? (like sending
> a new patch).
> 
>> as explained in another reply [1], would spin_lock_bh() be enough in
>> such a case?
> For the another one [2], I would send a v2 patch to change to spin_lock_bh()
> 
> [1] http://books.gigatux.nl/mirror/kerneldevelopment/0672327201/ch07lev1sec6.html
> [2] https://lore.kernel.org/all/5125e39b-0faf-63fc-0c51-982b2a567e21@wanadoo.fr/

For uniformity reason across drivers and also that not something else 
gets missed please compare your requirements and solution to the 
implementation of the "altera-msgdma" driver (altera-msgdma.c).

W/ special emphasis on commit edf10919e5fc ("dmaengine: altera: fix 
spinlock usage")

spin_lock_bh was changed to spin_lock_irqsave w/ this patch.

Cheers
Eric
