Return-Path: <dmaengine+bounces-6626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21232B83DC5
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA564612B2
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1D2FBE1E;
	Thu, 18 Sep 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fYa4uqtA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3F2ECD3A;
	Thu, 18 Sep 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188479; cv=none; b=eV3Djbvgi1fIO11Q6aQZhm7M5tO5doI/aQJwpr64ryyk4EKK08wmv8pO6gjNQVBNODwnenRmy+iSXo0AQcCGSz9jZbHCPsUaGzsKyY7wqTd/KFXCV7hyY3/NlO1SbMF7CHjXn5cAKeW7TBpSiYX/IjWY3K1SC4xLCs7w+3niXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188479; c=relaxed/simple;
	bh=OBIFE6ojfFL6e95wyXNWDBVEqczlw6HdgIdYE6+2Z2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ltbm9zRbLNhbQih+9CfP18zuiQipLjCPpeCxfyRqNPd3QdeZcQYaPDfS+eFPlly8iaxEvMM77CWXRrHmh87wQFtNtoICLSktdsi77d4rpDYv96YHq3JOlb4HOHG0eMR5q+kKvpY6JG7M9fK3+ft/jAeefrC7HWSWjnCwK40u2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fYa4uqtA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5UMnT017934;
	Thu, 18 Sep 2025 09:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DYSNLahZ8Utm8VhO8GcPwO
	EnHrxrF0HbxqaqoHsQPro=; b=fYa4uqtAfjDY774pNmf62Y0KgTRN/aIll2ww6Q
	Gv0oU+CALIlfYnZ7/3POHQrlG05mo8S60WeUIWVqxY0u2k/QRGUTx6RiYtqAZo/9
	zMNdoigBpIeIEy7l/jZeGiIH57KtWLEFKkuUsbHJXkV50hDSfwjUvz6MD5Gr7FPT
	EQjqj2smn+3qBe6fhBI8pHZIZXJg1zk8q3370STqPmYfX2cmoqOmQHmjsdWCz1i4
	pVto0HPKlO0QVGhduTfU30ewFAsdaO8DD8pzmVqJgzLt1Avx1tmu9ocqUSS4LzwX
	biEORXDF0R2IzrqR7tuGEeASecnqjgs0Sh3StZHwnZz/Dn7w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deaacn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gf029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:08 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:34 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 0/9] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms
Date: Thu, 18 Sep 2025 15:10:08 +0530
Message-ID: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cbd3b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=-e1QLBuyfe56JWC_VFcA:9
X-Proofpoint-GUID: I0AuhJlVh9FjpYpp8F149nTLOTB1QLKg
X-Proofpoint-ORIG-GUID: I0AuhJlVh9FjpYpp8F149nTLOTB1QLKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX2ubU4rsD1etj
 mS8iAoE3wx4u/TIyTU+sWaLNZx6f/Ca7i0cYM0d8xjXCNLnLTqprF4bWPhW2d+8GnLX6n+LiOwY
 5cO1/0zjRZpwC3MtMjzt0sz4DNM20FksBxwwdimv0g5ocDStgUmNk0bcfK54mL6HoHdo7xys5fF
 x95Snv02jObT+sB1sYRWUb6BPMI2DHQ+OralrEg7jruIgIolM/f+i3S7NClDlpV2VMwTjrJfULJ
 wr1fsNUX3BvUqHVbD+Q1Eho7Q85mgKGFArOo8QAXiVuPVfZMB04jUN1Ppe5k+6du5Pe3lgpWwNc
 K6C59kaOt4QFudE3eyhS6vbINsQnxF9/BhIKirIMWJ4n4w5d0ph06NVD1WhsPWw6AxrpVUzN5z3
 Sao4YrHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

This patch series adds comprehensive QPIC SPI NAND flash controller support
for Qualcomm IPQ5424 and IPQ5332 SoCs.

The Qualcomm IPQ5424 and IPQ5332 are ARM64-based networking SoCs that include
QPIC (Qualcomm Parallel Interface Controller) with SPI NAND flash support.
These platforms are commonly used in wireless routers, access points.

This series enables SPI NAND functionality by:
1. Adding device tree binding support for both platforms
2. Fixing a critical BAM DMA mask field issue affecting IPQ5424
3. Enabling SoC-level device tree support
4. Configuring reference board implementations
5. Resolving GPIO conflicts with eMMC interfaces

I have tested these patches on IPQ9574, IPQ5424 and IPQ5332 SoCs.


Md Sadre Alam (9):
  spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
  spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
  dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
  arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
  arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
  arm64: dts: qcom: ipq5424: Enable QPIC SPI NAND support
  arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND support
  arm64: dts: qcom: ipq5424: Remove eMMC support
  arm64: dts: qcom: ipq5332: Remove eMMC support

 .../bindings/spi/qcom,spi-qpic-snand.yaml     |  2 +
 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 44 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts   | 34 --------------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 27 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   | 43 +++++++++++-------
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 27 ++++++++++++
 include/linux/dma/qcom_bam_dma.h              | 21 ++++++---
 7 files changed, 144 insertions(+), 54 deletions(-)

-- 
2.34.1


