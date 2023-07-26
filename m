Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2F7630DB
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjGZJFB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 05:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjGZJEj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 05:04:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E9DB;
        Wed, 26 Jul 2023 02:02:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5992599b3a.0;
        Wed, 26 Jul 2023 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690362147; x=1690966947;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEZHGYX9dSDjbkw+aqvi35n/7qtSj+sTI/JiA4c39II=;
        b=n2HBSdB02c7mJmWrF/S0v8noxz6ai5qOYg2YO642G1SLlkfcrbgTlkYvG2upmvKNGT
         ld2kQlhwfstGKK/QkwBbmAE4ifJR94v9IzQDz2hLu+dMDAUxAeaAi9SFbyigst74nn+C
         mKRD2aYgGQA6qRA15V2uN+zXcwu5pvNUkoV2IQz+G/GnKyCijWfdl5eX0ZmoI3Hn/21T
         wPoFZx87qRJJaf+9RFVdGTthHvA0Z7xRo4Qg41lXWXg2Yejc5O0gO8d1NhxchTqzYL6S
         95+I3xnnmNBPpcKZnMECO5FU/mWJRAOcpY+r3+bqzTikR/J4ksE4yAKoX/56FEIl1jvg
         OHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362147; x=1690966947;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEZHGYX9dSDjbkw+aqvi35n/7qtSj+sTI/JiA4c39II=;
        b=iwvU9i9XXk7ABenCy5gymG+GMEXL2svopVmceCwE3MY0hWSRRIuvJnj8gXQjEiOgvE
         FXGBn6MpREPVFLwxsBST+HRo84n+pGfTyNcYCRlbbfq6DoCTIZUSBUJIfSWRdRTBFzM0
         +lyclILaiiYPqzK4iC/qPi3qd2lEGCUqvljlIYxuTtl0UwpoxLtXO95tIQatyv4AglAv
         r5oQInswpIYvs0ZbrN5TdI9aY94DPvrGqIKKUlvK13IXKbq/nulnNDuerNXJhXBR6fTW
         vSYWDHb5VedgM6UxVw1fmBdvI1rE+pf3DEnzSRoV+rokwKeV+4TWiouoCwWh3GOVuCPF
         qp9w==
X-Gm-Message-State: ABy/qLas7sdIPxEHi5BVUtMgA9A5tSIqTtki7C2q8R6aQUIfbt1HHBjv
        KdfJvTxi8LgEzM60KqYbM9c=
X-Google-Smtp-Source: APBJJlHcS8YQs4kPk6Qj6ozIXE01IrlQGjLIravDLzQ2u3g9XT8qrNNNQrMWtDCAt4tXP9vRA9YjCg==
X-Received: by 2002:a05:6a00:2e11:b0:67b:8602:aa1e with SMTP id fc17-20020a056a002e1100b0067b8602aa1emr1809504pfb.28.1690362146676;
        Wed, 26 Jul 2023 02:02:26 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b0067f2413bf6dsm10967454pfa.106.2023.07.26.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:02:26 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, len.baker@gmx.com,
        aswinder.singh@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: milbeaut-hdmac: Fix potential deadlock on &mc->vc.lock
Date:   Wed, 26 Jul 2023 09:02:04 +0000
Message-Id: <20230726090204.1458-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As &mc->vc.lock is acquired by milbeaut_hdmac_interrupt() under irq
context, other acquisition of the same lock under process context should
disable irq, otherwise deadlock could happen if the irq preempts the
execution of process context code while the lock is held in process context
on the same CPU.

milbeaut_hdmac_chan_config(), milbeaut_hdmac_chan_resume() and
milbeaut_hdmac_chan_pause() are such callback functions not disable irq by
default.

Possible deadlock scenario:
milbeaut_hdmac_chan_config()
    -> spin_lock(&mc->vc.lock)
        <hard interruption>
        -> milbeaut_hdmac_interrupt()
        -> spin_lock(&mc->vc.lock); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
the three callback functions to disable irq while lock is held.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/milbeaut-hdmac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 1b0a95892627..6151c830ff6e 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -214,10 +214,11 @@ milbeaut_hdmac_chan_config(struct dma_chan *chan, struct dma_slave_config *cfg)
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
 
-	spin_lock(&mc->vc.lock);
+	spin_lock_irqsave(&mc->vc.lock, flags);
 	mc->cfg = *cfg;
-	spin_unlock(&mc->vc.lock);
+	spin_unlock_irqrestore(&mc->vc.lock, flags);
 
 	return 0;
 }
@@ -226,13 +227,14 @@ static int milbeaut_hdmac_chan_pause(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
 	u32 val;
 
-	spin_lock(&mc->vc.lock);
+	spin_lock_irqsave(&mc->vc.lock, flags);
 	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
 	val |= MLB_HDMAC_PB;
 	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
-	spin_unlock(&mc->vc.lock);
+	spin_unlock_irqrestore(&mc->vc.lock, flags);
 
 	return 0;
 }
@@ -241,13 +243,14 @@ static int milbeaut_hdmac_chan_resume(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
 	u32 val;
 
-	spin_lock(&mc->vc.lock);
+	spin_lock_irqsave(&mc->vc.lock, flags);
 	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
 	val &= ~MLB_HDMAC_PB;
 	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
-	spin_unlock(&mc->vc.lock);
+	spin_unlock_irqrestore(&mc->vc.lock, flags);
 
 	return 0;
 }
-- 
2.17.1

