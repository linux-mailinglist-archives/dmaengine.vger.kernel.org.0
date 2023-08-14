Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD48877BD09
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjHNPaH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjHNP35 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 11:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59F10D5;
        Mon, 14 Aug 2023 08:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3F261E74;
        Mon, 14 Aug 2023 15:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2F0C433C8;
        Mon, 14 Aug 2023 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692026995;
        bh=vCRlrdZqjMH67x3gjEky9BrHKTd04af3vMzFdJBho+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UOKVLKXeqzrDG/Ysv9MCmP6d8Mjn6EYJLo22aw/neCTYsz34ZLEAf5gqnuYcYKz9o
         dF5UNOjCJRdzxhFOoo4ajc1kYg2Iq56mGtRGnYZR6pnyj1j2vtYWx8qCC4iSwPq57/
         APQ0Pn55+wZA4U4OjJdy5uHZwcPyx6y04s1dgAvyMqraCqvkO4ua7AVpTgRhhSGbxT
         Szx1hfl4fn72hCZBMQgVDIsdTRC8Er+Ggaj0K9cZTx9bbafkWxWWJDWfJN/yQ401zs
         vnwlZra/r9sxe1s2PBzgdiCm1PP84FvCXuM0lGOny0RFRk1NCkJVwYkk0eFz1kJe/H
         6iLPVvsKlMKPw==
Date:   Mon, 14 Aug 2023 08:29:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Message-ID: <20230814082953.747791ff@kernel.org>
In-Reply-To: <MN0PR12MB5953A9FEC556D07494DB8E37B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
        <20230808154853.0fafa7fc@kernel.org>
        <MN0PR12MB5953A9FEC556D07494DB8E37B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 12 Aug 2023 15:27:19 +0000 Pandey, Radhey Shyam wrote:
> > Drop on error, you're not stopping the queue correctly, just drop, return OK
> > and avoid bugs.  
> 
> As I understand NETDEV_TX_OK returns means driver took care of packet.
> So inline with non-dmaengine xmit (axienet_start_xmit_legacy) should
> we stop the queue and return TX_BUSY?

You should only return BUSY if there is no space. All other errors
should lead to drops, and increment of tx_error. Otherwise problem
with handling a single packet may stall the NIC forever.
It is somewhat confusing that we return TX_OK in that case but it
is what it is.

> > Why create a cache ?
> > Isn't it cleaner to create a fake ring buffer of sgl? Most packets will not have
> > MAX_SKB_FRAGS of memory. On a ring buffer you can use only as many sg
> > entries as the packet requires. Also no need to alloc/free.  
> 
> The kmem_cache is used with intent to use slab cache interface and
> make use of reusing objects in the kernel. slab cache maintains a 
> cache of objects. When we free an object, instead of
> deallocating it, it give it back to the cache. Next time, if we
> want to create a new object, slab cache gives us one object from the
> slab cache.
> 
> If we maintain custom circular buffer (struct circ_buf) ring buffer 
> we have to create two such ring buffers one for TX and other for RX.
> For multichannel this will multiply to * no of queues. Also we have to
> ensure proper occupancy checks and head/tail pointer updates.
> 
> With kmem_cache pool we are offloading queue maintenance ops to
> framework with a benefit of optimized alloc/dealloc. Let me know if it 
> looks functionally fine and can retain it for this baseline dmaengine 
> support version?

The kmemcache is not the worst possible option but note that the
objects you're allocating (with zeroing) are 512+ bytes. That's
pretty large, when most packets will not have full 16 fragments.
Ring buffer would allow to better match the allocation size to 
the packets. Not to mention that it can be done fully locklessly.
