Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019F94BEF62
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 03:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiBVCTd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 21:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBVCTc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 21:19:32 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F924BE7;
        Mon, 21 Feb 2022 18:19:06 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id g15so3239674ual.11;
        Mon, 21 Feb 2022 18:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ufMpXyX8wvbwg6lkdn4RGY7MXdJTpjdjeP8aaHnNrQA=;
        b=XTg1Lyd927xtSqxfId1zvPsqC1RRDeBFnszhoz25/0QLs7Wtc7+MaP2aHo8Xg7r6ep
         4DTBABrElucb30U56gXykbj7kqzwSLKhjb/uyVmSbxmqTyfcr2E18Mpa4KJua/ddCa8/
         YdgSMbUktnZEYP3ZmcemAFqpEg2xQONfeXgl6DH0h1fs8ze1+s3+YWu35eNGwHXZThUZ
         uqyq9EcBQ3bGrOvV8WI1lxJsIrs0IGz5XDEFPgCJHs4tHy8Y6912K42lj0hrnXCXYaP9
         BAGHm4EfuLqgMxp8t6JDzaN8TMrr6CjGNrWfI91cZsrd5oM6E/6trfrA9wv12eXkvtZW
         xRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ufMpXyX8wvbwg6lkdn4RGY7MXdJTpjdjeP8aaHnNrQA=;
        b=a65WSvvDedrD+H6Lb4ZyJOl+CYf81uaiMIqfeiLiQc/0kCJXZjoBqNm3tSLbJHiaRf
         L/PgLI/l8xnbnp0zdsFXzACtFA7UJ1nlCz9X2Gu7kiyibVYt6SxBTg1TFEZDoymFTExh
         Me+IKNKL7k8ONjXB+R/G+XYM6Tlu1pAUPNeTuNbb8YzeDXVnPIWnH2WYTP6SdsSTToIg
         Y2UimyxOd+Y9Y+8zeXQyStmpRd+vqMjUctgs8+QdQ0v8VKHDO8WD3sxydq5nuKHEfeQR
         JkIpbDnRI0KsVzpeYRWL6SpP2vMPzsq1GWa5u56aT04yrsnYelkCor9uCNgQySYL3cRc
         rocQ==
X-Gm-Message-State: AOAM530LB/8JHyt3un6qvsVzWYU47KohR18uzvF/uB0W2ojSi8F41vHV
        eTpHhGDim1NPvbRQz0qHmDnJAmhbSufttpWcDuClrX2k1mSX1EGT7e0=
X-Google-Smtp-Source: ABdhPJxwqVa3AIlybnf3f5tdqduw8XU2dXs+0RF/ibIsBOCyL8UdoD09ohRskCESzbUNHxTFQ0G2/dqOkvvymabZjmY=
X-Received: by 2002:a9f:25b3:0:b0:342:8ed1:d4c6 with SMTP id
 48-20020a9f25b3000000b003428ed1d4c6mr3161554uaf.128.1645496345875; Mon, 21
 Feb 2022 18:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20220222015849.14727-1-davispuh@gmail.com>
In-Reply-To: <20220222015849.14727-1-davispuh@gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Tue, 22 Feb 2022 04:18:54 +0200
Message-ID: <CAOE4rSyDy8U-_DZ31gUe4KQddrxKD+EiiKQwR7QtDzqWO69Mnw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: fix locking for dma_channel_rebalance
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

otrd., 2022. g. 22. febr., plkst. 03:59 =E2=80=94 lietot=C4=81js D=C4=81vis=
 Mos=C4=81ns
