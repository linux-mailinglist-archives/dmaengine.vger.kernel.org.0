Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE0654B16
	for <lists+dmaengine@lfdr.de>; Fri, 23 Dec 2022 03:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLWC0Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Dec 2022 21:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiLWC0Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Dec 2022 21:26:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FC60F0
        for <dmaengine@vger.kernel.org>; Thu, 22 Dec 2022 18:26:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 78so2487118pgb.8
        for <dmaengine@vger.kernel.org>; Thu, 22 Dec 2022 18:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeWgt78fMtqOLf9jf/mlI1pe5FwR0D/kOgRYfZXjo1E=;
        b=Mcndd4qil61iXSG5wVtZG5gBfB6m4WfBGf/c6GDqh8S5UC0EEXrr3ndxASAg/wNzKL
         +ekYYApr3kSh4cm9ZbdlqjH1LaPy5oQempDyparknrRby21MUwd1fYegaVZlMSVJzHHR
         Q269D9koaP7+xVmFu3vu2LVwo3ni1h9Cyze1bE1sg8bsbaaY13cU4qGsUL5S+9egMFbA
         Hrn8SlFQLnRksWA0ak95NOYZ/ZfeD+Y2jO2vo47H30GR832Ir/1RtqEZve+BHVMvu/ey
         XP2fuayUXTNDFZxFLm0qLmNdhjkd/42kl8E8hSyUy3P+rZfniJUue2/no5hOJKiKr8wJ
         HWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeWgt78fMtqOLf9jf/mlI1pe5FwR0D/kOgRYfZXjo1E=;
        b=w7VJW5mL/3CASdIFrS1gyRljLi0BXqvH6JtsbsieXgLRczV86BK9NDbNq8IhZF/FXr
         I+h2xBfk3IYN/dJdyM8Of15mdVNhLTq1Uv8dBfrZ/bVbwtXiDDKq0SL3XIN7ET148Pj1
         KlS3y75zB6FBPB8a4WR7QWQ8HAoROjy9fUcLfFqZO7R1a7DMffIenYvTo0nbDw8qeavn
         xGE2K4P2ftUtuqMPtU75IjkieEoTnR5yzXJUd6MgKvEHZcnnlaGcaL4js7DfJxuma/+4
         2dMfEd6P4MIOz1sX+9COWlk2xmSzdA0ehDRQErRf3SUjnXkkRRkcgJt/FdCdx47LaSxK
         wv4Q==
X-Gm-Message-State: AFqh2krgEeKafb/r3IBP7Cc8x8ZWTtmXa49SUz47DV985ZtjcVtgWxS2
        nyZLuSlmq4kRO+fdjLESsiN0QQ==
X-Google-Smtp-Source: AMrXdXs1VLiXcv65qwumDiKVdqz8fFy7qHdw9UNURe6wo3ZdfzKABH2MDztpgWxWhxSGdIg6/7WWDg==
X-Received: by 2002:aa7:9735:0:b0:57f:94e4:5a61 with SMTP id k21-20020aa79735000000b0057f94e45a61mr9351092pfg.16.1671762382736;
        Thu, 22 Dec 2022 18:26:22 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b005772f762e43sm1418471pfb.13.2022.12.22.18.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:26:22 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
Date:   Fri, 23 Dec 2022 11:26:07 +0900
Message-Id: <20221223022608.550697-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dw-edma driver stops after processing a DMA request even if a request
remains in the issued queue, which is not the expected behavior. The DMA
engine API requires continuous processing.

Fix it to add a trigger to start after one processing finished if there are
requests remain.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c54b24ff5206..669b97313911 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -170,7 +170,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_start_transfer(struct dw_edma_chan *chan)
+static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
@@ -178,16 +178,16 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
-		return;
+		return 0;
 
 	desc = vd2dw_edma_desc(vd);
 	if (!desc)
-		return;
+		return 0;
 
 	child = list_first_entry_or_null(&desc->chunk->list,
 					 struct dw_edma_chunk, list);
 	if (!child)
-		return;
+		return 0;
 
 	dw_edma_v0_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->ll_region.sz;
@@ -195,6 +195,8 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
+
+	return 1;
 }
 
 static int dw_edma_device_config(struct dma_chan *dchan,
@@ -568,14 +570,17 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (desc->chunks_alloc) {
-				chan->status = EDMA_ST_BUSY;
-				dw_edma_start_transfer(chan);
-			} else {
+			if (!desc->chunks_alloc) {
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
-				chan->status = EDMA_ST_IDLE;
 			}
+
+			/* Continue to transfer in case of there are rest chunks, or issued
+			 * requests remain.
+			 */
+			chan->status = EDMA_ST_BUSY;
+			if (!dw_edma_start_transfer(chan))
+				chan->status = EDMA_ST_IDLE;
 			break;
 
 		case EDMA_REQ_STOP:
-- 
2.25.1

