Return-Path: <dmaengine+bounces-11055-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG0sBx0tG2qU/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11055-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:31:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B5611E7F
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8671530D1424
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546C3C3C08;
	Sat, 30 May 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SsngdvJU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTdAS+1c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D503BE175
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165699; cv=none; b=LXsBFt6BK+YUxZacWfelrMzVjz+tqe1bDvPvBMNONZ4Hi8r7OuCjvO7v499irEAJFh+fufCwX9VUwYoI1tnDNa1ju+VcMUwrDCdAYaGT1kJCRrH20cWe0R35iZWacLp7OMknFeBr0kA7m6yVfC4hHwYMGLGJlIkcTndKD5wmXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165699; c=relaxed/simple;
	bh=86lPrtRRC68324GBhKs+vwQEKBOkSk9+14YWGTO4z3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiJOz3P4ZoNnctE2Nurv/Gd5WA8SFXJW9hVr4fl1vhKB+dyrI19HEPhxieWS5h0eHkGA8dvrODnh4tiSmZcTBwrwAMDUBaFwtZdV0k1MCvId7eyZF8Fw0odvZRtLxAt2NuL3Vs5yuq/WnG1LKk4Jx75FcodjlHQZdNs6nqFpR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SsngdvJU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aTdAS+1c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOSnn3468237
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Slub8Pw8ysKXpaiVe5IGzxnoE2Fy4UyZFu5zqxaUWts=; b=SsngdvJUz7ydfAD0
	fM5nBpaqxUwA7mWqPgNRIeTBcAauuu6NrQ3CNViRTJowweR6n86ALMW8yQTPEdeN
	yaSPz/bGmxrKygplb+eWO+RuyJbi2tQllqSwkpG8n6cK9D42ZZgTJ9cqWEsghOZi
	cr2qD9IhxIQFD411bmNfQhaUkWTsCCeyAOfm0bx5QKu2W10B2htuKT39o/JQ+nDu
	lK0yEdyQXN5dSY0dzz0gctFv6+2UCPHMCNRcyCS4depfzBoPwIn+4d0nFPN7eN3g
	GFCEVTnPfnQqGcziVGXiuE9cVGOlZEEsNkyg3d3y/XzouS3Dic0YB1T2RgrdPljk
	tE1nGA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr989n2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c20f7581so964855ad.0
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165696; x=1780770496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Slub8Pw8ysKXpaiVe5IGzxnoE2Fy4UyZFu5zqxaUWts=;
        b=aTdAS+1ciq+utM0k0Mrpg8MLuuqSkV495Z1OOlteG/lPjiUH8dRXE5ziWe/FM0Flgv
         vG8QnccoFxuI1axJ4QbXt66I8PHeuNN9m+j1aLZwSckKOxVSIQ7LE1iQ7pNB1XPC/OkI
         Dbcg/Hdx95MocjYedunGhR68/PuvA+fQjinYem6rPUBbLbpqwNjea9MhQfeCxowYsZJv
         nlmUKoyO0bhE2gZb3Ba4GO+0P15ANGcopP1/vlD310IXtgoDftBFL4OPAZVBpDe4Ptyr
         cdc3SqMJAfeLabnfNpTFM32dLAdbp/7/ABPvhI1fY7MqLvzxzNB/aVxlPjkmT879kqeP
         14Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165696; x=1780770496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Slub8Pw8ysKXpaiVe5IGzxnoE2Fy4UyZFu5zqxaUWts=;
        b=hfts/Z4/s1m7c1odGXOgbTTFlDv2sGWJS/bGyr23EI+jUoBUgKBT3t0DsTi4zTiEvl
         o07fAUQuHi75Umzmi+1BE5m1Dpqf3BB24KOX2X0JJUp1NGp6GdsxEbFiVHL9PD+l9GWO
         3ylvF9FfbILjkFIBeACBBip5ReVTdB10VjAQA/Phr8RMTNjNZ+CezuAs+1MSV/IMhGms
         0ldxsYbPpJQoAgfr2mj7PdyPAyih+ATmxbAwCYBt8u/SOkHjMuerWHdJ9nvKpmr0Z+2O
         qOkc5OMCq2mmrKe4UccWeT7FaycsaLORp/aAJuZYxtR78U1kUZAsbas/5Og8xdTb6LoX
         2MEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pF74NS+lMxPZ44Ahiv/s0E4NN6IBsZt9Fom7vvyc92H/zHOEqY8GJiT3ppooRcPXUtEJDlYSteaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuxSoU9oCejCBloIKsqiIrQCowwJrWtzdveJM7pGTE8z9rDDN
	C9ZeS64znOP6iflbCV/OYjG4gqmYqMxqJ3jZexoXG3qO7OghAi6KuZqhOgnnkvqnZqglR47r5wO
	9ngxyeUWrBKAlr7uLMZgm0LeB8Z0KamdDYHhLFh4EWHQbJWVEb/vGd3Q1rM9qqRcZJiV1wKE=