(<davispuh@gmail.com>) rakst=C4=ABja:
>
> dma_channel_rebalance comment says:
> >  Must be called under dma_list_mutex
>
> We have few places where it wasn't done and could cause crashes.
> So invoke it only when it's under mutex.
> ---
>  drivers/dma/dmaengine.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2cfa8458b51be..5198bdf7ee804 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1098,7 +1098,10 @@ int dma_async_device_channel_register(struct dma_d=
evice *device,
>         if (rc < 0)
>                 return rc;
>
> +       mutex_lock(&dma_list_mutex);
>         dma_channel_rebalance();
> +       mutex_unlock(&dma_list_mutex);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
> @@ -1124,7 +1127,9 @@ void dma_async_device_channel_unregister(struct dma=
_device *device,
>                                          struct dma_chan *chan)
>  {
>         __dma_async_device_channel_unregister(device, chan);
> +       mutex_lock(&dma_list_mutex);
>         dma_channel_rebalance();
> +       mutex_unlock(&dma_list_mutex);
>  }
>  EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
>
> --
> 2.35.1
>

Seems there still is some issue left, but I haven't been able to
figure out how exactly.
At least with both of my patches it doesn't happen that often anymore
but still can be reproduced trying unregister/register in fast
succession with like 10% chance for crash.

    list_for_each_entry(device, &dma_device_list, global_node) {
        if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
            continue;
376: list_for_each_entry_safe(chan, &device->channels, device_node)  <-----=
---
            chan->table_count =3D 0;
    }

BUG: unable to handle page fault for address: 00000005d2fb3000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:dma_channel_rebalance (drivers/dma/dmaengine.c:376)

All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   3d e0 7a 18 94          cmp    $0x94187ae0,%eax
   5:   75 12                   jne    0x19
   7:   eb 5c                   jmp    0x65
   9:   48 8b 47 20             mov    0x20(%rdi),%rax
   d:   48 8d 78 e0             lea    -0x20(%rax),%rdi
  11:   48 3d e0 7a 18 94       cmp    $0xffffffff94187ae0,%rax
  17:   74 4c                   je     0x65
  19:   48 8b 47 48             mov    0x48(%rdi),%rax
  1d:   f6 c4 02                test   $0x2,%ah
  20:   75 e7                   jne    0x9
  22:   48 8b 4f 10             mov    0x10(%rdi),%rcx
  26:   48 8d 77 10             lea    0x10(%rdi),%rsi
  2a:*  48 8b 01                mov    (%rcx),%rax              <--
trapping instruction
  2d:   48 8d 51 c8             lea    -0x38(%rcx),%rdx
  31:   48 83 e8 38             sub    $0x38,%rax
  35:   48 39 ce                cmp    %rcx,%rsi
  38:   74 cf                   je     0x9
  3a:   c7                      .byte 0xc7
  3b:   42 54                   rex.X push %rsp
  3d:   00 00                   add    %al,(%rax)

RSP: 0018:ffffbf7e51f43be0 EFLAGS: 00010246
RAX: 00000005d2fba000 RBX: 0000000000000010 RCX: 00000005d2fb3000
RDX: ffffa058813f4e00 RSI: ffffa05a3b24ce38 RDI: ffffa05a3b24ce28
RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000140 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000080 R14: ffffa05ceef70e00 R15: ffffa05ceef70e20
FS:  00007f4c901a1e40(0000) GS:ffffa05fdb980000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000005d2fb3000 CR3: 00000005c1f24000 CR4: 00000000003506e0
Call Trace:
 <TASK>
dma_async_device_unregister (drivers/dma/dmaengine.c:1338)
ccp_dmaengine_unregister (drivers/crypto/ccp/ccp-dmaengine.c:756) ccp
ccp5_destroy (drivers/crypto/ccp/ccp-dev-v5.c:1016) ccp
sp_destroy (drivers/crypto/ccp/sp-dev.c:208) ccp
sp_pci_remove (drivers/crypto/ccp/sp-pci.c:99
drivers/crypto/ccp/sp-pci.c:265) ccp
pci_device_remove (./arch/x86/include/asm/atomic.h:29
./include/linux/atomic/atomic-arch-fallback.h:1158
./include/linux/atomic/atomic-arch-fallback.h:1183
./include/linux/atomic/atomic-instrumented.h:608
./include/linux/pm_runtime.h:132 drivers/pci/pci-driver.c:465)
__device_release_driver (drivers/base/dd.c:1208)
device_driver_detach (./include/linux/device.h:782
drivers/base/dd.c:1047 drivers/base/dd.c:1239 drivers/base/dd.c:1273)
unbind_store (drivers/base/bus.c:194)
kernfs_fop_write_iter (fs/kernfs/file.c:300)
new_sync_write (fs/read_write.c:504 (discriminator 1))
vfs_write (fs/read_write.c:590)
ksys_write (fs/read_write.c:643)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
? do_fcntl (./include/linux/spinlock.h:390 fs/fcntl.c:82 fs/fcntl.c:356)
? lock_release (kernel/locking/lockdep.c:5315 kernel/locking/lockdep.c:5659=
)
? rcu_read_lock_sched_held (kernel/rcu/update.c:125)
? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4232
kernel/locking/lockdep.c:4292)
? do_syscall_64 (arch/x86/entry/common.c:87)
? do_syscall_64 (arch/x86/entry/common.c:87)
? rcu_read_lock_sched_held (kernel/rcu/update.c:125)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)

Best regards,
D=C4=81vis
