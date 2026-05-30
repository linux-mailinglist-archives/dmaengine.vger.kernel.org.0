Return-Path: <dmaengine+bounces-11059-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMa0CJYtG2qU/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11059-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:33:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD927611FC5
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EF1E3104799
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30423C9891;
	Sat, 30 May 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHgIef0q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPRsA6js"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7F3C5526
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165721; cv=none; b=JRx7qJ8BPcUcS+wsN7pxsy0e6pasVFlKor9qFT/L3WqMkZwvyPdPMkHjmUruAqxAoMd5VoFoD29FqEHQlroFOmT9hdUuL5gw4lQMJL8IoznoN+RFWaIiq2/t0+IZn5jwy0Fvgjqd82aBZDuUODfvLj9sv1dcTGGOrH1LdE/qNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165721; c=relaxed/simple;
	bh=O0ITinEiBDoqyNtfUbyM/puvl4+BRtjPN1CGKUba4DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rF2UUCAyWPfsPWY6d1f8DNKW47prdqOyzVAxyLwUp/ybrwLLS/1Xd7ULvGSGSMNMVvDLUTR2f3lYbr5yw277W1rVoMQp1n010dtbPo7BgdXZPrIiH7A7yLb5j2t2/jFVuwCw8T3cbcLDOoqU6oWSPFMlAhGWW/ZthFDv6p5I2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHgIef0q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MPRsA6js; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOrNB3072289
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=; b=dHgIef0qJ0ao9xb2
	I8wRr9pKXlFy/pwzyoWOt0Wg8YEi3RROYYxN69szm0eEgLsYTlrnZYNla7UOOuB2
	Dv+6JywuMacAR8/jnx73/EG1SrPebVeqWg3jC4FfyYDLcpLavfly2EROb8/6sKrB
	mODw8lEhBzU1pyvQB2Nrk4cQfjka5H4jSDfqinGRIW1EdK18fHCsBnjP9yMZrFzp
	JNznWyN2AYFYE044+ME0cUe9u+4DAT0ztXoDFggYQHy6LkaWT+3Hro0JbtBKkPo6
	wwtl4BQfijbEV9Z54QLzWFF+PryWzp54vUna+GfyhOudnS1an1v+HDZrFs5yLvL+
	Yg0H4Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efn8pj9q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf0d79d41eso19969955ad.1
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165718; x=1780770518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=MPRsA6jsJwN7ezEg1C9rMUesoewPRg1kBUnKaRaSgPM9+GU+6rUafFj1M3tZXBoMfC
         58roQ/+uJBwBF88Slj7xKsiJOvkJdyILywaL0k371KXs5weXlAii9rkAAi3XrKXYkmnA
         yH5UMIrYOirlmJ5knzdULYT7jB9HxpbHL4Uf6u5dKS9E9oG6dibY8AJ+dUPTnLQGu+vc
         eVstQsBGv26qaoWyf0aTKXMRTd4o3QW8V0hKZufjeZcBkhwIDvejrZZO9kmHdJq0Cntn
         vMMbNkPa4Deqmhh4D7yRaXFk/yFcAEZ6cC/WXcWpZlDAY9pDdohKLs5kVZ/SH19XaQF1
         CCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165718; x=1780770518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=K/VYjKUZHFkjkpbDXwiHi209B0Le9+DhS+9EpF4/Xne1drnv1kBZdr/oSJ0IRQc8bg
         iyCVnND5RqSRvni6QpFFfBoZxCQ+3L//kt4vWbE7BtkULH7kTShih/0I3oCfQrX0IJni
         ILsjNeUghrZdue9yqXF6gygnLUAvvOz2N/ACWZHvuPaLvSWAOIquIGKn5f1qdpr/iLeS
         wyAeV2eDJDaUPs131gQNjrypzPRGfzsm7KUlgx0/lq+Sq14RrBCrYUJBPIFIzQUD5Vai
         +v2NuZ8Br6uRqh1GFC44tQdVEffccDE6l3ZVEx673VlwjUiKgrNcO4oYs0N9NImOL7Do
         d5Fw==
