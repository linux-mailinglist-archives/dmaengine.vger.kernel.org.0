Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D65B24815F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRJHN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJHN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8FDC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so9467954pgh.6
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYKSRTuJVIPdNCr61TO9wwSP37OM1E0JoVpfKCdbfwU=;
        b=J1kg8BHuCaeqt6FywppmHSu/99JqDjIiSQns65xaA8Eg6IAjGW3kLZIcLgfEEcHu5A
         ZLwJjhkl0yPtpdaRNLCbXu4+7qGdO1410ypZRdnTpgVfPbKKYNJEU+zI+iUi9raLc6VR
         Xq4nLU0jtOggMBEz8QVZyUg2lD7JRC37UShIxKWGr4TrAPH8Jvk9Iarl2Hnf136LG6NO
         s6C3dqI9qowUrS7Q73y0ZO36MhuAiBaClm10xfkSWNBOI1375CDvjGkaoKtMwyXNynoe
         dLNY47HWm0bilEoj6+k6l4sK6o/zDVvPGWPPUac+cQzBwsMDCmrWtDC0suFQcgWdYGrH
         80Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYKSRTuJVIPdNCr61TO9wwSP37OM1E0JoVpfKCdbfwU=;
        b=X/Mtbt6JkS+PorKKVHtxcErjc1L3UJJ5tY3Sk2ae7XqSKJwONwhoDA3+jnawrRBZmZ
         fqgTtVFZPBlL2c/fY3brfw1eEACPTYz8zisK4HNJYWcc8DINY3UYi3RRQtpkpGuc7Tec
         LY+unIiVA3uCoBffDu2IPjBQW/DSOap/zOvs/hFEmflKowsZErVmbO0ni3a6+kIIYFNR
         2kP2S/ajmkqhviKlu1ilLFgUMQ+GV5/inytxj+OzpKJDuOEAwxmZUzDc2Wa6PX4qLOQ4
         apicCjYLcFEUN8eIFnn8oIC/3KY6AOYYmb8uerIZmDrCafBYdfE67h+lmPD1qKWV3+BB
         adAA==
X-Gm-Message-State: AOAM531aX5Qe/1d5jUwPy2Cv9GQiVvgnPO8AgixE9dQ8A3yLXXPHbRMa
        uwTJQ45dEiyt5CgXfZ89Xcs=
X-Google-Smtp-Source: ABdhPJxYyv8O5wuqmMkTxsrAvZ1bfDdZhIaKkaBGrsmxrH9/gsyc3biYt5aVPH4XmR7vl+Vn/RJ8RA==
X-Received: by 2002:aa7:9f92:: with SMTP id z18mr14477383pfr.260.1597741632837;
        Tue, 18 Aug 2020 02:07:12 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:12 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 04/35] dma: coh901318: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:07 +0530
Message-Id: <20200818090638.26362-5-allen.lkml@gmail.com>
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
 drivers/dma/coh901318.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 1092d4ce723e..95b9b2f5358e 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1868,9 +1868,9 @@ static struct coh901318_desc *coh901318_queue_start(struct coh901318_chan *cohc)
  * This tasklet is called from the interrupt handler to
  * handle each descriptor (DMA job) that is sent to a channel.
  */
-static void dma_tasklet(unsigned long data)
+static void dma_tasklet(struct tasklet_struct *t)
 {
-	struct coh901318_chan *cohc = (struct coh901318_chan *) data;
+	struct coh901318_chan *cohc = from_tasklet(cohc, t, tasklet);
 	struct coh901318_desc *cohd_fin;
 	unsigned long flags;
 	struct dmaengine_desc_callback cb;
@@ -2615,8 +2615,7 @@ static void coh901318_base_init(struct dma_device *dma, const int *pick_chans,
 			INIT_LIST_HEAD(&cohc->active);
 			INIT_LIST_HEAD(&cohc->queue);
 
-			tasklet_init(&cohc->tasklet, dma_tasklet,
-				     (unsigned long) cohc);
+			tasklet_setup(&cohc->tasklet, dma_tasklet);
 
 			list_add_tail(&cohc->chan.device_node,
 				      &dma->channels);
-- 
2.17.1

