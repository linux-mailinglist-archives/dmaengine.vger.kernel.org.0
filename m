Return-Path: <dmaengine+bounces-10788-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC+kCa1WE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10788-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:51:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA65C3EAC
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C916830221D3
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6831E845;
	Sun, 24 May 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rw7hzJkA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcSPSDBT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625C31E827
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652203; cv=none; b=esSMBRwrEkAiM2PqBq7aXxdn1BHGMr8M545alBHXkWx/s/Qsqpp6SgA3+lrO2aXpvgVnTmd7exACZ/X6qTbq3HtvMtejTESg42dPL9mkULBMcl/m+z4pSFCaNxz0vebt0hqtlBXxBlhfwXJ5MfWIWkswT9KAuasFRFK06CHrDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652203; c=relaxed/simple;
	bh=b+23ZjD20/zfX0Wk+Yhgv7IVAfpuYgIBSYXxov+Xe7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IckqOhYSN4WKUJb8RdMsz/uib4VERFtY2LvKSsGBsJJ3mnDF2RyO8FMaDueYX5L7m3NM1yfmk1BTOZmTSdYG/QUi662CsqBxb854edCebDSf86hgiOVtpxiq2mI3Cpu5Cj60b4csDXL4h7lspfBrDDvuXfUu8yNyAxYHOzbxo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rw7hzJkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcSPSDBT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OBQveZ584331
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RkUFsf2T+/cstUtuISGHLPa0b3uwoUOPZw+kpwQll2A=; b=Rw7hzJkAEPEUy1tG
	5GBH/nuXt5PRCUWKSkbGZwnj+UwCxiwjRkmdzMEQQNvKIELLpY2PG7vc6+CxLwyX
	Nt5TUD44KIxHjt6lnguoW7dhHFLUgGNUQzkj/Bl4cDYP9tQ0vJBpAMC2ChWmJMkO
	/+RlxFXp7iCuEqjACFgk2nB1vRLrn+dfpkxtvZBoVH/lb+dmqFaxC36/8sqsBKFK
	zwvcoTtHtRKAOjsB9jh++Uqwz+xwCYHE0aVXz1p/smo2xad5hOfi0iVWmDmrjIMg
	QAD7yh6aVIdBo0/GXLpaZ91UOLj2t8tqlHviPPd6lyaA2VtnSPToKyb25bjGRJtM
	aeq2UQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0u48c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-366015bca9bso7295015a91.1
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652200; x=1780257000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkUFsf2T+/cstUtuISGHLPa0b3uwoUOPZw+kpwQll2A=;
        b=dcSPSDBTdtmnFc06tsPwDBfzJS/gk4fK+l5ffY+3IxP9ZNyRfenHU4r6vNn9ZDlPT/
         5mmPtOuZAnu6R7aWgnHYbxO5jSjZvuak0eRhiicK0DdqAchosAODRthrRImz8l9F3EHz
         NeqmbL94yaap778pWPbeHuJb3XwbnDvRcXYJMEg0Za4pDNgz4KP11UfXLSp2Bp7MGVN+
         3kwWLyvHMCcoAQDDpLEuKccYycg07wWwFYsWj9QhdtiQ/JuabqKra0PF0BVSLPgbDTGt
         uhADoLlD4PXhP4OUzBkVvAOwwUoJW9ZHUKXqBIQ2Cagd6ok9MWPb90ngWPOiIYuk3Bzw
         XE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652200; x=1780257000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RkUFsf2T+/cstUtuISGHLPa0b3uwoUOPZw+kpwQll2A=;
        b=knmlxLnCe1TuyC/5RHqhIsVQoYk2J+i+Ok0SAtHGYZZN9y4vaT4vOSCY8vdqZI8PU3
         jIPiKuR3CAxK5D9j1X9id94nEyafeVGbbn7CwOwIu+qKZyzRXAVpbgakpBQNUHG2/QJl
         ggGEMfoBSmAk99CYgFNkq9OGGLOsIBSntOCVHDhr4cqoMBT+TS1K6XcIble+f5uKD9IL
         LKeRQNNOiLLDEv5d53/yQV8gijcMIcwneN739wuJE0QV7ACPLZsZ8H2sm9/AToQeyA1d
         pm3hgCszlNZnS7D8VGUcgDkEWS0Qhh+aAJMhuStxztp90jFYEFtL7f/e3OUxGL9G05FK
         59Rw==