X-Forwarded-Encrypted: i=1; AFNElJ9YTreg3at6IbF9ZjvLFhyhsjFdNZhRTYjF3O1O7ToazwVX5vI6x6olg5+RHxHDGiJXpkzKmyZUkTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxWRaLHEcrDi5Me9Va9ahkhnwNMY3ux3p8f+ajJqsIZ0vHtzo
	Axv2hw3IYf/Oi9b0P2GEqXTqfSQvUrJVUT1jmil3iP7N/uuaQB1CR7qgBnRRGG33ctDEUoRqlaA
	gqS59ebhrJ+RHS+Xd/v9nLjgdxl0XWz+3WHBshNGlNl8dOr5+kovrD73MdlR6fH+2ppUzlW8=
X-Gm-Gg: Acq92OHcFz/ODUA4rwOE02/TwytETfzUfKHZ52u3vlpDrqohBExlPlwpUG5UzNitzbU
	MR/W0aFOURWjNiWm++MYwI3SEU8VoBQqzvumAIECQdQO2FbbW8/TzjFMxG8GAdoVGPRNPt6iGX5
	nQaz+WbE7sQDtr2aT1LZEdeCen9Nk9NI+M0HWNnoJDqIurAY3x5S1G9+eu+snfAMkSQIZOO8FCw
	xK8MuWnsNIGtpor8/6NRhvSnrusWZwC+1R0gvwVqQ7PpEdao2PztU/9VWpvtE6eqNkF5zazxrVf
	e8/fItxuMJ9eVFExBLRzM49tAKFTMb2DlKvkGdgiW5oD889LruwvG9jIcdplt7GUCIA6axQdC1N
	9LeSP5odZFwHWY359KpimakvvYiT8rh19Wc3XonYZIwGChDM=
X-Received: by 2002:a17:903:380d:b0:2bf:343e:731c with SMTP id d9443c01a7336-2bf367c0d68mr55836585ad.10.1780165718237;
        Sat, 30 May 2026 11:28:38 -0700 (PDT)
X-Received: by 2002:a17:903:380d:b0:2bf:343e:731c with SMTP id d9443c01a7336-2bf367c0d68mr55836275ad.10.1780165717752;
        Sat, 30 May 2026 11:28:37 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:26 +0530
Subject: [PATCH v2 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-8-6bb581035d13@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=2571;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jZ5sk6mDCOuUmvLcAvbMml5Kmz0BhTO2YLQnfm6VPW0=;
 b=PbFIyNvoBdBIOscCpaSJwnHPwIZ7/VErt4P/TvuWXAVL7yjduiICUyX9woCSpVGUs4zKGSRoQ
 wUI9WC+gqh1DxR94QUJTAmiiTmY9BbNN8XmtiEtKX7/M7550LwbHgQp
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 04-Kc2HhGMbNloWSl9VrfahJuTnxdLhR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX3iveZ5xVt3C/
 6uMzahL6QwEqsmHBPxyNaQ+8dko6Fa9uZQ534ySFwE/ImR84F1ZH+T99LT9fy3b/fvwVB3h1TCH
 z/4anwo+I1k4J7D75ADfCvgayeYmELsm7pjPSj3O+c/TMG1ofBE3IBEDbF4ocVIRapg6IY9KxJ1
 Hkkpo5indmbW/r1FbtXOLSmOQm5gqG9exfn63zSQhTxPnowBQ86KWAKckOd6+RT9DVJUCVNK4+z
 ra8sHg7/NsjZsxHyPqC9qWtP1GalW+T4ERMBk3tttfd1f8+99uYcRtz8hJ0hOQvcYVWUfgZng96
 N7oziBaQ6rlKCtuql9j9Jc5a413+sMMZboFntC1aC+R2kkmZPDgfbAJubYPSLUorsJoiRq+4h69
 eAPqNUEu2XDIADTotEKucrgmplGcfp9b7USHGAttg2AGTG7Nj0rc3khUPaa42FfVRLgPOitVcYh
 SfUVhKJDhjjQ6zHakIQ==
X-Authority-Analysis: v=2.4 cv=NvvhtcdJ c=1 sm=1 tr=0 ts=6a1b2c57 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 04-Kc2HhGMbNloWSl9VrfahJuTnxdLhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199
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
	TAGGED_FROM(0.00)[bounces-11059-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: CD927611FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c..b112b21b1d79 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..e62ba5aef71f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..727809430fd1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.34.1


