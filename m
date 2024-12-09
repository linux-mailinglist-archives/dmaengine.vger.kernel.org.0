Return-Path: <dmaengine+bounces-3929-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFAE9E8C3B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A51161F2F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68401214A66;
	Mon,  9 Dec 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VfVLn8/z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31621481D;
	Mon,  9 Dec 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729774; cv=none; b=MWYaHkHF6vFZX54CUMPC8hq4cKeRd/OwfDvSzEZoA2c7B2q+EbwPcOO3JBqpNoE5qjpodU+75Usoqg5pX8qYfxZBsctQcbfmQSazmDXaTeQmrWRTYrCQHhujaUuZxN89t4oTCYWR9Ao1Ovr8LIYZpJPegfERgE1N6zQkvbNDEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729774; c=relaxed/simple;
	bh=bgfSgowanNcQdKmeZtnINFv8JA5gGj3/lDW4sVWMas4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oT5+zZdcRVu4eoA9p1gXmAJib2NZOyKs3UttAJeXNywPhL/jgSL4dM2vuU/pKeurjYxsfjnB/iPzCA+Djbk370RLDG+/DM5XNaEbmZ1zY91Nnx5hMP0/s73oGRQiWIgZPpYFnfxZLLiWOXOArxV2N3D2T5Z1Qh3Hz+OrGmcEhz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VfVLn8/z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MK34G020690;
	Mon, 9 Dec 2024 07:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=PkApUxXq8oM9V8hqQ3Rxdpz+MJ9Oq76S+7E5HyyHPvo=; b=Vf
	VLn8/z306YK5g2ehBAI8qc4UiX7AUcSheeAPZZbwAoNJPBt7Hy4OiJSF6BqF/Jfr
	OrG7FljyDDQflXnXsIktuyn2mQYxzsZBY2Fyjp66YHu2YyGLsxkQ798lPLp23/CG
	N3Ex5y+6FA6TjKnDrWkL0Hhz1GxxrG4oKo+AnVict1kLls3Sa9pALeq3F7w637U2
	W/mw7tJ6Y0PCVoHhBndAuaykbT+aMQ5u36yrADGYI7dv5cGdHJhaetla93vzGwhH
	147gO0sQfRchyVbB4sIjBMuT8+D9UauxvMOzjJY6ixQ1iP4V88/P3W+xZvyMp4Vb
	iqmUp/lV/QZ2ZPtR3jKw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cf4e3ntv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 07:36:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B97a96Y009574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 07:36:09 GMT
Received: from hu-jseerapu-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 8 Dec 2024 23:36:06 -0800
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>
Subject: [PATCH v5] dmaengine: qcom: gpi: Add GPI immediate DMA support for SPI protocol
Date: Mon, 9 Dec 2024 13:05:53 +0530
Message-ID: <20241209073553.818-1-quic_jseerapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6k0_YiS5j3rLzlviEl59zbtGANSStpW6
X-Proofpoint-ORIG-GUID: 6k0_YiS5j3rLzlviEl59zbtGANSStpW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090058

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
 drivers/dma/qcom/gpi.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 52a7c8f2498f..b1f0001cc99c 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -18,6 +18,7 @@
 #include "../virt-dma.h"
 
 #define TRE_TYPE_DMA		0x10
+#define TRE_TYPE_IMMEDIATE_DMA	0x11
 #define TRE_TYPE_GO		0x20
 #define TRE_TYPE_CONFIG0	0x22
 
@@ -64,6 +65,7 @@
 
 /* DMA TRE */
 #define TRE_DMA_LEN		GENMASK(23, 0)
+#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
 
 /* Register offsets from gpi-top */
 #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
@@ -1711,6 +1713,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 	dma_addr_t address;
 	struct gpi_tre *tre;
 	unsigned int i;
+	int len;
 
 	/* first create config tre if applicable */
 	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
@@ -1763,14 +1766,30 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 	tre_idx++;
 
 	address = sg_dma_address(sgl);
-	tre->dword[0] = lower_32_bits(address);
-	tre->dword[1] = upper_32_bits(address);
+	len = sg_dma_len(sgl);
 
-	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
+	/* Support Immediate dma for write transfers for data length up to 8 bytes */
+	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0])) {
+		/*
+		 * For Immediate dma, data length may not always be length of 8 bytes,
+		 * it can be length less than 8, hence initialize both dword's with 0
+		 */
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		memcpy(&tre->dword[0], sg_virt(sgl), len);
 
-	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
-	if (direction == DMA_MEM_TO_DEV)
-		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
+		tre->dword[3] = u32_encode_bits(TRE_TYPE_IMMEDIATE_DMA, TRE_FLAGS_TYPE);
+	} else {
+		tre->dword[0] = lower_32_bits(address);
+		tre->dword[1] = upper_32_bits(address);
+
+		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
+		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
+	}
+
+	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV,
+					 TRE_FLAGS_IEOT);
 
 	for (i = 0; i < tre_idx; i++)
 		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
-- 
2.17.1


