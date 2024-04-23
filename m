Return-Path: <dmaengine+bounces-1926-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E68AE638
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E8CB250CF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623612EBF7;
	Tue, 23 Apr 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cyPYr43P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF086621;
	Tue, 23 Apr 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875734; cv=none; b=kJ/R4GqHIE32E2XvOOBcXOxOSZou51wr9NoW+/odItM5biJqVLCnQIvfxb8U0SaMyuOdKTeRSEowyJBMOp7fSIh6bdCUc8WjqoNXv3yn37l/Q4MolS9eEiZ0wqd2LH/uoZV3FcmypFCJbWUbHxDKI5q/JtCvNT5+6z6rjHKo4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875734; c=relaxed/simple;
	bh=7S3mGb3srO2KDRA0q+93ck20zvAlzTf4nkV/0RQisLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibv/9qEjcezKph/RUtaX3Ks0EWkiaUb1eVjP4E1Tw4bmpiH/yMkgO/fSy/qYe4+YgxwwBifBcNXs3qD8hO6agI6lGLsaPZ7ktD9DOvaWwvFUok8twnVrW4Vh+umQXRcugG2Hp+C3sZFYq03b+9ZMltN8OVDQVok8DhANF7YnsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cyPYr43P; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8BO5H013052;
	Tue, 23 Apr 2024 14:35:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ujtC6y06WSw8eFdrm80pVhRj07fS50OWORuQYTvb6es=; b=cy
	PYr43PjlP4Zw3s6RzJddlhfvk/+voNbBpzUKrIiRmdCav5FB/QkiR55MZ+WQMC2W
	8gcqajwIE0ON4ARJR1LwLuj1KoejKdZ9SaFJeRqbE8Ixf2hJ8t+U76s9JrdS6PJH
	0xiDswxUbJ/8satceaDtGyUQkaqBgKcYLl5mDaWJa2yc39J+U1m2Z3VGRKrIOPGo
	Ia7W2qWDH+P8q8i5N5Jt5SI+ypbZxT1eyNRAfVfApdGtzEdGItTUrqy7WZo1IJeh
	wIree69/C9tfNcs7NbiWiAq+tIqrFOQQZOYOd1OXaOMMFUZlbo0JPDV63Njtu07v
	qlMXlCWgqKNRp8D7cl/A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4edudu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:35:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 39AF440047;
	Tue, 23 Apr 2024 14:35:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DA4E21A23B;
	Tue, 23 Apr 2024 14:34:29 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:34:29 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>
Subject: [PATCH 07/12] dmaengine: stm32-dma3: add DMA_MEMCPY capability
Date: Tue, 23 Apr 2024 14:32:57 +0200
Message-ID: <20240423123302.1550592-8-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02

Add DMA_MEMCPY capability and relative device_prep_dma_memcpy ops with
stm32_dma3_prep_dma_memcpy(). It reuses stm32_dma3_chan_prep_hw() and
stm32_dma3_prep_hwdesc() helpers.
As this driver relies on both device_config and of_xlate ops to
pre-configure the channel for transfer, add a new helper
(stm32_dma3_init_chan_config_for_memcpy) in case the channel is used
without being pre-configured (with DT and/or dmaengine_slave_config()).

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 131 ++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 3afd9f8da2b6..73e856a5aeab 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -222,6 +222,11 @@ enum stm32_dma3_port_data_width {
 #define STM32_DMA3_DT_PFREQ		BIT(9) /* CTR2_PFREQ */
 #define STM32_DMA3_DT_TCEM		GENMASK(13, 12) /* CTR2_TCEM */
 
+/* struct stm32_dma3_chan .config_set bitfield */
+#define STM32_DMA3_CFG_SET_DT		BIT(0)
+#define STM32_DMA3_CFG_SET_DMA		BIT(1)
+#define STM32_DMA3_CFG_SET_BOTH		(STM32_DMA3_CFG_SET_DT | STM32_DMA3_CFG_SET_DMA)
+
 #define STM32_DMA3_MAX_BLOCK_SIZE	ALIGN_DOWN(CBR1_BNDT, 64)
 #define port_is_ahb(maxdw)		({ typeof(maxdw) (_maxdw) = (maxdw); \
 					   ((_maxdw) != DW_INVALID) && ((_maxdw) == DW_32); })
