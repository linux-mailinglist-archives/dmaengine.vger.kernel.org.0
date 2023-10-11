Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD967C4CB2
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 10:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjJKIMd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjJKIMc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 04:12:32 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190929B;
        Wed, 11 Oct 2023 01:12:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D5081BF203;
        Wed, 11 Oct 2023 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697011948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOZ53uDlJRud+RSY+ah8ZS/rh8udoyM60w7XsdTrQ3A=;
        b=ULdnuIEfUNsQOGmFVLOpN1K0Mu863utSDvP6VgnV2FwcjDgdsp8RQAT0O287xOj/he8DSX
        kvfyFcDoEOo4DUldDSq8T6KTBjQv68bYH2igSBePqPWZHIgY95v1Rp1m3njGnlr9O0dezP
        dwwHiSDY3Dl+uln3PRiAH50LrI1RO71ibZFoRU8I16MlINje9YHBYtyabqhZDkT89hc8y1
        OdfL5LsoO4X0kI63RuVx+zf1b28xJAAbfyQZGpoN2qlIYEiT2+AuhSjC1F0jARcABhkdA3
        JNG3jdS8ol13Vrfu6UBLg3fXW+uOH2Y0QRd72ugvuAv+9NPAWk5VuljAVG3Ulg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 11 Oct 2023 10:11:40 +0200
Subject: [PATCH v3 1/6] dmaengine: dw-edma: Fix the ch_count hdma callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-b4-feature_hdma_mainline-v3-1-24ee0c979c6f@bootlin.com>
References: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
In-Reply-To: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current check of ch_en enabled to know the maximum number of available
hardware channels is wrong as it check the number of ch_en register set
but all of them are unset at probe. This register is set at the
dw_hdma_v0_core_start function which is run lately before a DMA transfer.

The HDMA IP have no way to know the number of hardware channels available
like the eDMA IP, then let set it to maximum channels and let the platform
set the right number of channels.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

See the following thread mail that talk about this issue:
https://lore.kernel.org/lkml/20230607095832.6d6b1a73@kmaincent-XPS-13-7390/

Changes in v2:
- Add comment

Changes in v3:
- Fix comment style.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 00b735a0202a..1f4cb7db5475 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -65,18 +65,12 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 
 static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	u32 num_ch = 0;
-	int id;
-
-	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
-		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
-			num_ch++;
-	}
-
-	if (num_ch > HDMA_V0_MAX_NR_CH)
-		num_ch = HDMA_V0_MAX_NR_CH;
-
-	return (u16)num_ch;
+	/*
+	 * The HDMA IP have no way to know the number of hardware channels
+	 * available, we set it to maximum channels and let the platform
+	 * set the right number of channels.
+	 */
+	return HDMA_V0_MAX_NR_CH;
 }
 
 static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)

-- 
2.25.1

