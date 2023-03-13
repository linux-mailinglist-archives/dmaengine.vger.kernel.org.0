Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3826B7F1D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCMRP4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCMRPl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B091B2DB;
        Mon, 13 Mar 2023 10:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFD961381;
        Mon, 13 Mar 2023 17:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D613C433A1;
        Mon, 13 Mar 2023 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727622;
        bh=+THSfPIwklUUC80eud55EQMNToM9c5KqOlS32WoC2XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTOal6KEg0SZVhRbX2h2CEBDzRGBr32VzO+RBaVn1hEGQzAM4zdovWfmhZyejwSHN
         AJ+VvrD7VN5fr/rrtHU1E+KDt8Jcow0fge06jycv1hJTscQcJyr7INs2UmOBhdmwTb
         414DupFCmMvpm3lAhGnbmEqM2W/bL1MQnqHt1J8mRjpBije3IMDBN0OZOmBr19iTg/
         HnkT9mnarEL3YWzew22rp48cAsdYlGSzuUxZnf5Xd67fL5bBrbMfgWmsFIeEt8GGXe
         kuhVYiFRaUf4Ir8CB8H1S+SDGvR+kZbVcQNjlmJ9VJLoYp+dt/TxLpe120yB39YdPx
         WJBIaHv3hxzzg==
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
Subject: [PATCH 2/5] dmaengine: axi-dmac: Don't set chancnt
Date:   Tue, 14 Mar 2023 01:02:47 +0800
Message-Id: <20230313170250.815-3-jszhang@kernel.org>
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

