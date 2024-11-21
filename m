Return-Path: <dmaengine+bounces-3753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99979D4C4C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 12:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4840B25662
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1F1D5158;
	Thu, 21 Nov 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I9J0mb+Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6B1D4336;
	Thu, 21 Nov 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189948; cv=none; b=idaMc8P6ngoZDdugZSZXpxFDo4xDNrOnNwS/9I6G92/hILWERTxMM9qwatBWx+iGXiEEkR5MYE4J+knHdgI6crZOfNoVA1Gf5dToUcTIBkiWRi4Jtj2r/cwypfF1WYWQDqcYA/2WXMofsFVkjtRUJsVn9HtPvleF2U+LUfIWMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189948; c=relaxed/simple;
	bh=leFN8M2VvNEZJXMv7i4oXi23n5R8HDBh1+Ym3bkhIu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBcdr9Xt9n/uxYiW851yQGNwQdC1DHMfFUUBukxP6YMJ6pMbS7pzphf9hh6vsfheUrmdIo2ijx6UzkRgVWWJ1i+7s2l8LHsP6zk5SYHN7pfl9+tco1QJVed1uphSeCyB+YQIEcS1ileFwcD2PjUckgiqLgZk/DqltEGOxqvGhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I9J0mb+Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALA7lPI026219;
	Thu, 21 Nov 2024 11:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v5D+cVhAnSAu0jYvybf8xsTq
	HmEjzIlqBZTVbc3jrvg=; b=I9J0mb+Q6D8cjuUR/0r3ls1h0p0btxehCzdj7ENv
	3ra4yovEr1xPDJ4/rHxVNDP6KJoCBEYHWP/7g6xylTXVXtN4nWMCymvoEO6kpoO3
	VTStTfrHhuxcvYtMr56JfxREoq27XxcCnjdUWP9wr6vERSVauLkE1wg/DV2RNrjZ
	fVDBKzijvuY5n6Tg9dBh5BCEEW87ia0iczCLqRc//xWgNIQLRD57RpxA23TGDYbE
	2V3EiiCxyYdESjcafOvExJocLj4CrbESRV5ee323666FcX+ZKtP4qcB+WyZN7wrN
	Dq8veBm3DtCkA0fx+2kBLRQQ9eJN0afg2TQ/X4B0yywFqQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ebybk2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:52:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALBqNV3016621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:52:23 GMT
Received: from hu-jseerapu-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 03:52:19 -0800
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
Subject: [PATCH v1 1/1] spi: spi-geni-qcom: Add immediate DMA support
Date: Thu, 21 Nov 2024 17:22:01 +0530
Message-ID: <20241121115201.2191-2-quic_jseerapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
References: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VrxN1DHnMYh3bxTJXjtc_5NKl7EpvD7I
X-Proofpoint-ORIG-GUID: VrxN1DHnMYh3bxTJXjtc_5NKl7EpvD7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210093

The DMA TRE(Transfer ring element) buffer contains the DMA
buffer address. Accessing data from this address can cause
significant delays in SPI transfers, which can be mitigated to
some extent by utilizing immediate DMA support.

QCOM GPI DMA hardware supports an immediate DMA feature for data
up to 8 bytes, storing the data directly in the DMA TRE buffer
instead of the DMA buffer address. This enhancement enables faster
SPI data transfers.

This optimization reduces the average transfer time from 25 us to
16 us for a single SPI transfer of 8 bytes length, with a clock
frequency of 50 MHz.

Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
---
 drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
 drivers/spi/spi-geni-qcom.c      |  7 +++++++
 include/linux/dma/qcom-gpi-dma.h |  7 +++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 52a7c8f2498f..a8df1e835e27 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -27,6 +27,7 @@
 #define TRE_FLAGS_IEOT		BIT(9)
 #define TRE_FLAGS_BEI		BIT(10)
 #define TRE_FLAGS_LINK		BIT(11)
+#define TRE_FLAGS_IMMEDIATE_DMA	BIT(16)
 #define TRE_FLAGS_TYPE		GENMASK(23, 16)
 
 /* SPI CONFIG0 WD0 */
@@ -64,6 +65,7 @@
 
 /* DMA TRE */
 #define TRE_DMA_LEN		GENMASK(23, 0)
+#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
 
 /* Register offsets from gpi-top */
 #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
@@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 	dma_addr_t address;
 	struct gpi_tre *tre;
 	unsigned int i;
+	u8 *buf;
+	int len = 0;
 
 	/* first create config tre if applicable */
 	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
@@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 	tre_idx++;
 
 	address = sg_dma_address(sgl);
-	tre->dword[0] = lower_32_bits(address);
-	tre->dword[1] = upper_32_bits(address);
+	len = sg_dma_len(sgl);
 
-	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
+	/* Support Immediate dma for write transfers for data length up to 8 bytes */
+	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {
+		buf = (u8 *)sg_virt(sgl);
 
-	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
-	if (direction == DMA_MEM_TO_DEV)
+		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		memcpy((u8 *)&tre->dword[0], buf, len);
+
+		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
+
+		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
 		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IMMEDIATE_DMA);
+	} else {
+		tre->dword[0] = lower_32_bits(address);
+		tre->dword[1] = upper_32_bits(address);
+
+		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
+
+		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
+		if (direction == DMA_MEM_TO_DEV)
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+	}
 
 	for (i = 0; i < tre_idx; i++)
 		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 768d7482102a..53c8f6b7f3c5 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -472,11 +472,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		mas->cur_speed_hz = xfer->speed_hz;
 	}
 
+	/*
+	 * Set QCOM_GPI_IMMEDIATE_DMA flag if transfer length up to 8 bytes.
+	 */
 	if (xfer->tx_buf && xfer->rx_buf) {
 		peripheral.cmd = SPI_DUPLEX;
+		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
+			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
 	} else if (xfer->tx_buf) {
 		peripheral.cmd = SPI_TX;
 		peripheral.rx_len = 0;
+		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
+			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
 	} else if (xfer->rx_buf) {
 		peripheral.cmd = SPI_RX;
 		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 6680dd1a43c6..0eb96e62a1f1 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -15,6 +15,11 @@ enum spi_transfer_cmd {
 	SPI_DUPLEX,
 };
 
+#define QCOM_GPI_BLOCK_EVENT_IRQ	BIT(0)
+#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
+
+#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
+
 /**
  * struct gpi_spi_config - spi config for peripheral
  *
@@ -30,6 +35,7 @@ enum spi_transfer_cmd {
  * @cs: chip select toggle
  * @set_config: set peripheral config
  * @rx_len: receive length for buffer
+ * @flags: flags for immediate dma and block event interrupt support
  */
 struct gpi_spi_config {
 	u8 set_config;
@@ -44,6 +50,7 @@ struct gpi_spi_config {
 	u32 clk_src;
 	enum spi_transfer_cmd cmd;
 	u32 rx_len;
+	u8 flags;
 };
 
 enum i2c_op {
-- 
2.17.1


