Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2D6119A1
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ1Rv2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1RvZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 13:51:25 -0400
X-Greylist: delayed 19194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 10:51:24 PDT
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net [46.105.49.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326BCA8BF
        for <dmaengine@vger.kernel.org>; Fri, 28 Oct 2022 10:51:23 -0700 (PDT)
Received: from player792.ha.ovh.net (unknown [10.108.16.164])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 2DF2B25FF6
        for <dmaengine@vger.kernel.org>; Fri, 28 Oct 2022 11:54:03 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player792.ha.ovh.net (Postfix) with ESMTPSA id AFB223030BAFD;
        Fri, 28 Oct 2022 11:53:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-109S00381dfec32-158c-4e50-a43f-6652ca230d89,
                    064883BA926DE173662F194B93470FD4AA5384D5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] dmaengine: sh: Remove unused shdma-arm.h
Date:   Fri, 28 Oct 2022 13:53:36 +0200
Message-Id: <20221028115336.1052782-1-steve@sk2.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14040816263407896198
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkphepuddvjedrtddrtddruddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

shdma-arm.h was introduced with commit 1e69653d40f1 ("DMA: shdma: add
r8a73a4 DMAC data to the device ID table"), and its sole user was
removed with commit a19788612f51 ("dmaengine: sh: Remove R-Mobile APE6
support"). The latter mentions r8a73a4.dtsi but shdma support was
removed from that with commit cfda82037780 ("ARM: dts: r8a73a4: Remove
non-functional DMA support"), so it seems this is safe to remove.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/dma/sh/shdma-arm.h | 48 --------------------------------------
 1 file changed, 48 deletions(-)
 delete mode 100644 drivers/dma/sh/shdma-arm.h

diff --git a/drivers/dma/sh/shdma-arm.h b/drivers/dma/sh/shdma-arm.h
deleted file mode 100644
index 7459f9a13b5b..000000000000
--- a/drivers/dma/sh/shdma-arm.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Renesas SuperH DMA Engine support
- *
- * Copyright (C) 2013 Renesas Electronics, Inc.
- */
-
-#ifndef SHDMA_ARM_H
-#define SHDMA_ARM_H
-
-#include "shdma.h"
-
-/* Transmit sizes and respective CHCR register values */
-enum {
-	XMIT_SZ_8BIT		= 0,
-	XMIT_SZ_16BIT		= 1,
-	XMIT_SZ_32BIT		= 2,
-	XMIT_SZ_64BIT		= 7,
-	XMIT_SZ_128BIT		= 3,
-	XMIT_SZ_256BIT		= 4,
-	XMIT_SZ_512BIT		= 5,
-};
-
-/* log2(size / 8) - used to calculate number of transfers */
-#define SH_DMAE_TS_SHIFT {		\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_64BIT]		= 3,	\
-	[XMIT_SZ_128BIT]	= 4,	\
-	[XMIT_SZ_256BIT]	= 5,	\
-	[XMIT_SZ_512BIT]	= 6,	\
-}
-
-#define TS_LOW_BIT	0x3 /* --xx */
-#define TS_HI_BIT	0xc /* xx-- */
-
-#define TS_LOW_SHIFT	(3)
-#define TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
-
-#define TS_INDEX2VAL(i) \
-	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
-	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
-
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | RS_ERS | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | RS_ERS | TS_INDEX2VAL((xmit_sz)))
-
-#endif

base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
-- 
2.31.1

