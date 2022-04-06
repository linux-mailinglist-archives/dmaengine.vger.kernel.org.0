Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA584F64AE
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiDFP6b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiDFP6O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 11:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D102AA18D;
        Wed,  6 Apr 2022 06:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F50B60BBC;
        Wed,  6 Apr 2022 13:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185FAC385A1;
        Wed,  6 Apr 2022 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251523;
        bh=QGkEFEefYTEXkBMQJmoYFoH64Owk00x5HUyX9UzaMs8=;
        h=From:To:Cc:Subject:Date:From;
        b=TwpYw6Fg0t6V8g3Y7nVZRVWV8NiF+3mdJQYWFirzVZ4t+NhlaKECJ3JtqEhRg8ktS
         Gq60nyUvTUKVGCu8Fr5ISHt5ArbWDbdaTXwyrTRLUeiZ+TBf1YrDCSf4vYUyiYpy25
         9KfXhv2PzqvtCB/Xiv1Gus4I82LFALzoLrwETJmc6eqB4ZJlFi7YtDHb/WvlIDVfqA
         dlMYd43CgZOk/+1b7zjWOgPizhaLY587A2LsD45zBzb1HbHsPe0ASSRZpjWJ82Z35Y
         D8WiAPxLT4iwfiatsghZPzA+MzynRuupSb8cHIleMmFvveK8tlC9q4aoUMWiBGbxd4
         Nh+3Ypkh8Up1w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: qcom: gpi: set chain and link flag for duplex
Date:   Wed,  6 Apr 2022 18:55:06 +0530
Message-Id: <20220406132508.1029348-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Newer platforms seem to have strict requirement for TRE flags which
causes transaction to timeout. This was resolved to missing chain and
link flag for duplex spi transaction.

So add these two flags.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/qcom/gpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 94f3648f7483..3429ceccd13b 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1754,10 +1754,14 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 		tre->dword[2] = u32_encode_bits(spi->rx_len, TRE_RX_LEN);
 
 		tre->dword[3] = u32_encode_bits(TRE_TYPE_GO, TRE_FLAGS_TYPE);
-		if (spi->cmd == SPI_RX)
+		if (spi->cmd == SPI_RX) {
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
-		else
+		} else if (spi->cmd == SPI_TX) {
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
+		} else { /* SPI_DUPLEX */
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_LINK);
+		}
 	}
 
 	/* create the dma tre */
-- 
2.34.1

