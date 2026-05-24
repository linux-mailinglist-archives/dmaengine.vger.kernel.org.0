Return-Path: <dmaengine+bounces-10785-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEhSGoBWE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10785-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBA5C3E42
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C62F63009985
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDE318EF4;
	Sun, 24 May 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJvpbwfu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KRvykyvZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABA30B50F
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652188; cv=none; b=p0JQTAwxTHqrWlNImOt+wDkNvOGZLP7pEYi0GoJ2gIWcffMIQanuWy6UVe7VTToQ8AeYRat60QxY8offbELxRecKYJW8hUIsUMf4ai3OguGypqr0pqlxUezZ9toYPuSWeF7XbKPPlpHVf+gazzYjT6fmRY3HPrqehg4rNEoim74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652188; c=relaxed/simple;
	bh=MIUCULZ6SKXJFGgZfpP70x61UkEtycDQsAmNpodx7rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkmZBEOBUw3ZbBjxhkVzsO9WeCWTn8Lt/odnTQSgZsSwQPYUOluKLsuc3XfKmatvaT6JdpaaZWYZukHRR1rwY+VmUcEBQtjK75DMVUbfJEMr0oPtILnd2LWggksLwGpm8xdfKvqlsC8KOiA0ZVTRfvugWooUuj8WJANNHb2jejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJvpbwfu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KRvykyvZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OGp7FO1237908
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uDABXrJgK+8ravfK/476LEWmVo1YEHFobSPdeiEfn+g=; b=KJvpbwfuIW6+tWor
	sqBT/cp6/R35+njL4STidIcF4HLeT15BcEAEmuBg5FXYStTlIXcPvrPPSfCblDfb
	8gC36SA1q/ltaYdvjnSfn8R6tmxeotDKeUTIjnXpSzgP/SuScWJxzgpo/mz9TPwI
	uyC4YcbhMzXEJSzDOmUU0cobkJAExWHEVt4kuHgIt8nCqfVVmJLev8I4o8wl0Z7w
	V8QTaGchYoZ0USecJlba3iEhewi+9uEd3/xyI0W9PC0pgBXvZkG6JnHKicfpMEb7
	4eIX6YkL4r4y2I8IxzhIMjtKjWdLmofOxjRQJALg66O0iQAPlaqNB7+QZX8jkglZ
	lNPGiQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgv0k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so8029699a91.3
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652184; x=1780256984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDABXrJgK+8ravfK/476LEWmVo1YEHFobSPdeiEfn+g=;
        b=KRvykyvZS4fQ3bOyaALX2k+8nM9hQKpAWv0dhWRxHAG2Ayc7NRFw0HgeEX6TTiiwVU
         RqCImGjG1Jg7SpR+gRTPeNBOuUyjGJ/QL0G8Il5KyAK0gXElyBd6FCUsZGpihIvEChej
         CvbV5X1QMHUUhQajcwOqZFlsYcCc4yu3BaNEQW1IAgb4i0kWxaf5x0gHQEbfJ/u7niqt
         zKF3eXmYynCfdy7k8JAzIMrKngLnrvGhWl2YG3SbHJ/qH/8exrDF6MgQ/JQqCU8GUgGR
         Reg7eK0C7l0bs3+Nxm4TuiiMgsgD51g7DM0osMgu45fK92D779qi3tR1Iebt7dB8PiPs
         Vgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652184; x=1780256984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDABXrJgK+8ravfK/476LEWmVo1YEHFobSPdeiEfn+g=;
        b=PjYWt9w4KiCKzRyj9VVXnRsVjt2/GWgGH7esKfV7EWK475PSO4oCBCxhwSRdA3jmxl
         Rqp2f982SRNPcJE/JU85fHUCyNIUcgemjHsE33JusC8+2KANuHoE0TYK7kjaZ6HbjVBr
         ykVZTWc0N3+/XoBjqdLnQnZ90Tx8aKFOpBjO7wRUhVeVTGyT7udZOsr8r+L1UehMzfqh
         Qk3IGKIXeqq8TSK4DhBEkci1RnM+kIdRo5gc2DKsX75wxcK5KY4WRkaOyR4z9pNLtk+P
         +7n5/IW5eAuSS9OtQlTufEcFl30ypuYwRVd2ukI12kfE8HbxQ923UX86A6RaKuvi2QRY
         K3gw==
X-Forwarded-Encrypted: i=1; AFNElJ9aYECecg4IITwMo5tEPkZdQqpCeQjQwowxaY8dyl5+9BOkjeS17P3/KsLtvo8vfePE5tC7CViOIus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMrrKYx6TVo904ZeaJExPeirWYAWpVPKrHak+xD/bNodUtg9Z
	1dADfmPYtkqsOdTAmFBbkHByinaBjXAPLnsN/Spc1Evq5iM00D7FY+6sOLMI0WMQyuJ4g0QvYfp
	cYIOmZVdTmS0u8ch1PQf3tIGJK5YIFBFuykGjanF+74e28v9Hul6+xFE/GkCrAJ0XzsV0XZs=
