Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C051671518
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 08:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjARHfE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 02:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjARHeR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 02:34:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863034C17
        for <dmaengine@vger.kernel.org>; Tue, 17 Jan 2023 22:50:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A5D4B81A16
        for <dmaengine@vger.kernel.org>; Wed, 18 Jan 2023 06:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B12EC433D2;
        Wed, 18 Jan 2023 06:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674024636;
        bh=3Aiht0UF2mbsB7ZfcTBAKn+r8U0tzcv0M4oXNv/layE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClyugwJ76G4MS4ZkZf/lw9mNyv3sTsae73cKmQ20x2zgcZEya3emE6VVCHy1CM0Cf
         nd1kMo+7qEtwwdjQNb+ix2AHRAAwQup6D61ujmAnbGwVcg1vTuZQO5c9ZjkaoAb7SB
         htGxa7x8WH+qeIz25wAUx2tn4zmPKQCkAh312CNlswC0jdmdm4IgxZbA3p3/coXWd0
         Ymbj7/Sw8SpSM9CgHJwMFdDu5ppsweULk96vs6Q3yQeFO3XudgN/n5f07dTp9aFmbK
         22vE8Lld/c31JWa6oP81BTXcEpqkr4evnxn4+KxndQfjPSA2J/clVYqkr9hMWqcpMO
         sDnwtrVe4ReVA==
Date:   Wed, 18 Jan 2023 12:20:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     "Mehta, Sanju" <sanju.mehta@amd.com>, dmaengine@vger.kernel.org
Subject: Re: [ptdma] pt_core_execute_cmd() from interrupt context results in
 panic
Message-ID: <Y8eWuJU5KlTMzRN4@matsya>
References: <CAOQPn8vzL7h9K8pbCbho-7vNDMhjaufPoGUnTUUiWNfbz6y_Pw@mail.gmail.com>
 <CAOQPn8s+jjuowgsY10T0_uCDB3mK2B730AXntozVVzjnMjoH4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQPn8s+jjuowgsY10T0_uCDB3mK2B730AXntozVVzjnMjoH4g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-23, 10:00, Eric Pilmore wrote:
> On Wed, Dec 28, 2022 at 1:41 AM Eric Pilmore <epilmore@gigaio.com> wrote:
> >
> > Wondering if this might be a known issue in the ptdma DMA driver. Did
> > not see anything obvious in bugzilla.
> >
> > I am doing some testing of the ntb_netdev module in conjunction with
> > the ptdma module as the supporting DMA engines on an AMD Rome CPU
> > based platform. The ptdma driver being used is the latest code in the
> > Linux (6.2) repository.
> >
> > There are no issues in doing simple ping operations across the
> > ntb_netdev (TCP/IP) interface, including sending large packets which
> > we know will cause the respective DMA engines to be utilized. However,
> > while doing iperf testing across the ntb_netdev interface, we have
> > encountered a panic:
> >
> > [ 1626.776583] RIP: 0010:mutex_spin_on_owner+0x3b/0xa0
> > ....
> > [ 1626.776588] Call Trace:
> > [ 1626.776588]  <IRQ>
> > [ 1626.776589]  __mutex_lock.isra.7+0xad/0x4c0
> > [ 1626.776589]  ? ntb_transport_rx_enqueue+0x127/0x200 [ntb_transport]
> > [ 1626.776589]  __mutex_lock_slowpath+0x13/0x20
> > [ 1626.776590]  ? __mutex_lock_slowpath+0x13/0x20
> > [ 1626.776590]  mutex_lock+0x2f/0x40
> > [ 1626.776590]  pt_core_perform_passthru+0xc5/0x160 [ptdma]
> > [ 1626.776591]  pt_cmd_callback.part.7+0x262/0x2d0 [ptdma]
> > [ 1626.776591]  pt_cmd_callback+0x13/0x20 [ptdma]
> > [ 1626.776591]  pt_check_status_trans+0xc3/0x120 [ptdma]
> > [ 1626.776592]  pt_core_irq_handler+0x36/0x60 [ptdma]
> > [ 1626.776592]  __handle_irq_event_percpu+0x44/0x1a0
> > [ 1626.776592]  handle_irq_event_percpu+0x32/0x80
> > [ 1626.776593]  handle_irq_event+0x3b/0x60
> > [ 1626.776593]  handle_edge_irq+0x83/0x1a0
> > [ 1626.776593]  handle_irq+0x20/0x30
> > [ 1626.776593]  do_IRQ+0x50/0xe0
> > [ 1626.776594]  common_interrupt+0xf/0xf
> >
> > The issue is that the ptdma handlers are getting called in interrupt
> > context, and ultimately the flow leads to pt_core_execute_cmd() which
> > will attempt to grab a mutex, which is really not appropriate in
> > interrupt context. I have temporarily changed the lock in question to
> > a spinlock, which seems to have resolved the issue. However, I don't
> > know enough about the ptdma driver to really know if this is the
> > desired repair.
> >
> > Hoping that others with more knowledge in this driver might be able to
> > comment as to the validity of this bug and whether a spinlock is the
> > correct approach here. If it is, I would be happy to submit a patch,

It is the right approach.. ISR needs to push descriptors and yes you
need to hold the lock for that..

Pls do send the patch, looks like AMD folks didnt bother

> > otherwise I can just file a bugzilla for the module owner to make a
> > more appropriate fix.
> >
> > Thanks for any advice.
> >
> > Eric Pilmore
> 
> I haven't heard any further on this, so I filed a bugzilla so it
> doesn't get lost.
> 
> Eric

-- 
~Vinod
