Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FF79E5B4
	for <lists+dmaengine@lfdr.de>; Wed, 13 Sep 2023 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjIMLEw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 13 Sep 2023 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjIMLEv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Sep 2023 07:04:51 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B61726
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 04:04:47 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8804424E1DD;
        Wed, 13 Sep 2023 19:04:45 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 19:04:45 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 19:04:42 +0800
From:   Tan En De <ende.tan@starfivetech.com>
To:     <dmaengine@vger.kernel.org>
CC:     <Eugeniy.Paltsev@synopsys.com>, <vkoul@kernel.org>,
        Tan En De <ende.tan@starfivetech.com>
Subject: [v2,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and dst_maxburst
Date:   Wed, 13 Sep 2023 19:04:25 +0800
Message-ID: <20230913110425.1271-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.38.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Current implementation has hardcoded CHx_CTL.SRC_MSIZE and
CHx_CTL.DST_MSIZE with a constant, namely DWAXIDMAC_BURST_TRANS_LEN_4.

However, to support hardware with different source/destination burst
transaction length, the aforementioned values shall be configurable
based on dma_slave_config set by client driver.

So, this commit is to allow client driver to configure
- CHx_CTL.SRC_MSIZE via dma_slave_config.src_maxburst
- CHx_CTL.DST_MSIZE via dma_slave_config.dst_maxburst

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
v1 -> v2:
- Fixed typo (replaced `return -EINVAL` with `goto err_desc_get` in dma_chan_prep_dma_memcpy()).
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 38 +++++++++++++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +-
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index dd02f84e404d..f234097dffb9 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -610,7 +610,7 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	size_t axi_block_ts;
 	size_t block_ts;
 	u32 ctllo, ctlhi;
-	u32 burst_len;
+	u32 burst_len, src_burst_trans_len, dst_burst_trans_len;
 
 	axi_block_ts = chan->chip->dw->hdata->block_size[chan->id];
 
@@ -674,8 +674,20 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 
 	hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
 
-	ctllo |= DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
-		 DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS;
+	dst_burst_trans_len = chan->config.dst_maxburst ?
+				__ffs(chan->config.dst_maxburst) - 1 :
+				DWAXIDMAC_BURST_TRANS_LEN_4;
+	if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+		return -EINVAL;
+	ctllo |= dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
+
+	src_burst_trans_len = chan->config.src_maxburst ?
+				__ffs(chan->config.src_maxburst) - 1 :
+				DWAXIDMAC_BURST_TRANS_LEN_4;
+	if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+		return -EINVAL;
+	ctllo |= src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;
+
 	hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
 
 	set_desc_src_master(hw_desc);
@@ -878,7 +890,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	size_t block_ts, max_block_ts, xfer_len;
 	struct axi_dma_hw_desc *hw_desc = NULL;
 	struct axi_dma_desc *desc = NULL;
-	u32 xfer_width, reg, num;
+	u32 xfer_width, reg, num, src_burst_trans_len, dst_burst_trans_len;
 	u64 llp = 0;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
@@ -936,9 +948,21 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 		}
 		hw_desc->lli->ctl_hi = cpu_to_le32(reg);
 
-		reg = (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
-		       DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS |
-		       xfer_width << CH_CTL_L_DST_WIDTH_POS |
+		dst_burst_trans_len = chan->config.dst_maxburst ?
+					__ffs(chan->config.dst_maxburst) - 1 :
+					DWAXIDMAC_BURST_TRANS_LEN_4;
+		if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+			goto err_desc_get;
+		reg |= dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
+
+		src_burst_trans_len = chan->config.src_maxburst ?
+					__ffs(chan->config.src_maxburst) - 1 :
+					DWAXIDMAC_BURST_TRANS_LEN_4;
+		if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+			goto err_desc_get;
+		reg |= src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;
+
+		reg = (xfer_width << CH_CTL_L_DST_WIDTH_POS |
 		       xfer_width << CH_CTL_L_SRC_WIDTH_POS |
 		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
 		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index eb267cb24f67..877bff395740 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -265,7 +265,8 @@ enum {
 	DWAXIDMAC_BURST_TRANS_LEN_128,
 	DWAXIDMAC_BURST_TRANS_LEN_256,
 	DWAXIDMAC_BURST_TRANS_LEN_512,
-	DWAXIDMAC_BURST_TRANS_LEN_1024
+	DWAXIDMAC_BURST_TRANS_LEN_1024,
+	DWAXIDMAC_BURST_TRANS_LEN_MAX  = DWAXIDMAC_BURST_TRANS_LEN_1024
 };
 
 #define CH_CTL_L_DST_WIDTH_POS		11

base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
-- 
2.34.1

