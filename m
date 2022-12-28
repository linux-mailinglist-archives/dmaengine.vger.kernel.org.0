Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DAE6574D1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiL1Jlt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 04:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiL1Jlq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 04:41:46 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1556264
        for <dmaengine@vger.kernel.org>; Wed, 28 Dec 2022 01:41:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id tz12so37213186ejc.9
        for <dmaengine@vger.kernel.org>; Wed, 28 Dec 2022 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dk1EvcTU9lT8mhVKioQpbbr/X3t9yNONpG3kqVL2vnk=;
        b=HposA8GoIWgI797X6KIdWhh0fj6rd/PR9eC3oYfxqAlK8PExPp8Kc9sdLJ/nsvjCzR
         h6bb0eFRjF7kI/93U/CEb822O8FIpuhKpW4OS9r9dkNWr6FKtUjAM9nBvCcg244dxDk6
         zSXR+RYpXj4HBEJ3V+POrHmWLZlNoudMofewZS5fQ3cg5nyyV3L1u8sTZbL7F6Edbq7O
         voz9h1HXa6r9+Fqlp84LNB0+NlBpKUtgZJfWzhbfMkdwtUqlXTZ4368xTYFMwveW9otr
         rANHuYInsSHnbmQkCXugPBrsJxMVFJo+whrRPXWc8bw+7aUmXOoCqPC3Ut6A8if1g17F
         frlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk1EvcTU9lT8mhVKioQpbbr/X3t9yNONpG3kqVL2vnk=;
        b=xVzh4ky8kK1wl+itlETb4raRRxGk3tk3k8oud8Ln40WNI916AHEeEyQYJN6A4CzPtd
         PMNkCPFCGMQLr8z6PsdL5PV8tRDuRBdX31IP7p72JvxM4psbbMIrX5dUOpX6Lcgl/3IL
         PdmDQ/EmKXVO4+AlILldScrWXdgtB72FzczlWDSExYZ9SXYkqL59/G3uFxP2Va7qeprj
         cfy6eDV5maAXPhn+F88HOAVOaBTjgwNfEnyOgOGlMdOlPXtAjJj6s9rgtwkIA+NkbBYs
         l1hTMVZ+CgmO+Pf4hd5XYDPSw0v3rt4DF2fgzd28uhWdBPKoHalbjG4VECi8flrh3l9a
         siHA==
X-Gm-Message-State: AFqh2kpXkKP4gntHc8LCjsNU1sX6+8AA8Kp0KnI63gf5x+JmfE3h+lUZ
        BJudJcCD6so1OpwQ6anW9Gs6tzse+eYbvJELYLCHLw==
X-Google-Smtp-Source: AMrXdXtGKFQ7BDZtuaE+bLkd5a/pe4+1iQeE3gt2TztYHVdL8HatvnKrN4M56+pWpM+SQJsfS6TSIVMNsEUnfwp3LQ0=
X-Received: by 2002:a17:906:bce8:b0:7c4:fe2d:afd3 with SMTP id
 op8-20020a170906bce800b007c4fe2dafd3mr1557859ejb.390.1672220503360; Wed, 28
 Dec 2022 01:41:43 -0800 (PST)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Wed, 28 Dec 2022 01:41:32 -0800
Message-ID: <CAOQPn8vzL7h9K8pbCbho-7vNDMhjaufPoGUnTUUiWNfbz6y_Pw@mail.gmail.com>
Subject: [ptdma] pt_core_execute_cmd() from interrupt context results in panic
To:     "Mehta, Sanju" <sanju.mehta@amd.com>, Vinod <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Eric Pilmore <epilmore@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Wondering if this might be a known issue in the ptdma DMA driver. Did
not see anything obvious in bugzilla.

I am doing some testing of the ntb_netdev module in conjunction with
the ptdma module as the supporting DMA engines on an AMD Rome CPU
based platform. The ptdma driver being used is the latest code in the
Linux (6.2) repository.

There are no issues in doing simple ping operations across the
ntb_netdev (TCP/IP) interface, including sending large packets which
we know will cause the respective DMA engines to be utilized. However,
while doing iperf testing across the ntb_netdev interface, we have
encountered a panic:

[ 1626.776583] RIP: 0010:mutex_spin_on_owner+0x3b/0xa0
....
[ 1626.776588] Call Trace:
[ 1626.776588]  <IRQ>
[ 1626.776589]  __mutex_lock.isra.7+0xad/0x4c0
[ 1626.776589]  ? ntb_transport_rx_enqueue+0x127/0x200 [ntb_transport]
[ 1626.776589]  __mutex_lock_slowpath+0x13/0x20
[ 1626.776590]  ? __mutex_lock_slowpath+0x13/0x20
[ 1626.776590]  mutex_lock+0x2f/0x40
[ 1626.776590]  pt_core_perform_passthru+0xc5/0x160 [ptdma]
[ 1626.776591]  pt_cmd_callback.part.7+0x262/0x2d0 [ptdma]
[ 1626.776591]  pt_cmd_callback+0x13/0x20 [ptdma]
[ 1626.776591]  pt_check_status_trans+0xc3/0x120 [ptdma]
[ 1626.776592]  pt_core_irq_handler+0x36/0x60 [ptdma]
[ 1626.776592]  __handle_irq_event_percpu+0x44/0x1a0
[ 1626.776592]  handle_irq_event_percpu+0x32/0x80
[ 1626.776593]  handle_irq_event+0x3b/0x60
[ 1626.776593]  handle_edge_irq+0x83/0x1a0
[ 1626.776593]  handle_irq+0x20/0x30
[ 1626.776593]  do_IRQ+0x50/0xe0
[ 1626.776594]  common_interrupt+0xf/0xf

The issue is that the ptdma handlers are getting called in interrupt
context, and ultimately the flow leads to pt_core_execute_cmd() which
will attempt to grab a mutex, which is really not appropriate in
interrupt context. I have temporarily changed the lock in question to
a spinlock, which seems to have resolved the issue. However, I don't
know enough about the ptdma driver to really know if this is the
desired repair.

Hoping that others with more knowledge in this driver might be able to
comment as to the validity of this bug and whether a spinlock is the
correct approach here. If it is, I would be happy to submit a patch,
otherwise I can just file a bugzilla for the module owner to make a
more appropriate fix.

Thanks for any advice.

Eric Pilmore
