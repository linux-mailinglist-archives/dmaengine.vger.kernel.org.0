Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD1726F47
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjFGU5E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 16:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjFGU5D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 16:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1401FD5;
        Wed,  7 Jun 2023 13:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF82B64864;
        Wed,  7 Jun 2023 20:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD84C433D2;
        Wed,  7 Jun 2023 20:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171419;
        bh=HDgUBzjEunBc8EhZGUDA3+maO/LGYlO/MvUdwUN7QMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDnurTQx6gBB9IrZ+tmlFnvTJDxTfnfJijinTKsOyUT76OujGRoF0qKLwcea4xXu9
         lv/W7+OW4TKM3zIVLpFoD7tn99kJkRonLrIh3tTHOhcxx1Tevcw9PQA7lYKc1cfBig
         eP8BKnqvy79ksCWBpqsq2DeLbUy+zGke7AKw2y24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jaswinder Singh <jassisinghbrar@gmail.com>,
        Boojin Kim <boojin.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/159] dmaengine: pl330: rename _start to prevent build error
Date:   Wed,  7 Jun 2023 22:15:14 +0200
Message-ID: <20230607200904.041824517@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit a1a5f2c887252dec161c1e12e04303ca9ba56fa9 ]

"_start" is used in several arches and proably should be reserved
for ARCH usage. Using it in a driver for a private symbol can cause
a build error when it conflicts with ARCH usage of the same symbol.

Therefore rename pl330's "_start" to "pl330_start_thread" so that there
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
Cc: Boojin Kim <boojin.kim@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Link: https://lore.kernel.org/r/20230524045310.27923-1-rdunlap@infradead.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pl330.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4ef68ddff75bc..b9bc82d6a1622 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1050,7 +1050,7 @@ static bool _trigger(struct pl330_thread *thrd)
 	return true;
 }
 
-static bool _start(struct pl330_thread *thrd)
+static bool pl330_start_thread(struct pl330_thread *thrd)
 {
 	switch (_state(thrd)) {
 	case PL330_STATE_FAULT_COMPLETING:
@@ -1702,7 +1702,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 			thrd->req_running = -1;
 
 			/* Get going again ASAP */
-			_start(thrd);
+			pl330_start_thread(thrd);
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&descdone->rqd, &pl330->req_done);
@@ -2089,7 +2089,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
+		pl330_start_thread(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 	}
 
@@ -2107,7 +2107,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 			if (power_down) {
 				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
+				pl330_start_thread(pch->thread);
 				spin_unlock(&pch->thread->dmac->lock);
 				power_down = false;
 			}
-- 
2.39.2



