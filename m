Return-Path: <dmaengine+bounces-6780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C9BC4191
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E687B4F8B25
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A42F60CD;
	Wed,  8 Oct 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mSt8SMXQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409A2F5A3F;
	Wed,  8 Oct 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914296; cv=none; b=nXzfBs/ufQSIWFghR/WFmih6Eq9mntawMpFudxejAfav8bsZyUhVUoVX4Tx+4rg95yozj8rs3+EEL23ZpILOAVbbpXGOxebWAKVru0glq9uoNDlWTYLisdtxjlhD533huHuSC/Jh56T5EonUEeJQiL/zI49gojGzusQY2MFYd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914296; c=relaxed/simple;
	bh=BzfYaq+lv98ed5RZReuApeJ+qs0wMUrYH8HvPx0pv+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIA5xYfvEGuh1spz6vP0xHjKTcJdkrTIpcdviVAWC3JLMjC4MPhJn8302cMmn4502Bgp5oCMY32AitRK/WYPv8hKGh0QN0C+2gBT2brCpvSQkfnv231RZQ8T9UWAzv7QDISGRXjwtV/xX/pMf1RUktKA9LvEc8ezDy03ZcIWKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mSt8SMXQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890SGT026700;
	Wed, 8 Oct 2025 09:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJHSOo/vb6vzT6a0ie7jTy+d5c7d254DApCBlCTgFBY=; b=mSt8SMXQHz1oI7qA
	APOVpR2YGoW9QIoJownYQ0MuOI3zDNyS0e8eIjwQtP3OPd7Q8XFMI6D1Eym0FL0P
	O3eer83CWd/LVIWfXOEMCeeAWarGOFGP6Fn7uNSKRBJ8evfNqkApM+99yo9vesGE
	50xwh1YsYLhoW7203ivODJvcRQoSO85Opm+LjK3tl6za3WXbsbhzciDWu/lg6e4L
	yTqOgTjrs0iWzWjs8I0BDDRCzNsTd4VJ6Xpfeui8H3shwY8oMDsucHIJnRjBuKcE
	EDG5Fa9zBsr+klu6dQMQJt+fmnifInTEbJXGYpYb1ckLLoOIF8+LpWXmO2s+xCJQ
	Gj/x9g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hhmmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:04:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59894qA8002634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:04:52 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:04:47 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
Date: Wed, 8 Oct 2025 14:34:08 +0530
Message-ID: <20251008090413.458791-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008090413.458791-1-quic_mdalam@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfXxt/4KzXE1zSu
 XMtQDDkwGoLUzUkwKUNv9STkbM2Ow187jWAQGVojzohJEFaM20yAAKO0AuYfea7y2kKL4BFG98j
 C9BDEKBbZxpwKzJeWRKIRF2SNWWevPC4aCQtWgjpnZXbZVK2srWcgdAcCCRggmy+Q7phq8gewO4
 e6OOmrBWsjKU30J5WX83A8kbP5VYpsCfkFyPFXHpoPnJTT3uSDvHlk7OCJUz5eumCBjbtnYDc+8
 9lMcSooqRKPcoacAvDR1Owhvav7pWv0iAOUqTvm2FPCZ350P3XUV3erQxlpxf199z9Ex6VVU7A/
 6S7bcObJmHc9MrpHpmH5VuVyrNZW90YHJwebzaL4J7OhTkrM5H7SvlN9dMIe1G5SN486puJtFjt
 +aahQErn6OthvQHwDNKG7vkQecux+w==
X-Proofpoint-ORIG-GUID: 7iREjOnsUVDSjbLiJD3b19rukpSy4yc7
X-Proofpoint-GUID: 7iREjOnsUVDSjbLiJD3b19rukpSy4yc7
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e62934 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=6UWhdCim3U11iwMnUWwA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

Add device tree nodes for QPIC SPI NAND flash controller support
on IPQ5424 SoC.

The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
devices with hardware ECC capabilities and DMA support through BAM
(Bus Access Manager).

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* No change

Change in [v1]

* Added qpic_bam node to describe BAM DMA controller

* Added spi nand support for IPQ5424

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index ef2b52f3597d..81f133568bb6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -567,6 +567,33 @@ sdhc: mmc@7804000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x07984000 0x0 0x1c000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq5424-snand", "qcom,ipq9574-snand";
+			reg = <0x0 0x079b0000 0x0 0x10000>;
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
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0xf200000 0 0x10000>, /* GICD */
-- 
2.34.1


