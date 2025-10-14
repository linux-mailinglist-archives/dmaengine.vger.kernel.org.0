Return-Path: <dmaengine+bounces-6841-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4CBD8EA0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357414024EE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2B30FC16;
	Tue, 14 Oct 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QDElClUQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0030DD37;
	Tue, 14 Oct 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439993; cv=none; b=szgylv0DV+pyKHgOzttqkV8xn91oiDVLjpoCuz9UL0jjhz6f9ppdAyiS0FaykBtSsADj4fklK/trql7eGClFolQ35yrGPQtb6GgG5kcFS3Qf/0jJLrHbxAtwmuO4oZiSZtXTENDc4lmyQokVZNF5vBMIazVxR3MtL3HvY4oDNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439993; c=relaxed/simple;
	bh=08oCG4NDA5iG7p0wPbgt0TusUPdmJJt9uSeHGGxMYaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6dclqFefxBeCjL5BBCREB3+dW7dtTXXVK7UN7JOFmSBAFB63ZksDCUspQJpuGjaCzZkru8sM4xJvXKfLs67M2Sxs6I483uYup8obINnMpwXlFOy3ZtTc2DLm8OGyznvJzsOdLLUW7jjZcgkuLyz3Hv2+DRNMecF5u3G7RCg41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QDElClUQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JZI031000;
	Tue, 14 Oct 2025 11:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qh5LA2oDFBQJ4a0FmDywL530zoMD89Po5hnnk+bJEVA=; b=QDElClUQHt1DqoAq
	LOHgauZS8cO+WlnsrlX9yT2B6cql9Nut1kAkELJ36hh/E+xmwiZL514c5hdDB5zW
	RcXtL1h1sQ/UQeK2+3i0MQz2airNmduHxBoCfFBOB4hIKRudkB/mTdgcMqmitUOE
	7kpZDGvIjyHLjVtTNRf40kNpzjaHJPeobcDRrMGjDqoOT4JodOLsFJaQTRDsH9eN
	HvEkIS/ILr97q7g5qhSFwwS6ADuHjDFkgVPeBg4eB+77YKuJAg4L487MTSMe3Ftm
	N7SnF3O7L/Uc6Dqik1/XWnt3hrC9tXr51Dj+z3NBINJRjsjALhKVyIJ+Z8PGXdaX
	jWsqSA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0r5yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB6SSk023502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:28 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:06:24 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 8/9] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
Date: Tue, 14 Oct 2025 16:35:33 +0530
Message-ID: <20251014110534.480518-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014110534.480518-1-quic_mdalam@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXzLQ4dnZn+xCE
 KJn98uK5NwX7MyDXfRAqfiwTEXEZasOp/1V8CVO8RkCdexXKuLGHrdomaBJErzSbMmvCoJCLYVy
 dVCr1OjF24HOO4alv4qK5O9U19WyAEIHhijhK+cEcf0LXLo3XvOdb4w5EgmHa05ErrHIGZSvrRI
 kwKyg9Iy4qGAw5CxokPqLZVIYmGsdDAz2vtcOaphEpEhnjPZK9nurU3VDv3ep9yPu64Gm6Ih5y4
 EjoOsr/75yk/kY3YBQMotu1ep8wzFiQIMPRP6OpH1bsRdjh+vIR6cV1J+xsXIEJu3QeutWrbY6G
 BpWQPtGDUm/OtwvWjVdnDXPhSqERRR88AqR5rGFD/agJKtoorjEXGCKNPjgN8bVADc6bjnfHnBZ
 lfk6CCZN79C6gfFPItnHj95AXGCWyg==
X-Proofpoint-GUID: F6IXqGsMP36oNV4cgJdHHIC3mRJWOD-H
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee2eb5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QIVe3DVYhI_-bwApSWIA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: F6IXqGsMP36oNV4cgJdHHIC3mRJWOD-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Remove eMMC support from the IPQ5424 RDP466 board configuration to
resolve GPIO pin conflicts with SPI NAND interface.

The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
mode configuration. The eMMC controller and SPI NAND controller share
the same GPIO pins, creating a hardware conflict:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Added Reviewed-by tag

Change in [v2]

* updated board name commit message header

Change in [v1]

* Removed eMMC node

 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 30 ---------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index 7c32fb8f9f73..de71b72ae6dc 100644
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


