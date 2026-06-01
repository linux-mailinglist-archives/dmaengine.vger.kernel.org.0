Return-Path: <dmaengine+bounces-11103-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB4PHfWCHWqcbQkAu9opvQ
	(envelope-from <dmaengine+bounces-11103-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 15:02:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD661FBE5
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07677309CBDD
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697139A7F6;
	Mon,  1 Jun 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJpeFKnB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="We0xOMZG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B1392C48
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318570; cv=none; b=RO50CKA91oMBVbfQltJNUSK7N/yQJMncZ+Z0Gy4j37/qqNQ/9mqrWYO7k3NcqzsnDoW7OX+dfw/paR2g1X15YPumVg6WORTjOxVSKodm+fo+jW+WtBVBlRO9/RuYsCiKDmEK721eAgg+vuuPAKz8fS/hK+kivi4OHMlx0g4ZvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318570; c=relaxed/simple;
	bh=8CNewaz6ysb0yOj7npMCemP+QV12Ecsvd1busAKDrHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vz9z02hsqBd1myb4soV8IT6pDxyGXHmzw9cD8v9LcIA/godEYeXSemLJvsoGXKE469xvTnFp8uZFwFAZ/+JWuj1Dh2ne0pgW9VQwVeTw3XDebMGu4RdmwU5+NoIQnvGxTyrIronUGDtUrZr4TIGH6pzVtBbG94aOXfI7490NIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJpeFKnB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=We0xOMZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651BM7ds622454
	for <dmaengine@vger.kernel.org>; Mon, 1 Jun 2026 12:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ljg6QncM4kslF0r8lBAtPXwQOgZ/kk4lr+BM+tIVpFo=; b=dJpeFKnB4GTvomm3
	8SvGshjhKVqsQG8EQvsqrEtBqqiBCl4P5r5Aomv/JHRkBAxpIf4p680aS3gBYU4b
	G1MR4/YLHjK+4vS117/2H+qnDXLJvhEWTDJgFzxNoVJawkK/w1nNW3Fjn8toYnPs
	2oiSEiBw1lGUHKyYjZree6v5hZa05cYxD3Rq/dIq6Rilg4UfFOOJjJDJPwcHQpLC
	7UNFm3lh6kS3wGDMby45XbVs8zjWVxxnJGwmdOLYBDXMfU1a9Vu5ez+42+pHR+mO
	JcWYZFMKVAy1DD8q4DWJ0rbfP9JYNUQJJFksP0TOxpZUK0ViUI3/E/kp6ajPKfP/
	bogeBQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh954gbup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 12:56:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf335549b8so34696345ad.1
        for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318566; x=1780923366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljg6QncM4kslF0r8lBAtPXwQOgZ/kk4lr+BM+tIVpFo=;
        b=We0xOMZGoKHwi/RLC5iNSx9OSIX8HL+njJGS0zLKuIvhbW58JmwFCORW6zORxUXkZX
         PDLpPT9ZPmbwvPv9iRLjKbkBIOQMEJbcumubcdI4k1Be0TipEsLNBfUYKS9mNrDxwNMu
         X4HKAMTA+eA8T9S3RfJAWODepyr5AauaJxFpqvii+pHoli1WDizb4yiku1E4wDYg+pMc
         14vkRVMPkltqjgWvQv83bpDmzTbsvJB6BPsSG+YmEoG//FBfaQop+pSjq0zxxROu2KyV
         BRJvzTC5Cs8FG1Jt3c00fi+7xsY5CvbBcsA98Q5+VYuJd6mVYO5Er5pFlwX6Texv6cNI
         d9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318566; x=1780923366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ljg6QncM4kslF0r8lBAtPXwQOgZ/kk4lr+BM+tIVpFo=;
        b=rOBBdXeqdVFfUA3P9UF/8hHke/cfWKwi1v3wVXB+fP53tx6Oicr79y/6QvuyNeq1bJ
         b84WE5er0I8wHDn9iw4f9RAqhXAk486VzSU2CyEXXtXncCu/ZaW0nEkFlPrMPH/nNitH
         +/uAHvPoYtLwNLrlvqjgZ70zaMhrFgHKm2mmeR32jtyTzp3M02Tm1yqVfTaHgk1Yqhd7
         rS/EHimvtin0EfYksm6lorgwQaf39AAxWSCOqRT6pyqknP0WaDd8NBxdw7aMV5uxdfMR
         OXk+tYb4JYeWOZSiroDKNJqG080mVej7S5ufUmKDAVyO4ns//ubDoPryvpqXNR9+o64B
         r1+w==
X-Forwarded-Encrypted: i=1; AFNElJ9SuZl24HVFn9yj+4VwX2wBPN8ZanhF1Bb/nsBX+2QO+xipijb8JB+wHJ31vX1kkmpCzHHe7elfUY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjY6YuNHgWnKgWf9PIgDBl8hqlojz5zdRzA++4xGcUO2l7U8O
	csKIb1236jJpgmD9hI1dKBUHGsuNeLALZHBcN0fL/VjY5FW01fWQ5MxiU3mgBaNhimVKFbJ5GGT
	dOvABZmoTBOQjag863S6u1QuQ/gjmCEz7B0LwNwck4Sz3ej8Mroblq15MZFE2V3A=
X-Gm-Gg: Acq92OEnD1RvGz4HjD4UpDT9EVCHTtn/12QPgXalaljojHo8Eg8qL5BbC5ubL9FJ6iX
	GkU7O+bYxZsNuEDFSNnpgzmLwciPjVB0vmQ8ng1PlFNGwbTzuaZofplBqNQzlr2D1BiqZXRuaO5
	r+vPlE3SzH1d3IXXr60Jxf/BcQvy1u+5rdL2bnGvzN64ZgvjdcAARR/LlV3eVCrrv3VcUmpAaHV
	J1/Ln/Ne/c1ej2fGCqQQR8sHFKmUqVetPZ3m97MRUIabKNIEgXeBT9RT/TlAtE0p224IhZR5lim
	56Rg6TTT7cVYGOdngUoHs2W0LGYkxS9vsDvbNRjHqbjohOcOrs2r6iB1UCHhIvktGP9fBtUr9+g
	Vz/5On9CpO0bEtFMeTVKCZgxoXg0oWQwmopM3KpXFEEbPLO8=
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2bf36803dccmr130195415ad.24.1780318566191;
        Mon, 01 Jun 2026 05:56:06 -0700 (PDT)
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2bf36803dccmr130194895ad.24.1780318565635;
        Mon, 01 Jun 2026 05:56:05 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:56:05 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:11 +0530
Subject: [PATCH v3 09/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-shikra-dt-m1-v3-9-0fe3f8d9ec48@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=6253;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ygYH80VGTldZTm+qIdOLxhatW9DjYu2Ft5s94EWNAAk=;
 b=ILR63sSazSBm6gk4qW0Jxbl+jidOAVc+MJEHK4/v0zJY2ow7dqG8vVhMkQdQgibps4FAoa6Pd
 8b9yrbjcDrXClg0nsX6VB2Kg8XcO6JXe3dPD765ZgstJobiJJwpl69o
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: 5F-uyJiPBtESz-EHMMRNeP2e0QuWcpMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfX9Iox+NKPJry3
 UpeH7FKNtsEHhPXw3NaNkT+hamuD7qVlUR6TSlVkZrRBq1uGHHH0w0TN11QlUMmPwsjP9SnEFf2
 SD2hFnk+O42yPRcNYhNolvKijMl/AfD23wwfKxQlxAQkajCgACGvX/RIepDviESqZu+wtfSdMSa
 LBc3BY23nqK3bTtYexhVmHT6MxVisV51O0bT9T75kQWnRhTlNhvalIXOIzNIrPeIhNAQz4IYk0A
 2eWkLD78PCBMo4iAspxMYrtGModMzDL/ZLNB8s65dPap1PDE40xFueT6vwr5gFQfUv8OzRH/oh6
 ho0z86TK/CN7t8AfKpnPevbGKwc/jep0Oh60INiwgjRZD7jnoJBIbxKZwbtNxvJ54sRgnhlDgmJ
 4H5GGomKcsliRSQNfplM4q1DZSkGu95xU6ma+GvJjvKWNLPVBKyWxb1bgipRVcjISKuqA6xPhyF
 G8WacVj8dsbhi1BAYfQ==
X-Proofpoint-GUID: 5F-uyJiPBtESz-EHMMRNeP2e0QuWcpMH
X-Authority-Analysis: v=2.4 cv=VpcTxe2n c=1 sm=1 tr=0 ts=6a1d8167 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RA8m1HTphegElRrk3pgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010129
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
	TAGGED_FROM(0.00)[bounces-11103-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,45f0000:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,1c40000:email,0.67.78.120:email];
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
X-Rspamd-Queue-Id: 73CD661FBE5
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


