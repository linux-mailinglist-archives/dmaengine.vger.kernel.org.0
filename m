Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9264670ADE1
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjEULsZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjEUKZE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568D10C4;
        Sun, 21 May 2023 03:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE68861541;
        Sun, 21 May 2023 10:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465CAC433A0;
        Sun, 21 May 2023 10:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664047;
        bh=705IbEQR9rBrNaTOK0WaKUUekkPcDSW7kXi/cfnV5VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUVndTHcpPU908yiU65cmte9E0nyV3gRWK9GLfARUXuD0H7FKZn12VR11W/FwfLCC
         SDxcuqtYH403Imj8zdQVqJI6Kp4DSqG87zDbE4k3euSrIp0z1GBqPXmW8B746uSEhu
         Pfje810jmbEiYAOcypN3Nt0WbHxmR7qr0BfLGVDGlZzEy//ACd5IKw5rilFobMxJ6V
         I27lH8Gc5Q8QLGn10R7+OqyR5jK5KZ7Q1GDk6smvWW/Obhr8WyAuG88GobdRVQHRlU
         tuc2xGCW0+no1IGxSCDnha0LARVY4RNXU3tjrSE2qL7c5dlRPUJFbR33p1giAI5IEx
         w0ucU+KcMY+pg==
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
Subject: [PATCH v3 1/5] dmaengine: dw-axi-dmac: Don't set chancnt
Date:   Sun, 21 May 2023 18:02:48 +0800
Message-Id: <20230521100252.3197-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521100252.3197-1-jszhang@kernel.org>
References: <20230521100252.3197-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma framework will calculate the dma channels chancnt, setting it
ourself is wrong.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 6937cc0c0b65..796b6caf0bab 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1466,7 +1466,6 @@ static int dw_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
-	dw->dma.chancnt = hdata->nr_channels;
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
-- 
2.40.0

