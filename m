Return-Path: <dmaengine+bounces-54-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5907E1D72
	for <lists+dmaengine@lfdr.de>; Mon,  6 Nov 2023 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441EF281281
	for <lists+dmaengine@lfdr.de>; Mon,  6 Nov 2023 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F542168A3;
	Mon,  6 Nov 2023 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375116420
	for <dmaengine@vger.kernel.org>; Mon,  6 Nov 2023 09:51:18 +0000 (UTC)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2FDB
	for <dmaengine@vger.kernel.org>; Mon,  6 Nov 2023 01:51:15 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 34A2C24E26B;
	Mon,  6 Nov 2023 17:51:12 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Nov
 2023 17:51:12 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Nov
 2023 17:51:09 +0800
From: Tan En De <ende.tan@starfivetech.com>
To: <dmaengine@vger.kernel.org>
CC: <Eugeniy.Paltsev@synopsys.com>, <vkoul@kernel.org>, Tan En De
	<ende.tan@starfivetech.com>
Subject: [v3,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and dst_maxburst
Date: Mon, 6 Nov 2023 17:50:34 +0800
Message-ID: <20231106095034.2009-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.38.1.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

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
v2 -> v3:
- Removed the use of dma_slave_config in dma_chan_prep_dma_memcpy.
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 18 +++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  3 ++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81ff0caa..2a4747917a3e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -656,7 +656,7 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan=
 *chan,
 	size_t axi_block_ts;
 	size_t block_ts;
 	u32 ctllo, ctlhi;
-	u32 burst_len;
+	u32 burst_len, src_burst_trans_len, dst_burst_trans_len;
=20
 	axi_block_ts =3D chan->chip->dw->hdata->block_size[chan->id];
=20
@@ -720,8 +720,20 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_cha=
n *chan,
=20
 	hw_desc->lli->block_ts_lo =3D cpu_to_le32(block_ts - 1);
=20
-	ctllo |=3D DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
-		 DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS;
+	dst_burst_trans_len =3D chan->config.dst_maxburst ?
+				__ffs(chan->config.dst_maxburst) - 1 :
+				DWAXIDMAC_BURST_TRANS_LEN_4;
+	if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+		return -EINVAL;
+	ctllo |=3D dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
+
+	src_burst_trans_len =3D chan->config.src_maxburst ?
+				__ffs(chan->config.src_maxburst) - 1 :
+				DWAXIDMAC_BURST_TRANS_LEN_4;
+	if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+		return -EINVAL;
+	ctllo |=3D src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;
+
 	hw_desc->lli->ctl_lo =3D cpu_to_le32(ctllo);
=20
 	set_desc_src_master(hw_desc);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-d=
mac/dw-axi-dmac.h
index 454904d99654..652e983409ba 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -269,7 +269,8 @@ enum {
 	DWAXIDMAC_BURST_TRANS_LEN_128,
 	DWAXIDMAC_BURST_TRANS_LEN_256,
 	DWAXIDMAC_BURST_TRANS_LEN_512,
-	DWAXIDMAC_BURST_TRANS_LEN_1024
+	DWAXIDMAC_BURST_TRANS_LEN_1024,
+	DWAXIDMAC_BURST_TRANS_LEN_MAX  =3D DWAXIDMAC_BURST_TRANS_LEN_1024
 };
=20
 #define CH_CTL_L_DST_WIDTH_POS		11
--=20
2.34.1


