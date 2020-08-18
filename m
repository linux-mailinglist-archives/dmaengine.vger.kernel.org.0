Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF424816F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRJIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJIK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EEAC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c10so9121103pjn.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zY00DfBPk2FI3CMNWn52CBXvi0OzneRvuEaVydUrqYM=;
        b=ubyNGXhGQbbATp/qTeppTRsn/+9ryNh2V4G7MV+EX3ArP+CyhD4n4EYjWA8K31l4LR
         Eg4zqsgEp7f8XNT4yYKnS909UWnj5vgqQN1KHvIx7L8awu2gZaMAhZWiqH1d+BMtgh6w
         x+LqymLxo0Ay5wD/AdQ3O4OyjdeibgG6Wp61L73nACPmKV/83CYlabXO4ZRzNI9LudU7
         ShHt5Zolw0+KP9yUsm+uCpIkKUjIqnw51CUW1ad7MxlKlxnuvwR4eJyu1+FfhPtpRzjx
         2ipSZPhp0EeZhD1Lvk7eaW3kjuQQcvlhAqAja+HIan0Toe0XkD2Mt1L/5mWT2peWMlcp
         iYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zY00DfBPk2FI3CMNWn52CBXvi0OzneRvuEaVydUrqYM=;
        b=s9qgJzWT2fH6oP9TShQw0cbMyLY2u2ajP9Mhpk8DwOh8me43yXlrhd2Wnz5yb1kSEr
         uAWTqV6QsltOG+A28fArLDP9l+/MGkRQOeNjNRkWNoG4hmfpARgHJAu6esB1fAtdXHT3
         DUHRPe9qXQUtkWFuWnL5MS6FWxYJdWa8QZys6cJORRBQ2UfPz04cJWLsUIrvtnHlTxQV
         rNG9PxtyBngQZnveziM6l9PrNyoTpc51MfeM2UgZ7b3OjnNSMT05FXuQxMuWkY+BcKrb
         JktC8Vu827xF8shJ5OFluEzdJnPQSYkxXqz6IpyvOF5SxXS/1DrCIgPr48zMmWYCj1qn
         FiOA==
X-Gm-Message-State: AOAM53385K+iZ/50dEENtnHpud8LKp4VdHLNPJm5jHvWy0YNgkgFRvlW
        xY5nvznj9FjuoCajE2JEv8E=
X-Google-Smtp-Source: ABdhPJxbx9Q9X8M3/dssIcXlxZB7wuWgRIOHdIqO8FWqVeB7j5hdYGKjmYgwnYoLy0SScf4hUrC3+g==
X-Received: by 2002:a17:90a:a50d:: with SMTP id a13mr15760061pjq.180.1597741689583;
        Tue, 18 Aug 2020 02:08:09 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:09 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 16/35] dma: mv_xor: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:19 +0530
Message-Id: <20200818090638.26362-17-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
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
2.17.1

