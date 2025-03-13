Return-Path: <dmaengine+bounces-4727-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAAA5F5A8
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E719C139C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8BB2676F9;
	Thu, 13 Mar 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hCMZwiXi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D824E010;
	Thu, 13 Mar 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871419; cv=none; b=tFWXh8nHImmwi3Nuldx0JvBvk+B+VMWHOKAvmPftRjn4DaIIYmLGZc2bfOdRVq2tQhD8NnXV3PaFQiGvtmyQtBgJssGVv3P4BfzaDz3npX6KoUDRNcPijQ8Z3kQlFi9MH8V4wjZ5vgTii5r3Nwjt/hbeKO0GVSQOcOLEupEoQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871419; c=relaxed/simple;
	bh=8NU4juysYoyJsQFa23j+XL72HurJpW8Ab/z9JtI2o5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZk1KOvuiYM1mnLAuGdinBbnkzZbQzIRlYtiOiodkpD1EQyovLk+XjvHHaA41Gqmm5v5HPT3f7vb9I6Nj3H3dICcArNVZZCZx/YUBQEmBdZncR8jyvPqVz7zrCH93OtVDAO2RJ6nX63vB/J0qQPlqI+yH2+XidiD10UF9Bw03MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hCMZwiXi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9A5Y0018566;
	Thu, 13 Mar 2025 13:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=dHR26g87SbgpvNBDmfouMw6szuPW3LIbyRevxJX9tiQ=; b=hC
	MZwiXit0hzNmqIyYCGpwHKQJ4/oU0lZUAtp+mIQagRDVatDkhGU2iMCO3wOTUQBg
	UYjNDXRBTCxUuycpNo4dx7DF83PZW/AV0vhKbqUsgx/gGDAWAapt4T9dUIyCVdyc
	RBAgjp05nFBOkRtv3pAClsoXt+B8WsTuOPe6o/qSZ5m0dB3LcU11ZhX+fd2vyv9F
	VxDLtZVVp0wImtRuwpj7/tEn1PSSaTh6WyruiZUmzgGUBWWeRYXpzryoUZ76CVyl
	1pe+QB6vqw/MGGHt5YSmaK08124U7Q6Jr8WIdKgVvsAgvGO/ZafEUqoCF1UwRl/X
	WkMftIo4jk/7mtodO3/Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nx03a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:09:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DD9wF3013047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:09:58 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 06:09:53 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH 0/6] Enable QPIC BAM and QPIC NAND support for SDX75
Date: Thu, 13 Mar 2025 18:39:12 +0530
Message-ID: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dBTtC-SNAllfZqoCWnsaaI4RjB4BGiEL
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d2d928 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=IoVFHHhwEPMUAHoi-2YA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dBTtC-SNAllfZqoCWnsaaI4RjB4BGiEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=657 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130103

Hello,

This series adds and enables devicetree nodes for QPIC BAM
and QPIC NAND for Qualcomm SDX75 platform.

This patch series depends on the below patches:
https://lore.kernel.org/linux-spi/20250310120906.1577292-5-quic_mdalam@quicinc.com/T/

Kaushal Kumar (6):
  dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND
  dt-bindings: dma: qcom,bam: Document dma-coherent property
  ARM: dts: qcom: sdx75: Add QPIC BAM support
  ARM: dts: qcom: sdx75: Add QPIC NAND support
  ARM: dts: qcom: sdx75-idp: Enable QPIC BAM support
  ARM: dts: qcom: sdx75-idp: Enable QPIC NAND support

 .../devicetree/bindings/dma/qcom,bam-dma.yaml |  2 +
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 23 ++++++++---
 arch/arm64/boot/dts/qcom/sdx75-idp.dts        | 18 +++++++++
 arch/arm64/boot/dts/qcom/sdx75.dtsi           | 38 +++++++++++++++++++
 4 files changed, 75 insertions(+), 6 deletions(-)

--
2.17.1


