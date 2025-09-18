Return-Path: <dmaengine+bounces-6627-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6790B83DE0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BE94A04CB
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E273002C1;
	Thu, 18 Sep 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CbcYBYse"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9F2FFDD2;
	Thu, 18 Sep 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188482; cv=none; b=KDWx6LUnla1LyAv9eueIlOaW5MfjvD/Qn8xmGtkLAKVOw0XgO6uhZ02HOPW7JriRVJG6y+idTg6neMI2cTtgEk7Rlb/PVpvGF4OFzevAqGgzHegpM2I0TgwOf8Gp6Sk8QF8OkOhrQx3J3unswlRUmLF92YVORBr/TTpKkFDWSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188482; c=relaxed/simple;
	bh=iNIW6Ig/R0jBcU1ipy88h4CePqrzK12A5gXblRD5MsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDNRVpCyPbVpICTrW3n6ECNJT0Y9/2GNlFCq582Oel3tmzx3V09miA6o74Qbg5CIZPoj6NLHb317ln54Tdyv9beQFUVppA3Ut9us8k98WoDcmpisJyxQc8WP/eKe3KNuBxaqX53BO/ASFvO45qQQvNpWhx8jEfWfbBRXBiH/Wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CbcYBYse; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7dONu013186;
	Thu, 18 Sep 2025 09:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Nx5jpucxpBfAEXxkmUbfMYh5HKvwd8GpF4BKYFxjm8=; b=CbcYBYseQEevUyIK
	8CUCynzH+8AnWL+vBVDHpPMH6Nb8x6fNskeUKHCLSRTjaT4iBjC+QN4+7GdwtJ+s
	unXXTuzB1be1f/5ZOPWwuQMtNsCRY8uXWX1safOYaA93ZYzMQiZtWza731wLX3Zt
	hE0WmjzVqrqLL8MHL4fE6SD7brNO1CExRGJYrLVCxjgXYjRGGGrDZKbZnio0rIz2
	rOMV/tYFgXUYP+MoDYe0qbWtdaa/vdlnxW2DsVa/VvSxwympuBzP+VW+Ejx994qi
	rUYKefGDBKhGnmDPhDHkafqsSC9bp/r2QHg8ETYdKGeMxXJz+uh70ycy/ow221d5
	1qyyeQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx1qg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9fGe4019322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:16 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:41:11 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 9/9] arm64: dts: qcom: ipq5332: Remove eMMC support
Date: Thu, 18 Sep 2025 15:10:17 +0530
Message-ID: <20250918094017.3844338-10-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rrwIlaCFuQx2ZHWGma99z0MsIaF4vjlT
X-Proofpoint-GUID: rrwIlaCFuQx2ZHWGma99z0MsIaF4vjlT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfX4Sy93abIFcEx
 tskCgs9Fr8NK3NwdwmhrIoGEnRFeEvf9JAa4M+4SCGFojX33a2GyC2JfuTIl7x/Bah7GVctSbBZ
 aMyOF0XFbzPZrv4ivznPjD52E9nbDsASUSH9alJofna1isSl+HJZazBHXPUiwjdGOMpT6JsIiqt
 Vym0UUKbppDrv0NH+wDf2uNYIcfzG+4hpsflOFLQQr0ButjJ2FbXtEVu+1sFHNDCi4DJY4p2FG1
 6/q6gdaV5zo1L2RwZq1Fjq3huQvj/5nti/T5l6dkUMFUoLmnx1+hFu4nMKyJV50HICB+lQJgTTs
 4mlL+ZD2m7d05N0UExfyAUThO+uz3FyxE++6L0NG9ZVWhkZVIr1VvFt11BlznaEUvYbG5ycyGmh
 1K6DteU7
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cbd3bd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=fuWxvNZPvO_ztXA3lyEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219

Remove eMMC support from the IPQ5332 RDP442 board configuration to
align with the board's default NOR+NAND boot mode design.

The IPQ5332 RDP442 board is designed with NOR+NAND as the default boot
mode configuration. The eMMC and SPI NAND interface share
same GPIO

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 34 ---------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
index ed8a54eb95c0..6e2abde9ed89 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
@@ -35,17 +35,6 @@ flash@0 {
 	};
 };
 
-&sdhc {
-	bus-width = <4>;
-	max-frequency = <192000000>;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
 &tlmm {
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
@@ -54,29 +43,6 @@ i2c_1_pins: i2c-1-state {
 		bias-pull-up;
 	};
 
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio13";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio12";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
-
 	spi_0_data_clk_pins: spi-0-data-clk-state {
 		pins = "gpio14", "gpio15", "gpio16";
 		function = "blsp0_spi";
-- 
2.34.1


