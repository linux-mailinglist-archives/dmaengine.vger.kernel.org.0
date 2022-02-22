Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967494BEF5E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 03:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiBVB4Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 20:56:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBVB4P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 20:56:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E025C4B;
        Mon, 21 Feb 2022 17:55:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y24so9488849lfg.1;
        Mon, 21 Feb 2022 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggSDpVECXelegeqZDgEPwPilMcN1aFE9YOivy1REeIU=;
        b=MCZBsv+Lqmb8N+DdFgswyexG1GwAK4B2nswhJmWpL75R2Ky1sXeAb1AXW7394HohKO
         bdWwGHx6uDaA9cbj9ybzH71+vQWDVPPB8+MBR6aDCHOTt2FFhcNBgETyELlbKQ34+uxi
         RFzzlYVqH6Ikfkz5Fftwfrp4hWCBSdwMcngf3wue9aXN29BeKAjV+YAyiziS8tbFvz6V
         vOVBmBz01b/ZlbhYuOiAjBTDeIoC9rLgIHyArQtmQ3EUKF57KATATu4ohV9mKYSg9lSB
         RDlPln/4UBYF5Yt0HGDkhxMaaAFsyaciuXOJjh3Q2AFjFIGbsqmHdUt6f5AvYRyvf7C3
         G8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggSDpVECXelegeqZDgEPwPilMcN1aFE9YOivy1REeIU=;
        b=fxzk338KPHKtfvfxmcH1m8rBTELvrUHjyBBQYEFKWW9YAR3A9FLEaaglNuAkQs/5Cn
         SoqqOJXr7Fm1cS/I3P30XGmbAlPrZr+/CWysvttk55MGU6/WEigh/uGeCpc/3zecwiMy
         G435J3VzzV/7KgIHQSP07pPJEZgqf7gYSJy7jPeuYSjQ+Xp5lu5g277j3yT94JId0w8G
         h/goX1+RL5zYiVKkD53i8+3weYd6gzQKM6wRNvE1iqCw5pOCIIeRiWQw0rs6eBsrNEwD
         dsyl2xPazxiAF8ED8xZQYloWQBIBr2mHvb4ZBeOyY/iGCH4JitNwPd+KTIZZ1HUlwjnz
         zgnQ==
X-Gm-Message-State: AOAM5326E10vu4Ep7dm+mmd3CyMNRCZUTqt69hjt0FjnKdVADxHlvMRe
        WU4muQ1nkEiiWxrzDDzPZwmUxLvPwyv9KEa0
X-Google-Smtp-Source: ABdhPJz5J27IkdttabqmKuwyNvBN6yZaQ018z2PxNWtxdIJJeHtm9h5v2dlBGJcUerwxQInb3/T21Q==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr15552951lfh.629.1645494949014;
        Mon, 21 Feb 2022 17:55:49 -0800 (PST)
Received: from TebraArch.. ([81.198.32.225])
        by smtp.gmail.com with ESMTPSA id m7sm1541683ljh.47.2022.02.21.17.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 17:55:48 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH v2] dmaengine: fix async channel removal for dma_issue_pending_all
Date:   Tue, 22 Feb 2022 03:53:26 +0200
Message-Id: <20220222015325.14245-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217205147.35586-1-davispuh@gmail.com>
References: <20220217205147.35586-1-davispuh@gmail.com>
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

dma channels can be removed asynchronously while we iterate over them.
Without this various crashes can happen in dma_issue_pending_all.

One such example:

kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page
kernel: PGD 0 P4D 0
kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
kernel: RIP: 0010:dma_issue_pending_all (drivers/dma/dmaengine.c:562)
All code
========
   0:   48 8b 45 20             mov    0x20(%rbp),%rax
   4:   48 8d 68 e0             lea    -0x20(%rax),%rbp
   8:   48 3d 60 36 35 bc       cmp    $0xffffffffbc353660,%rax
   e:   74 4d                   je     0x5d
  10:   48 8b 45 48             mov    0x48(%rbp),%rax
  14:   f6 c4 02                test   $0x2,%ah
  17:   75 e7                   jne    0x0
  19:   48 8b 45 10             mov    0x10(%rbp),%rax
  1d:   4c 8d 65 10             lea    0x10(%rbp),%r12
  21:   48 8d 58 c8             lea    -0x38(%rax),%rbx
  25:   49 39 c4                cmp    %rax,%r12
  28:   74 d6                   je     0x0
  2a:*  8b 43 50                mov    0x50(%rbx),%eax          <-- trapping instruction
  2d:   85 c0                   test   %eax,%eax
  2f:   74 0f                   je     0x40
  31:   48 8b 85 88 01 00 00    mov    0x188(%rbp),%rax
  38:   48 89 df                mov    %rbx,%rdi
  3b:   0f ae e8                lfence
  3e:   ff d0                   call   *%rax

kernel: RSP: 0018:ffffbc5004897de8 EFLAGS: 00010282
kernel: RAX: 0000000000000000 RBX: ffffffffffffffc8 RCX: 0000000000000000
kernel: RDX: ffff9c2300e36a28 RSI: 0000000000000202 RDI: ffff9c2300e36a10
kernel: RBP: ffff9c24473a3970 R08: 0000000000000001 R09: 0000000000000000
kernel: R10: ffff9c23ab165ea9 R11: 0000000000000000 R12: ffff9c24473a3980
kernel: R13: ffff9c2367bca000 R14: ffff9c23112ae000 R15: 0000000000000000
kernel: FS:  0000000000000000(0000) GS:ffff9c2a5d500000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000018 CR3: 0000000700d0a000 CR4: 00000000003506e0
kernel: Call Trace:
kernel:  <TASK>
kernel: raid5d (drivers/md/raid5.c:6563) raid456
kernel: ? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6370 (discriminator 1))
kernel: md_thread (drivers/md/md.c:7923) md_mod
kernel: ? do_wait_intr (kernel/sched/wait.c:415)
kernel: ? md_submit_bio (drivers/md/md.c:7887) md_mod
kernel: kthread (kernel/kthread.c:377)
kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
kernel:  </TASK>

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 drivers/dma/dmaengine.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..fe53a507a8f95 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -360,7 +360,7 @@ static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
  */
 static void dma_channel_rebalance(void)
 {
-	struct dma_chan *chan;
+	struct dma_chan *chan, *n;
 	struct dma_device *device;
 	int cpu;
 	int cap;
@@ -373,7 +373,7 @@ static void dma_channel_rebalance(void)
 	list_for_each_entry(device, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
-		list_for_each_entry(chan, &device->channels, device_node)
+		list_for_each_entry_safe(chan, n, &device->channels, device_node)
 			chan->table_count = 0;
 	}
 
@@ -552,18 +552,18 @@ EXPORT_SYMBOL(dma_find_channel);
  */
 void dma_issue_pending_all(void)
 {
-	struct dma_device *device;
-	struct dma_chan *chan;
+	struct dma_device *device, *_d;
+	struct dma_chan *chan, *n;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
-		list_for_each_entry(chan, &device->channels, device_node)
+		list_for_each_entry_safe(chan, n, &device->channels, device_node)
 			if (chan->client_count)
 				device->device_issue_pending(chan);
 	}
-	rcu_read_unlock();
+	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL(dma_issue_pending_all);
 
-- 
2.35.1

