Return-Path: <dmaengine+bounces-3811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F139DB8D1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 14:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2708F281BFE
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760151ABEBA;
	Thu, 28 Nov 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D4V9vRBg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CE1AAE30;
	Thu, 28 Nov 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800863; cv=none; b=ZJsz/vXAsPmsmMIvtfhUtCylFSdnyXCirJcohHYRzL9f9SyDXkhiYDgZLbQGnjf39BaeXFnsuc3cmYG0BS59GaXr5sThWdooINZD/PQydFkacT4I2Vr4jug0HqEt31E6vHx2vAktnfqUUV7PObFsTcy/szxz69lm8s9gDw+ZACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800863; c=relaxed/simple;
	bh=iV2BjvM5a6UXebt00RXFCnpmRZW0G08nFpB5T8dwNUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB0uMa4jDM9X1XlDxsgH174gToesqTjnoWyebMoUYuGQYGw8cXH/9DyM5nRwrKV5exLogkKQUCb827xYAAdMaOtmIOcwnrDx7g57kDtNX3ZHIyA6IU7qgGJzx5lCkaQ2bG18aTDH0KT5S5d/3L+FEBU70YMXp6IOSiHi1SN9mwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D4V9vRBg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8htiW024159;
	Thu, 28 Nov 2024 13:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qaS8vDA1kerhICEaXt+WC4nF
	bY8OcaNBATn5J8PMFJw=; b=D4V9vRBgfG7Dqht6v8oLrBTubGlJtyzRHfaA5DZJ
	uxllJT7a3HlZRSLZZJfqatec0vuFeXOLFBAd9ydmdsTdCp8ZkwwH0HP+JSNDDxfX
	Unk+QTCgvBTxJQFiv5WRmqBEK0/nBc39gxxZ9bOR7/3TChK8q0cKMeojNx9EDFCy
	m92j08dl/ORrZlfyWn77f8ZNghsPyLMSqmtpmjO9Q2Jh8Ulcn7ElxJgHMt6SuIfs
	8NIkvRDXclNc/kxIVPOS7N0to9rnttnt+IDlEDGt3Ehy61MuGWD8VSjLYn4aNUMq
	fWEXhwMFBE71Q1Kbc7s2nIRKNvTpVlWso8AQ3hp7ujFYug==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xwjts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:34:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASDYGff017492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:34:16 GMT
Received: from hu-jseerapu-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 05:34:13 -0800
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
Subject: [PATCH v2 2/2] spi: spi-geni-qcom: Add immediate DMA support
Date: Thu, 28 Nov 2024 19:03:51 +0530
Message-ID: <20241128133351.24593-3-quic_jseerapu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: f5CrYLWt1IY-AhCKmb-Zbs-kCv1XmVOO
X-Proofpoint-GUID: f5CrYLWt1IY-AhCKmb-Zbs-kCv1XmVOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280106

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
   - Moved the spi changes as patch2.

 drivers/spi/spi-geni-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

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
-- 
2.17.1