@@ -281,6 +286,7 @@ struct stm32_dma3_chan {
 	bool semaphore_mode;
 	struct stm32_dma3_dt_conf dt_config;
 	struct dma_slave_config dma_config;
+	u8 config_set;
 	struct dma_pool *lli_pool;
 	struct stm32_dma3_swdesc *swdesc;
 	enum ctr2_tcem tcem;
@@ -539,7 +545,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
 	struct dma_device dma_device = ddata->dma_dev;
-	u32 sdw, ddw, sbl_max, dbl_max, tcem;
+	u32 sdw, ddw, sbl_max, dbl_max, tcem, init_dw, init_bl_max;
 	u32 _ctr1 = 0, _ctr2 = 0;
 	u32 ch_conf = chan->dt_config.ch_conf;
 	u32 tr_conf = chan->dt_config.tr_conf;
@@ -658,6 +664,49 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 
 		break;
 
+	case DMA_MEM_TO_MEM:
+		/* Set source (memory) data width and burst */
+		init_dw = sdw;
+		init_bl_max = sbl_max;
+		sdw = stm32_dma3_get_max_dw(chan->max_burst, sap_max_dw, len, src_addr);
+		sbl_max = stm32_dma3_get_max_burst(len, sdw, chan->max_burst);
+		if (chan->config_set & STM32_DMA3_CFG_SET_DMA) {
+			sdw = min_t(u32, init_dw, sdw);
+			sbl_max = min_t(u32, init_bl_max,
+					stm32_dma3_get_max_burst(len, sdw, chan->max_burst));
+		}
+
+		/* Set destination (memory) data width and burst */
+		init_dw = ddw;
+		init_bl_max = dbl_max;
+		ddw = stm32_dma3_get_max_dw(chan->max_burst, dap_max_dw, len, dst_addr);
+		dbl_max = stm32_dma3_get_max_burst(len, ddw, chan->max_burst);
+		if (chan->config_set & STM32_DMA3_CFG_SET_DMA) {
+			ddw = min_t(u32, init_dw, ddw);
+			dbl_max = min_t(u32, init_bl_max,
+					stm32_dma3_get_max_burst(len, ddw, chan->max_burst));
+		}
+
+		_ctr1 |= FIELD_PREP(CTR1_SDW_LOG2, ilog2(sdw));
+		_ctr1 |= FIELD_PREP(CTR1_SBL_1, sbl_max - 1);
+		_ctr1 |= FIELD_PREP(CTR1_DDW_LOG2, ilog2(ddw));
+		_ctr1 |= FIELD_PREP(CTR1_DBL_1, dbl_max - 1);
+
+		if (ddw != sdw) {
+			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
+			/* Should never reach this case as ddw is clamped down */
+			if (len & (ddw - 1)) {
+				dev_err(chan2dev(chan),
+					"Packing mode is enabled and len is not multiple of ddw");
+				return -EINVAL;
+			}
+		}
+
+		/* CTR2_REQSEL/DREQ/BREQ/PFREQ are ignored with CTR2_SWREQ=1 */
+		_ctr2 |= CTR2_SWREQ;
+
+		break;
+
 	default:
 		dev_err(chan2dev(chan), "Direction %s not supported\n",
 			dmaengine_get_direction_text(dir));
@@ -927,6 +976,82 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
 	/* Reset configuration */
 	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
 	memset(&chan->dma_config, 0, sizeof(chan->dma_config));
+	chan->config_set = 0;
+}
+
+static void stm32_dma3_init_chan_config_for_memcpy(struct stm32_dma3_chan *chan,
+						   dma_addr_t dst, dma_addr_t src)
+{
+	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
+	u32 dw = get_chan_max_dw(ddata->ports_max_dw[0], chan->max_burst); /* port 0 by default */
+	u32 burst = chan->max_burst / dw;
+
+	/* Initialize dt_config if channel not pre-configured through DT */
+	if (!(chan->config_set & STM32_DMA3_CFG_SET_DT)) {
+		chan->dt_config.ch_conf = FIELD_PREP(STM32_DMA3_DT_PRIO, CCR_PRIO_VERY_HIGH);
+		chan->dt_config.ch_conf |= FIELD_PREP(STM32_DMA3_DT_FIFO, chan->fifo_size);
+		chan->dt_config.tr_conf = STM32_DMA3_DT_SINC | STM32_DMA3_DT_DINC;
+		chan->dt_config.tr_conf |= FIELD_PREP(STM32_DMA3_DT_TCEM, CTR2_TCEM_CHANNEL);
+	}
+
+	/* Initialize dma_config if dmaengine_slave_config() not used */
+	if (!(chan->config_set & STM32_DMA3_CFG_SET_DMA)) {
+		chan->dma_config.src_addr_width = dw;
+		chan->dma_config.dst_addr_width = dw;
+		chan->dma_config.src_maxburst = burst;
+		chan->dma_config.dst_maxburst = burst;
+		chan->dma_config.src_addr = src;
+		chan->dma_config.dst_addr = dst;
+	}
+}
+
+static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_memcpy(struct dma_chan *c,
+								  dma_addr_t dst, dma_addr_t src,
+								  size_t len, unsigned long flags)
+{
+	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+	struct stm32_dma3_swdesc *swdesc;
+	size_t next_size, offset;
+	u32 count, i, ctr1, ctr2;
+
+	count = DIV_ROUND_UP(len, STM32_DMA3_MAX_BLOCK_SIZE);
+
+	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
+	if (!swdesc)
+		return NULL;
+
+	if (chan->config_set != STM32_DMA3_CFG_SET_BOTH)
+		stm32_dma3_init_chan_config_for_memcpy(chan, dst, src);
+
+	for (i = 0, offset = 0; offset < len; i++, offset += next_size) {
+		size_t remaining;
+		int ret;
+
+		remaining = len - offset;
+		next_size = min_t(size_t, remaining, STM32_DMA3_MAX_BLOCK_SIZE);
+
+		ret = stm32_dma3_chan_prep_hw(chan, DMA_MEM_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
+					      src + offset, dst + offset, next_size);
+		if (ret)
+			goto err_desc_free;
+
+		stm32_dma3_chan_prep_hwdesc(chan, swdesc, i, src + offset, dst + offset, next_size,
+					    ctr1, ctr2, next_size == remaining, false);
+	}
+
+	/* Enable Errors interrupts */
+	swdesc->ccr |= CCR_USEIE | CCR_ULEIE | CCR_DTEIE;
+	/* Enable Transfer state interrupts */
+	swdesc->ccr |= CCR_TCIE;
+
+	swdesc->cyclic = false;
+
+	return vchan_tx_prep(&chan->vchan, &swdesc->vdesc, flags);
+
+err_desc_free:
+	stm32_dma3_chan_desc_free(chan, swdesc);
+
+	return NULL;
 }
 
 static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan *c,
@@ -1110,6 +1235,7 @@ static int stm32_dma3_config(struct dma_chan *c, struct dma_slave_config *config
 	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
 
 	memcpy(&chan->dma_config, config, sizeof(*config));
+	chan->config_set |= STM32_DMA3_CFG_SET_DMA;
 
 	return 0;
 }
@@ -1224,6 +1350,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
 
 	chan = to_stm32_dma3_chan(c);
 	chan->dt_config = conf;
+	chan->config_set |= STM32_DMA3_CFG_SET_DT;
 
 	return c;
 }
@@ -1322,6 +1449,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	dma_dev->dev = &pdev->dev;
 	/*
 	 * This controller supports up to 8-byte buswidth depending on the port used and the
@@ -1343,6 +1471,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = stm32_dma3_prep_dma_memcpy;
 	dma_dev->device_prep_slave_sg = stm32_dma3_prep_slave_sg;
 	dma_dev->device_prep_dma_cyclic = stm32_dma3_prep_dma_cyclic;
 	dma_dev->device_caps = stm32_dma3_caps;
-- 
2.25.1


