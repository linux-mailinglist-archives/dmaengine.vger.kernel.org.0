Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358F4C61CB
	for <lists+dmaengine@lfdr.de>; Mon, 28 Feb 2022 04:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiB1D2m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Feb 2022 22:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiB1D2m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Feb 2022 22:28:42 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9914617E;
        Sun, 27 Feb 2022 19:28:03 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 29so15503690ljv.10;
        Sun, 27 Feb 2022 19:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0iBLGB6HbzcC/iu5C+tQ5/tqPh9n64xyr0lLd4iYHo=;
        b=ZF5UETI4VTidqFP9bbw3TPgD2GpLVYf4pcBw30K60JzUs/r1KdZffYG2jqnJ0paG0I
         XfQ+dFmoC5MGJXu51Gwsficq2AAtLQqHm7mpd43crSXSxfLhthtUwFvBcArswygRk1CB
         M9IZ4K5beNoEefHVavTCT6dKEER7KBiV0pZ3YFqXMOVY6Jgnu1zUOeU67ZEpk2mVoLBf
         Icb7cg6P+8l9u/mIOKbT7e4kC3lliqkK0PnpkZCoQp/+Hb9uUGfwFLRTk3bI64O6Ngxf
         5RXIB6B7UQJK0hn/jeWF1TrdsrSHO34fDdXDlUk/LdKJnPLBgC6e+wJSDStKyzW3x1PZ
         Hiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0iBLGB6HbzcC/iu5C+tQ5/tqPh9n64xyr0lLd4iYHo=;
        b=H5FTCAPV9PAMDv85t005nU6OsZnQunBP4QwHiNoLoIgAAoQeSDxl7RZFwAacp6JxwW
         EGsguk5isy1j0tmhgyifJvjmbIOKBfVovkbA68EfDrcLtsE66Oo9ClEOcDPfus/tGAqr
         YXhwepFddNshc0kfwhmp5LA9lm/Dt8qfvscvhxQBtJ17taEp1cKT3znYGrFjwQchhkZc
         WXcZGExmyLJF5ljOf12z9cCfQ+bDA5upBvAQ8NHQp5o2yOljeFRSbv8xJ7EcOY7oLC5T
         5TJH67KSzszYXdvMYUNQ2nhY73GHL4ve3iMMJ5m0FZrD1Zr6/WjwG5t9sCpYAwyShkAB
         NwsQ==
X-Gm-Message-State: AOAM532pLQY/aIwjXAqXfxOTK0INe3n4/BIL08wuDoqZDj7lJMV6xPAC
        Hwv8eJ33L+w5B3Z9LCb9tAyvn1W6+KSkXA==
X-Google-Smtp-Source: ABdhPJz5kBegtKMzwPNC4wxduFoN72FRtYSKaw3qVAAfuvxdgp/eR+BaipHMJmlX273E2cg0BzaPxg==
X-Received: by 2002:a2e:990e:0:b0:240:ab6:da94 with SMTP id v14-20020a2e990e000000b002400ab6da94mr12898373lji.274.1646018881856;
        Sun, 27 Feb 2022 19:28:01 -0800 (PST)
Received: from TebraArch.. ([81.198.32.225])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e924b000000b0024649082c0dsm1109420ljg.118.2022.02.27.19.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 19:28:01 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] dmaengine: release channels on device unregister
Date:   Mon, 28 Feb 2022 05:27:41 +0200
Message-Id: <20220228032741.13428-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently if dma_async_device_unregister is invoked while some clients
still hold a reference to some channels it would prevent device to be released
which would leave dangling pointers inside dma_device_list and cause crashes
in methods that tries to use it

Fix it by force releasing channels which will allow device to be also released

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:dma_issue_pending_all (drivers/dma/dmaengine.c:562)
All code
========
   0:   45 20 49 8d             and    %r9b,-0x73(%r9)
   4:   55                      push   %rbp
   5:   20 4c 89 ed             and    %cl,-0x13(%rcx,%rcx,4)
   9:   48 83 e8 20             sub    $0x20,%rax
   d:   48 81 fa e0 7a 18 b2    cmp    $0xffffffffb2187ae0,%rdx
  14:   74 52                   je     0x68
  16:   49 89 c5                mov    %rax,%r13
  19:   48 8b 45 48             mov    0x48(%rbp),%rax
  1d:   f6 c4 02                test   $0x2,%ah
  20:   75 dc                   jne    0xfffffffffffffffe
  22:   48 8b 45 10             mov    0x10(%rbp),%rax
  26:   4c 8d 65 10             lea    0x10(%rbp),%r12
  2a:*  48 8b 08                mov    (%rax),%rcx              <-- trapping instruction
  2d:   48 8d 78 c8             lea    -0x38(%rax),%rdi
  31:   48 8d 59 c8             lea    -0x38(%rcx),%rbx
  35:   49 39 c4                cmp    %rax,%r12
  38:   75 05                   jne    0x3f
  3a:   eb c2                   jmp    0xfffffffffffffffe
  3c:   48 89 c3                mov    %rax,%rbx
  3f:   8b                      .byte 0x8b

RSP: 0018:ffff987e44a9fde0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8bdc410e6e00 RCX: 0000000000000000
RDX: ffff8bdc41700e48 RSI: ffffffffb090de19 RDI: ffff8bdc410e6e00
RBP: ffff8bdc41700e28 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8bdc41700e38
R13: ffffffffffffffe0 R14: ffff8bdc4b3e5000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8be39b380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000018e1b6000 CR4: 00000000003506e0
Call Trace:
 <TASK>
raid5d (drivers/md/raid5.c:6563) raid456
? rcu_read_lock_sched_held (kernel/rcu/update.c:104 kernel/rcu/update.c:123)
md_thread (drivers/md/md.c:7923) md_mod
? do_wait_intr (kernel/sched/wait.c:415)
? rdev_read_only.isra.0 (drivers/md/md.c:7887) md_mod
kthread (kernel/kthread.c:377)
? kthread_complete_and_exit (kernel/kthread.c:332)
ret_from_fork (arch/x86/entry/entry_64.S:301)
 </TASK>

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 drivers/dma/dmaengine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..92d4d0522694c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1112,6 +1112,9 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	mutex_lock(&dma_list_mutex);
 	device->chancnt--;
 	chan->dev->chan = NULL;
+	while (chan->client_count) {
+		dma_chan_put(chan);
+	}
 	mutex_unlock(&dma_list_mutex);
 	mutex_lock(&device->chan_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
-- 
2.35.1

