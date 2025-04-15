Return-Path: <dmaengine+bounces-4890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B220A8950F
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 09:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15673BA1F3
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0427A913;
	Tue, 15 Apr 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mYPijmio"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE627A904;
	Tue, 15 Apr 2025 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702136; cv=none; b=VS7WBjfxNr1EuzIRXtRtWN3RBy4bA//HTWp4dJt69hLxiZgdoIN3QCBkmMZ+aRIHjNwV00xNH8L0Pq7F6jsKFeNoeGYUb+O0FRd0+st7i9mepZi5Tghgewp3UHjFpLpCzhg07pmU8ZfCstZsvsQJpEO4zhBMNJITxoLqWnZtJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702136; c=relaxed/simple;
	bh=QcnhZN/vLYzQJW9lcBG1DsRa/Z8Nrwbw0xLY2hX4YNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYomlTEhIkxSZEfVli4vA8blhEqzeIUT34jOHoRGIgUYfsIpXUDJ5aWRzQyM2H1yewHv9HmTvbJ38qnc0wRtPD4n3TJRQHIi1kDGZ2cKCokE4Ya6MdmjudT2MWhAaDG/MWyBOfqoc6jSVO4gC3AnHoATyvLlNqT/O84uUIQGMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mYPijmio; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15ePk018685;
	Tue, 15 Apr 2025 07:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=te0sy/dFG3n8hgy9m/Xap0ITW+qXd3H9xo5+/x7mjGU=; b=mY
	PijmioGnocsmhlofFGpxERnmgtSE6XYO4jUUOyS5SVG8RtwELNmer24hkS4toEQj
	i1KzTxvZcxlpnZr4JTjNcH8cQEjrriXxU8Xmbk99u3NxQqm1uyokO1RAs+xAVk2d
	Vt84SzYtM7IQC+ty0Fd3SbDKWFJVnBNtJJZ2PWg6IPQ1LUwjFh5c+2u7AEQAaCEw
	DOkLVsFG/NRy7MP/798X7Bm5aKdFaVbmH4kZBhvezT0g5wREHmvOqRkzuO926I5j
	ET+rp6XkyloHTFWrA1j1FX6S+FTWEIKZQoXvpf429D8MErxqF6O3ib5bWKPuWY/J
	CZOxIPEAOjtqkp7/PzEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wf1pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 07:28:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F7SWHU032593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 07:28:32 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Apr 2025 00:28:27 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH v2 0/5] Enable QPIC BAM and QPIC NAND support for SDX75
Date: Tue, 15 Apr 2025 12:57:51 +0530
Message-ID: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fe0aa1 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=c2BNjoVmnf2s0oQOp70A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _xHYmi8j79GWNkAxsH-MoeC064icYFwT
X-Proofpoint-GUID: _xHYmi8j79GWNkAxsH-MoeC064icYFwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=743 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150050

Hello,

This series adds and enables devicetree nodes for QPIC BAM and QPIC NAND
for Qualcomm SDX75 platform.

This patch series depends on the below patches:
https://lore.kernel.org/linux-spi/20250310120906.1577292-5-quic_mdalam@quicinc.com/T/

---
Changes since v1:
 - Use sleep clock instead of adding a dummy clock for QPIC NAND since
   sleep clock has the required properties.
 - QPIC BAM controllers have dma-coherent support hence document it as a
   global property.
 - dma-coherent property is not applicable for QPIC NAND controller so
   remove it.
 - iommus items is fixed for SDX75 NAND controller so document it likewise.
 - Merge QPIC NAND and BAM devicetree enablement into a single patch.
 - Fix minor coding style issues.
 - Link to v1: https://lore.kernel.org/all/5a1b52a3-962b-04f9-cdfc-4e38983610b5@quicinc.com/

Kaushal Kumar (5):
  dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND controller
  dt-bindings: dma: qcom,bam: Document dma-coherent property
  arm64: dts: qcom: sdx75: Add QPIC BAM support
  arm64: dts: qcom: sdx75: Add QPIC NAND support
  arm64: dts: qcom: sdx75-idp: Enable QPIC BAM & QPIC NAND support

 .../devicetree/bindings/dma/qcom,bam-dma.yaml |  2 ++
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 30 +++++++++++++----
 arch/arm64/boot/dts/qcom/sdx75-idp.dts        | 18 ++++++++++
 arch/arm64/boot/dts/qcom/sdx75.dtsi           | 33 +++++++++++++++++++
 4 files changed, 77 insertions(+), 6 deletions(-)

--
2.17.1


