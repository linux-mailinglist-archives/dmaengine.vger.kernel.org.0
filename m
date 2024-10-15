Return-Path: <dmaengine+bounces-3363-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29C99E96D
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2FE282A84
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24021EF953;
	Tue, 15 Oct 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1Jk2rpjH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F51EF0A0;
	Tue, 15 Oct 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994592; cv=none; b=S+CwDWbcNETEDPV6F5lCYb91mvMI6TOn7Tos8q/Iq+9nd7hoByChVfPpmVjzmhIlmpwDeYjCAFluES1UEUmEEjkLulIhZa1SMjegx9IXx2ci5W7gsTHfIiVLAU5QBvQAgMf/4TyPO0Y/Vj9+F3pFASeRdwAyT693okJX6ucHEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994592; c=relaxed/simple;
	bh=LBdAfU8Kqu/fwBNvbyHjVHYadinYm9GDo39TryH+pVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=unNNwh4zNC7vB/R3XfcKtJryXMHdCiMSQBOEsVoiXXYipF/M52bkvWxvdx9HeIYKUQzaRyV3zKONp5O9JD/q6KYIoOy393d/IymALjM86nFCC7PSQy8wAB+OjUglqG3PN24PEoZUCgPXfCWDWapNNM/gKh/RBwV/+AXEtw6U8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1Jk2rpjH; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBQP8Q005433;
	Tue, 15 Oct 2024 14:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+kNC9WvxILqPos1K+zUy/g4I3JBkEYea0nY08omeYVo=; b=1Jk2rpjHqCLvUNCc
	8RAHFA6XwWgdVDHkFt0SBWlewbtLobrW8rjC90qqm9tBVK06tDMsVvudlaEoHDrz
	6o2iBddnp8yH8touNsOVcACaWdsdvjLzwxm2BlPegt2tcROmrrVTJdmDgsoEUijJ
	i0x1seVJ5plQ9KUI14ao039CrRXfZn3xnpnSY2CwcHOXx1BWvfNoMw3Hb0sylfXu
	tcYfC+W5l1lOR2l+8LkSl7F7Cd0Irzpa8kKWDOjmolvKPk0PphDY+2NQRGgjuqVx
	fAa/eC45zjkt85WVh/FJEPVb+73CFbR0IT68aGtPdYWPMPuWU2tTAtsmrUORgwU1
	b2/MHg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 427ehg5n91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:16:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0813A4004A;
	Tue, 15 Oct 2024 14:15:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D55B7222CB4;
	Tue, 15 Oct 2024 14:14:50 +0200 (CEST)
Received: from localhost (10.48.87.35) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 14:14:50 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 15 Oct 2024 14:14:42 +0200
Subject: [PATCH v2 6/9] dmaengine: stm32-dma3: clamp AXI burst using match
 data
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-dma3-mp25-updates-v2-6-b63e21556ec8@foss.st.com>
References: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
In-Reply-To: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

STM32 DMA3 can be interconnected with AXI3 or AXI4 busses. In case it is
interconnected with AXI3, the maximum burst length supported by AXI3
protocol is 16 beats, which is lower than the maximum burst length
supported by STM32 DMA3. So the programmed burst has to be shortened when
AXI port is used.
Introduce struct stm32_dma3_pdata to specify the specific configurations
(e.g. AXI maximum burst length) required by the SoC, so implied by the SoC
specific compatible.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Rework AXI maximum burst length management using SoC specific compatible
  instead of st,axi-max-burst-len DT property, as pointed out by Rob.
---
 drivers/dma/stm32/stm32-dma3.c | 59 ++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index fc874fec729df733fd8a6b4362fe1a937e9443c7..0c6c4258b19561c94f1c68f26ade16b82660ebe6 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -230,6 +230,8 @@ enum stm32_dma3_port_data_width {
 #define STM32_DMA3_CFG_SET_BOTH		(STM32_DMA3_CFG_SET_DT | STM32_DMA3_CFG_SET_DMA)
 
 #define STM32_DMA3_MAX_BLOCK_SIZE	ALIGN_DOWN(CBR1_BNDT, 64)
+#define STM32_DMA3_MAX_BURST_LEN	(1 + min_t(u32, FIELD_MAX(CTR1_SBL_1), \
+							FIELD_MAX(CTR1_DBL_1)))
 #define port_is_ahb(maxdw)		({ typeof(maxdw) (_maxdw) = (maxdw); \
 					   ((_maxdw) != DW_INVALID) && ((_maxdw) == DW_32); })
 #define port_is_axi(maxdw)		({ typeof(maxdw) (_maxdw) = (maxdw); \
