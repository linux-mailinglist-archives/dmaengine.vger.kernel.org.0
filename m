Return-Path: <dmaengine+bounces-10795-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA7pNVJXE2p/+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10795-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:53:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DAA5C3F7F
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 397BB303F47E
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB931F9B8;
	Sun, 24 May 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAZvv0R8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SX0Jr34C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CC31F998
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652240; cv=none; b=quy0Eup5AwQeAVKsIyla91sUw1RjHJGhuwIG/iC5M3BbQljtvwxhvc5tjJcV5zimVDw9YsMD1nWU4Cxrf4Hb0aUAWUUKQmiUDcSOHd0x6GSsTH/GPY+p0nLguh7+Kg7V2JWRDqR66fxac1Y/71GzqtPR+W1t3Mu9PqjP49tqWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652240; c=relaxed/simple;
	bh=y8hzVy6cCcJ93bHvBbe4ds1C+WcIptdu8VcitZODijU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fl2y6HeeKrS7g52s+XcSc7PEY52US2hc382GQabTePWK7czb/ZMUFxDxoWaHv9K4dYAGxv1sS72VVbtrvrRYaGvc98Zri48uPR0wi6zAR0pd6g5NlHz8G93WBGOJaHRnve4X4B/FMbFQiAcpzyQHjJpAt6YyvbcYXclLnXuITBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAZvv0R8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SX0Jr34C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O5Lt2k2782054
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qeQxQjRAZZ2hYSr+SWxRvaMT5vkjwlopuyhcFv2hw0E=; b=WAZvv0R8javfWBox
	w/OqDYSh3rTqUd5Ado94TOuvX7TesP6frhn2VvAcq1f3CPCwyhnu/OpTUNDOVs1j
	mHJj4BmkKPIEHNnyQjqv0aMvXCy8p/If2wvjzBvCTzJHLjT+bwO23TL3QVhK/FF6
	jWhTtXGSUXgjgW3TE3GFykVnVidf+AVzW6OhUBXd26S0z2QDsFpScof/42cZXmo4
	hb5zY5MjlgDLFBKdmHDGHdQExa1OH71vfdE4BN78i7hjHGZ3VFqOI0N4LV5+V8Hm
	poCcRWO/bSuM/4vwZtlE2C3shPE/9JxirmEAUQGOio5KklnRFnvEXF3tkwQCSz8a
	70LiKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9kr8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso17006667a91.1
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652238; x=1780257038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeQxQjRAZZ2hYSr+SWxRvaMT5vkjwlopuyhcFv2hw0E=;
        b=SX0Jr34CeCFNPlHQPnOPiUf+KQAlQ673jdflkfR4ABpvZ0fCPWV8n8shsCq2VVNQYG
         KvyXNSpPBG3fohRSB2QPfB8TSu1Oh3Gv2KG5h3Xu7LqyDC6pp3PdglbXdQUjqg7MKDDr
         C1v9hKgVhHEjkJJ7FaF+KQuzu3L6mcuE3qGgSPE22BfdMXmq8OKUAmKh7Mvmeg1OaCxA
         DqGwdfv26xyruvAj6tSucnzCdbI6sTmpa6RBVFmQwZ8arae8UGRgy1tFPj7hBWlkVqp2
         OFF2bF6T0Zk1qxeNGdVFSfsKwa0cQJ2G9zbA3RAaSNwgIUQqLwPYcEfVCAdmjWs4OQpG
         KBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652238; x=1780257038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qeQxQjRAZZ2hYSr+SWxRvaMT5vkjwlopuyhcFv2hw0E=;
        b=XeUabg7o5m9VPGhvLOUTC07ixyuUkls1cZ/aq1cfG4C/pWCoQLnYW8KUGrcBJWUq+Q
         tMElun1s8CSS0q2Z0WPsCm2EBv8O1eBbUAw9jzyqv+QiehXpxqJiNpVfCQHCLjcC/XoZ
         22vVS7R3ZR9PK+oLri6Y13Geawvp1RUAHHm8N38rDuYDwSJ9Hv+V7RTd0FSrink7RQDL
         Iyp/Foutx2k9cX1okH7soXuljmNlRo55sbxtdVum6Lp/pjpiQrepVnK3eomRUTUeUh9q
         8qfnQs1vE2ENChveWtAGXpgwLJw1JtLSbfHJtLxhm0diRJM15raj71JVUfvlQZ504KuK
         +2bw==
X-Forwarded-Encrypted: i=1; AFNElJ9JDm/lDwInVF76vgd9H5aGRhZqPRARdlfgT2+VG/BzJ8GBWapB+JcI9vNFMaNH+h2n+tu0Ghi2PS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgb1Ic0KJxi9wCDPURm2N0+tLlMc+18ylZH4FSHrdRIWkb+L+D
	C1cuXuJucbrYQtk/jIPoeq9eHstvaW5QghpPmGLG1KmNZZM+7VpcyAp5bJ9PSpAQzCtRR3aS+3b
	xRNMivaW7Coyx1BoQFgALWiY6FmSa7hUmO2Osc0kBzX+TKeOm7wTtbU2Hivn41Ho=
