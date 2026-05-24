Return-Path: <dmaengine+bounces-10787-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM2HOKBWE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10787-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A52885C3E96
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04AB0301F783
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956A3321F2D;
	Sun, 24 May 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glf0BYMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJDpg5m8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDC31E845
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652198; cv=none; b=j5wH1E6muN5BhIT0ELs6oJ/cqlrnjpFcgeJAdM+nC2CHV8AdeLsKTNLzSiDbHE6BO+LqJhet2f0bbRPuYqw3FER+Vwozh4Jmd6LSSipAJpPAbjOeOxVVIwlhq36Tqv80oOUTuKUjLxEaOfUcgD+z8Yt5s/vejCg+cMk5O5/ch6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652198; c=relaxed/simple;
	bh=7rayGBQKh6NbUwuE5mW9yTPwMZ0wU3HJLg8mP5slUH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Msih4gZ0cg01dlcMVkBXy6rDSaYyAXpNix9+yxvlY6TtLIVQ0vqic/Adl9D6cSjdtfNLZbQI7IxnlGtYQFkJGwDZVQSdS3Ds4mXdUCZ9FxAsd8icsoHutx7QToqpiWB5WP7c+e6U4o6T56r1ZIB/6FMnmSKGif87p/yy3S27uBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glf0BYMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJDpg5m8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O6kMaI206656
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GlVMdI6iWsrQK+09Of+sgMv2sIv/9UulNUsp0d4OMkw=; b=glf0BYMtq/oMsEjD
	981NUAmbsihLePMvg+5vVK9/0oV8vQt29zeJl24xSNtHTtd02bfGxdUXS9tOz+dO
	fAARqem+/u2dZ2QNYoFWx5ExLgqeldRLfqKMnDYroOg7QKBBJgY8mNMRiPHqpYti
	WIPLOIPqU//ju7E/cLattUyQ0B587PGg/6ytPqMhQBfgguoNoVIri5OZ+gtsdZGb
	D0dX+P/PUilA6xpGfdkfUAOOjmIumDufemkHUOrD9BgIUA2imeqibB8uTHPeq145
	PzDFUHF/APgLlz5ocOwpHabfMgOQvt/TIoDtf8q6VHDJUfoZ7fHI5GBIODZ+gLTA
	Owa+oA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7kus9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso17006311a91.1
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652195; x=1780256995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlVMdI6iWsrQK+09Of+sgMv2sIv/9UulNUsp0d4OMkw=;
        b=VJDpg5m8qySDLAoy3y9P55LCXtAZt1T9NKN7rcFsB+IRdi0dF9jtmnkI2c1kJ1O2SH
         RBP/b6JtHcRJjWeB8ffDF37B3jHSboVOuCXwBPluuaYHsIFSbVjOeq6ykHlxCeZVUSt6
         LMb6tgilQkAHoeWbC3W1vP4rw/lGZdAbGYPmM8ckclSgKyCB8MSukdMDM+9UfsVgxTnG
         XQENxZF9cRqRDHbEpc46a5Y9jEHNBkkpvCGX5hTHOhPYBazltVvpc1C8LdjszjWre7J2
         dwmRQCtnkeONa3m1wxlSrIlVnT5JDqzBvUjayPvXKq3aI3Z75Ij5bqxoPitLt7/lBLkt
         aRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652195; x=1780256995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GlVMdI6iWsrQK+09Of+sgMv2sIv/9UulNUsp0d4OMkw=;
        b=l6II+qrtNPTv07yUaJXVuWE7MziA7w+GUX/zSrVEXO5E+AE/ICBVo3nZRQ9PAxdBmj
         jDZK5dust8bc07cc59jekRkoP9XWqVkVuQtvcO9o19ZRFSLdrynOUwzB7ELprSUABQhG
         X8/jQuWCP876K7idEKEgUcN3UscJgAf7jA/QQuxGz2a+/8FK689weBsQMXtX5Fu9cfTc
         2465PQYGw7zYG5fVxTfFztDCQW2lxliBufD8o/tn5uxu3q2WPy8nu6lor4ZzRgkLgTCP
         QpSShJ2tmfGH7QjUjkuLyQv81vLFs3CZgOorJ9RyEUIt2udkZ95wHvkrD9hJ16Gn1OkO
         +4Zg==
