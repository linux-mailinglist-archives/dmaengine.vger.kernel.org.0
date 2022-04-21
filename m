Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D95509F78
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353531AbiDUMUf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 08:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiDUMUe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 08:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B872D1DC;
        Thu, 21 Apr 2022 05:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0D77B8244E;
        Thu, 21 Apr 2022 12:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F9C385A5;
        Thu, 21 Apr 2022 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650543462;
        bh=bWhHXUS3ks/K10eMNGHlsMHzHCbNNvETLjCIS2G+PL0=;
        h=From:To:Cc:Subject:Date:From;
        b=N26UwyuHAXz4IxSwINoBj83cio8nD7RpJaoNvKKfi1nNza020ZQmk+Zp26yw+gI2O
         p1I7RvSFH9qNtmznMRICwMTn8h1Vf+3wNL+7+F4qYXCsCcWYjwG4IbyXXDfigoNGCG
         IPjOqzt/Tm5vz7xq+FOQtZUW0nlSrk2PXRkDnu4mXiHd/iTUrnNb8fCZoCiJmfv8ng
         fH40njFZTUVvKLLYvfDY8fzLc02qd9XZUaw5m8MV/fTP0s36C0gxqGA8RooqXCzFNA
         m5ATghtDwbrOI6nAJcIDh4Kor6pG2qwh1nacvVAxwHeddh/5GPELQ33jXy2gQXSoh+
         xnKiITDsbp6Yw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] dmaengine: qcom: gpi: Add support for sc7280
Date:   Thu, 21 Apr 2022 17:47:33 +0530
Message-Id: <20220421121733.1829350-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add compatible and driver_data for GPI DMA engines found in Qualcomm
SC7280. The driver_data contains ee_offset of 0x10000.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/qcom/gpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index bdf2013ca7ca..09916a0eb755 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2312,6 +2312,7 @@ static int gpi_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpi_of_match[] = {
+	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
-- 
2.34.1

