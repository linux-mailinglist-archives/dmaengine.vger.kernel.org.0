Return-Path: <dmaengine+bounces-762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B18329EB
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 14:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1ED1F23281
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917735380D;
	Fri, 19 Jan 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chlwqT5n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046A52F86;
	Fri, 19 Jan 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669260; cv=none; b=iB2nmH0SSZ0pwZBPcZSJiStmvwEThanOLpJy6d4x9c1cSWuOnKDMD/3x4Fozs/DrSRqgncgfAJu6l67TB0jNq3l1GRBFuCZJYFQ31dTZ6t9ByaE6smpX9glnMbvAU72+ZKqJmyyNDZ8t20ukepONkPI+6sYh3LxElYgY6wg6nSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669260; c=relaxed/simple;
	bh=EerfizSXmr8ySSTQG3Ek8cTyqeYJTbG6H8QUFJ+dUbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dwpLCOz/f7dLawmjcu/GJHbnaMaMKdniV4eNpJ52H8rkV8eN34hswRKpMyeW6RvoNm5WRA7raFXMDGsEgU/2ft2sq1pF6v+L69tK5+BxC/Il9Fp+6/6rTAwnys2MIUcUBhtWPVB2Bs9J80C3OZYWhqnhun/L8Xjb/JgGdaj0WU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chlwqT5n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JCRWRX021492;
	Fri, 19 Jan 2024 13:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=J5N0eH+XorUHi+CvGk/WwzsrjWyuz4FCQ2eZXs4R5nY=; b=ch
	lwqT5nOSWEWRJwPAFnbuTrHhaRl7l9q+E5zsdLBei1bYES4dpzq0is7VpLxwOiwc
	fVeaPlli/Ix157Tc0v/tvnr9baWTAN7N1uhzUt4HC07lc5Ru2YCRUdrAhzV62m+H
	5gxKk7AHTMfGm9WudeqFPsadude9nT1xV4pEr9lFF4nVPL2tn2eYnDcDdxdtMQyo
	dvJFe0+cWlptKAhAxhE9nzoe1zOytYvB2FuzW4GrRUrwtOha9l9Qw6l4OOZTtziy
	WM5FKtijvB1vhn5Wjr+5V2SnE3mwq1T/6Kpfm7xNHnhKmqbaO8yr0kshUXrOM3CR
	LJJKmBw5tL+TYPD30C5A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqh2k90tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:00:43 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40JD0eMr023790;
	Fri, 19 Jan 2024 13:00:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3vkkkmtgrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jan 2024 13:00:40 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JD0dLE023785;
	Fri, 19 Jan 2024 13:00:39 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40JD0dlN023784;
	Fri, 19 Jan 2024 13:00:39 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 3BC35273A; Fri, 19 Jan 2024 18:30:38 +0530 (+0530)
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
Subject: [PATCH v1 3/6] PCI: dwc: Add HDMA support
Date: Fri, 19 Jan 2024 18:30:19 +0530
Message-Id: <1705669223-5655-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z69Q7pBn-mgOoTOjfxot1-qCLdMS5U1p
X-Proofpoint-ORIG-GUID: z69Q7pBn-mgOoTOjfxot1-qCLdMS5U1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxlogscore=803 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190066
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
unrolled mapping format. So the platform drivers need to provide a valid
base address of the CSRs. Also, there is no standard way to auto detect
the number of available read/write channels in a platform. So the platform
drivers has to provide that information as well.

For adding HDMA support, the mapping format set by the platform drivers is
used to detect whether eDMA or HDMA is being used, since we cannot auto
detect it in a sane way.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 55 ++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 96575b8..07a1f2d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -880,7 +880,29 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
 	.irq_vector = dw_pcie_edma_irq_vector,
 };
 
-static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
+static int dw_pcie_find_hdma(struct dw_pcie *pci)
+{
+	/*
+	 * Since HDMA supports only unrolled mapping, platform drivers need to
+	 * provide a valid base address.
+	 */
+	if (!pci->edma.reg_base)
+		return -ENODEV;
+
+	/*
+	 * Since there is no standard way to detect the number of read/write
+	 * HDMA channels, platform drivers are expected to provide the channel
+	 * count. Let's also do a sanity check of them to make sure that the
+	 * counts are within the limit specified by the spec.
+	 */
+	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > dw_edma_get_max_wr_ch(pci->edma.mf) ||
+	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > dw_edma_get_max_rd_ch(pci->edma.mf))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dw_pcie_find_edma(struct dw_pcie *pci)
 {
 	u32 val;
 
@@ -912,13 +934,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 		return -ENODEV;
 	}
 
-	pci->edma.dev = pci->dev;
-
-	if (!pci->edma.ops)
-		pci->edma.ops = &dw_pcie_edma_ops;
-
-	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
-
 	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
 	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
 
@@ -930,6 +945,30 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	return 0;
 }
 
+static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
+{
+	int ret;
+
+	if (pci->edma.mf == EDMA_MF_HDMA_NATIVE) {
+		ret = dw_pcie_find_hdma(pci);
+		if (ret)
+			return ret;
+	} else {
+		ret = dw_pcie_find_edma(pci);
+		if (ret)
+			return ret;
+	}
+
+	pci->edma.dev = pci->dev;
+
+	if (!pci->edma.ops)
+		pci->edma.ops = &dw_pcie_edma_ops;
+
+	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+
+	return 0;
+}
+
 static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);
-- 
2.7.4


