Return-Path: <dmaengine+bounces-6621-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B540CB83DB3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA907AD64C
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4F2EF646;
	Thu, 18 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WHJsvr36"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5592848B0;
	Thu, 18 Sep 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188477; cv=none; b=YFzNdTTgEOpwqHVO9ryvnPKk7ObMyNDLexd6FQ46EwrJKPe7s8HhBFyEPudnQjlW1Ee2o7k6c0khGTPjH1VxgN1ihqRc/NMMke6C9JvKjHizDWCUNX7cNkttcyUqoimLj7TIWvPknVNLKnKY9J4RAI8738oY8/8At1zDVyQ8JbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188477; c=relaxed/simple;
	bh=x+wf670frM2M3XbZD2f1X2qfsPmDFZ+bdIfioqEXkVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owncPLU5tDj/yOF1YvJJ1s6eaOTVR2RIAaDGbA/tA2pzN/mR/502Zr39zi1ekhZZGRDNJhZSEE4I4rVEJOTNT1GJ9ej77Gg1pCuumHzOCwRFz4M0flDriDAVeSMpnm2fT/n1zjs/K76QQ7QQRW+7/Gs8UzAeSX4ysTBZUSMjdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WHJsvr36; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8B5tV007399;
	Thu, 18 Sep 2025 09:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N25teEMszfSC2luTNv5v8f4B5IzPjfEfF9bdQ4SfG9I=; b=WHJsvr368JWiQNz1
	MQkmwPOKKGY45bzeLGPPQ9JKQjG0ATdU64SVvumtlg+rieNPPBsScnfX/4Xh/udJ
	Ihi/bTGs+K0IpwksgAN0ITknBInXZKEO9M3rhCEa23Ksd04bECv5tBENR/tJp8tM
	9S+S9HbX6GfQ+R7hdyQpABK6IEnhHaEQbXrDPvF0xNmqwof+aEwfsuCGHQAp47jy
	xKRrkbuPfZSOhx7FRwk8EPruEpTcoDhvkGd6EEZ1WaimssnhiPqTPi0QnQMW6XMg
	fjWZhroAGPKRoAQQ3FApCOp57sGoPPZp5SKZxwjzzuyr/WhnZVptCfQPL4Q3GJ6m
	6CLmxw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498eber9k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9fBoK011282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:11 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:41:07 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
Date: Thu, 18 Sep 2025 15:10:16 +0530
Message-ID: <20250918094017.3844338-9-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: T4hRukYhxMN6YQYjBdH8s9z_X-db_VGK
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cbd3b8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=QIVe3DVYhI_-bwApSWIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: T4hRukYhxMN6YQYjBdH8s9z_X-db_VGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX3zGR6uM8uOkM
 qdLPiduJ0Ln5cBgkdrvA06a/XbhluuP+91/vq6JWcr9NZ7oz7gkONk8Nn+PM213lpU5JcnOZ+/u
 fBFq/S12MaFcLAqHBdfWeM3uDlvkqQyHOgHPcuacT0yRVFmzb1RQSRZFqDnXS9mjHIWzbKKzRpE
 tPkVidxD7hTnaqO7j+8y7lFrrVIMqc0uoxlEsKIHlF7dm7DF+0y44hAWJxsbXVxsgcCHw3ivWrw
 44HfDp76khiWLtPuZoItIYug8Sv5oZ54ZHnzjPSnbamSkTtuiNfI1TFBSLUVLmplSS2OuAUODZM
 Iojt0Ncu1HDXTmqT1fZoitDfrL3bUTaGa0qL7Bo7/Nxz2X2lmyRl97v0Wojaxe8/StbR461fWQW
 Uu5oSvzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Remove eMMC support from the IPQ5424 RDP466 board configuration to
resolve GPIO pin conflicts with SPI NAND interface.

The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
mode configuration. The eMMC controller and SPI NAND controller share
the same GPIO pins, creating a hardware conflict:

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 30 ---------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index accb15b0d742..347659d4f551 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
@@ -124,13 +124,6 @@ &qusb_phy_1 {
 	status = "okay";
 };
 
-&sdhc {
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
 &sleep_clk {
 	clock-frequency = <32000>;
 };
@@ -201,29 +194,6 @@ mosi-pins {
 		};
 	};
 
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio5";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio4";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio0", "gpio1", "gpio2", "gpio3";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
-
 	qpic_snand_default_state: qpic-snand-default-state {
 		clock-pins {
 			pins = "gpio5";
-- 
2.34.1