X-Gm-Gg: Acq92OHmxbax0XslriAoCqif3R80yYEikOxv9BoNBzYtrfkNTU8Ix3uM+z6O8bm+eMs
	PUjFsN1RaEhfn5mnLR6VnDwoeegv9aiQUmGzK/bnZvUaGuh5FjyoNArnwfx99UHjUrc2JfiU6fV
	w8yCyZ2inmFFfY50+nI54YLyu3TKIsQoWqJd89SWx85uq+24FeOit2dJH4ptgBjukV0sBMyyvYG
	CxpxjpjqB/SLoTY57zRdgNglUqNUFTjthQqO5iibubSA8dsh3b6YQgbJ+X+7Tb1dERUwFKwpPaj
	exEf7pNrfW2xfBW/3gvnoeTc8JBYMAbQavsHtiS4sV1KORvvzbPGmHtNSdYEJAzEnbQ9BAg7ONs
	v2afAYa/LRdwVxjybYK/8EW7K7g4sN1EfiJK3/9q/Y1CRW4I=
X-Received: by 2002:a17:90b:4e84:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-36a67732b8fmr12043726a91.10.1779652183758;
        Sun, 24 May 2026 12:49:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4e84:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-36a67732b8fmr12043711a91.10.1779652183036;
        Sun, 24 May 2026 12:49:43 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:42 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:07 +0530
Subject: [PATCH 03/16] arm64: dts: qcom: Add QUPv3 configuration for Shikra
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-3-f51a9838dbaa@oss.qualcomm.com>
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
        Xueyao An <xueyao.an@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=28684;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ygaSDmza/u6IYKsN0t4xLP2AX3842dUY9VPDSgggZh4=;
 b=QkvEhX8gF4PnPrQY8OfrsLVuX1khjaUeY6y+QuqUrX8MScqLC1Fg2yaAx1+JA2OBDod+l0aTO
 8eU1OFUmodWAXUxyJyhFlHXskr7N+KfkeXVKAFqMydTWKt6utkLM5WG
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 1vIQsCkbtHiA8plbqZdjdsvqZ3rPb0ig
X-Proofpoint-ORIG-GUID: 1vIQsCkbtHiA8plbqZdjdsvqZ3rPb0ig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX8N2o7dVnt4AT
 pNY917HBC/cG0ngYBdUqt/0qrIx35p1DkCLyAWEY/jbDMup0wyqQJ3e99OvQKy1HrQw2lyCs9RI
 tOLM6UzsnQi633JZ0+cXbEyhp9NfWBhP/nMHRKu6iFo32kgkGT+Iqf5Cmsw/3kbQYZGqMGBvY17
 0r/LItvoIR6TGVykz7ah64iG526M+yrd5QXhQBniThVSntyoaM/ICbT1lKGkiNh0uNF09Ics8Wk
 glQvT7Rb5uV5CrHT/rd5wFbVre0WDGCqKiL6rrRAc7klD+WI7x/W1AukLkBKjD0ypxcsidBqg8l
 +vIww0bZi4TMHPPP3kqIWlvQbiZJQnT8bK/ldX91Fvz8p+M1U/eOIH9MHL/+0OOlZZBG/1hEzpo
 V802pco8zwiwLdsLau/nhEmbvvA+QZDn4yTzM8scggh+Nf1E0JG26c8w5bvjPCq8vNVA4fXk8yu
 GPsd0XBqOZD5e+fV9Tw==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a135659 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lZImzISf86lFr0hzVWMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10785-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D4EBA5C3E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Add device tree support for QUPv3 serial engine protocols on Shikra.
