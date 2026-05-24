Return-Path: <dmaengine+bounces-10786-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAgcMrNXE2qA+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10786-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:55:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4E5C4006
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C3A6304CA67
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609531A56C;
	Sun, 24 May 2026 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f11KwDAH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLzv2EHr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797C30E0F5
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652192; cv=none; b=m7iIwevGLeAmjVVKK0wLUPgcwFx7VW3+rCCJwMN4KkWDj0kCGZKsWa5n0dAruudfEvK15b0d0gvViBMxNxIwVgbyzi+BqLnk5usi8o/sBgwKhq+3bEooF4x7T70YxAKqrWTQQNkhrtNm+C8jd1F5guRAdyKHA+LLqmXI7ZJHM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652192; c=relaxed/simple;
	bh=BIGk9NUVoNDrOtt6d4N1Uq4IdfPUi7mT/rywQ2ssYKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fclWz/0UdIJrHAml6Em61tHvX4JQCIf0/fGjW3FD643luNVI0zpWKUMCrs+y5vwZRk/OMZ//kiH7WEEUTcCZYUBNOPkMeS0PsoMl2nCvxSEVnVnnmE90LaxyFJ1gVFuq6vzajxxEJeK2FUYcuRvyJgCpotaSW8iIct4issHTfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f11KwDAH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DLzv2EHr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OHkSTa1350437
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dn3fvC+mkNY1uNxo3o5q69xFB3+G2i+dm6Pos/3JyeU=; b=f11KwDAHJGu31tiS
	Kz8lwsS4BECL1KzQ55FgxdQ8k7m0zLCLf4XOcX3MMb8fQB8mNZirDkOvzAt5k3vY
	UGWbwn/v1ENp/5ZhRDEbElW4VxOnCoAS5y+hemT3XV0x9Z+gdUHbbYvBYnbXTk8U
	JlP7y3dv0yVzNQheJtJB8/qXtPsjrl65iRde+lHV+lAGkbGtMR6tA7HTC3VlcTwl
	DfQxmZXiPfunsiV4hMgh2rerqlkVlLd0MEg/lr2/l63Xq2wRWnP7tyKELiA5Y6Gv
	CowxyRcjq+Y0Sd+X3r6As/FdcNx0vODWxItItFiHUUlurB5TrjE4nFy5FuO80/JA
	g+G6Pw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgv0kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso9237433a91.1
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652189; x=1780256989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn3fvC+mkNY1uNxo3o5q69xFB3+G2i+dm6Pos/3JyeU=;
        b=DLzv2EHrmi9vfs+pNxxCCbSJs/VLnAXD5pVPeylO+nUrF0cFnhc265uc9sQUjiMNIY
         5Ej1CQ9nRqdXUREWlQUSFegIHt+oHQXLmwM+81DYdE0mJYIpd9lfKOgpM67Kovnp/D3h
         yGYG3+uTJF5xWFKvAkJJmBjMYJvK2rxmyMk1ybRoVgMU/m2Y0gOhWVqwLHIBwkwy5XU3
         u2jAKqYdBYT+2j6+4Be4kr+2MdlGQIs8wRtgi+C81rIxSE8mfg17Uc9Re6RudoMVUGw2
         uJYjrywxetBFkW7oGaq4MZ36tVU36eDkqk2iWqatJVfH6U8f47A8+yDLglk73AWjJWyw
         D1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652189; x=1780256989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dn3fvC+mkNY1uNxo3o5q69xFB3+G2i+dm6Pos/3JyeU=;
        b=IL5wydjIeFiCAqNVUTlIZ06UpfmtjUhlP8mpkgtsPtC3YFma6xGEYK/UcxnGmnor/O
         d/1XO3HYC6k/3UTJmrkFJZhVflA1HL/xyAL/mrDY/GyF2lAhaOINJPl1R87jO5ia+UtA
         em+4Cz2IYzlLhBdgXiyJQkVEAscVXs9f13PvAjWBbAX569HNSAD9+l14JVqCnitdNTHW
         aHTmpd+jWeYF42bsUHb2aZJ/keo3xu4DAqCgEVYoCpqwkr1bayu5tFkXSdHB6i7m1WJB
         AMARD8U10tzoDfBeBnPMTsYBw1sdyvXBOZqi9qGBi2z4QhIHQn72N8T+DQYoarwyYe2c
         H08w==
X-Forwarded-Encrypted: i=1; AFNElJ/IGubU456fx/JSvo08G4KHQIVk54jeYdEqY1lbCsqpGZbhVJMIj1g9gKjHFsCCwKMD6IQY3g8v5jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMnBOEF9m7RTvtOt7S+lXuZAAsdUWmJmTZtfNlGFn1MAPlohH
	Y8TUseeG8V3csZdDKPhiGPBZOgJChr9leJkTb/wd9OneLJUokQl4hTNgsycDm0Ab0gKKgsOYzaL
	OWYr9Y2jR7fnI+ATaZZf/UPi5lnQlYIW09TnwH2PNj4rIzsdvnjtNvViGmuZ1ttA=
