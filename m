Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E576314D
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGZJKx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjGZJKX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 05:10:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5D4C28;
        Wed, 26 Jul 2023 02:06:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9e9765f2cso34354235ad.3;
        Wed, 26 Jul 2023 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690362397; x=1690967197;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEZHGYX9dSDjbkw+aqvi35n/7qtSj+sTI/JiA4c39II=;
        b=V8/deSWmG396BLvgSvQm/q/sW8F4ll0rggeYWR5l7A1QI2BE44QCvNG7DhKQZO+nUz
         Hl5Q4LrptJuN29klB4Km3mt68+InGxb6/U7hco5KUJ3lQvQR4GYjfUFuGFXCGMxaml5q
         FMJZhM4dV4PMEfc8jYk/dt8fywgBl5rsoi3UojvQ+9GteT8aiF4/P5pKgdmYQ1AshnNa
         sXl9SwGwPRNdprlYrD3xXSpWrQ2EJcMZ4wAoIj8fNceR6yiqG2ivqD25XJ5VnI+TiDaO
         03gqQUh7uPumgXfzNv3cW7w81plFxpU4kCzz8sVjJc/ReFbt9FYVjQDQr+Kk634bCYZG
         fjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362397; x=1690967197;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEZHGYX9dSDjbkw+aqvi35n/7qtSj+sTI/JiA4c39II=;
        b=l63F1IvDPX+rg4xVjnkFL1Zj+wnhfr+lf2nlUKvL3IbE5ITapRC4XArrgOfrTc1A51
         BEtzC3Bcok23qElNXgmklNYx9pQSfOwz9YnLgLqxhLmrOT5d/9B5nL2vUS9zuGZnpNbF
         5mX0Z0WJBBUpNIPODj0lxLYy29eIYWmuuaJcUYhIWYjXlWE0fpHbCTBb6YbiZG+Rc6GT
         D4F3bb7hdcMZj7uB16Ru8WFuoaOiIQxUvBf+/amcrs8NcWlCzV9H1mkySc4PU1iJIvaq
         FzFHb3s9yuHNRP/QRsEH7dujO46uQbQNlG3UFF+kiNOKAcQkySdqqped/UWT2tbpauet
         w6Iw==
X-Gm-Message-State: ABy/qLZieuoQcUsH2+SmFq4OvETa8N3ze3GhO/jti4X8DxiHkIWSNk58
        v/TcJTtEcEUlHNW0p17Z//c=
X-Google-Smtp-Source: APBJJlFAL7nZwqV0hS+O4zyWNLpS8Aoc6RDig/MMKJhDEjWNVBlApPDpDmoY0T5+wYpdK3lwXSDJtw==
X-Received: by 2002:a17:902:728a:b0:1b9:dea2:800f with SMTP id d10-20020a170902728a00b001b9dea2800fmr1046434pll.8.1690362397271;
        Wed, 26 Jul 2023 02:06:37 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b7feed285csm12538593plx.36.2023.07.26.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:06:36 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, len.baker@gmx.com,
        jaswinder.singh@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH RESEND] dmaengine: milbeaut-hdmac: Fix potential deadlock on &mc->vc.lock
Date:   Wed, 26 Jul 2023 09:06:28 +0000
Message-Id: <20230726090628.1784-1-dg573847474@gmail.com>
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

