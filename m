Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1737E763430
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGZKso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjGZKsj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 06:48:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D69B;
        Wed, 26 Jul 2023 03:48:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6689430d803so4054398b3a.0;
        Wed, 26 Jul 2023 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690368517; x=1690973317;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzoQMpvGRNL8VqFE+s9CDXc1p5AFdGR1RsPZHygM1wQ=;
        b=JkAe8rG3vg2NSWI3ufZkddqyJwqDmXnCVrcSgU2txE9NH/IRtHErdd7u+ejn80h7Gt
         pSxx2XVBNdtqkWDAbdlujIYj/oyhUe98w4NY9sN0wkfo52bS54iTYN4Xfrl1Yl1nmamh
         RCI/+WNxf2+6ejC23vXbGAVuX+dk9FPhnncwzJ/oj2DdHEz/H8dEiKciZqGNglH/Jvt7
         j5+YxJitWNnhytlBt/Y5Hx3o6DrNX8HFwfWTZumaArbkvkHryy+nWoDHXIsdmaMueKdJ
         bPDROlQztPj0MjXIooTOGVm2R+StR5FHnlEdpmFnx8UOH4uzyJ7k+Ey6VVpXYw57NWeF
         MMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690368517; x=1690973317;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzoQMpvGRNL8VqFE+s9CDXc1p5AFdGR1RsPZHygM1wQ=;
        b=dNRdH9l1VgMMWDmqjNclzfgogKYg/1DTONJDUbzG84BQhop4b6t97qVD2zZLEY6EDa
         J+cTE9co+G+Da//XUZqVZUxFXMKsTm4Ueu4WmR84zjqIl+7+sHcAseSC9SoOseATgJE5
         wc0T8wMuiKAS6p0183F7XUwxJZbB9McWRtuLW0mIOuusfSw15ciEGfg22YrveMw13N3k
         lMzeNMsbLnFiJ3VVZ+xO7IsO2tASOTeP/CB0+N+Me3bWYM+kDHiCdSoQWO9UPm7FeU3l
         sXIN/UlG3RG705LfcaTvhK9nqJv7GrLkmUzWtrnajeRT1LrDaVV8zeM+6YQ4Z0UqsHSR
         /p+w==
X-Gm-Message-State: ABy/qLZ9kCh/o2VAjW7XSHiMOT71/OKVZHcTILNc5yJiDokKMqta/lD1
        FsoirRyOAqCuoiSPP1yCJmf23XLjfZg=
X-Google-Smtp-Source: APBJJlFcIP+ORQpvKX1QSLryeoaAAcBf5PCBlmtoWIx/HSujJbBcIOhIj9ZjrHwzH/j8d9yfcfA4Og==
X-Received: by 2002:a05:6a20:3251:b0:135:38b5:7e4e with SMTP id hm17-20020a056a20325100b0013538b57e4emr1123689pzc.59.1690368517088;
        Wed, 26 Jul 2023 03:48:37 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7914d000000b00682a839d0aesm11177202pfi.112.2023.07.26.03.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:48:36 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     logang@deltatee.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
Date:   Wed, 26 Jul 2023 10:48:27 +0000
Message-Id: <20230726104827.60382-1-dg573847474@gmail.com>
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

The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
plx_dma_process_desc() to disable irq while lock is held.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/plx_dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 34b6416c3287..46068b8d83f9 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -135,9 +135,10 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
 {
 	struct dmaengine_result res;
 	struct plx_dma_desc *desc;
+	unsigned long lock_flags;
 	u32 flags;
 
-	spin_lock(&plxdev->ring_lock);
+	spin_lock_irqsave(&plxdev->ring_lock, lock_flags);
 
 	while (plxdev->tail != plxdev->head) {
 		desc = plx_dma_get_desc(plxdev, plxdev->tail);
@@ -165,7 +166,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
 		plxdev->tail++;
 	}
 
-	spin_unlock(&plxdev->ring_lock);
+	spin_unlock_irqrestore(&plxdev->ring_lock, lock_flags);
 }
 
 static void plx_dma_abort_desc(struct plx_dma_dev *plxdev)
-- 
2.17.1

