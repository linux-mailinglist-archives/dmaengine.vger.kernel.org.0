Return-Path: <dmaengine+bounces-759-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A128329DD
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B121C2200F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09966524A7;
	Fri, 19 Jan 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="niwQZv6+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88E51C51;
	Fri, 19 Jan 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669256; cv=none; b=QxEj+2kpmzGCpw4qTxCAmt/M7ag69bmTTKzZo4WYgrk5YzB8lzt5Wgz+60syBUIEWQYCiuWlfA3FYvCQX1JI0hVtzRjjVVG7hbhWFJjk4AUn4okHGcQhmL6SRPZ/ViRtIlQCwDc+doRPafjE4IkxX1M73XaWtTJ305jXdrWbgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669256; c=relaxed/simple;
	bh=7if1y3LEA2TciUlZzH4PB3mo5tvNU1LOoYchLLLIcgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uflT9qMELjw6JCRi4pNHXJgNxf17q9IX/j+KkMqhu0M/1qeBsLQ3XExdd2NDGT3+ZPShTvS9R64chXpzvzBpHPnFk8UdMbOXs88Vti/qg77EOVc2jPTGxrdl4IcSENKtrN98cGRSTBtMrA4ZyhgZF+sar4WiyaLFHD0mDiAJs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=niwQZv6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9BOqZ012323;
	Fri, 19 Jan 2024 13:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=UCljDwG5bVjcE8GSPbx7lIYjj7v3bE8mKi8kdhrvC7Q=; b=ni
	wQZv6+lX/WgnLZt//LkJ00+t6whjGzWUji+EmjCDOtZBidS+p17WGB4mSTH6UMC2
	Asx9BjNPKbRqGWluIA2nrgGVbX4vP/wzz9N4OA8gLqRzPFxx+2fPM7ysx0+UkELI
	gYlpRdEGsGnacxx5JDa/7IZuSKM4q0Ic8FmYLduBuYKv4M/l/tJ2VNt5HqxY88vC
	UJy5+qv83UWjqlF8z6TwHKyp59mu13p3ciKUmfYS7FbBvCBdDve0UruZdOebdHf/
	xwBwJRmf8J2yQu5C+V7P8FCNoHsuvBubI03hKHAdBOlyIXOrF/P5YlVY4Bc7Yh2x
	9Zhf8etv1ep1sTnLeZCQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqndb0grb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:00:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40JD0bMQ023773;
	Fri, 19 Jan 2024 13:00:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3vkkkmtgrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jan 2024 13:00:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JD0bIf023767;
	Fri, 19 Jan 2024 13:00:37 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40JD0aYK023765;
	Fri, 19 Jan 2024 13:00:37 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 1748B273A; Fri, 19 Jan 2024 18:30:36 +0530 (+0530)
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
Subject: [PATCH v1 2/6] dmaengine: dw-edma: Introduce helpers for getting the eDMA/HDMA max channel count
Date: Fri, 19 Jan 2024 18:30:18 +0530
Message-Id: <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GmMST81T2hRl2-fzUAeJ0DfgPBStIF6_
X-Proofpoint-GUID: GmMST81T2hRl2-fzUAeJ0DfgPBStIF6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=843 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190066
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add common helpers for getting the eDMA/HDMA max channel count.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/dma/dw-edma/dw-edma-core.c           | 18 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c |  6 +++---
 include/linux/dma/edma.h                     | 14 ++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 7fe1c19..2bd6e43 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -902,6 +902,24 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	return err;
 }
 
+static u32 dw_edma_get_max_ch(enum dw_edma_map_format mf, enum dw_edma_dir dir)
+{
+	if (mf == EDMA_MF_HDMA_NATIVE)
+		return HDMA_MAX_NR_CH;
+
+	return dir == EDMA_DIR_WRITE ? EDMA_MAX_WR_CH : EDMA_MAX_RD_CH;
+}
+
+u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf)
+{
+	return dw_edma_get_max_ch(mf, EDMA_DIR_READ);
+}
+
+u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf)
+{
+	return dw_edma_get_max_ch(mf, EDMA_DIR_WRITE);
+}
+
 int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index eca047a..96575b8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -864,7 +864,7 @@ static int dw_pcie_edma_irq_vector(struct dw_edma_chip *edma, unsigned int nr)
 	char name[6];
 	int ret;
 
-	if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
+	if (nr >= dw_edma_get_max_rd_ch(edma->mf) + dw_edma_get_max_wr_ch(edma->mf))
 		return -EINVAL;
 
 	ret = platform_get_irq_byname_optional(pdev, "dma");
@@ -923,8 +923,8 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
 
 	/* Sanity check the channels count if the mapping was incorrect */
-	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
-	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
+	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > dw_edma_get_max_wr_ch(pci->edma.mf) ||
+	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > dw_edma_get_max_rd_ch(pci->edma.mf))
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 7197a58..550f6a4 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -106,6 +106,9 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+
+u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf);
+u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -116,6 +119,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf)
+{
+	return 0;
+}
+
+static inline u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf)
+{
+	return 0;
+}
+
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.7.4