Shikra has 10 QUP serial engines under a single QUP wrapper, all with
support of GPI DMA engines.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 951 +++++++++++++++++++++++++++++++++++
 1 file changed, 951 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index a4334d99c1f3..2751b4f89678 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,shikra-gcc.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -348,6 +349,161 @@ tlmm: pinctrl@500000 {
 			gpio-ranges = <&tlmm 0 0 165>;
 			wakeup-parent = <&mpm>;
 
+			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio2", "gpio3";
+				function = "qup0_se0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio4", "gpio5";
+				function = "qup0_se1_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_data_clk: qup-i2c2-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio6", "gpio7";
+				function = "qup0_se2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio10", "gpio11";
+				function = "qup0_se3_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c4_data_clk: qup-i2c4-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio12", "gpio13";
+				function = "qup0_se4_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_data_clk: qup-i2c5-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio14", "gpio15";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c6_data_clk: qup-i2c6-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio18", "gpio19";
+				function = "qup0_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c7_data_clk: qup-i2c7-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio20", "gpio21";
+				function = "qup0_se7_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c8_data_clk: qup-i2c8-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio22", "gpio23";
+				function = "qup0_se8";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c9_data_clk: qup-i2c9-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio27", "gpio26";
+				function = "qup0_se9_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_cs: qup-spi0-cs-state {
+				pins = "gpio1";
+				function = "qup0_se0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi0_data_clk: qup-spi0-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio2", "gpio3", "gpio0";
+				function = "qup0_se0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_cs: qup-spi2-cs-state {
+				pins = "gpio9";
+				function = "qup0_se2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_data_clk: qup-spi2-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio6", "gpio7", "gpio8";
+				function = "qup0_se2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_cs: qup-spi5-cs-state {
+				pins = "gpio17";
+				function = "qup0_se5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_data_clk: qup-spi5-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio14", "gpio15", "gpio16";
+				function = "qup0_se5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_cs: qup-spi6-cs-state {
+				pins = "gpio29";
+				function = "qup0_se6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_data_clk: qup-spi6-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio18", "gpio19", "gpio28";
+				function = "qup0_se6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi8_cs: qup-spi8-cs-state {
+				pins = "gpio25";
+				function = "qup0_se8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi8_data_clk: qup-spi8-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio22", "gpio23", "gpio24";
+				function = "qup0_se8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup0_se0";
@@ -355,6 +511,105 @@ qup_uart0_default: qup-uart0-default-state {
 				bias-disable;
 			};
 
+			qup_uart1_default: qup-uart1-default-state {
+				pins = "gpio4", "gpio5";
+				function = "qup0_se1_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart2_default: qup-uart2-default-state {
+				/* TX, RX */
+				pins = "gpio8", "gpio9";
+				function = "qup0_se2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart2_cts_rts: qup-uart2-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio6", "gpio7";
+				function = "qup0_se2";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart3_default: qup-uart3-default-state {
+				pins = "gpio10", "gpio11";
+				function = "qup0_se3_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart4_default: qup-uart4-default-state {
+				pins = "gpio12", "gpio13";
+				function = "qup0_se4_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart5_default: qup-uart5-default-state {
+				/* TX, RX */
+				pins = "gpio16", "gpio17";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart5_cts_rts: qup-uart5-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio14", "gpio15";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart6_default: qup-uart6-default-state {
+				/* TX, RX */
+				pins = "gpio28", "gpio29";
+				function = "qup0_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart6_cts_rts: qup-uart6-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio18", "gpio19";
+				function = "qup0_se6";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart7_default: qup-uart7-default-state {
+				pins = "gpio20", "gpio21";
+				function = "qup0_se7_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart8_default: qup-uart8-default-state {
+				/* TX, RX */
+				pins = "gpio24", "gpio25";
+				function = "qup0_se8";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart8_cts_rts: qup-uart8-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio22", "gpio23";
+				function = "qup0_se8";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart9_default: qup-uart9-default-state {
+				pins = "gpio26", "gpio27";
+				function = "qup0_se9_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -604,6 +859,34 @@ opp-384000000 {
 			};
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,shikra-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x0 0x04a00000 0x0 0x60000>;
+
+			interrupts = <GIC_SPI 511 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 512 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 514 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 515 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 516 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 522 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 526 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-channels = <16>;
+			dma-channel-mask = <0xff>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0xf6 0x0>;
+		};
+
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;
@@ -613,10 +896,75 @@ qupv3_0: geniqup@4ac0000 {
 			clock-names = "m-ahb",
 				      "s-ahb";
 
+			iommus = <&apps_smmu 0xe3 0x0>;
+
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
 
+			status = "disabled";
+
+			i2c0: i2c@4a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a80000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c0_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi0: spi@4a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a80000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
 			uart0: serial@4a80000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x04a80000 0x0 0x4000>;
@@ -638,6 +986,609 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 
 				status = "disabled";
 			};
+
+			i2c1: i2c@4a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a84000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c1_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart1: serial@4a84000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart1_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c2: i2c@4a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a88000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				pinctrl-0 = <&qup_i2c2_data_clk>;
+				pinctrl-names = "default";
+
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi2: spi@4a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a88000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart2: serial@4a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+
+				interrupts-extended = <&intc GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH 0>,
+						      <&tlmm 9 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart2_default>, <&qup_uart2_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c3: i2c@4a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a8c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c3_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart3: serial@4a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart3_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c4: i2c@4a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a90000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c4_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart4: serial@4a90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a90000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart4_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c5: i2c@4a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c5_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi5: spi@4a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart5: serial@4a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart5_default>, <&qup_uart5_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c6: i2c@4a98000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a98000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c6_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi6: spi@4a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a98000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+
+				interconnects =	<&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart6: serial@4a98000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a98000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart6_default>, <&qup_uart6_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c7: i2c@4a9c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a9c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c7_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart7: serial@4a9c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a9c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart7_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c8: i2c@4aa0000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4aa0000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S8_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 8 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 8 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c8_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi8: spi@4aa0000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4aa0000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S8_CLK>;
+				clock-names = "se";
+
+				interconnects =	<&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 8 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 8 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi8_data_clk>, <&qup_spi8_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart8: serial@4aa0000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04aa0000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S8_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart8_default>, <&qup_uart8_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c9: i2c@4aa4000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4aa4000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S9_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 9 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 9 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c9_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart9: serial@4aa4000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04aa4000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S9_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart9_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
 		};
 
 		sram@c11e000 {

-- 
2.34.1


