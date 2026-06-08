Return-Path: <dmaengine+bounces-11327-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WulDJbnBJmpAkAIAu9opvQ
	(envelope-from <dmaengine+bounces-11327-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:20:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F97A6568F4
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:20:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PLjpSp9x;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JslgQqjD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11327-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11327-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0663031028
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8AE366049;
	Mon,  8 Jun 2026 13:11:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC705370AC8
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924265; cv=none; b=sBwnpeMFPSO/hmpzZlI877+Jb3d+Q19WgWrHp9kb2ST6821qH6nnnFcUT5fmNDj9eCq8lRK+zw0GkSjq99baU3yXHpeA/P8tEiiuCXLINtd9waEqZTa9IsYLbNEIkOU3HoNp+0HyUbCZfr5w18xbCnBLx2AgR/SXaKtSE5h+h/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924265; c=relaxed/simple;
	bh=DQT/zNqQq2aLAulWAmnNWMK9zqPYRi41u9uyToFunqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwcKWY8kXpMel7YYQpUCU08lKAY7yf73hk+tcCRt1YyaaHFpCE9Z+eTvU6X1W4emwLRa1I5BdlJ9iw+cyPcpRldvSNEFZ3aP2NQ0yEGLSlyPzElxVQjSy9LklRzSciwdxQId7MX2pzdVtC+DayQZ5qFzyHnmO93V7DkVHXiuzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLjpSp9x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JslgQqjD; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BkWgT3115570
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=; b=PLjpSp9xJ1iVcLha
	SlOxzU0r+fTsHCyl5swAYh5dVkL6iFaZ6NoZoIkbWl3MHXeANjTcE2sxDX7ZOF4d
	v3PKnHzVa2MLrarxqcNqxMDtrD/5oe0ZDdBpT7X+10G5eTzgWL84kSrNaqflDIMd
	yPGGeVtXIu6rSt1M8YlcrU+z1XINGRRoxgyA2DWUkhDH5/fWUYf4rQsDJIR06POM
	FDUhltg+qaqLLN5NFYskNya5WWIYEevE2uGhqDBQcVW0ggG2IR9waWRVJfzAUmK/
	m2lP0d17m5hjXUfxyIdPtS/enh0mS4h4OT0Hxox5ItBZg3HIC5UFGDm7Ycuie9q3
	CEtT6w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m0bcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:11:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c272e532so45641835ad.1
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924263; x=1781529063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=;
        b=JslgQqjDHl6Ovg1PmSBz2tiIfRliDYN7Y4DTMDMrBkVBtvhg0N6Eaae5RcgAq2Ra9M
         Yb+kWO717cW/huhgwSpb4VafJZK7P0/swNc56cecCw7SxtOOb5F4WajGz/F3YoZZ0Z+H
         MPbG3hPqKuR+xmWozhhFiOGoz74uoQARGTaihCzYCZJAfuAG/1tuJh5e+TbjoTP+hEoZ
         uoqe5ugyenzH5wOlApAr4T4qeD2oc/i/wqWh5Th9bb/YZ1/dtopxGUNHL4QGTYR7j2cG
         XbCkjsA2UIX87McHPVdmjiVfByqb9xnX7qyVyrjbr3F9VSaw9naxi/VayxLWWoV8pRKl
         57pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924263; x=1781529063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=;
        b=VEresDYJsPfhz2kaPbe3agIw+kT+kV7V3pSyxKzSskospnY4jpZFPf8n6p6atQjgz2
         43+KVS4D+to+DiMUml2uc8RUOOtxQdXN5nOv51yWNNVl9UTUhH9KqiGFE8gkDDV3eqHl
         P8FXcHN23B6j+dU4Ksh+e9QpStLtAB5cDBLCZjJd1ipsOrgEMsu3qtwWBVOIwpI3q6Dg
         +KwLdEOlMFxcmYZbgs/taVynGw1luayKKYN9i22xk6hQKsF6IMwFqTMHbS076yAJVNZx
         JqjsF3HvFo6QJsGw5ypAsXXWSX/kTA6E835CECSiXgoN8dIAmvpVoBgexmP5vQn2l08T
         7gJw==
X-Forwarded-Encrypted: i=1; AFNElJ+1z4MEd4vHi/RMsY3m22AVUNqkX4nU11bvDi2sPXR0CADoJWoafUstphjL1+ury8sMi0M+t4bAUlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywafIebyNAtzLcVzZzQtk9vZ1FgI6ZFgrD4HClILTvVMkv2E4n
	VpSUiIYisTq3ENfQa5s3YCEHXVXCN2gv5S5GVJWd7yBGdoiWzsNX6ZR0wFWCFfsBpfM9o6snI7q
	xM+2hHtIiV8U2tSELdXtmDMNTjS58s2HGyRE/SWDkP4+LqixcGMazIZqYO8BivS4=
X-Gm-Gg: Acq92OGjcnnlRaV3Sug8tf0FYm7foL/4rnlqIiARl/ANI5PXbt+/YW55D5qwL+TvgEq
	aRlLXlYvOYLP5Tc/RuZxayAbdXDWv70uQUG3e7b8Mzk5Z6a1j0odj1wH529EtuF7Vc4DAAYbTwL
	vx4SzKddu58FFr+OdDs52YYu1OCDbbKyZI8lYuc8OfgdT8yW3OPYH8dX1gKovkbLuPW7+vJmuP4
	ezrMJXLwNC8t8hEvJQJJ7ITOIjbcEwNI99VUlKIgv/a5qh7uxaDbjFFNXm7JacBSABPiYCRwGPY
	lcQDAmBrakbgPS+R/WneL1+TgA3syolAE8MMeF8KUlxbky7zGDnNafSM8Wwb+Bb7vPrG6SCzav3
	+n/7wfReX8EIwC3ldUBrqnZqVmARIhxET0RXzc3cVqgTdRJI=
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id d9443c01a7336-2c1e7f92548mr183184485ad.24.1780924263512;
        Mon, 08 Jun 2026 06:11:03 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id d9443c01a7336-2c1e7f92548mr183183815ad.24.1780924263007;
        Mon, 08 Jun 2026 06:11:03 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:02 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:24 +0530
Subject: [PATCH v4 04/10] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-4-2114300594a6@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=7ByKGzzDTD14i4DIQy9VognEH4x590vwDySV2Co3gPA=;
 b=nsZErkUbo/EXqASccR2ilHGqPbl/KdmXeGHwHAHGIBrjgMHzdglD4X0gd5IuKNYU/zbDE7RJ9
 FBjLaA0SeQ7BiEIweGWqNmb6hg54PGGtv7fa6AVcuinOiHZhiHZeSj9
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX5Xs+ujlOQKdE
 Cjb4btGIFrYWkOXyh0m360li6IAceIZwLtAgczrg1beTOCGyBwNTN7zTab4tPhis3wxHQsdYAlF
 jG/2q7OD2T4hYVooKdYuHXdcE2nTclj4ASPevCHrKNmq/f5tXXjb7B7lxUP8CPX2sk/fZ4fg89w
 RT13FpcJ7NeQsB9wN7bjLBkwVXy9+Lgwg+TWkvbSKTf9fz237sL1Ghjx397/tLJGIn1lwUJ/Q0U
 SpnADJAxXE8PYa3tpsggx/8Q3TaDTgslIupPKrkXbL2FezvMfNhADYkcfnZP0YGygL8cA2rJ3MW
 QO1nf3fF+FW1OvL9Rtk5RVOgBn79IAYFANxvB2ubZmh6REPqlNa8yui5rStItGysBGwr0J3bJk3
 IamMJGgQMisvNbvhW2CpQUl8Cl/vphfU8PI/QKFIDdM89i7eI1SiYEJXuKAa/5pdZaWIvhb7eDf
 4lWATPJGyzJ/0LCeFPw==
X-Proofpoint-ORIG-GUID: L_V6rR7HM38Hb8J6YWjU_lNh85MJc-jQ
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a26bf68 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: L_V6rR7HM38Hb8J6YWjU_lNh85MJc-jQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
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
	TAGGED_FROM(0.00)[bounces-11327-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 2F97A6568F4

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
index e6ec07a865f0..ec1bfebed226 100644
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


