Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89078B53E
	for <lists+dmaengine@lfdr.de>; Mon, 28 Aug 2023 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjH1QSq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Aug 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjH1QSO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Aug 2023 12:18:14 -0400
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0F12F;
        Mon, 28 Aug 2023 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jf5g/I36r8ob2yv+ooeobt1OMylegtPYl6OH7WsCMnM=; b=gp8SlCD90GGLp/mqNqI9T9E6Z2
        Dj+kRGH3k5wTRycffBpos50/y3SY5FF3UCKHqJh+esdd6IbdTWqXMDvKfuQkKAwDjAU2HylItVoAt
        BD0XW9vpKX1orkZuBn/9cplhDH2DIGqfT+jCMwaHXj9McULYWI0EgmsnYHv6VFXbEF9c=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx07lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qaewK-0007Ow-0K;
        Mon, 28 Aug 2023 18:18:08 +0200
Message-ID: <3545b782-756a-3d2a-d192-8b224a783c13@sw-optimization.com>
Date:   Mon, 28 Aug 2023 18:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
Content-Language: de-DE
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     yuyunbo519@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        vkoul@kernel.org, logang@deltatee.com
References: <20230729175952.4068-1-dg573847474@gmail.com>
From:   Eric Schwarz <eas@sw-optimization.com>
In-Reply-To: <20230729175952.4068-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Am 29.07.2023 um 19:59 schrieb Chengfeng Ye:
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock.

Just out of curiosity, did/could
- Linux kernel config checks like CONFIG_DEBUG_SPINLOCK option or
- Smatch [1]
find that issue too?

I have also found an article from Dan Carpenter on the net about lock 
checking capability of Smatch which relates IMHO to what you are doing [2].

The question is, whether the checks/algorithm what you have developed 
already exists in form of other tools or they might be added to an 
already existing one, which is already spread across the community and 
used accordingly.

Many thanks for your reply in advance.

[1] https://github.com/error27/smatch
[2] https://blogs.oracle.com/linux/post/writing-the-ultimate-locking-check

Cheers
Eric
