Return-Path: <dmaengine+bounces-6624-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746EB83D9F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ECA464F6E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA82F6195;
	Thu, 18 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fYNixNI0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8AB2C026D;
	Thu, 18 Sep 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188477; cv=none; b=ichvMoujOS03XevL8O2qrye28fIaqXzljnCmre8dh+BI2dinRAnba/LaGJl6Kx0YQTbu0RBagylcqsyV5s1C1gbzdRK2OwsrGAHsmbIzmK1tghsiwJrH+FKHA7QImU4Oq2pPdYPD9F2WlqNkOQ1STsbGtR5mcPq4NB0O8qYN3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188477; c=relaxed/simple;
	bh=+8tFR81mbSvaag43UHGQEx7A1HAaQFJbb5Yluw0PBTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5yPAOVrNYiExXt89Dvc9y3V4LchjgMwSsYUXlrOhKVlDaGUFTpmfns9c2j4KyIQCyYRhnHi6D6bx6S0xzdSdqkWYSP43f8btAMo3dNJeJjYOT/htp8r70/qOWIx4CdXijJpXpMrokmQcMVFKwlpBd6+wPoDghwNCW2tjusuouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fYNixNI0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I2pMrc019548;
	Thu, 18 Sep 2025 09:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aglD8QUnx5HyLvrgHnwtuqWoc+P3zYgU3azv7R5Z3lc=; b=fYNixNI0Njii9T7Y
	njcovg1XfQ3Q/d5FKWbDUade8885Ai5Z7fh6VRqJG01NIdZPjvy+tf6+3iZD6Q85
	Lod2WMqxwgrOwjeUiM+ePj1mEVZBVKgQbClinx4n5PdvkpcxFsF7X3jeMn1t19f3
	5yzCOpKzVyI5/jy5JG8PpQAmotkVe7s1c+F1C9uk0FaIwlZJNMVdC9H7ukqvyXyL
	55BTon+3+aL/qclS9NjoaEceeEqsbD9vRg5GZQs91SqEaiM2itjajlrHNnLlf/V+
	Ir3Nhfsz2mEGbjYLSatTk9IuVheUMiP0uX1NKGpMyT90hl6uKwCcwUVqvLnVBtY4
	xIMGvw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1wvcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gk029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:55 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
Date: Thu, 18 Sep 2025 15:10:13 +0530
Message-ID: <20250918094017.3844338-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 9CXIAzfly-nrFusjw3Htaeakxd23YBjo
X-Proofpoint-ORIG-GUID: 9CXIAzfly-nrFusjw3Htaeakxd23YBjo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+7O7Da8gXdSt
 LTZ+JtGkjW6fKb5Xqd1tVELxJ7ddz3x+lA/FcfeUtMrAsbmfC8TbvqFaEgwntkHiTaxd2spqlJD
 jLYSt2AncLXqjtQWvES970I+LOl3Rj/mfo4rfrpw1oK8tPe0y/1cP9of5+KNs70NTpaJ9L9gXDF
 T3FXQ4qldC3YWHsL0Z0/ANZcyPOAaS1bAU6TUmGYEAYSl5CUqh9h7UAJ1HB1/hy4PaHaghNU0Qj
 H1lA119HILcEmKBUW8pEMxWam24yqUmIG+YVLVAOYsaMawu9EdmDJubgGtjqjQGP1A0ErBzRVPH
 50NPg76htwHfnrD8lC8ZDrV55rlb0lC/hixDRvpheyEOfnO5Wyda+WE1WZel4GIT7wIHees8CKx
 Lp7q4rTx
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cbd3b6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=Xm9ZT0FCSYBaAg3CLZYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Add device tree nodes for QPIC SPI NAND flash controller support
on IPQ5332 SoC.

The IPQ5332 SoC includes a QPIC controller that supports SPI NAND flash
devices with hardware ECC capabilities and DMA support through BAM
(Bus Access Manager).

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 45fc512a3bab..af3fd55a85cf 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -423,6 +423,33 @@ blsp1_spi2: spi@78b7000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x07984000 0x1c000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq5332-snand", "qcom,ipq9574-snand";
+			reg = <0x079b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>,
+				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core", "aon", "iom";
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			status = "disabled";
+		};
+
 		usb: usb@8af8800 {
 			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;
-- 
2.34.1


