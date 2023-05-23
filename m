Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9646070CF2B
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 02:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjEWAZN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 May 2023 20:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjEWAXE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 May 2023 20:23:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B721FCA;
        Mon, 22 May 2023 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fkCEJfb3Xyk1ZV6efA1WasgmQsRQP8Wls6LMXRrock4=; b=0Upe6JIyvZ2C08MzGLCOI8PXTK
        GUZ+Blmio/BtEuNeH64kTNcu5HiUxZkAtTgsofUeQssPsUljnsQjEzdS5SYDjsSE4Y82pf0gPNBtz
        MBcwh0n7u8zpaogBBoVTSluRB0lZbxQ/NaLPMmZfTZivqmbGxe5HF3I5/KXvVwuY3ALmwcjpViqao
        oHT6ojzUW6l76p8umQI83HI++sLkhbk1/xAl9cHoz2+7JkB6FREUxpA+MQhTSke8vDGANt7Rv1mvA
        Zv/mnnYKtw78FvMKH2TO3JyYLq8w2/Yv0kKDWOhxP4u2qc1SGlZd1vh8TJQVxgKbQ3uFx0ELEfN0l
        o2BjjNXw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1FXT-008Q3s-2Y;
        Tue, 23 May 2023 00:06:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaswinder Singh <jassisinghbrar@gmail.com>,
        Jaswinder Singh <jassi.brar@samsung.com>,
        Boojin Kim <boojin.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] dmaengine: pl330: rename _start to prevent build error
Date:   Mon, 22 May 2023 17:06:06 -0700
Message-Id: <20230523000606.9405-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"_start" is used in several arches and proably should be reserved
for ARCH usage. Using it in a driver for a private symbol can cause
a build error when it conflicts with ARCH usage of the same symbol.

Therefore rename pl330's "_start" to "_start_thread" so that there
is no conflict and no build error.

drivers/dma/pl330.c:1053:13: error: '_start' redeclared as different kind of symbol
 1053 | static bool _start(struct pl330_thread *thrd)
      |             ^~~~~~
In file included from ../include/linux/interrupt.h:21,
                 from ../drivers/dma/pl330.c:18:
arch/riscv/include/asm/sections.h:11:13: note: previous declaration of '_start' with type 'char[]'
   11 | extern char _start[];
      |             ^~~~~~

Fixes: b7d861d93945 ("DMA: PL330: Merge PL330 driver into drivers/dma/")
Fixes: ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaswinder Singh <jassisinghbrar@gmail.com>
Cc: Jaswinder Singh <jassi.brar@samsung.com>
Cc: Boojin Kim <boojin.kim@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
---
 drivers/dma/pl330.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/drivers/dma/pl330.c b/drivers/dma/pl330.c
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1050,7 +1050,7 @@ static bool _trigger(struct pl330_thread
 	return true;
 }
 
-static bool _start(struct pl330_thread *thrd)
+static bool _start_thread(struct pl330_thread *thrd)
 {
 	switch (_state(thrd)) {
 	case PL330_STATE_FAULT_COMPLETING:
@@ -1702,7 +1702,7 @@ static int pl330_update(struct pl330_dma
 			thrd->req_running = -1;
 
 			/* Get going again ASAP */
-			_start(thrd);
+			_start_thread(thrd);
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&descdone->rqd, &pl330->req_done);
@@ -2089,7 +2089,7 @@ static void pl330_tasklet(struct tasklet
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
+		_start_thread(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 	}
 
@@ -2107,7 +2107,7 @@ static void pl330_tasklet(struct tasklet
 			if (power_down) {
 				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
+				_start_thread(pch->thread);
 				spin_unlock(&pch->thread->dmac->lock);
 				power_down = false;
 			}