X-Gm-Gg: Acq92OH0UPwdTjxaXhn7Jq28sZ9BkLRTlp7dk/jw25scPDeV+Tx/I1AaK9N2+mfJTQb
	1rfzN+v09WaVFBvk9/BIMNlAalGy88BiS7O9gL4vCcB/SCEnUeplTeGYosfXmTfDjMuCcqDRW9l
	nVeWDwO0RePHt0jjf81Mcan59xKiN7QUVTuRzPsVrXIhgVhiuPRMk/+6qBMbXaI/Iidibgm7S6n
	24/NZXpBkU9kn0t/1/a9KsgPGU8fh9SYIl8oHaZgn90rJtJHDCv/YPOx85BgvwBIoN0xxIE2NPv
	2OuK01TANdAsRsIFc034QNWjWpNXhuEtoMR5Hl1wdFqEEhee0Dxi4gaB8u5X3Bib3A7wXFpLQ4u
	lZ4OP87PS78kTDNoJNw58WjRZPhD42Rvo1GPH
X-Received: by 2002:a17:90b:3791:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-36aa16b66bemr3848177a91.7.1779652238074;
        Sun, 24 May 2026 12:50:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3791:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-36aa16b66bemr3848157a91.7.1779652237499;
        Sun, 24 May 2026 12:50:37 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:17 +0530
Subject: [PATCH 13/16] arm64: dts: qcom: shikra: Enable TSENS and thermal
 zones
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-shikra-dt-m1-v1-13-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=6253;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=cGxRrrI7UxJhRRdzjLYdr6kVl234MC9MAoygig5zUp0=;
 b=COlXrzf36pdnGoe4SayHJsxe71fdlF/YeDbTQSMd1ttTUxHrSyf4xRtCdak0uP68JKzNuyvrG
 G3fJQ2a/lLdDzNRAaLbAJ59r546oKLtJpJ0aoK0xH+b+V5ybWOEbtja
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: mQndkjNrOwU0PKs_7qpbdcW-HMnqlZx6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX3dvpxCgf4xQR
 lPIEMPc+RXTKwwaMISpNWUBid7cG8qox3jWDvO5Ekk6qvqp0fLBMbMWbc/yrkpnAMRTbLUfqS4H
 z0VGL3LdrhAFu5lMpa9Noo2UecNDgR/U7dtFe8zzo1rZHCgxryMGevszJzbt22HUtQOIebuldke
 H4SsDXkVLsDPSI3bHnrl0j5YC6beWxrtLPytXgyBli+qW7PjacK4ylgo0USEQcNfYWH5d9lCQkh
 eEOp69/Ogn4WfajaDRZfEMrrzlxVWQFgWIGB23V0zAs/iMioWGaUtsmSvbdiXcdrAwiMB0tuvhk
 aAYpBoyWFTse+Cz0tju1Y6SqXUR6/R1SOrGy+xtwfsaUVIwRoxJAqw6JaSIqmGMOHmGEd6D/+89
 InSTlyxi3j+Y8cwabV7ZKGUDfEng40QKLt5d64TQV197VlCWVcyKfNcAt6c4BxI3gpb3g+RftZb
 dFWtW1h9abMwVa0GwuA==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a13568e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8VSKil3hnYOHzGXlt_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: mQndkjNrOwU0PKs_7qpbdcW-HMnqlZx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10795-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fd91000:email,0.67.78.120:email,1c40000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 54DAA5C3F7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

The shikra includes one TSENS instance, with a total of 14 thermal
sensors distributed across various locations on the SoC.

The TSENS max/reset threshold is configured to 120°C in the hardware.
Enable all TSENS instances, and define the thermal zones with a hot trip
at 110°C and critical trip at 115°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 267 +++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 96ec5b5c7203..124d0f05538d 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -982,6 +983,18 @@ spmi_bus: spmi@1c40000 {
 			qcom,ee = <0>;
 		};
 
+		tsens0: thermal-sensor@4411000 {
+			compatible = "qcom,shikra-tsens", "qcom,tsens-v2";
+			reg = <0x0 0x04411000 0x0 0x1000>,
+			      <0x0 0x04410000 0x0 0x1000>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "uplow",
+					  "critical";
+			#qcom,sensors = <14>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -2179,6 +2192,260 @@ cpufreq_hw: cpufreq@fd91000 {
 		};
 	};
 
+	thermal_zones: thermal-zones {
+		aoss0-thermal {
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-0-thermal {
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu00-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-1-thermal {
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu01-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-0-thermal {
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu10-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-1-thermal {
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu11-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss0-thermal {
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpuss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss-thermal {
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpuss-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsp-thermal {
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsp-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mdmss0-thermal {
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mdmss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mdmss1-thermal {
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mdmss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera-thermal {
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				camera-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-thermal {
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				video-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-2-thermal {
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu02-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss1-thermal {
+			thermal-sensors = <&tsens0 13>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpuss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 

-- 
2.34.1


