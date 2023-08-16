Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F59777E723
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbjHPRBC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbjHPRAg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 13:00:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4226A6;
        Wed, 16 Aug 2023 10:00:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26b7c16556eso1295174a91.1;
        Wed, 16 Aug 2023 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692205234; x=1692810034;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PYaXMe/nlp8yVrrb6yGMJtqNU4p8cj6vJCqISzfbDQ=;
        b=aE+Zc0+bDMFXuytHHOEjtSFikOls6o9h64eXNmdVlBVceWkTRtD3SClPyn5NvcCHDH
         VdxNW84FhE49loir0qeW0lQtI+Q5jMwYRxNJyiuktIvm7ZKWN81TW5Ws54wLTWP11zez
         Xb9TntzGuMTXfESjdkD4yeAjM7mtHqZ+ZEEc+1NBo7f7YycOcY5BzqlFgUMxJkVUJi9k
         5Utf/Rk5AEfneFqoRwwh1lJsYIU74yBULDdZ1mXJwfgbWDEC4r6jQjV5Uprt3LHSutqD
         pxMXg9LZ5Dujpp5Ah6+f5eFjtch7vP2VB89BKTLAZ08qanlgKrOEXxa36egphaQhqoQY
         RMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205234; x=1692810034;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PYaXMe/nlp8yVrrb6yGMJtqNU4p8cj6vJCqISzfbDQ=;
        b=RvY1XZu/UsUXRSodnhEEHCeNHqsXylYWMur6zdhQUfmL012Rlb/iiUBXSYVkgBW0+S
         EUEeEApcATtyGUS3YtcEX8xRSoBeWk5MWpeRDxgYFQ4PK889KWG+CbDE4r+twZpFNLI4
         BVAJkXU4vhp7kKwjE8Zof9RyhAE1zyx15owk0lRGrpXjAvnZeB8X6Ls2G+Esc6gQlEDV
         djvgGtj9aXGTBhxK7nNNH5oDTvZBTgiWelIdiguwy1lCXbyng7ySVzpvepwKPNBdubNH
         CecZptrVg9xV5eQR9aPUOekVwKQOVoiaPNRc0Tqph2RMISKUu34rBp/Szfri9beG6CQx
         ItAA==
X-Gm-Message-State: AOJu0Yy5yU8qQ7NsP+nZq6mlNeB0qJuSKtQ5GJGCL27mhzxvvOElSuEg
        3iKE/BggSVPDhCyU70m4+1E=
X-Google-Smtp-Source: AGHT+IGkennMBgjBNmFDn/FXs93MyYPFOqjjMuHUvzYfQ/6a0Z5X49K9MASilFYVNVNKBZxze8QtNg==
X-Received: by 2002:a17:90a:fd14:b0:268:42a2:35db with SMTP id cv20-20020a17090afd1400b0026842a235dbmr1903541pjb.48.1692205234144;
        Wed, 16 Aug 2023 10:00:34 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id n32-20020a17090a2ca300b00262d9b4b527sm12327087pjd.52.2023.08.16.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:00:33 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, len.baker@gmx.com,
        jaswinder.singh@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] dmaengine: milbeaut-hdmac: Fix potential deadlock on &mc->vc.lock
Date:   Wed, 16 Aug 2023 17:00:13 +0000
Message-Id: <20230816170013.4262-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Change in V2:
- Also change &mc->vc.lock to &vc->lock for uniformity consideration

---
 drivers/dma/milbeaut-hdmac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 1b0a95892627..5c664c8c10f5 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -214,10 +214,11 @@ milbeaut_hdmac_chan_config(struct dma_chan *chan, struct dma_slave_config *cfg)
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
 
-	spin_lock(&mc->vc.lock);
+	spin_lock_irqsave(&vc->lock, flags);
 	mc->cfg = *cfg;
-	spin_unlock(&mc->vc.lock);
+	spin_unlock_irqrestore(&vc->lock, flags);
 
 	return 0;
 }
@@ -226,13 +227,14 @@ static int milbeaut_hdmac_chan_pause(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
 	u32 val;
 
-	spin_lock(&mc->vc.lock);
+	spin_lock_irqsave(&vc->lock, flags);
 	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
 	val |= MLB_HDMAC_PB;
 	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
-	spin_unlock(&mc->vc.lock);
+	spin_unlock_irqrestore(&vc->lock, flags);
 
 	return 0;
 }
@@ -241,13 +243,14 @@ static int milbeaut_hdmac_chan_resume(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
 	u32 val;
 
-	spin_lock(&mc->vc.lock);
+	spin_lock_irqsave(&vc->lock, flags);
 	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
 	val &= ~MLB_HDMAC_PB;
 	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
-	spin_unlock(&mc->vc.lock);
+	spin_unlock_irqrestore(&vc->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

