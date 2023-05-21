Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6770ADD0
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEULsN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEUKZc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5810CC;
        Sun, 21 May 2023 03:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14AAD60F0E;
        Sun, 21 May 2023 10:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACFDC433A4;
        Sun, 21 May 2023 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664060;
        bh=6pmh1p/2P56PknsAf9XgnrAcTCEe0jke0QzLpJtlW2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uofbQcNglIZ9SCjmGN+WPWumHtt/je6y8z/YzzUos9PthN9lQldIWEzLGiL6qhyLs
         zKpcmIWqjnBTatvWM58sQ48WBPDzYdChRwONNQYeDmKPnJFU39vvPPeX6w4BYDPXFD
         F2/AutCikIJdzYM2Cbm6RX5ZLnnDVGswhSpCK36slWRJUCiuhcwrIhcIkcNeLeWFOa
         53jIlqITQiEkHsQx7z+F3gnQ2BYHCp3CNtUBBjkbETRf/uslkwFCP3mUr+zRB/Wj1q
         lBnvVuJEPBlSfOqE5LFmEv641lmVLX9HTKLDhywlJKtZuJrw1PMaM2B3gCmG3F1vbM
         gZs8mNOQ5Pj5g==
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
Subject: [PATCH v3 5/5] dmaengine: sprd: Don't set chancnt
Date:   Sun, 21 May 2023 18:02:52 +0800
Message-Id: <20230521100252.3197-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521100252.3197-1-jszhang@kernel.org>
References: <20230521100252.3197-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
2.40.0