X-Forwarded-Encrypted: i=1; AFNElJ+kznSj0gA0COWuR0L+XkbbCrzPFQ6mSlSt60EoNq9aO+2I51P0l4tc92ZjcE7sQT8XdtHSsz1++DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsVgOBIApZtFoTt8ITLW31PdRs2BIbC1AObcbD6fh5Zed6TQU
	hzVF/NlQKPDCLeqKzz6Evu/uKasaYkn0plLOmrfPPimIZgM5Wdml3uBTxMFAZH7FVYpkOI5Mvl9
	hOONAuEEFBMlT/j0eP7GTyhstbeDoUQJ20kM2aFexEuW3N3UnNaoNNl40Y2SiGrM=
X-Gm-Gg: Acq92OHEjpo0UbyRSXqlquzWVF/kBHGRGZdoXD35HZnEiPAVM2FR+rzkJ8RJ9SSoAKg
	DV7ZxfSYx3Ohp5SXCnl2OJ9sbbMjN51biNE0zEUIGsoHRIA8o+b8744WAM+V5TkU4gK/5iHIqmq
	CNLGtMq3FhbbmgxddXz0wP8e7f7l0qsH342cwQFn7tjbsxf0f3265/OHuJw+/dVLzoHBV9B+BZb
	mnwkh2Jre3FGG0+oTZJT4KKVpfEyqZUu5tnwka1yRwfJuI5n24Oay9HPnIaSrAenvBMftorapOd
	Y4FMGnATrFOKSefZx+MkoOiERVvZ/gSJ/UvtLxkUkIT6bgSrUcmR3PaIQD7AtJ9eCwhp2zZHDXy
	HXTZwnvTva+jTY942WtfUtC769NxGUa8Zemym
X-Received: by 2002:a17:90b:3f8b:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-36a67454586mr11597148a91.12.1779652194874;
        Sun, 24 May 2026 12:49:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8b:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-36a67454586mr11597136a91.12.1779652194341;
        Sun, 24 May 2026 12:49:54 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:53 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:09 +0530
Subject: [PATCH 05/16] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1702;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SxVgOdo9GtFzDEX1P8cyQC8v0IJByE8HPx0wGhmlVfQ=;
 b=4BIAOkrGoNLKhsxYF2SHCN/F2zjMSvgbkxJBxuVCp9VKMpXHKRuJevKKshH3Xit7SoxPsxq7v
 rbkj/2o9pmSD7a1yur3icDAevKhy2fgKPO8cog45qT2gWAyHt8iptBk
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: xbYmVln7vunvibO1MTet6735BjjuNa0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX61ohdU7C67/W
 ha9rQyz5MekWWq++JItr5SCVd0FXRohkz4sTFgyYx7OwAVQ/R7sy8LXtedIEHPjp9gWs88YoLqy
 KIfdk2qz/+khW7kpsLd6Et5MxAzqejmhIFdov0UbMqvr/TOFzXaeBgIUCxPOp1aCGexBDynXzo6
 ZxdhPKehBFTTVqpUqNbbnxKGMmtOXKPuIp4YPHZsEJvZOklZGXCb+ys7uuwmkbKxgIqpJ7vV1td
 tyYbQXAEECZo1uAsbQebODE0jE8B+GyoC3CWE2P/cYOvDoQQYaFRtGHOV/bAuVVuui3AVItWVr0
 g4rxUXGlaDNvRF4vjiN7WIgS3GvADDjZ4opK8hecbDqI6IZD2tBUGBurMtt4t7ZYx1f/YlyBLKU
 2I+et5YhKJdHG1hjbc2kGEc7U8U+Ac7h23ofb/8x2bZ/EpzgN/V2rmEUsFRDA5MPeBCO1H0VkeI
 BuRDUOdmPO8Y8K3QDvw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a135663 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: xbYmVln7vunvibO1MTet6735BjjuNa0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
	TAGGED_FROM(0.00)[bounces-10787-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,c91000:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: A52885C3E96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 35ab7072e20a..238772f064ec 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -673,6 +673,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1