X-Gm-Gg: Acq92OFQVqP0m59OVeKdPymZnLi+rCvBqfS3hHc+jIOTkX7F5kaoiRV2toD1SwIE+Eq
	JO1/D9Xxu1Ivk4SSPGMb8ft5hFQsc5yF32nBtcEI1MJLQgMi8iQO/LFqzbWKrc9kNT4ko8cjQa0
	bxYzXSro+o35iQ58lhwjxV1Q6jeIt8N4WRAehbcINbiKWLjj3Pd7RDbX07PzsanBq2A9MT0upX0
	AZUtQq85t1rd7SZ2NOxSYxJUprLGNDB+1lcwrfPdWne9DWlZZ76e/NAIyGkZkLbSA7KB9sbQFGt
	cjrGfYXv3HCp1P9LoLA34dVd/T9W5IMn/lAMdKMVcjoig7laCYPJCnl8J/eYZHHZCTrFhGBjWG9
	ux/7Ju8OY4cfT8ftC06XaUFhjYm+ORLDMP0fSAy7aL+7ldjA=
X-Received: by 2002:a17:903:380b:b0:2b7:a350:463f with SMTP id d9443c01a7336-2bf367c0cbdmr56458795ad.10.1780165696481;
        Sat, 30 May 2026 11:28:16 -0700 (PDT)
X-Received: by 2002:a17:903:380b:b0:2b7:a350:463f with SMTP id d9443c01a7336-2bf367c0cbdmr56458525ad.10.1780165695991;
        Sat, 30 May 2026 11:28:15 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:15 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:22 +0530
Subject: [PATCH v2 04/10] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-4-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=tn3IGq8WrOemms6NfQb1GjtMbRgBWAwqXyYL+aik15Q=;
 b=KsffD1NMjNJfuDmwtCqOrxLoLEA9krJDSCScwkD28ixyYV0gfrudV7WNjFiOGxkxL+DDmgD+a
 xlJSI5X8tsUBpwVQnBbRlIpYJFp6ZAjZkMiBXd9v20ksc+HyAH0YVZi
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1b2c41 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: nVTkoM3zGAV4FOPztiMJPAFw17osVktc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX310nlJL8PrmV
 AUeZmH1Y/LztjBMDyAeH5J1FysvcsPNTza6JdTCe9CuDq1Ia8r6Obn+HxoXQ4e1ONtypQB21d0o
 OoIiKes1unF/8q88C+J5SGpMCHH3EzlLvl2szmoEjbkDgQ/3BAkJmbeApvgDODxe+cc28lX6xB4
 KGKB+DV8BpvE4nuRdkTD/JnYYcWWIp91ShogWMMWIUTPqVk3rbm/ZQ2uBa7npOkrCzPPhkuCdPj
 NhN+exUkUn8L/FS4oE8v8+m2SRvdBDVVQE7h2RGJC8fWRERNbKLNS4D30VEIYxSMP+a7n5pq3MJ
 0GgZCUW6FJtEilH7bTdOLufl6sn1JT6TIBFUi3hN5d3xKUsNQ4SxW8NwDU2n+NIYwoZKEccFPhl
 5EEeAVX1Ekifq6L3QKFEqjK40Gh7UuqEw9aPifBW/l4qnbTSP969+8oQOfkWD22JC8pCRuWWIjT
 wbGcovXxS0uFqYQnISQ==
X-Proofpoint-ORIG-GUID: nVTkoM3zGAV4FOPztiMJPAFw17osVktc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11055-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,d00000:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,c91000:email];
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
X-Rspamd-Queue-Id: 940B5611E7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2751b4f89678..3cdabe718714 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
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