X-Forwarded-Encrypted: i=1; AFNElJ8SW3hsGl20zhY1xybRl4SPH/66Orzx0aE2eMrt7UUt6h3bWSxn3h5S6UOz+VHqV8lIfkyT1HeQO1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xxo49Zq9H5YJa8rQqxSbI4oyUdKQMQl/jQe6uw/mEaHtLi74
	iGGZbeL6SzKyDy/j2GZD/nYECjqpiQmBDB8IvZzraF1/uiKEzyoXhQS3QGVErOC7KhFyX224pcG
	87OmUEQTBwxxeMHfbw5I9VrVHim6EkiJ4FyPT/eFSk60Zd31OExxiuMuOMkhygZI=
X-Gm-Gg: Acq92OHHHusPAYtVROvZPLB1iK/7ovQThm9e0S3R2/LLIKzH27heeVmx1KtC7jW6Jo1
	4GL8+rrf3GoJFICP8gXHvEx4js2iAXaVg90O6GcBHkeDpDYJ9bKioONtlh3f+LRSFOa+sfN8Uj7
	skpvoarKHwKnWQ5nsVlM554OIPTF1ZJg++6mBYo7JcFy7OjBDMKWaOOZik7vtM34zq4LPliAh60
	zAMltiRCv0ZJLAiaeyTCQOb12WyjtFzvtddMuJhawAgLnivFeVtGgj/Wk8P3FHGmON0ZnYHctI6
	jvhvZW8vQA/tSJx/Y2AZ3ZBtZjpjF1r0+ByoNQ2RS/RMsxKwOa9UwbB57mYGhn4HO1D7BS/FjME
	75DFOcQKcp8/wOwYMYeV3mA45OMPSnjF84Dtp
X-Received: by 2002:a17:90b:2712:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36a6c79dd38mr8744323a91.12.1779652200266;
        Sun, 24 May 2026 12:50:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2712:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36a6c79dd38mr8744310a91.12.1779652199671;
        Sun, 24 May 2026 12:49:59 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:59 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:10 +0530
Subject: [PATCH 06/16] arm64: dts: qcom: shikra: Add EPSS L3 interconnect
 provider node
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-6-f51a9838dbaa@oss.qualcomm.com>
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
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1320;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=dEWvwbcLQmzuI3XkSrEr3+ecYdNDbFw8synh+n3gH5Q=;
 b=9PueDrgoyTVBdXUt5RaCvm7z8DQPhu0eSbiw0BzW9l3UlKlj1VJul4jhUyK7CXS70IZ/zq2m7
 +cjS+ypBh4dBbJdF/6n/SIgI6JQTHZi8atbMSrhPZwCf3aBYW6Oxneh
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: A_59v4F55hGqvOoM-6P1czBxK0i999ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXwK+p4FAm/558
 j1nX8Jd+3/xztSJbPxF84hRDaCnn6tEHpl4zIb2TF/bFss+r6PgDeNxN4dhWF9hbrxhy0hf+b2m
 A89dk9H///MilUe0uUpxIcWshjCbtW4MhO/zIdsm8GeU4sbY2OZ48sDoAZuhg/gsjQGFpuiVqkS
 4sSlr4oKnvwAWg+Frcpmfwn8DfqCG+nmXOBPQls9/+ao+FsTtl6xsZciyqgnTWxi6KQOWJBi3PU
 ob5Sw/opQAYg/LDq4arIr4sRWVbwxtiECfk5EyIAhpsgd3rim/r3a2yqdWRg+5e6Bg0HKiRjgbv
 hEHm4smP9d1wL/m+mTFVP8of0yEC1DSmhZxV5XFa/+W5qpTVsOJyC33tMgg9kcD5GsgDu+J3ky3
 v8soPyF1RNghiUcUAMLNrskeNca3Uk4cFr/72YMY7tAViMJTBzP1dWrHuTu2DA/kcHjGVyptzs8
 9IhH76MQxIf1Vh/51og==
X-Proofpoint-GUID: A_59v4F55hGqvOoM-6P1czBxK0i999ul
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a135669 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=V_Xbm4hklSwhDaoQdiQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198
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
	TAGGED_FROM(0.00)[bounces-10788-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,fd90000:email,fd91000:email,f42d000:email];
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
X-Rspamd-Queue-Id: A7CA65C3EAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

Add Epoch Subsystem (EPSS) L3 interconnect provider node for Shikra SoC.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 238772f064ec..ebdb4bc15d76 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,shikra-gcc.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/interconnect/qcom,shikra.h>
@@ -1833,6 +1834,14 @@ frame@f42d000 {
 			};
 		};
 
+		epss_l3: interconnect@fd90000 {
+			compatible = "qcom,shikra-epss-l3";
+			reg = <0x0 0x0fd90000 0x0 0x1000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@fd91000 {
 			compatible = "qcom,shikra-epss";
 			reg = <0x0 0x0fd91000 0x0 0x1000>,

-- 
2.34.1


