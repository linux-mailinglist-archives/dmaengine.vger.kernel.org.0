Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129B66A1E6F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBXPWf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBXPWe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 10:22:34 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F876A9CD;
        Fri, 24 Feb 2023 07:22:28 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1677252146; bh=qcgclGCFYD+77b0HLKFa7/pKBARXaiNkZFUlsvgiV7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rPQdylosAxrYCCO5c8/2Rz1rgF2eMzEo2nN+XzDHHHY4+Y/P8SWrZZ3ZkW96z5Hcb
         7hYQRfRVs/LzFiwrE5hV2PlmdcgVImUYYTcN6kqBi+W5L2KFPLvVQuwqPe1AOsk3bW
         qLWLeQ+rLGrT5pbA3RNrIgOsxOwUY1GatwjsNLj8=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: apple-admac: Set src_addr_widths capability
Date:   Fri, 24 Feb 2023 16:22:22 +0100
Message-Id: <20230224152222.26732-3-povik+lin@cutebit.org>
In-Reply-To: <20230224152222.26732-1-povik+lin@cutebit.org>
References: <20230224152222.26732-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add missing setting of 'src_addr_widths', which is the same as for the
other direction.

Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/dma/apple-admac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 497bb65b7d6d..4cf8da77bdd9 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -861,6 +861,9 @@ static int admac_probe(struct platform_device *pdev)
 
 	dma->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-- 
2.33.0

