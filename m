Return-Path: <dmaengine+bounces-12436-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rhbLIxM/VWoNmAAAu9opvQ
	(envelope-from <dmaengine+bounces-12436-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:40:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE374ECC1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=UGO8KAbm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CCR5pIO5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12436-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12436-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95FF73051337
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFE35AC0C;
	Mon, 13 Jul 2026 19:38:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27975357D05
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:38:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971496; cv=none; b=HO/1zMQ4/gI8XGqN2CJIywi/8SPFmj7VB8RWe3oCHs7pi8F/hv/ZJVCaeuMZaGOesDuQgbaQ9TdFRAw4StAaxHtlCAqvbn/rJWB1DmjHl3spPo/9KXByvri0yIIcG38iZI0Xnh8CCWVk0v9u6OEBtG3PmIr0e63ztp2Qni8vFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971496; c=relaxed/simple;
	bh=sbRcTEeb44L+08dKreeQTiR50to36bm2tH/jEQ+fRXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/iCwzC2GhATaGTShN/xxqHo2a7haq+xORwOxlWFXmWAkwUuZd606knZbg8BIHt9ImYLkDXvcRhgj9Pa1omxLw47JGiOtYa7QcZj0MVkWPfN4UdOFdosNK2mKXx59HxACcOhPZNzLRAZcQv/QDeVeVNLoDw0J8y5hENg05+JRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGO8KAbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CCR5pIO5; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9Ais2519331
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pW3/eYdiBNHzYmsNVVqfzYe8CiL1sfBuzUTnSxzi/2E=; b=UGO8KAbmjpxzI0YU
	o24qV+lfAKSboVc9UwWcBQ/TPiywloJ03yC2iOJ9M8webTA8IoPWe62EIsPVbBQO
	bqeCx7yfg+8FhYeDVhNQ9l+Uo1O0xZ/zc7S3b8KT9MXSds+MRRAaduRBW2zsz/48
	cuCITQxNoaruXIMMMNtceMliNKT9Ca4nw94f+aHWy8DsDffEjH2ZunleD4foEd/b
	Kg2My11S66bILO4XYjw3r7iCsghl+uj+UlFjV5RRHzP7uRh0vtHNJRqtdLT7ODRv
	dekDlUqo+ix8x0hNH8j64F36AZJ7dmTCvkbpvLZdoM27FDgZwX4lpS7J1PSXJGa0
	77st1g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44crj19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:38:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so65755515ad.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971494; x=1784576294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW3/eYdiBNHzYmsNVVqfzYe8CiL1sfBuzUTnSxzi/2E=;
        b=CCR5pIO5Uobbth4Ws58z1HA7FXcBiyUf9v5HJSMIlCdi40g8XaMUM8K2hEB3Ck2XOS
         /OrCNGjquThCkxx1AsGOz4+LQFw/5miT6AiaZXO+/hL/U1udTn1UttP9/ysYM4tZ5N5C
         8AQo15b0NnJtSS4ebmCVo+4IcN38gPY0dWcYyfiZpu8eqlsqczM/wcM8kDFXcxkMOyVf
         bqML6wjjexlPfGRAeZ1TXBS4oBeSDYKeM757LgwpXcvNzQ9spw1LHopC5q2BOjbmqe89
         R3w82v7DZu5DtY0LpTRY1KC1AIpqbVoJhnSM9O0EItHS/OciGGl1cffCJDkozAnZowPg
         GtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971494; x=1784576294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW3/eYdiBNHzYmsNVVqfzYe8CiL1sfBuzUTnSxzi/2E=;
        b=U+FQpfStE8F2qlNaJm7vv+jJpJZ4VMQ2CDHwUTrDR+oK0DOhgQxPP4rOSheE2rfJrh
         y2WLS8AaS7Ykv7WXlu7ePpY8T4Zbl8LKZKXcjz9ntu+SQgvuzMljQkeiV0qpRY4bWX1O
         796zNbdeLZVq9AOwwNLzEJPsqnF+iTM7cpVTl8xsK0zLjtP41oDYdmKmrKn54UDmLGnV
         rK8VWpA8yzYVTFCpY77DOj8gw92+fwduz5co01ziQtepUXqGaGSJGF58nO0kNMR4oktG
         1fM4JdwBjaRZ8RGiiAWP9n7k12sPak31gTVzsSz53Iy2KJN6dLomBDDJHkLVqsye5pKp
         tg5g==
X-Forwarded-Encrypted: i=1; AHgh+RqMSHuvQ8grvn0QRF0ldJwzRK0KWK4pvc4nTuq8JwyUhphqUSS81kMFo1gbvT0o7xAq5ox1imcu6X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvu8cwFuol8q6mslMqHmKNYqZ6pVYMxv7wUeclxgvMSSirvDIt
	XYjqgqCUEL6Um/H5vv12nEoTTKu/KJOtwp89EZgukurGNr+g+aWwlX9GU881MvEZDr2TGqFj6aP
	hlBz0DFYCeuNomGF3hviXyjtiHCQeQqQ2DNoc5rwXWe0KoX2QlaKFYV8pRgX8oH8=
X-Gm-Gg: AfdE7cnnvP03LDBky+9srWTYl3nQ4wNO+wZ2dKSdW+ojElPEHlXWOmI/AKW4PdWLbGB
	DJ31cJxo7nsFsELo7xN9avcPrVM7R0t/c4N9oNHCorgZtQFVg07JJHsUFqX/sF7vv+bdsv/Fs6g
	IqHWfx6ygUjJBrHX57d86V+c42paTx7swJw6UIN+xUtRpLb1L6h7Su+yOCgUEO81SXcD+kE7F3U
	efoZbduCpTKW+gZbOhnlRqmdh9rN7N9cd1nwXKceFmeFSkNs3fgKokmy1wtTSJ/ecMr7IDvnFFx
	PHSF1SrVHPa3oRcnGe5xWI/Cpe+iZa1K9x9PrlsLcJtY7tdhWgO5j9QvaGmFkenu+agmzQCjx68
	x3gtMVfJIjWyIaLov8uI5oAv1kA==
X-Received: by 2002:a17:90b:1f8f:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38dc75eb7d7mr10201294a91.16.1783971493814;
        Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8f:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38dc75eb7d7mr10201280a91.16.1783971493399;
        Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:07:00 +0530
Subject: [PATCH v6 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-11-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
        Anurag Pateriya <apateriy@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=2134;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=sbRcTEeb44L+08dKreeQTiR50to36bm2tH/jEQ+fRXA=;
 b=Wz4odGLEk4bkPwCpS6QykF+GmDbi3S5JMmJswgb10VehZPDUbG3zVfLbP93tww2Va7rxXbfIw
 rLl4xZkiA76DT9lTTy0QbYO745BIl9AEMbc2Omp69KCv37t/ynPv94p
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: o8KSy2iyONI1zWa3n-978opPVtsF5kkH
X-Proofpoint-ORIG-GUID: o8KSy2iyONI1zWa3n-978opPVtsF5kkH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfXzuei89y+P323
 aDz5MlZNIIQ6qd4ar8WNvaRWpLmG/lPUiQYOfmPJ22Tfo9CPqvMb0FWAfw5P6QXWHPQgCgq2bDA
 NQ4N6z8i7XHTPDARoCEil2bfwyVeWrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX2RWRhwzq57O8
 PGi7UL/0wz8PM9jYekgT0vIOvBZAQ1PL+wwO/wdTDbZL9FKp7ByaTUtwsBFo8mUlhkBduL0xJx3
 RkEqjARjtrgeZxC4VTinmBYdtT/zJsVafvrk17oSD/WnL+mc38Qy7+PAzBx8XWERcU6R8TW2EjJ
 +eNxMTfveXwzq31CKf++DRY4HgrXQN9ikXTxgzjc5HTXVyf8JHZRQR3ltFGRU24xZ1ux3AHiCDT
 h7+BiF0OcHo5vnNG9niUlEVo5HhlcKS5YcyeHLsZgfUmqozJvGPuUdBGAmt3ULrGadmCrrkN0Ok
 WuvnNLcyR7gCz2AtNXEcTpe0qT7+trvhLghPz1tC6V5JTWNVzTnOT7xouSE+eS9Ib97s+uAuS+/
 XM0R4AgpMrke7H2wTT1EjZrpO7fM4Ls/QKo57Tf1CVLgxaDLYZH8MlpqtN/9tIszxwLGjH8C/Rk
 UvsVYhDVdZ+P9RAFljQ==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a553ea6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KewF8LS1X-wPzteKbbsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130203
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12436-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CDE374ECC1

Add gpio-reserved-ranges property to the tlmm node for all three
Shikra EVK variants (CQM, CQS, IQS). These reserved GPIOs are
inaccessible from the non-secure world and dedicated to fixed functions.

Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index b112b21b1d79..10d0b4533009 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -57,3 +57,11 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	gpio-reserved-ranges = <6 4>, /* Fingerprint SPI */
+			       <14 4>, /* eSE SPI */
+			       <30 2>, /* NFC SPI */
+			       <138 1>, /* NFC Secure IO */
+			       <155 11>; /* eMMC Boot */
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..a56ea39a7c08 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -57,3 +57,11 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	gpio-reserved-ranges = <6 4>, /* Fingerprint SPI */
+			       <14 4>, /* eSE SPI */
+			       <30 2>, /* NFC SPI */
+			       <138 1>, /* NFC Secure IO */
+			       <155 11>; /* eMMC Boot */
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 727809430fd1..3a6962388dfd 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -57,3 +57,11 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	gpio-reserved-ranges = <6 4>, /* Fingerprint SPI */
+			       <14 4>, /* eSE SPI */
+			       <30 2>, /* NFC SPI */
+			       <138 1>, /* NFC Secure IO */
+			       <155 11>; /* eMMC Boot */
+};

-- 
2.34.1


