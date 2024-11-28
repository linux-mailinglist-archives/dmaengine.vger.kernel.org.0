Return-Path: <dmaengine+bounces-3810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B59DB8CE
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 14:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1D7B22711
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CB1AA1E7;
	Thu, 28 Nov 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ChB1+KTW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF881AA1CC;
	Thu, 28 Nov 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800859; cv=none; b=k46vz+eRwqK+SXDqeP4DaR7pViKT6J2xQzyy319RBXFfXDtKtGjMA7jPSbVzmkdvDIDHNRdD3NQfLpTIYSVWaf43JBdWJFETci6P0wHhqguv3bUvfdEvXNvzV/SRrv85DiVMOglnbECgi4nO8UsYFtbQpsf78JhwX4J+fP9xU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800859; c=relaxed/simple;
	bh=LaNzY0F+kfjIqn2VwZ9oGtLQGPAVjhJWESNzhuQ0JIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRe1kVLNQuWVb5wlRN89GTV3egQXHqOPj1SHteDbj8BY9hMoubflFUqvXMP408oAv5gbz+Lx+m11J87SBoXSDwpo1rTrAyTWvhc7m8Zs5HBd8W/8JslnTsImUrkeEiI0C8lXP9j7sEy+Ooz01d/OOAvuOGEJAMn3TVs2hr2nSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ChB1+KTW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS7V3kO029064;
	Thu, 28 Nov 2024 13:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T/86HuJh8hsMj+fz3SMDfPfL
	FziymtJMnPQs5sJr0IE=; b=ChB1+KTWy6xpNqYy2e/A2nWSvebcrMsoCJZF91ny
	2JkEaWbtQhTnl/49ZDIzLOrH136BQHLcbY3O2purzO/t7H76b+76DmGfyQnmk893
	Yb4X1bhPCpKkhV/orTTldO+VGV3ft7GoosYcgS+gijtxkrxFmgsgnsxVOViBXCbA
	Twj4SgrD3c+B0nWmurZ3Ip30khWoRvTq9TLgrHkoZpGlS+k5aLCVAstppqth5COh
	Hok/lNqpSshXzQOHBVbVH3huR++vI7HXsvXnccdeRritU121IzSjNmppL3hk9JnS
	0R2A40JWlOa0hzDofNxd53ZrxdQkQtErM0ZFkyqCgFk2lA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xxjvbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:34:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASDYDw8018333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:34:13 GMT
Received: from hu-jseerapu-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 05:34:10 -0800
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
Subject: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA support
Date: Thu, 28 Nov 2024 19:03:50 +0530
Message-ID: <20241128133351.24593-2-quic_jseerapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
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
X-Proofpoint-GUID: HVh9iXfwZBF3pCDsYifxBL-CZQ0Tqc_l
X-Proofpoint-ORIG-GUID: HVh9iXfwZBF3pCDsYifxBL-CZQ0Tqc_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280105

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
v1 -> v2:
   - Separated the patches to dmaengine and spi subsystems
   - Removed the changes which are not required for this feature from
     qcom-gpi-dma.h file.
   - Removed the type conversions used in gpi_create_spi_tre.

 drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
 include/linux/dma/qcom-gpi-dma.h |  6 ++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 52a7c8f2498f..4c5df696ddd8 100644
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
+		buf = sg_virt(sgl);
 
-	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
-	if (direction == DMA_MEM_TO_DEV)
+		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		memcpy(&tre->dword[0], buf, len);
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
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 6680dd1a43c6..84598848d53a 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -15,6 +15,10 @@ enum spi_transfer_cmd {
 	SPI_DUPLEX,
 };
 
+#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
+
+#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
+
 /**
  * struct gpi_spi_config - spi config for peripheral
  *
@@ -30,6 +34,7 @@ enum spi_transfer_cmd {
  * @cs: chip select toggle
  * @set_config: set peripheral config
  * @rx_len: receive length for buffer
+ * @flags: true for immediate dma support
  */
 struct gpi_spi_config {
 	u8 set_config;
@@ -44,6 +49,7 @@ struct gpi_spi_config {
 	u32 clk_src;
 	enum spi_transfer_cmd cmd;
 	u32 rx_len;
+	u8 flags;
 };
 
 enum i2c_op {
-- 
2.17.1


