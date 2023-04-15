Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D96E3065
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDOKG2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDOKGY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C454230;
        Sat, 15 Apr 2023 03:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C536861173;
        Sat, 15 Apr 2023 10:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0649BC433D2;
        Sat, 15 Apr 2023 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553180;
        bh=tfDJeLEBi00e9/yxIl4hwmsmHEqD5UdGR6/fxpDa4NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2sRikwZx+XiHCdfh4R7Ouv5k2zlr3bwWx/XzF1tfUIkEE8KXZ6oMolLVyNsGKWPb
         22UnC8x2NJzkmX+QyQeajrja4LbRqXi4ANbk/DOQxRxTACrHiKRuCaoWkWbzPaCRtM
         f3QPFkhdwajIuo32SA45G3EnhQ+Af5Ppy1178VSNAuhs43eLJ5oP27SP9Ms5CiTy4T
         4A34nRroPNzztOipRbVVFnfTtiIc7Bpll2SpXRXwOV/EXYHx5tOU2voMaQ6zptNbz2
         x57bYW6oDu2+LxYffEDa8gpMBaDFKVTBMuuDjql5Q6PZArQ79W2yfEjvWQyJy3QPqS
         mK9nY62W+KlRg==
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
Subject: [PATCH v2 2/5] dmaengine: axi-dmac: Don't set chancnt
Date:   Sat, 15 Apr 2023 17:55:14 +0800
Message-Id: <20230415095517.2763-3-jszhang@kernel.org>
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
2.39.2

