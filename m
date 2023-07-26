Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA02C7634A4
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGZLR1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjGZLRR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 07:17:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED3271C;
        Wed, 26 Jul 2023 04:17:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89cfb4571so52378915ad.3;
        Wed, 26 Jul 2023 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690370225; x=1690975025;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SELQNWCM0Vfw3jXEg+B1K9VTFsk/ohvBXYAV3q7aEg=;
        b=VFoAMxMovxl0is1nUMBnCSNE9X5PgOjqbXMiaQ0q6vw1eawI5Rw9c/TaEYx+CtgVNq
         eLbLeqdNQO4MbKLFqZp0306yByHdqsMGdgDZW9BfBayclUurcDjgTmykcml0NwwOzKiJ
         4BNytXk7PUC38VPUsj0sFBPZV9/rY1oXSRPf++d6eDudmWuKilJ6XGLh0FUwbrv/LH3Y
         xrtdkSMVt3/6BOk+QYapRvSKc4+A8m/fYDk/9kKshfu8pZsz+a96OSZsPEz7tNpeQBje
         HU0lae0F5wnYcq40IM92aFGy4XnUv1qINNiQQdmWIwQuVTPJvG/7t5fwiC0NKVuZfDrz
         wn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370225; x=1690975025;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SELQNWCM0Vfw3jXEg+B1K9VTFsk/ohvBXYAV3q7aEg=;
        b=Lpghc9GJt6ikddCT0Hfj5GNgt1zqyPRVBKiM17YXH96QuO99wkYcGnemrKMNYkOZSi
         UXYIRxyXnwHl92gsVDocj6+EDTF7TN656qPccXnufGEbMTR7MaBC9FyVR7qLhLcq/Mtq
         jCx0NBujUX9x31ZdsqpR+esRbZem0N6htXKKZK1MMNr1MLAB1pYPobGBLmzUHTw4cSpe
         R9H/XP9xAm9uGpX1NTvtIbRAWzdVtOzoQJ/WJcXnGSZhsUXzQwozChk2D21s6o9XxAR/
         tBXCxarxaPxg9kdENOYcvgc+QrnyLwvEVr3qBpmKy6B4KEZJnQvN+7LfvKSvMsayZuXv
         wwrg==
X-Gm-Message-State: ABy/qLZ7wl748FgR7+3AOAbEi0H+eaPpwTdQ3jErixQgiCho8B+pqyVQ
        zJtGzuWueobuEPBmR6cZWuM=
X-Google-Smtp-Source: APBJJlF2L3aSjYORABVQ8C/l87u3iEkhcgxf2vRMJtoFdMU6Mk6qPtz6/QuCfCqr8mrP5N9mgwdiXg==
X-Received: by 2002:a17:903:2308:b0:1b8:400a:48f2 with SMTP id d8-20020a170903230800b001b8400a48f2mr2189158plh.62.1690370225095;
        Wed, 26 Jul 2023 04:17:05 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id jh11-20020a170903328b00b001bb3beb2bc6sm5676141plb.65.2023.07.26.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 04:17:04 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org, rsahu@apm.com, lho@apm.com, allen.lkml@gmail.com,
        romain.perier@gmail.com, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: xgene: Fix potential deadlock on &chan->lock
Date:   Wed, 26 Jul 2023 11:16:30 +0000
Message-Id: <20230726111630.25670-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As xgene_dma_cleanup_descriptors() is invoked by both tasklet
xgene_dma_tasklet_cb() under softirq context and
xgene_dma_free_chan_resources() callback that executed under process
context, the lock aquicision of &chan->lock inside
xgene_dma_cleanup_descriptors() should disable irq otherwise deadlock
could happen if the tasklet softirq preempts the execution of process
context code while the lock is held in process context on the same CPU.

Possible deadlock scenario:
xgene_dma_free_chan_resources()
    -> xgene_dma_cleanup_descriptors()
    -> spin_lock(&chan->lock)
        <tasklet softirq>
        -> xgene_dma_tasklet_cb()
        -> xgene_dma_cleanup_descriptors()
        -> spin_lock(&chan->lock) (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
plx_dma_process_desc() to disable irq while lock is held.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/xgene-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 3589b4ef50b8..e766511badcf 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -689,11 +689,12 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 	struct xgene_dma_desc_sw *desc_sw, *_desc_sw;
 	struct xgene_dma_desc_hw *desc_hw;
 	struct list_head ld_completed;
+	unsigned long flags;
 	u8 status;
 
 	INIT_LIST_HEAD(&ld_completed);
 
-	spin_lock(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	/* Clean already completed and acked descriptors */
 	xgene_dma_clean_completed_descriptor(chan);
@@ -762,7 +763,7 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 	 */
 	xgene_chan_xfer_ld_pending(chan);
 
-	spin_unlock(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Run the callback for each descriptor, in order */
 	list_for_each_entry_safe(desc_sw, _desc_sw, &ld_completed, node) {
-- 
2.17.1

