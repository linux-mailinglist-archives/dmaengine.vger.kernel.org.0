Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE64C446B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 13:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiBYMRZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBYMRZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 07:17:25 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0714966217;
        Fri, 25 Feb 2022 04:16:52 -0800 (PST)
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 0B6A3CC3AF;
        Fri, 25 Feb 2022 12:03:05 +0000 (UTC)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id DC5E960006;
        Fri, 25 Feb 2022 12:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645790581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xmAETL88ozFterU6nFZtAF7xxcPU2p4puDat4V2JVsI=;
        b=Tz4YK8B/W7g7MiVtr3UWlLFxHBsG+ANM08f1HlngBpuAnFgWC290P2wAfu0j2x1qmk81FH
        xG0Ih1XCbbQpQWAYZbsi3ApTHBX7Kxg/YUEP3mx1LAuS48b0f6e0VAmu6ISiiibIU/Bjl1
        g5yQzZ3YcA/rx8FwrqIf8jf8L6OHUU9N5u0NmYZeh66bgdFworBFZ0l7ZT1m2BDvM7O6/1
        f48v+kR2SfJEf49maj4f3ZN1qzGoMmrxnIyAn6ukUMH6ZrMW4hu1fKh4H7+U73rLCLmnFL
        HDeVDX9jghq9pdnJSSn/Z+w8of+zb89kT3dxDPvkIF/h2l9uD4frmaczBqLIcw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/1] dmaengine: dw-edma: Fix unaligned 64bit access
Date:   Fri, 25 Feb 2022 13:02:52 +0100
Message-Id: <20220225120252.309404-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On some arch (ie aarch64 iMX8MM) unaligned PCIe accesses are
not allowed and lead to a kernel Oops.
  [ 1911.668835] Unable to handle kernel paging request at virtual address ffff80001bc00a8c
  [ 1911.668841] Mem abort info:
  [ 1911.668844]   ESR = 0x96000061
  [ 1911.668847]   EC = 0x25: DABT (current EL), IL = 32 bits
  [ 1911.668850]   SET = 0, FnV = 0
  [ 1911.668852]   EA = 0, S1PTW = 0
  [ 1911.668853] Data abort info:
  [ 1911.668855]   ISV = 0, ISS = 0x00000061
  [ 1911.668857]   CM = 0, WnR = 1
  [ 1911.668861] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000040ff4000
  [ 1911.668864] [ffff80001bc00a8c] pgd=00000000bffff003, pud=00000000bfffe003, pmd=0068000018400705
  [ 1911.668872] Internal error: Oops: 96000061 [#1] PREEMPT SMP
  ...

The llp register present in the channel group registers is not
aligned on 64bit.

Fix unaligned 64bit access using two 32bit accesses

Fixes: 04e0a39fc10f ("dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 329fc2e57b70..b5b8f8181e77 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -415,8 +415,11 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
 		#ifdef CONFIG_64BIT
-			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
-				  chunk->ll_region.paddr);
+			/* llp is not aligned on 64bit -> keep 32bit accesses */
+			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+				  lower_32_bits(chunk->ll_region.paddr));
+			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+				  upper_32_bits(chunk->ll_region.paddr));
 		#else /* CONFIG_64BIT */
 			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
-- 
2.35.1

