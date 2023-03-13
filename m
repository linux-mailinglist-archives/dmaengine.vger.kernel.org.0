Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62846B7F14
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCMRPY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCMRPL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:15:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB918D536;
        Mon, 13 Mar 2023 10:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6807BB811A9;
        Mon, 13 Mar 2023 17:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01845C433A4;
        Mon, 13 Mar 2023 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727626;
        bh=MmQlG4bKX5zRhls8Ppg0KYbzYJ0yCTbRflxLRO/KTAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaxyiQm3zr++CxlIZQvcW00rgAI+9VUp45EuH39mSHwSJYNEN3erATeQQBmRAbDu4
         cVAF7BjY731YkBIC0veCIoGxOy9TjxXtXygU7Dtk1Npl5Ayu4xhUdiBEKdLfSqk3+2
         /E6GI7kiVSyhBBujStix0sb6kdj4ecpiaU0exXy4zUVucXDiEkeLdWhTIrM2khMzH8
         tBP5VPdrF1QADqGTs7xKRL+lHSi3t0mdSNDibe6Uhs1lXcCeFYczD95hqoZExkOYNQ
         r/Tp1Ch88FT7gUE24U8Ajn7vz22H4nQj2DP1/9hZHty6kAixtFz8/BcoGKZ85yRAdW
         oKxHJ7Gc7jy2Q==
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
Subject: [PATCH 3/5] dmaengine: plx_dma: Don't set chancnt
Date:   Tue, 14 Mar 2023 01:02:48 +0800
Message-Id: <20230313170250.815-4-jszhang@kernel.org>
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
 drivers/dma/plx_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 12725fa1655f..34b6416c3287 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -517,7 +517,6 @@ static int plx_dma_create(struct pci_dev *pdev)
 	plxdev->bar = pcim_iomap_table(pdev)[0];
 
 	dma = &plxdev->dma_dev;
-	dma->chancnt = 1;
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
-- 
2.39.2

