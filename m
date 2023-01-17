Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A756566E5F8
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jan 2023 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjAQS3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Jan 2023 13:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjAQS2e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Jan 2023 13:28:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD460521FA
        for <dmaengine@vger.kernel.org>; Tue, 17 Jan 2023 10:00:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s3so8046674edd.4
        for <dmaengine@vger.kernel.org>; Tue, 17 Jan 2023 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxCsa+0kl7CuaMoEW8Zsr6p/Vbnjtl5dgdEjVy74pXw=;
        b=zwhoTnu08SFegeD3FG2w+KoxDdFYL4iEA1tCVXqgAMFvqtkHmY8TF6/sQb4DM1UxR6
         8c6k+X81Xya0zPggJUIOF5ExxUgblsKDOhLY0/ga6fol4T8Qo0pgCb52OwAc5t7z7eKV
         7qBSDdD0WIU57b8bxVbsPZuwjqefO9LhNf2v30X7F1wy/+zjJnsBg5WTcm7FjXkRtIHW
         1zJNEi3q55XiZGbfyAgIOBoiy7IQvxnxBqnHqbo7RmmEylaV2z5wUJ51vO0wtTsibXlf
         fL6aKnteVVn6k2MCX88ZwDM9e7Dugy2omZKMHACXSMd6n2GVCGNF5l7Ank0wey3GnfEN
         TgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxCsa+0kl7CuaMoEW8Zsr6p/Vbnjtl5dgdEjVy74pXw=;
        b=BKUM8QnI9iF72OqnURVSz2qBKe0QVg2A79e7jFXpAhYcGhoz6F6Ay0w4DNBIVIkCf3
         r7b3D0OdW6ALcMXUyBLncRYLlQSxEEqI/0Fjcbb4UXKdz6YB19Y0uSYDAptdsiIc3lTn
         hmqv2cXFSGshMQvaP9VYwaNu/ZeemO9bIIfBh2yU2fO/WBiD9zdsy18X8NsPO6MLOlXm
         mafUIDKY4a03RLsxZLT1y+e6XqW2yUOSIkxN/bxaVBxbqXygg29UUDajWDYUjk7u5Ic1
         qWq8oNHCBsOeDaGdnY3u9OtkDbz3Eo/y4uFJ0GAGmfAtS7chTbfVSFElHX58QDC/npw7
         H3ZA==
X-Gm-Message-State: AFqh2kqCRmR2Yz0RtaUbXMpvlCn3cRXwT/7VkKZ1PcNoh/uvSiIJ2RI0
        s/KkbMDO+7cndJssFqFtgXffOQCiwwqm/ZbZ6djJdQ==
X-Google-Smtp-Source: AMrXdXs+WWmqd0bQxBOyjlXbpEPQSGzoCFfhfHDv8Vg1YGB6c1KWXO0XzSO6MIO4QZk4ggF3YEeL8iy/hyuiGd4P6cE=
X-Received: by 2002:aa7:cc81:0:b0:49d:efdc:4f78 with SMTP id
 p1-20020aa7cc81000000b0049defdc4f78mr309123edt.390.1673978421235; Tue, 17 Jan
 2023 10:00:21 -0800 (PST)
MIME-Version: 1.0
References: <CAOQPn8vzL7h9K8pbCbho-7vNDMhjaufPoGUnTUUiWNfbz6y_Pw@mail.gmail.com>
In-Reply-To: <CAOQPn8vzL7h9K8pbCbho-7vNDMhjaufPoGUnTUUiWNfbz6y_Pw@mail.gmail.com>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Tue, 17 Jan 2023 10:00:10 -0800
Message-ID: <CAOQPn8s+jjuowgsY10T0_uCDB3mK2B730AXntozVVzjnMjoH4g@mail.gmail.com>
Subject: Re: [ptdma] pt_core_execute_cmd() from interrupt context results in panic
To:     "Mehta, Sanju" <sanju.mehta@amd.com>, Vinod <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 28, 2022 at 1:41 AM Eric Pilmore <epilmore@gigaio.com> wrote:
>
> Wondering if this might be a known issue in the ptdma DMA driver. Did
> not see anything obvious in bugzilla.
>
> I am doing some testing of the ntb_netdev module in conjunction with
> the ptdma module as the supporting DMA engines on an AMD Rome CPU
> based platform. The ptdma driver being used is the latest code in the
> Linux (6.2) repository.
>
> There are no issues in doing simple ping operations across the
> ntb_netdev (TCP/IP) interface, including sending large packets which
> we know will cause the respective DMA engines to be utilized. However,
> while doing iperf testing across the ntb_netdev interface, we have
> encountered a panic:
>
> [ 1626.776583] RIP: 0010:mutex_spin_on_owner+0x3b/0xa0
> ....
> [ 1626.776588] Call Trace:
> [ 1626.776588]  <IRQ>
> [ 1626.776589]  __mutex_lock.isra.7+0xad/0x4c0
> [ 1626.776589]  ? ntb_transport_rx_enqueue+0x127/0x200 [ntb_transport]
> [ 1626.776589]  __mutex_lock_slowpath+0x13/0x20
> [ 1626.776590]  ? __mutex_lock_slowpath+0x13/0x20
> [ 1626.776590]  mutex_lock+0x2f/0x40
> [ 1626.776590]  pt_core_perform_passthru+0xc5/0x160 [ptdma]
> [ 1626.776591]  pt_cmd_callback.part.7+0x262/0x2d0 [ptdma]
> [ 1626.776591]  pt_cmd_callback+0x13/0x20 [ptdma]
> [ 1626.776591]  pt_check_status_trans+0xc3/0x120 [ptdma]
> [ 1626.776592]  pt_core_irq_handler+0x36/0x60 [ptdma]
> [ 1626.776592]  __handle_irq_event_percpu+0x44/0x1a0
> [ 1626.776592]  handle_irq_event_percpu+0x32/0x80
> [ 1626.776593]  handle_irq_event+0x3b/0x60
> [ 1626.776593]  handle_edge_irq+0x83/0x1a0
> [ 1626.776593]  handle_irq+0x20/0x30
> [ 1626.776593]  do_IRQ+0x50/0xe0
> [ 1626.776594]  common_interrupt+0xf/0xf
>
> The issue is that the ptdma handlers are getting called in interrupt
> context, and ultimately the flow leads to pt_core_execute_cmd() which
> will attempt to grab a mutex, which is really not appropriate in
> interrupt context. I have temporarily changed the lock in question to
> a spinlock, which seems to have resolved the issue. However, I don't
> know enough about the ptdma driver to really know if this is the
> desired repair.
>
> Hoping that others with more knowledge in this driver might be able to
> comment as to the validity of this bug and whether a spinlock is the
> correct approach here. If it is, I would be happy to submit a patch,
> otherwise I can just file a bugzilla for the module owner to make a
> more appropriate fix.
>
> Thanks for any advice.
>
> Eric Pilmore

I haven't heard any further on this, so I filed a bugzilla so it
doesn't get lost.

Eric
