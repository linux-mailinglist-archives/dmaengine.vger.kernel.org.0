Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92800726ABB
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFGUUF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 16:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjFGUT4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 16:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A52708;
        Wed,  7 Jun 2023 13:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34351642FE;
        Wed,  7 Jun 2023 20:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6FAC433EF;
        Wed,  7 Jun 2023 20:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169145;
        bh=kT3jh64tJMjQU7tzukJRwEmX2q6UV7BbOXCt0kxTlVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUXX0nU7+WR5RdD6Vt42fokrffbpEcxiMRRDrHUmeyF12dNkF43N9E08ks6eeaQQU
         vWBE3DFtsjvQlLVLk/JFgdzGUa+CB724x4ZuAfpjk5f4in2IqeV4yrOEozVrgmWeMz
         oqfRnHi8hExQUIJMvwFsyBg4Yg2AQFrnwhqDuEWs=
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
Subject: [PATCH 4.14 04/61] dmaengine: pl330: rename _start to prevent build error
Date:   Wed,  7 Jun 2023 22:15:18 +0200
Message-ID: <20230607200836.680552722@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
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
index a8cea236099a1..982b69d017cda 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1041,7 +1041,7 @@ static bool _trigger(struct pl330_thread *thrd)
 	return true;
 }
 
-static bool _start(struct pl330_thread *thrd)
+static bool pl330_start_thread(struct pl330_thread *thrd)
 {
 	switch (_state(thrd)) {
 	case PL330_STATE_FAULT_COMPLETING:
@@ -1584,7 +1584,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 			thrd->req_running = -1;
 
 			/* Get going again ASAP */
-			_start(thrd);
+			pl330_start_thread(thrd);
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&descdone->rqd, &pl330->req_done);
@@ -1974,7 +1974,7 @@ static void pl330_tasklet(unsigned long data)
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
+		pl330_start_thread(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 	}
 
@@ -1992,7 +1992,7 @@ static void pl330_tasklet(unsigned long data)
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