@@ -295,6 +297,10 @@ struct stm32_dma3_chan {
 	u32 dma_status;
 };
 
+struct stm32_dma3_pdata {
+	u32 axi_max_burst_len;
+};
+
 struct stm32_dma3_ddata {
 	struct dma_device dma_dev;
 	void __iomem *base;
@@ -303,6 +309,7 @@ struct stm32_dma3_ddata {
 	u32 dma_channels;
 	u32 dma_requests;
 	enum stm32_dma3_port_data_width ports_max_dw[2];
+	u32 axi_max_burst_len;
 };
 
 static inline struct stm32_dma3_ddata *to_stm32_dma3_ddata(struct stm32_dma3_chan *chan)
@@ -535,7 +542,8 @@ static enum dma_slave_buswidth stm32_dma3_get_max_dw(u32 chan_max_burst,
 	return 1 << __ffs(len | addr | max_dw);
 }
 
-static u32 stm32_dma3_get_max_burst(u32 len, enum dma_slave_buswidth dw, u32 chan_max_burst)
+static u32 stm32_dma3_get_max_burst(u32 len, enum dma_slave_buswidth dw,
+				    u32 chan_max_burst, u32 bus_max_burst)
 {
 	u32 max_burst = chan_max_burst ? chan_max_burst / dw : 1;
 
@@ -546,8 +554,9 @@ static u32 stm32_dma3_get_max_burst(u32 len, enum dma_slave_buswidth dw, u32 cha
 	/*
 	 * HW doesn't modify the burst if burst size <= half of the fifo size.
 	 * If len is not a multiple of burst size, last burst is shortened by HW.
+	 * Take care of maximum burst supported on interconnect bus.
 	 */
-	return max_burst;
+	return min_t(u32, max_burst, bus_max_burst);
 }
 
 static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transfer_direction dir,
@@ -556,6 +565,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
 	struct dma_device dma_device = ddata->dma_dev;
+	u32 src_max_burst = STM32_DMA3_MAX_BURST_LEN, dst_max_burst = STM32_DMA3_MAX_BURST_LEN;
 	u32 sdw, ddw, sbl_max, dbl_max, tcem, init_dw, init_bl_max;
 	u32 _ctr1 = 0, _ctr2 = 0;
 	u32 ch_conf = chan->dt_config.ch_conf;
@@ -596,10 +606,14 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		_ctr1 |= CTR1_SINC;
 	if (sap)
 		_ctr1 |= CTR1_SAP;
+	if (port_is_axi(sap_max_dw)) /* AXI - apply axi maximum burst limitation */
+		src_max_burst = ddata->axi_max_burst_len;
 	if (FIELD_GET(STM32_DMA3_DT_DINC, tr_conf))
 		_ctr1 |= CTR1_DINC;
 	if (dap)
 		_ctr1 |= CTR1_DAP;
+	if (port_is_axi(dap_max_dw)) /* AXI - apply axi maximum burst limitation */
+		dst_max_burst = ddata->axi_max_burst_len;
 
 	_ctr2 |= FIELD_PREP(CTR2_REQSEL, chan->dt_config.req_line) & ~CTR2_SWREQ;
 	if (FIELD_GET(STM32_DMA3_DT_BREQ, tr_conf))
@@ -619,11 +633,12 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		/* Set destination (device) data width and burst */
 		ddw = min_t(u32, ddw, stm32_dma3_get_max_dw(chan->max_burst, dap_max_dw,
 							    len, dst_addr));
-		dbl_max = min_t(u32, dbl_max, stm32_dma3_get_max_burst(len, ddw, chan->max_burst));
+		dbl_max = min_t(u32, dbl_max, stm32_dma3_get_max_burst(len, ddw, chan->max_burst,
+								       dst_max_burst));
 
 		/* Set source (memory) data width and burst */
 		sdw = stm32_dma3_get_max_dw(chan->max_burst, sap_max_dw, len, src_addr);
-		sbl_max = stm32_dma3_get_max_burst(len, sdw, chan->max_burst);
+		sbl_max = stm32_dma3_get_max_burst(len, sdw, chan->max_burst, src_max_burst);
 		if (!!FIELD_GET(STM32_DMA3_DT_NOPACK, tr_conf)) {
 			sdw = ddw;
 			sbl_max = dbl_max;
@@ -653,11 +668,12 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		/* Set source (device) data width and burst */
 		sdw = min_t(u32, sdw, stm32_dma3_get_max_dw(chan->max_burst, sap_max_dw,
 							    len, src_addr));
-		sbl_max = min_t(u32, sbl_max, stm32_dma3_get_max_burst(len, sdw, chan->max_burst));
+		sbl_max = min_t(u32, sbl_max, stm32_dma3_get_max_burst(len, sdw, chan->max_burst,
+								       src_max_burst));
 
 		/* Set destination (memory) data width and burst */
 		ddw = stm32_dma3_get_max_dw(chan->max_burst, dap_max_dw, len, dst_addr);
-		dbl_max = stm32_dma3_get_max_burst(len, ddw, chan->max_burst);
+		dbl_max = stm32_dma3_get_max_burst(len, ddw, chan->max_burst, dst_max_burst);
 		if (!!FIELD_GET(STM32_DMA3_DT_NOPACK, tr_conf) ||
 		    ((_ctr2 & CTR2_PFREQ) && ddw > sdw)) { /* Packing to wider ddw not supported */
 			ddw = sdw;
@@ -689,22 +705,24 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		init_dw = sdw;
 		init_bl_max = sbl_max;
 		sdw = stm32_dma3_get_max_dw(chan->max_burst, sap_max_dw, len, src_addr);
-		sbl_max = stm32_dma3_get_max_burst(len, sdw, chan->max_burst);
+		sbl_max = stm32_dma3_get_max_burst(len, sdw, chan->max_burst, src_max_burst);
 		if (chan->config_set & STM32_DMA3_CFG_SET_DMA) {
 			sdw = min_t(u32, init_dw, sdw);
-			sbl_max = min_t(u32, init_bl_max,
-					stm32_dma3_get_max_burst(len, sdw, chan->max_burst));
+			sbl_max = min_t(u32, init_bl_max, stm32_dma3_get_max_burst(len, sdw,
+										   chan->max_burst,
+										   src_max_burst));
 		}
 
 		/* Set destination (memory) data width and burst */
 		init_dw = ddw;
 		init_bl_max = dbl_max;
 		ddw = stm32_dma3_get_max_dw(chan->max_burst, dap_max_dw, len, dst_addr);
-		dbl_max = stm32_dma3_get_max_burst(len, ddw, chan->max_burst);
+		dbl_max = stm32_dma3_get_max_burst(len, ddw, chan->max_burst, dst_max_burst);
 		if (chan->config_set & STM32_DMA3_CFG_SET_DMA) {
 			ddw = min_t(u32, init_dw, ddw);
-			dbl_max = min_t(u32, init_bl_max,
-					stm32_dma3_get_max_burst(len, ddw, chan->max_burst));
+			dbl_max = min_t(u32, init_bl_max, stm32_dma3_get_max_burst(len, ddw,
+										   chan->max_burst,
+										   dst_max_burst));
 		}
 
 		_ctr1 |= FIELD_PREP(CTR1_SDW_LOG2, ilog2(sdw));
@@ -1647,8 +1665,12 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 	return chan_reserved;
 }
 
+static struct stm32_dma3_pdata stm32mp25_pdata = {
+	.axi_max_burst_len = 16,
+};
+
 static const struct of_device_id stm32_dma3_of_match[] = {
-	{ .compatible = "st,stm32mp25-dma3", },
+	{ .compatible = "st,stm32mp25-dma3", .data = &stm32mp25_pdata, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, stm32_dma3_of_match);
@@ -1656,6 +1678,7 @@ MODULE_DEVICE_TABLE(of, stm32_dma3_of_match);
 static int stm32_dma3_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct stm32_dma3_pdata *pdata;
 	struct stm32_dma3_ddata *ddata;
 	struct reset_control *reset;
 	struct stm32_dma3_chan *chan;
@@ -1750,6 +1773,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	else /* Dual master ports */
 		ddata->ports_max_dw[1] = FIELD_GET(G_M1_DATA_WIDTH_ENC, hwcfgr);
 
+	/* axi_max_burst_len is optional, if not defined, use STM32_DMA3_MAX_BURST_LEN  */
+	ddata->axi_max_burst_len = STM32_DMA3_MAX_BURST_LEN;
+	pdata = device_get_match_data(&pdev->dev);
+	if (pdata && pdata->axi_max_burst_len) {
+		ddata->axi_max_burst_len = min_t(u32, pdata->axi_max_burst_len,
+						 STM32_DMA3_MAX_BURST_LEN);
+		dev_dbg(&pdev->dev, "Burst is limited to %u beats through AXI port\n",
+			ddata->axi_max_burst_len);
+	}
+
 	ddata->chans = devm_kcalloc(&pdev->dev, ddata->dma_channels, sizeof(*ddata->chans),
 				    GFP_KERNEL);
 	if (!ddata->chans) {

-- 
2.25.1


