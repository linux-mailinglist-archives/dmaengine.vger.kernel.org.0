Return-Path: <dmaengine+bounces-11332-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9yMpGHnCJmqEkAIAu9opvQ
	(envelope-from <dmaengine+bounces-11332-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:24:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FC7656991
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YIVapPQ8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UrMm0len;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11332-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11332-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D399E307BAE4
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE038D40B;
	Mon,  8 Jun 2026 13:11:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177DC38CFFA
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:11:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924299; cv=none; b=mFCp/xKiP8mu9MT9e9L94LPVSLHgUHIzJJYnz43+D9OffWc56/+N4uhzrNexSe898DYwYSzvPza+SigLIxGlOVg/jbevH9lKOlK0trkRvDcwMtm/RXwc+A4X08qw5nzNsClSlo1/bBXCB35FBbPQg2p5eaUKl8ieeBut7ktKx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924299; c=relaxed/simple;
	bh=NOKFq/SDiz/OoyYtcUc5wHPfD55NbS/2YLEB90Lp+p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fS6dSWBmAGPSo588WAnhUTR/W/TT7gg9Kt0QfHthosfmyF6hdC7/7y8VF4d7sgqDFDFgKpMH0lf3qRW3Q5zNaYn/Troq/2fwe+aROkmw4JfIkgFbZngrAg3hwhmJWcOow7vzcaGdtFKcMvJWPa4z8G7FSgjdsgYZwGG1phTQ6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YIVapPQ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UrMm0len; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658CmdF43593511
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PckU5u1SzqZ+RYh35ZmEhvngTkL5r4rG5OsTb5FLskk=; b=YIVapPQ8KdiDkkKx
	WnT1+kLxX2N/GlXbQ7HhMTrdtohEHZAKCrtSo37C5p23+5zka0wud2lJZNXkGmG/
	0HF3qLDcwoG+pz0itmfQc77uuui5xwZulgdTESA7IYzp3fpi7rTT4fO6NJEEhTRw
	VlB+Ak68IBHhRTloVffhlNw3bilhhJurbVgIE10B3x5jSwYalWPNIcGujYfL/LvP
	3mw0zFwV48AdBFO8AmP+efh2KPuBMK8+T0o13+CcLDLKNyKnursc8lqIsuYEYaGl
	nM/SPzLvWOigybbgcBLmBaHnmXQKpA5JIdf5kd/AoDuc4CCIFiGWartRi0Ud3eiS
	omyeNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rr3ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:11:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c1e112dfso60967445ad.0
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924296; x=1781529096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PckU5u1SzqZ+RYh35ZmEhvngTkL5r4rG5OsTb5FLskk=;
        b=UrMm0lengpZgb9JCaAfX8/FCLdHnYRH+8z0ETbOSJb0dN2IP3GODV2SPu3ITCx2dnp
         J1VQw7pMaAkjisDim2S0j9QsEIQPpstgyF1BnV5LwRmnV0TZOvNnKwuGuthQUO0YcSlE
         sj5oYtRLWoU9hwzRwvo6xiAZzTBeQDA01yjXt/3Jh5BjEYFHYExJNCw/yZ6HS79cVRfV
         Hzx0HoPy6S+wfkWJstMWiSs9HoHMGY7RCnOs/KmVfeElOmDUep1IIe4GYdZFP58BQT4b
         ZGfBssRjw4gK69fN+KnHOCK1at6abiyIHpLbiC6pYFPg1e/35q4CetkOuhBCqxik3DR/
         6n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924296; x=1781529096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PckU5u1SzqZ+RYh35ZmEhvngTkL5r4rG5OsTb5FLskk=;
        b=ofzLRqq4k2Zj5FCg/NrO8M60cRlwKdZR/7oiVHnR/WdyS4VeRKElgazoGaUV5kiM7n
         19GO+wAD46muoknuxrWhxACV0A9HjV3w8j4urQsjMhfV9Bi3c8Zl3R6314YcGlZjKBzU
         diIONm7N4ZOM0ySUNVxrUgExQdDsF9+scr/+4w21pG68muuZFh+gMJJKzHpqqh8m8P/4
         PUPRis3UQDjMTU+1OElz1rk5qoefu0DAj5LCVtOTGgtClqMnJjug6PI6A6YmSF5SameR
         WPYFopEEDzwLqVxiLzRCCmb659q28fsce5asQeMBKijuLNl61eGv3jv2dYFQIgT8iOsZ
         n8/g==
X-Forwarded-Encrypted: i=1; AFNElJ+sQBbU9amwptz0oivjdUn7ixEqnjj78jxdi5xUPfrxWdvhohlqj9A05hNOm+7rHUtEcwqgQ2xiSV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVop0QnrVCySbAPthTQFV+G247MqPYGhjIqkiQKyD0a7o1wTt
	URjDPRm8HCIbZjg0BKlmlehZItLRoRTZsjDFYbBXP3qI1QNKl0AH4C+U4lG+n5dXrYJE+Z2qUy2
	I63mDweYkjuF4v9mzLblDyIrW4qC+gnmuDo+7Q/e1e9Ivo/owJ0toP3yJzz1pDug=
X-Gm-Gg: Acq92OFwzvJRM2rIvjINRJFKRMAJCkR5IYuAVmjlw0pFDRhiHLhYrcIZp85LP7UwUl6
	wOVCtgTmXLtvcrlchQJaEp15LIUaWZLUk2zy7odJpqd9NuRLsazlghiIYzKUUmqCwjUsyRS0RHp
	CZwDIQmRzWC/3omofgwWlUk94Y17SzyNEOROPiVXqUTmHwiqoe4G5YAYymwz3ChM0Tra0qbKrbH
	w79dD4fvo4PldS2EhNF4yRlFG4Su91b/VhWRnT+AXonnM3wAShPR0of4uuCaEjM3HprcUL1Thq6
	6FpkMBfAaCLmJAdEwuUYEZqcb26DUP2wHvC6RSN63f+V/VSslV/XMkMaDslcNzuLjmFzGhWrlFy
	CYtlD4hcyTL14VybPl0+afuUsAX8yvZfHBguNCD5QizeK7FU=
X-Received: by 2002:a17:902:ced1:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2c1e7e5267emr171619725ad.15.1780924295939;
        Mon, 08 Jun 2026 06:11:35 -0700 (PDT)
X-Received: by 2002:a17:902:ced1:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2c1e7e5267emr171619185ad.15.1780924295431;
        Mon, 08 Jun 2026 06:11:35 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:35 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:29 +0530
Subject: [PATCH v4 09/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-shikra-dt-m1-v4-9-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
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
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=6320;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5GO6GjX1SPCU3e6EbzxXVd34IDEP215KBVt1xhfHa7A=;
 b=ywgyacqq7XdEiOr+DvEjTpvuJ61MGmgY0KmEPWsI5V1NiUbPlHT5wkeHCJjEIH89eCPbi7lZf
 rfAo5TC4jluACJOcuERviM7A82E58lT4vUmCMqRTyzVAa7ahnkzBj4W
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: NVw2-y_cHRQKEyUCrEf_ax1-W1weVu0J
X-Proofpoint-ORIG-GUID: NVw2-y_cHRQKEyUCrEf_ax1-W1weVu0J
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26bf88 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ciYlwfYJ63W0farxgtcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX8hdcFm+ar5P9
 mCZu7WysskcmnPxzu3EU7W7mDLX2NK+lHHcZ6Ilj8GVWSdD2DQL8M9pn2s89JnxsK99x6u5jqUM
 jW8dz5tAOWUGMTxPJ96+x/hBm7BeSJ9AhAlrduDidGBtzQBE68j9p4CJ1/dTH55GTAiTLt93swn
 j43mKFuB+efv1NkcijqgmBQ/dchp8UBkSIIn9MHvSO+ityMfy2A4ER+u4WUxn1fBjoSaOMx7Ino
 VStvyjp7xzz0L9/q5qG07wTE62wbb/g9FzVMApvJB9Bh4WIk7NkUpqVUNH95vWXXhBI+zBQOsH/
 NdVK7kTxxLhzsuUXg6U6ZwlKBczqkF3LKspbetn1Mw9tMZ+zDDaMfZFedhP4ctYFGol9WU2hZLH
 FcyckCdM/rdjgGEhkpLTQ88WziduTsVS6sTPjVLdSsaZPCVwPjaQwDs68WcDjBC2mP83PtfnPqw
 ls/qHmLO3yQjbX08xkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11332-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:gaurav.kohli@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0FC7656991

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

The shikra includes one TSENS instance, with a total of 14 thermal
sensors distributed across various locations on the SoC.

The TSENS max/reset threshold is configured to 120°C in the hardware.
Enable all TSENS instances, and define the thermal zones with a hot trip
at 110°C and critical trip at 115°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 267 +++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 445dd8bb7269..c1f25ce89bb1 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -983,6 +984,18 @@ spmi_bus: spmi@1c40000 {
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
@@ -2180,6 +2193,260 @@ cpufreq_hw: cpufreq@fd91000 {
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


