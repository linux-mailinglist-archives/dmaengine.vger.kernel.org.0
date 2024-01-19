Return-Path: <dmaengine+bounces-763-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625A8329EC
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B45282493
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BBC53E08;
	Fri, 19 Jan 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DcJVAeFc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535152F9A;
	Fri, 19 Jan 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669260; cv=none; b=GxTtvXe8AV9KsJ2P9vx8CCoQYYKp8YcxCfQuid2QFo88edy/FMysPyPAmkM6dd3N/uD4Zl2cy3INDOMgYJMAl1iabfhCe93gqEzmxeW6ktgbU07Fj8GB0td5PvRGuRA7mMjxOnYe/Jetm58fRdWRY/8xLISulWOR+B2ismAhty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669260; c=relaxed/simple;
	bh=CqYEzmURPXo21SeA3Wn74xLCC9GqEY3rnUfGrRYc2yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=peY3OvG9/WATmXi4g9fThPXdKKWFu0eNNp+i5cds3/OFv2v2WyAYL48LCYRYXCGNKsKtLaHQRFnvP/Uv5548bxTdUAQi67GMrIhvAT4yG3H9g4LMwcwaU2D4yMim4h+PUFJPizdRbwpns4hBiE56vmw7r1uqRhWly5r91zHSnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DcJVAeFc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JCFHFS011907;
	Fri, 19 Jan 2024 13:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=kvzZR+kG3EOMUkKldFt2KjVBCWiNRqBgBOnY3xjuKO4=; b=Dc
	JVAeFc8RuGnF/uWjzHg60SUj43xwVHBSnH4+eAh8dPvAMmidp/cJe08CdvLNuaKq
	rf25z2Z3bompxZsPxtJOffibB+7GtrSuiiBJPRN/5ZTbrVUMRp/gshVqyHsqdRUU
	LxaUtQt7wjmEtx3Kykdv5ZB2FnbvSDo4LFgDnwD6+x7xeMcOK6CNScf2TH3pnitV
	js9oE4Q972tEMEnGQuA8wVuUBtLRkMtenDJ1Ccrriwq66rqzTG5N+SeE3zNbQuBN
	YsSq3SrcoCKQLiIjG91Mxuyo9dF3UtuWaX5nmaHxp0eXpeQ9UvZyWYT79NMkzO3z
	ViwzE89pBTZcXmhenGLw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqreq847n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:00:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40JD0bMR023773;
	Fri, 19 Jan 2024 13:00:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3vkkkmtgsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jan 2024 13:00:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JD0fbd023804;
	Fri, 19 Jan 2024 13:00:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40JD0hlw023830;
	Fri, 19 Jan 2024 13:00:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 2D4EE273A; Fri, 19 Jan 2024 18:30:42 +0530 (+0530)
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
Subject: [PATCH v1 5/6] PCI: qcom-ep: Provide number of read/write channel for HDMA
Date: Fri, 19 Jan 2024 18:30:21 +0530
Message-Id: <1705669223-5655-6-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3DMeqHBM_sncGLSzpC3AZKYrcE71h8st
X-Proofpoint-GUID: 3DMeqHBM_sncGLSzpC3AZKYrcE71h8st
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=783 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190066
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

There is no standard way to auto detect the number of available
read/write channels in a platform. So adding this change to provide
read/write channels count and also provide "EDMA_MF_HDMA_NATIVE"
flag to support HDMA for 8775 platform.

8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for
this platform. Add struct qcom_pcie_ep_cfg as match data. Assign
hdma_supported flag into struct qcom_pcie_ep_cfg and set it true
in cfg_1_34_0.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 45008e0..8d56435 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -149,6 +149,10 @@ enum qcom_pcie_ep_link_status {
 	QCOM_PCIE_EP_LINK_DOWN,
 };
 
+struct qcom_pcie_ep_cfg {
+	bool hdma_supported;
+};
+
 /**
  * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
  * @pci: Designware PCIe controller struct
@@ -167,6 +171,7 @@ enum qcom_pcie_ep_link_status {
  * @num_clks: PCIe clocks count
  * @perst_en: Flag for PERST enable
  * @perst_sep_en: Flag for PERST separation enable
+ * @cfg: PCIe EP config struct
  * @link_status: PCIe Link status
  * @global_irq: Qualcomm PCIe specific Global IRQ
  * @perst_irq: PERST# IRQ
@@ -194,6 +199,7 @@ struct qcom_pcie_ep {
 	u32 perst_en;
 	u32 perst_sep_en;
 
+	const struct qcom_pcie_ep_cfg *cfg;
 	enum qcom_pcie_ep_link_status link_status;
 	int global_irq;
 	int perst_irq;
@@ -511,6 +517,10 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }
 
+static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
+	.hdma_supported = true,
+};
+
 /* Common DWC controller ops */
 static const struct dw_pcie_ops pci_ops = {
 	.link_up = qcom_pcie_dw_link_up,
@@ -816,6 +826,13 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.ops = &pci_ops;
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
 	pcie_ep->pci.edma.nr_irqs = 1;
+
+	pcie_ep->cfg = of_device_get_match_data(dev);
+	if (pcie_ep->cfg && pcie_ep->cfg->hdma_supported) {
+		pcie_ep->pci.edma.ll_wr_cnt = 1;
+		pcie_ep->pci.edma.ll_rd_cnt = 1;
+		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
+	}
 	platform_set_drvdata(pdev, pcie_ep);
 
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
@@ -875,7 +892,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
-	{ .compatible = "qcom,sa8775p-pcie-ep", },
+	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
-- 
2.7.4


