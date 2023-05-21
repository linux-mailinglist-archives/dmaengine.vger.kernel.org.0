Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BD70ADE2
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjEULs3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjEUKZE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FB710C6;
        Sun, 21 May 2023 03:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC8761528;
        Sun, 21 May 2023 10:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978D8C433A1;
        Sun, 21 May 2023 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664050;
        bh=iKBSLxOITCXkuIZreLUcOGXCAwPyJ2AdsBgElqBT+P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jalWQArAy9uK0OcA78NzbJf6BcDyjcl8QCFrKtS5uzQErfVDibIxJWp9+YjqwKE8G
         fczdosw3VjLQ32PcSSoRQ3xkDwdVNj8kYrMA60jQVVjZnjYWlRFbpWQbMi/tHEAQlO
         Q77wjRHo7sHMWk5H+zdlSqyOn7FVM8mY+4npxP6SlciOM997/MPKUHNfnx/81eil1P
         mGea0V77U8ZRFXgTDXW0+39hfIGHJPxwBZ/tObb0eOZDc5s0HQrGpXqeDvS2yDarcF
         E8mRyccMsmLFzy/2+ZTRE2ei4DLbBQyEYGhwVEU65M1H+kxdGnlp8dKTXydESO8pSs
         mGt26HR+FF3rQ==
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
Subject: [PATCH v3 2/5] dmaengine: axi-dmac: Don't set chancnt
Date:   Sun, 21 May 2023 18:02:49 +0800
Message-Id: <20230521100252.3197-3-jszhang@kernel.org>
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
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/dma-axi-dmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a812b9b00e6b..fc7cdad37161 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -963,7 +963,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->chancnt = 1;
 	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
 	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
 	dma_dev->directions = BIT(dmac->chan.direction);
-- 
2.40.0

