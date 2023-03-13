Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7729D6B7F18
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCMRP0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCMRPX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:15:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865977E1F;
        Mon, 13 Mar 2023 10:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0D0FB810D8;
        Mon, 13 Mar 2023 17:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7D2C433A4;
        Mon, 13 Mar 2023 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727633;
        bh=waygJoMsmEuzShbrfLKTmYsjXJJABs/ZjxmcAXxJrFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzHKXiczApY5CW+k510wfPoijOe94MAfIi9QUFi6zkEn4hI/btbZ9sLGreVlnKLeR
         bcpn7r6Kbv1A15fq6RMXqCj57/YTzz1VxBTzjijTyos35t5U4w2C3Hfe0CKPZxB5K4
         IdRpfyr0xXHVSbQpqvMCLcMtQ8NFC/FLXCNK0PJkqeyybsMU7nOa0ibkMtJMOrLILJ
         4rd+3N8Y2i196SbGbk/+aXTt003pva4/qKcLDo9FKe1GGvV48IS8yz23oY/JZLcDu2
         A5NglNk2j5ouel+0hhQBzTq3AdpdF14O09x0v72BqY2pNuTklScLo/DhHHemSSAr15
         kaAULm8lzRayQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] dmaengine: sprd: Don't set chancnt
Date:   Tue, 14 Mar 2023 01:02:50 +0800
Message-Id: <20230313170250.815-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170250.815-1-jszhang@kernel.org>
References: <20230313170250.815-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma framework will calculate the dma channels chancnt, setting it
outself is wrong.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/sprd-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 474d3ba8ec9f..2b639adb48ba 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1169,7 +1169,6 @@ static int sprd_dma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_MEMCPY, sdev->dma_dev.cap_mask);
 	sdev->total_chns = chn_count;
-	sdev->dma_dev.chancnt = chn_count;
 	INIT_LIST_HEAD(&sdev->dma_dev.channels);
 	INIT_LIST_HEAD(&sdev->dma_dev.global_node);
 	sdev->dma_dev.dev = &pdev->dev;
-- 
2.39.2

