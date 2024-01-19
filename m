Return-Path: <dmaengine+bounces-764-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4D8329F1
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 14:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B1A1C22FD2
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324A53E2A;
	Fri, 19 Jan 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l1SAwvsn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2A537F8;
	Fri, 19 Jan 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669261; cv=none; b=ZS34LDnSsyKD1E/2fqzMXgAlShFJXBeHsGYbqwUJzsNPxh07mWKDrRCmcf7dBU8vLLCtKeZwxoMXI6akVA2bOmZSwuRlsPDgFQXQrQiW1ywbp439BwerBKupLGhXvoKqjODfdpY5q7m6k5FreGGTF41RfhdCHEnH8BdNIjkstYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669261; c=relaxed/simple;
	bh=jX++M430EcANMENTDtP9yb5IhDtDJ5Z2fZ7ZYqDAREE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UF0OytzyReHod+UpVkTPv/vYmQGTr2RKhFWUTy1ptcLoPSPf2hhdXmLUssa95N2wcd443QV0EbvJpZfVm/N+QyXL7n5pZYj+QVYppdagoPs4b0M07yZB3Pq/Cc6dkTQEKj9guN3vhwEkINGioTRpQezGDzDQ6KPhp9Or+tDbu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l1SAwvsn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9FRuv025502;
	Fri, 19 Jan 2024 13:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=fK+ysfreXQCoYCrRDidxH8G6FWPAOE4Xo0Df71HiZKw=; b=l1
	SAwvsnRzclC6ZNnViiJkoMcIH/kygWCF6FgiHLjIDQgxyCIoD4RTZWIZg2d5e9RF
	6xEgVYLaaVWsKqiag9a5HuTViAG0Nz6LO8EeQC535ADy92D3BA+wgDf3EU3llQOx
	tYDllR8T4J4CDh6HwnMLqF7dymlosZK/wB9ZksWCgNGAFUn+l2slW60FFWVXn5Rt
	lJ0rEy4jHVsbpYtaSry/deaKcGtmQKEWOJLkh5HLokmyJDYUBi8X9hR8Nhb79L89
	fDdQZSa5Pbeub1TIgQSf9Z6O3B8RyppFuwiCH0M/eYrkgb+wffKq91B1MDTrn0n7
	b3H0OKUr0C9fcSkAziww==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqh2k90ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:00:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40JD0Wfh023730;
	Fri, 19 Jan 2024 13:00:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3vkkkmtgs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jan 2024 13:00:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JD0fbb023804;
	Fri, 19 Jan 2024 13:00:41 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40JD0fN1023801;
	Fri, 19 Jan 2024 13:00:41 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 5BE75273A; Fri, 19 Jan 2024 18:30:40 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: [PATCH v1 4/6] dmaengine: dw-edma: Move HDMA_V0_MAX_NR_CH definition to edma.h
Date: Fri, 19 Jan 2024 18:30:20 +0530
Message-Id: <1705669223-5655-5-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2M1_j7cANaScCFkrQDV0zx96fN0Wmx4y
X-Proofpoint-ORIG-GUID: 2M1_j7cANaScCFkrQDV0zx96fN0Wmx4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxlogscore=695 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190066
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

To maintain uniformity with eDMA, let's move the HDMA max channel
definition to edma.h. While at it, let's also rename it to HDMA_MAX_NR_CH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 4 ++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h | 3 +--
 include/linux/dma/edma.h              | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1f4cb7d..819ef1f 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -54,7 +54,7 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 {
 	int id;
 
-	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
+	for (id = 0; id < HDMA_MAX_NR_CH; id++) {
 		SET_BOTH_CH_32(dw, id, int_setup,
 			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
 		SET_BOTH_CH_32(dw, id, int_clear,
@@ -70,7 +70,7 @@ static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 	 * available, we set it to maximum channels and let the platform
 	 * set the right number of channels.
 	 */
-	return HDMA_V0_MAX_NR_CH;
+	return HDMA_MAX_NR_CH;
 }
 
 static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index a974abd..cd7eab2 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -11,7 +11,6 @@
 
 #include <linux/dmaengine.h>
 
-#define HDMA_V0_MAX_NR_CH			8
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
@@ -92,7 +91,7 @@ struct dw_hdma_v0_ch {
 } __packed;
 
 struct dw_hdma_v0_regs {
-	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
+	struct dw_hdma_v0_ch ch[HDMA_MAX_NR_CH];	/* 0x0000..0x0fa8 */
 } __packed;
 
 struct dw_hdma_v0_lli {
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 550f6a4..2cdf249a 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -14,6 +14,7 @@
 
 #define EDMA_MAX_WR_CH                                  8
 #define EDMA_MAX_RD_CH                                  8
+#define HDMA_MAX_NR_CH					8
 
 struct dw_edma;
 struct dw_edma_chip;
-- 
2.7.4


