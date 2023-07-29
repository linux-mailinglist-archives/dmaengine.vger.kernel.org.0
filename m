Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0A7680DC
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jul 2023 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjG2SAR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jul 2023 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2SAR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Jul 2023 14:00:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C9FF;
        Sat, 29 Jul 2023 11:00:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8ad907ba4so20293395ad.0;
        Sat, 29 Jul 2023 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690653614; x=1691258414;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy7FPVTqEQtbAbgd1X4XqKyPaRp0gdtbk+50wpWYN14=;
        b=P8XfptERNkybpZ7yCAZm+dltRI5LxUHfF12Z576i3skheC9zM97sX4Ba1ZWNiGGT9r
         ES6uW1Kwqq5fSoOs1J+WpKCNphszMzSMo+WSZAU6k8oLhQUcjkzYp535WmAmrYRVv8n4
         ZB39neooZ5phpAmD7jcMUGz4dlPOIX7N2L1ymx1ZXcSsfrSnZY0+2YqrsKgpnL3n+92H
         P6E+aLLClfvLhLv3MRjkuCDi66Wp5lQYS8YJqnonikpbKii8s4+iKvWd/kJMGszJ82vK
         1RY20YwVlJiZDgELag065PEVWReHiA2G5yf41XmmT7TfHfJZogDhMon1etzwPe331AiM
         J59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690653614; x=1691258414;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy7FPVTqEQtbAbgd1X4XqKyPaRp0gdtbk+50wpWYN14=;
        b=ZvfeFY8SIfDu55HB/X+17y1dHX2uyRWJdMIWRMt3usfwty33jL/hMesiLYEk0hbpbu
         At9op3LzVA/ccsP46O6bdaRzmwZd5oGlT3o530a6f1ppOSSm26+P9GHzT7ixRAPKpR6g
         xqv/6qp8jRPqNukI/+vNWTN9cxrDuxJ+COAgfjYYyCQOhcgpSPNXZvY8lOhbRv9ao8JD
         q1RSbq/cuttAgKYzNFJdYn2II7pge7Wsb/V1cGSdsCeSe8X2xttr/tM9buAftMbNeBoB
         ULwMi0dK1C1LtsM9uAZCfo4GRNGthDwhptnx6Tom/PesYYgmsxffjyWKDWciGb0X/tz2
         qcnA==
X-Gm-Message-State: ABy/qLY9HI8KDcz5tGOif+IJHkczGrj/ENfAEzwClfrxalY4s5RF29Zt
        mjFpYbeSLdMUUODVjSG2zZ8=
X-Google-Smtp-Source: APBJJlGrm/kR5mwJ8W866MnK+C8izB1ZNdWBKzuP/zbAY/jZsRcz0cFU6YWuBPUvN7p6NdpvhXgKQw==
X-Received: by 2002:a17:902:b187:b0:1b8:4e69:c8f7 with SMTP id s7-20020a170902b18700b001b84e69c8f7mr4443569plr.23.1690653614299;
        Sat, 29 Jul 2023 11:00:14 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001adf6b21c77sm5573398plx.107.2023.07.29.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 11:00:13 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     logang@deltatee.com, vkoul@kernel.org
Cc:     yuyunbo519@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
Date:   Sat, 29 Jul 2023 17:59:52 +0000
Message-Id: <20230729175952.4068-1-dg573847474@gmail.com>
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

As plx_dma_process_desc() is invoked by both tasklet plx_dma_desc_task()
under softirq context and plx_dma_tx_status() callback that executed under
process context, the lock aquicision of &plxdev->ring_lock inside
plx_dma_process_desc() should disable irq otherwise deadlock could happen
if the irq preempts the execution of process context code while the lock
is held in process context on the same CPU.

Possible deadlock scenario:
plx_dma_tx_status()
    -> plx_dma_process_desc()
    -> spin_lock(&plxdev->ring_lock)
        <tasklet softirq>
        -> plx_dma_desc_task()
        -> plx_dma_process_desc()
        -> spin_lock(&plxdev->ring_lock) (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The lock was changed from spin_lock_bh() to spin_lock() by a previous patch
for performance concern but unintentionally brought this potential deadlock
problem.

This patch reverts back to spin_lock_bh() to fix the deadlock problem.

Fixes: 1d05a0bdb420 ("dmaengine: plx_dma: Move spin_lock_bh() to spin_lock()")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Changes in v2
- Consistently use spin_lock_bh() on &plxdev->ring_lock instead of
spin_lock_irqsave().
---
 drivers/dma/plx_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 34b6416c3287..7693c067a1aa 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -137,7 +137,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
 	struct plx_dma_desc *desc;
 	u32 flags;
 
-	spin_lock(&plxdev->ring_lock);
+	spin_lock_bh(&plxdev->ring_lock);
 
 	while (plxdev->tail != plxdev->head) {
 		desc = plx_dma_get_desc(plxdev, plxdev->tail);
@@ -165,7 +165,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
 		plxdev->tail++;
 	}
 
-	spin_unlock(&plxdev->ring_lock);
+	spin_unlock_bh(&plxdev->ring_lock);
 }
 
 static void plx_dma_abort_desc(struct plx_dma_dev *plxdev)
-- 
2.17.1

