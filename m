Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE94905A4
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 11:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiAQKDX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 05:03:23 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42602 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238473AbiAQKDU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jan 2022 05:03:20 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20H7ssvF007714;
        Mon, 17 Jan 2022 11:03:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=RQJJgQY1Idxf2tTyWLXLLK2DgfgnOIBmtxr9Lc7hWX8=;
 b=Qw0RY8iouxcUrfYnk1T42n6imKaX0Rp9da09yLAvJVJhe2TvKkHwa8hzVebJx8LpXMge
 hkWuNAEYIHldBRA0lWmCx9rOfOHYZzf4Sd2OiWBxcqKdgtlcH/qlSHCK9LaNCqFVQIfp
 OmC6TZ1FJE8Wv5XMIDx/yB1NzSdwaam32iiozE8ZEHpYBx/FkdbL0JihprsR/Npeevtj
 kKTxjkLeIO/Xv58BzF+4isuuejmmkn0jLNVZyPxvsqc41dUIPY2spZU1pPLHy3M+dXQN
 JAEC5Qy6symtj07dAtCk/DlWfrXWqyp9kqKW2MaZ5g5bFbS4tf1dBW42hUvNb4ZA9zuW Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dmwkwj9rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 11:03:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D487100038;
        Mon, 17 Jan 2022 11:03:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 348FD2122EE;
        Mon, 17 Jan 2022 11:03:01 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 17 Jan 2022 11:03:00
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH] dmaengine: stm32-mdma: check the channel availability (secure or not)
Date:   Mon, 17 Jan 2022 11:03:00 +0100
Message-ID: <20220117100300.14150-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_03,2022-01-14_01,2021-12-02_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32_MDMA_CCR bit[8] is used to enable Secure Mode (SM). If this bit is
set, it means that all the channel registers are write-protected. So the
channel is not available for Linux use.

Add stm32_mdma_filter_fn() callback filter and give it to
__dma_request_chan (instead of dma_get_any_slave_channel()), to exclude the
channel if it is marked Secure.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 6f57ff0e7b37..95e5831e490a 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -73,6 +73,7 @@
 #define STM32_MDMA_CCR_WEX		BIT(14)
 #define STM32_MDMA_CCR_HEX		BIT(13)
 #define STM32_MDMA_CCR_BEX		BIT(12)
+#define STM32_MDMA_CCR_SM		BIT(8)
 #define STM32_MDMA_CCR_PL_MASK		GENMASK(7, 6)
 #define STM32_MDMA_CCR_PL(n)		FIELD_PREP(STM32_MDMA_CCR_PL_MASK, (n))
 #define STM32_MDMA_CCR_TCIE		BIT(5)
@@ -248,6 +249,7 @@ struct stm32_mdma_device {
 	u32 nr_channels;
 	u32 nr_requests;
 	u32 nr_ahb_addr_masks;
+	u32 chan_reserved;
 	struct stm32_mdma_chan chan[STM32_MDMA_MAX_CHANNELS];
 	u32 ahb_addr_masks[];
 };
@@ -1456,10 +1458,23 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
 	chan->desc_pool = NULL;
 }
 
+static bool stm32_mdma_filter_fn(struct dma_chan *c, void *fn_param)
+{
+	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
+	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
+
+	/* Check if chan is marked Secure */
+	if (dmadev->chan_reserved & BIT(chan->id))
+		return false;
+
+	return true;
+}
+
 static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
 	struct stm32_mdma_device *dmadev = ofdma->of_dma_data;
+	dma_cap_mask_t mask = dmadev->ddev.cap_mask;
 	struct stm32_mdma_chan *chan;
 	struct dma_chan *c;
 	struct stm32_mdma_chan_config config;
@@ -1485,7 +1500,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 	}
 
-	c = dma_get_any_slave_channel(&dmadev->ddev);
+	c = __dma_request_channel(&mask, stm32_mdma_filter_fn, &config, ofdma->of_node);
 	if (!c) {
 		dev_err(mdma2dev(dmadev), "No more channels available\n");
 		return NULL;
@@ -1615,6 +1630,10 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	for (i = 0; i < dmadev->nr_channels; i++) {
 		chan = &dmadev->chan[i];
 		chan->id = i;
+
+		if (stm32_mdma_read(dmadev, STM32_MDMA_CCR(i)) & STM32_MDMA_CCR_SM)
+			dmadev->chan_reserved |= BIT(i);
+
 		chan->vchan.desc_free = stm32_mdma_desc_free;
 		vchan_init(&chan->vchan, dd);
 	}
-- 
2.25.1

