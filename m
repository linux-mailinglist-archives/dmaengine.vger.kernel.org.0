Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EED7BF36C
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442362AbjJJG5l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442330AbjJJG5k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 02:57:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F599
        for <dmaengine@vger.kernel.org>; Mon,  9 Oct 2023 23:57:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5193FC433C9;
        Tue, 10 Oct 2023 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696921058;
        bh=qzEvqR2EiRITq3h5Ai7PhsQMJA7H9V1fW2pVZlvkDuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qpJn0WKVKSUXhV7ifoJ1DZt01w4ZZrUMOO5ZskEuGY+3b1Jwg3kHRdojjZd6mNsiI
         bA0wzKC7QHOUQfPHCMIv0BLU2VV8a58SFX5IndDCunuEqqosRkjME1CwqMJOn1nMRs
         ZcGwEC595tVKfmX0sVRIQFbN56T3DEMqf20YonjLGY4GjA+JOQhUsiqJBRFSFKN219
         sXCwMDjRnZU+jzDsSwuNeYQxXzArgDoshoqHsupUKIFny21+SSsfn2aR7d0NPDFkvM
         Fq+RN7twhcQUai7w2/hV3tidZ/SVcKKqsjtNo+M87dc8x2aKWg6V91xrCJ2RYuF8+i
         eFuwiIivLjyOA==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] dmaengine: mmp_tdma: drop unused variable 'of_id'
Date:   Tue, 10 Oct 2023 12:27:29 +0530
Message-ID: <20231010065729.29385-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Recent change a67ba97dfb30 ("dmaengine: Use device_get_match_data()")
cleaned up device tree data calls but left an unused variable, so drop
that

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: a67ba97dfb30 ("dmaengine: Use device_get_match_data()")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/mmp_tdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 9fff54b12db7..b76fe99e1151 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -635,7 +635,6 @@ MODULE_DEVICE_TABLE(of, mmp_tdma_dt_ids);
 static int mmp_tdma_probe(struct platform_device *pdev)
 {
 	enum mmp_tdma_type type;
-	const struct of_device_id *of_id;
 	struct mmp_tdma_device *tdev;
 	int i, ret;
 	int irq = 0, irq_num = 0;
-- 
2.41.0

