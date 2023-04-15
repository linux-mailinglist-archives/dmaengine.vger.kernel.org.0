Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB566E3069
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDOKGk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjDOKGf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56E83C2;
        Sat, 15 Apr 2023 03:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C1E160B7A;
        Sat, 15 Apr 2023 10:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A277DC43444;
        Sat, 15 Apr 2023 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553183;
        bh=j0aBz66SH19AvtQqR7Wm6Ds/FEdfxHpyVN3OSq/97ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wnb6lo7ozMMC+0h+H3aHtR73fgbRh+c1fxAOUu/duhI+c/RZPDt+thU1gS8iYN437
         4xwKW5j54WgNmgpB46qD7PvQQ77aFl+X4XqFS5hBVXjfWB3hl8ElMn+2wWUVVA7bhW
         X2g6QLLhsl5w+8BRrkdt/0x7p7W3eVUUh6c06h3IE2Piuiy0xsVZ1+lTXvzIcns2q+
         fel9D5AIU6F1SbXSnGMX3evpMmfZ2jWuiY4TTbKYd8MqqRMFIqLAQ63LhHEoLmdbKL
         RPbBsV0Rqu4+TndBK4FcxdwmrmNsAxdxim9AHje8usVbPN+f4VJ9nVo1Mzn1CG33K8
         +8+BAvAGiaq1Q==
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
Subject: [PATCH v2 3/5] dmaengine: plx_dma: Don't set chancnt
Date:   Sat, 15 Apr 2023 17:55:15 +0800
Message-Id: <20230415095517.2763-4-jszhang@kernel.org>
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