X-Gm-Gg: Acq92OHDiAPdGzt69tvSJA7gRQxrN4DLOqTt9KZHZTC6mj95DQprK4c5jFOAp0Imyzy
	TNQk0MXWMqd0DLamGG3CuMLVcacUOkTJfOmXZ3RcDKagI/UShpAIUix7+i5YmOnm7lOM+2b1tPJ
	7Ewf6gMgzeOejBuLSFUBr60xTC6hhvc4+FFCATjBbmkDZgGe8gkEiDvrXA0bRRnpfoPeZ+xQ0nW
	8+uXFdV47TFT8jYDjmRkwucee6PquJPa/cn8+hV4rkSWpyga/pnpWj6TinVrdAz/IJsLRMVxfAt
	U3DmOwmvqv66FSYQ3DgsRLDgmrXC6lKDszOgcIIJ8lBNJkgOkifa2QP9D88NGKTc1lLqL+sycxN
	7ZpjybnoGlAh12nFEruWHgP0VZLglMippZL2F
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id 98e67ed59e1d1-36a473cf321mr13318567a91.3.1779652188961;
        Sun, 24 May 2026 12:49:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id 98e67ed59e1d1-36a473cf321mr13318546a91.3.1779652188436;
        Sun, 24 May 2026 12:49:48 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:48 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:08 +0530
Subject: [PATCH 04/16] arm64: dts: qcom: shikra: Add cpufreq scaling node
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=2418;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=x7oSC/QDcnnpqyvWDCndMCwGFZzXKEB/9qcjR+Qs73g=;
 b=HxZsJ/jHJslnVtlepsro7vs9WMcGY5uPTKgq44vIO85LdheKILFcNryAySnY0r2+UCs/LiR1c
 s7sw0PW3rBOCD9AeBLh0vzGROv8XydUBSXVMDKjw8OJyiXlg2UnNVpz
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: o1WJI81tPjyAD8inFnBVxEyaQvUxqtRk
X-Proofpoint-ORIG-GUID: o1WJI81tPjyAD8inFnBVxEyaQvUxqtRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX2ncXqSnNTKhT
 FwUrR9S8mrt4gfGJZaiQEljWey4f+ahgJm2/fvDuykbdAJkBkdiELQ4ceGpX6uRXpFJI2wEujSh
 jyzbbxNoQOJVZTijZEVaw7kgsUAA/ZyS7RYQryDO7vbADX3vxqSF+eSdvn+csjOjjcbfCg+sI0n
 seX1+av+oPuxR1G43WPIGcc/cKLk/GlCl6NBnwGJnOM1N8X+PaP6RbDA8yXe0LyExBvRucQ0HJB
 n3IMPGk63oWfsFztcxW6sbIWbKrvR5gQq3AQoLdYqRkjKtXf3mWP+RN+xwrtZT4y4IQfPypItGL
 6QlBIYz9x0oSudpsWeLupisGEZSyprwTect2pNLWlBENH2v/xcprPoTQxVwW/srPBuMb8StXIgM
 x0Gd5P6/ZVkgF5O0CgkRfQpGzYWftp+lwGGBBh5JFNp2qv4mZchOSBOP0XeLqCHh7dBkwSOUfrZ
 RnG2dpGXFKhhOxKAHrg==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13565e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sEM7OkBMBn96DhIRBF8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
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
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-10786-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fd91000:email,qualcomm.com:email,qualcomm.com:dkim,0.0.0.200:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,f42d000:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.100:email,0.0.0.0:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26F4E5C4006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Imran Shaik <imran.shaik@oss.qualcomm.com>

Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.

Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2751b4f89678..35ab7072e20a 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -44,6 +44,9 @@ cpu0: cpu@0 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -54,6 +57,9 @@ cpu1: cpu@100 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -64,6 +70,9 @@ cpu2: cpu@200 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -74,6 +83,9 @@ cpu3: cpu@300 {
 			next-level-cache = <&l2_3>;
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <489>;
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 
 			l2_3: l2-cache {
 				compatible = "cache";
@@ -1780,6 +1792,25 @@ frame@f42d000 {
 				status = "disabled";
 			};
 		};
+
+		cpufreq_hw: cpufreq@fd91000 {
+			compatible = "qcom,shikra-epss";
+			reg = <0x0 0x0fd91000 0x0 0x1000>,
+			      <0x0 0x0fd92000 0x0 0x1000>;
+			reg-names = "freq-domain0",
+				    "freq-domain1";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.34.1


