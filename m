Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA425776F
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaKhi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaKh1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07AFC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q1so2747952pjd.1
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YQfJ+Sb0Q5/2M2e0heN4P//qipJlVXjh7n6mVCID2I=;
        b=MQyEA9/779ut0htXTcYvI5VFs1Tdz9xiEN9mEFxUNzn9O0fm1KveFOdThZga4bpHJU
         J4BdB0o5IJnEsSX77vNyHz/DTE4JJuBH1o3ljMOAtn7Ly7bM0KeSyXR/kupYcwmgEyEQ
         paBhNBj811e04fmye3L18DsYm4e/KSlDJrV6+i0c9Mj+sy5/yz9vnTJuugeR6JV1Lm2b
         86u2Bi444gUq49RcdOH8d7fE2b2DAoDV1K7+qMlACtLnrHb7G4ywBjcUB/bX7G5tYonf
         wKOfFbSjamj8remMAbzNQXdebBjBUdtwNy4mxtXVpA6LWUdcdcvSqwSU1dp0ijXE/UUa
         +nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YQfJ+Sb0Q5/2M2e0heN4P//qipJlVXjh7n6mVCID2I=;
        b=ErNIL24Mhik+0TKDyLpByhw/zbIiDQKOdP/GCKZeLBKX9vqbQVZXwZvz+yQR6tIwBc
         d9PLdLKm7TMc2WY1EumiXWTsje8KDZDh+0B52icMgc/jfHCq4I5JpZf4ZvZk+xdWMzqr
         91FJ6uCXRLEi9BSimgzVSbTYsTynNkCkehL1LXXDFN0VM/xsIEZs7ve88xpkNB19EZf1
         6Pby81n9HggZWsFh8a6aEiIIghgVISkKi/lUnyXbye2I0NVOU4Y56HjrS+gRteo8yD1B
         6NRCEJbXCJGQlnwOSAg8GZJZsStb7QHXEMmQ373w0RppafHZGe458v53K/HhQzpD5v7Y
         Hrtw==
X-Gm-Message-State: AOAM533gcTkVobg2gNMZWwRsO/OD2PfDd2BulCNtFIyVyD79bRkHCS6M
        ZIsn1rPwXklUp2KUDu4XRy8=
X-Google-Smtp-Source: ABdhPJyIzXh4jnJwAt13ZHTLy+A2PmL7plvF8w1Q8Y2ufyENs+NFdWiNqimko0msQg947NQ0Ar1+RQ==
X-Received: by 2002:a17:90b:885:: with SMTP id bj5mr739857pjb.133.1598870246454;
        Mon, 31 Aug 2020 03:37:26 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:26 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 16/35] dmaengine: mv_xor: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:23 +0530
Message-Id: <20200831103542.305571-17-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/mv_xor.c    | 7 +++----
 drivers/dma/mv_xor_v2.c | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0ac8e7b34e12..00cd1335eeba 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -336,9 +336,9 @@ static void mv_chan_slot_cleanup(struct mv_xor_chan *mv_chan)
 		mv_chan->dmachan.completed_cookie = cookie;
 }
 
-static void mv_xor_tasklet(unsigned long data)
+static void mv_xor_tasklet(struct tasklet_struct *t)
 {
-	struct mv_xor_chan *chan = (struct mv_xor_chan *) data;
+	struct mv_xor_chan *chan = from_tasklet(chan, t, irq_tasklet);
 
 	spin_lock(&chan->lock);
 	mv_chan_slot_cleanup(chan);
@@ -1097,8 +1097,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	mv_chan->mmr_base = xordev->xor_base;
 	mv_chan->mmr_high_base = xordev->xor_high_base;
-	tasklet_init(&mv_chan->irq_tasklet, mv_xor_tasklet, (unsigned long)
-		     mv_chan);
+	tasklet_setup(&mv_chan->irq_tasklet, mv_xor_tasklet);
 
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9225f08dfee9..2753a6b916f6 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -553,9 +553,10 @@ int mv_xor_v2_get_pending_params(struct mv_xor_v2_device *xor_dev,
 /*
  * handle the descriptors after HW process
  */
-static void mv_xor_v2_tasklet(unsigned long data)
+static void mv_xor_v2_tasklet(struct tasklet_struct *t)
 {
-	struct mv_xor_v2_device *xor_dev = (struct mv_xor_v2_device *) data;
+	struct mv_xor_v2_device *xor_dev = from_tasklet(xor_dev, t,
+							irq_tasklet);
 	int pending_ptr, num_of_pending, i;
 	struct mv_xor_v2_sw_desc *next_pending_sw_desc = NULL;
 
@@ -780,8 +781,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_msi_irqs;
 
-	tasklet_init(&xor_dev->irq_tasklet, mv_xor_v2_tasklet,
-		     (unsigned long) xor_dev);
+	tasklet_setup(&xor_dev->irq_tasklet, mv_xor_v2_tasklet);
 
 	xor_dev->desc_size = mv_xor_v2_set_desc_size(xor_dev);
 
-- 
2.25.1

