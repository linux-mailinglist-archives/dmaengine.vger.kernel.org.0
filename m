Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAF46E306E
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDOKHD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDOKG7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1EA5F1;
        Sat, 15 Apr 2023 03:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5AB061177;
        Sat, 15 Apr 2023 10:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444C0C433A1;
        Sat, 15 Apr 2023 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553190;
        bh=Z+1BObiXlJgUhyPJtWXSHre7idf+1fVLpCNeJRw84co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeGcLJBv75tSgIpzlNfzHv3/MLU4/OGHjPh8RTfAsdeo8+0+ZSKtOhSLGmHmg/VYf
         ppyz46KmgHsl0wpKO/yzSynsis1Vmh9ImTWOviJtUHyH5GeppSxdB48uaitTi6R5b8
         LSwKISZeFt3mxodjCv+DKBsgWlHmXTch46IhAqfYOnGWkF8+kGPWlAtXI4UBv4ePS+
         ryaikh9nl4FK/vf9A6QcjXhNDPzFAbuBssonZfOBE7Y6aUtyPy2f7jreSlxmnRPF8v
         h98Boa6DdQr2pFnzZe4yqrZTJpMyn9sKtFlzpzOwD5TLKKHmArtK3j6uEOEIwGDt4z
         pMI6fKNT8u1Gg==
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
Subject: [PATCH v2 5/5] dmaengine: sprd: Don't set chancnt
Date:   Sat, 15 Apr 2023 17:55:17 +0800
Message-Id: <20230415095517.2763-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415095517.2763-1-jszhang@kernel.org>
References: <20230415095517.2763-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma framework will calculate the dma channels chancnt, setting it
ourself is wrong.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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

