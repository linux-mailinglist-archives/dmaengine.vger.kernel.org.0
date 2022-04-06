Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8884F6498
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiDFP6a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 11:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiDFP6O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 11:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D7613DFF;
        Wed,  6 Apr 2022 06:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87F96152F;
        Wed,  6 Apr 2022 13:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B4DC385AA;
        Wed,  6 Apr 2022 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251529;
        bh=NZuFXM3zqS91214yNiugl+PV0SUW+INnvg+0l8KGQ2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7hIVXjO8JIfjb8oqfshU57Clp3/ThSRPXcXZ21/OMEq7lCJxrkgyrQmgut1J8DC9
         9R637NI/wj8sryhCNbyrpqEtW4zHrrJ0tMI4/m2T1sGqMvEXKXc962WIVLINpF77D5
         oSOL52BCtccx0EgXpgTlKI9Z92ZiDlIPSgYroaHHruZw2L+McYa1p3B3+mhXPtpnk8
         O0Js3em3qzq6LxsmzX+wFbWG/XRY9v/WMV/m0mcAoTVRgI2wZNZ99rEsVFSkqou1Xe
         FQbhSnNXiphRwzEygoHIfX6eCBD3SHOL/sJCQnkC7sYVJf5syNNKOyJqbK1tV3c8Gz
         h2u2/JR1SQezA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: qcom: gpi: Add support for ee_offset
Date:   Wed,  6 Apr 2022 18:55:08 +0530
Message-Id: <20220406132508.1029348-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406132508.1029348-1-vkoul@kernel.org>
References: <20220406132508.1029348-1-vkoul@kernel.org>
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

Controller on newer SoCs like SM8450 have registers at at offset. Add
ee_offset to driver_data and add this compatible for the driver.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/qcom/gpi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 3429ceccd13b..0b402d923eae 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2152,6 +2152,7 @@ static int gpi_probe(struct platform_device *pdev)
 {
 	struct gpi_dev *gpi_dev;
 	unsigned int i;
+	u32 ee_offset;
 	int ret;
 
 	gpi_dev = devm_kzalloc(&pdev->dev, sizeof(*gpi_dev), GFP_KERNEL);
@@ -2179,6 +2180,9 @@ static int gpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ee_offset = (uintptr_t)device_get_match_data(gpi_dev->dev);
+	gpi_dev->ee_base = gpi_dev->ee_base - ee_offset;
+
 	gpi_dev->ev_factor = EV_FACTOR;
 
 	ret = dma_set_mask(gpi_dev->dev, DMA_BIT_MASK(64));
@@ -2282,9 +2286,10 @@ static int gpi_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpi_of_match[] = {
-	{ .compatible = "qcom,sdm845-gpi-dma" },
-	{ .compatible = "qcom,sm8150-gpi-dma" },
-	{ .compatible = "qcom,sm8250-gpi-dma" },
+	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
+	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
+	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
+	{ .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, gpi_of_match);
-- 
2.34.1

