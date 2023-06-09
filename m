Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63B729297
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjFIIRi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 04:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbjFIIRf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 04:17:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF1A35B6;
        Fri,  9 Jun 2023 01:16:59 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686298617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8snxb+3C9fmkNIycrjOe2QGKhT9VxzlCpHRN3AtV6g=;
        b=YsfuWmYOXUDE83S/ScUKeT2bzH5eUfjurjL4aQoAj+pw1QQxrMPRhokkwln9xq6A2pFEY9
        jzf9iXpyC/h1v/1Ny5ztGQ0Ma1RGWf9NBog3HQr3jckqC8IRKtyjs6S6zwZ1yLakYBwxyK
        v38XC6DPmcIkHw2e3fRmoYkHa3aKYpC86wI/Ka+FZAQEHXPyxFG5YLwAUoX1sbujXrSKZx
        BhogV3aG2InKR/F4mO1ZE4HGU4rDrTbGxAaaoTABRRfh6qJPS4Ze/DV14/utD+p3iFC2XA
        hUIP9Z9X08H9aMshuwbcgvzeAhLKuNa+q5C42FCau+uoNWE+Da1Hk2peEaT9iw==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E0B3C0003;
        Fri,  9 Jun 2023 08:16:56 +0000 (UTC)
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 1/9] dmaengine: dw-edma: Fix the ch_count hdma callback
Date:   Fri,  9 Jun 2023 10:16:46 +0200
Message-Id: <20230609081654.330857-2-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609081654.330857-1-kory.maincent@bootlin.com>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

The current check of ch_en enabled to know the maximum number of available
hardware channels is wrong as it check the number of ch_en register set
but all of them are unset at probe. This register is set at the
dw_hdma_v0_core_start function which is run lately before a DMA transfer.

The HDMA IP have no way to know the number of hardware channels available
like the eDMA IP, then let set it to maximum channels and let the platform
set the right number of channels.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

See the following thread mail that talk about this issue:
https://lore.kernel.org/lkml/20230607095832.6d6b1a73@kmaincent-XPS-13-7390/

This patch is fixing a commit which is only in dmaengine tree and not
merged mainline.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 00b735a0202a..de87ce6b8585 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -65,18 +65,7 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 
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
+	return HDMA_V0_MAX_NR_CH;
 }
 
 static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
-- 
2.25.1

