Return-Path: <dmaengine+bounces-11331-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1QgLNtXAJmp9jgIAu9opvQ
	(envelope-from <dmaengine+bounces-11331-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:17:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC965685F
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:17:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=o5oGz40H;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OMFgYQM5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11331-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11331-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 866BF302D0A0
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8137DEAA;
	Mon,  8 Jun 2026 13:11:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA8231835
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924293; cv=none; b=cQj0vhhEflPkfXUTk4q+fOIEYt763cGWm+s44uQcYsxhWj9+lf3tthy2qZty+EvNQ9mJb0XNZLCzpv1161wnGdEkfVFBCOnQp3Mva0L2zWys407NCbV4NjccrDE4mwpx+NPST/bgijSk+OlLawv8OROC5lBy6cwU43yl4rDKUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924293; c=relaxed/simple;
	bh=O0ITinEiBDoqyNtfUbyM/puvl4+BRtjPN1CGKUba4DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kas61rwvcQ39oYvdBsl1gaLWhlm6dNvxygoy8xFJ5db7EcRTrdWSuDyC/+qeg1YeCZ4fHJvAu0kPiQeCKZWv3zoanzB9zMsfOdae6PtTXl6jyf6vSYvcIwldK/BvvuCKjURq7MnELtmfM0I6Skp7ZAKuszfykNZ9s4+XjiTgTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5oGz40H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMFgYQM5; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658CTfFC3658144
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=; b=o5oGz40H352MsgMN
	lAGVwq5cHkQYe/rufKWn3mKLn/McLh+Ttr3fg07QKGbWG82iIbu4t6kt9f+bx1WS
	l4GCCPfsMMod3+s71eI+8hjvVcyQfo8MS//DdqAZ829L2yIE9JfkEhufcaTptKNB
	9hULS23NTGSlvTFCNivNlSYckS0QGLjJPRAHwOGMv8Xf0j+R7eS7c6dkTTtQIaJB
	ivz77YT/DtvS3qcpt0YD85ScItCac2D5jWIz7eC8MgLDJNZQmHLWQ42xwdhw9unH
	hhkaGXEepEhBU7ZyTXjvuqsQgkWgdeLk0M3Z49Eth9KA5gcOOUxjkENxsJxe6Arv
	WGNCeQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsv8689-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:11:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0d0516ad7so45206955ad.0
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924290; x=1781529090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=OMFgYQM5T+BCxRa8ojexw0DluolJrfnMYEtWGY36edAUEZmGLmiU8WGBBL8Xv5zSNS
         1krdwvtIhcBTmcWhjb0QtnptH0RacNmb/d3U99XMdojTQGmxxE+UEQ40qU8VWteDs4yI
         72OX752ihHwjfptU+LIGO4jIb0RCWyZAMKyqoGFv0bM+SNVEGrsMzm5FZZ4YCzCQaWNH
         /yc88Ga8EKM5TAyEnxNW2ezc/VSaByaoEpx6ysZpBT3Eds8meDth4QvqS/Jx34FzXqKi
         97NlNLVEmGfAm0CbilxkEtuWQuPqTylG+odEAUEF3U+vntbnIp93qJ3WeIyZXO2+bu2X
         K2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924290; x=1781529090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=kgrvxxbNKKewYb2GkBCpNb0VPFiNZJU2UrhqjB+v5FgYayQas+/Kel3z/XEtTBbbEg
         Hi/S6We9wubvRskIjYGT1r5K20IcxdhDOQpuXSc3FAqoqsJkuvBg6EeMwpy5QRmePQRZ
         J6WQh+Y5MhhPyy6pU5nCgy2cHCWF7Rkg8z6YBMrmgxsECD0satON2hD3NsgclBGN1iot
         wpfYRnNzdnO7m97yOKshcNXnz3KaaAjtjZzuFW+/nfX77YHM6TUb3dMgtmN4/CvVeoQG
         h79HVPdP0kv/lp9v1gcXN2cl44IWOZH1GcF6MqehfVIjmPv8Loyj1fhyUQhRB2PoaE6B
         apCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gsKwVOx5dYnHtUTsy6u3SQBCKA1blC6tx4wMmCag7o/QiZj5sI7LUHLWj6hje5kOSUIcipCJjdSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcIgcOMZodKo8qckMCxWhrivOdjWjgckmObwYMoOd5g8ZZegH
	2KPjTwXrG5Q4F/gxFG/ccfemRmAynRhwdEezlg+1D5ufprOoAMfYfUUxZARYvVnTEGVeS8driDv
	Mp7/gAGX+m0vUeNToxbjbgNvVSJhBENh359RA1OcDZd4Rne1x43wjFUHqfn5Ekio=
X-Gm-Gg: Acq92OGP6FVdLb90DHOof8QJ18LPkXNOVwmMCwCx9hFJTL5aI+31bNAo2xunRdTHMHm
	XPLiF+tAJF1GhDYlou00FYtCR92ye088/8zuCojiufZSauRzz+Iu6bku+55mEQRdL3FKF0Om9mE
	/PGOteq6eKK+zll6ClslCOG5oN9jgJOpMUD0JCrI4UKebOmITLAcXhNhhvXARNg7QaHxy35GFiQ
	mw4r5l5qX93oScGgpKU/BqM9+eaEe6UqmfhaQsqp4HbeU9YbjvucEgjw09N9mL9ZUNTU7AO8HLb
	FdA2wLMFCyKM5YXHBIBrFwsir+ryRKxfgFz3fD/g8Jd4x87WE7iNIHdeeQCgRfNB73arXi/zXrR
	70FsWIO/7lmoPYoWxdIalZexehtwUT3AC0xOFVsL6zJ8qwxk=
X-Received: by 2002:a17:903:1965:b0:2be:1c3c:72ba with SMTP id d9443c01a7336-2c1e80edc5bmr166944975ad.32.1780924290404;
        Mon, 08 Jun 2026 06:11:30 -0700 (PDT)
X-Received: by 2002:a17:903:1965:b0:2be:1c3c:72ba with SMTP id d9443c01a7336-2c1e80edc5bmr166943945ad.32.1780924289731;
        Mon, 08 Jun 2026 06:11:29 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:29 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:28 +0530
Subject: [PATCH v4 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=2571;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jZ5sk6mDCOuUmvLcAvbMml5Kmz0BhTO2YLQnfm6VPW0=;
 b=iPU4VF9GBAJVNtLfvVcV5Bu20W5HoLd/rGWsPqI9feK38Il9JMxP7W8SZ7FTvIe7L7uvrec5f
 60iHI31D58ACiVfpxLBpVd+GG3O2i2BJLj56xerILcRwXBku0YoUQhc
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: jFb191s2harxgnXS3BOicS0gUFYoSH-N
X-Proofpoint-ORIG-GUID: jFb191s2harxgnXS3BOicS0gUFYoSH-N
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a26bf83 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX6uE7hIz4B0px
 OXLFmWvMtS3OCKZUIjv1RxXsBmduOVNyqDAKeGSW9SHOHnFa+RP4OaMe9S0bbJrBAV7b8RbD4PY
 M19D8YwXsfCOwt0GQUvlUpKh7xIi0jvDsef7ATHQh73Nl5exVkM43eRWQXZuGeM0VpT4dX1O7E5
 Cs/ZyfrSO0g0X+a7vAm88zdVvqqrDe5ABRVkBq+ieWALMzwQYYvx6IFN4ldufZuPmxo40rhEqx/
 O83H/jlPbIB0uzP7MxFaTCW3fg5YV02/TWCV+KCsWrm1k2FiNizNEiacwPNlPr1HZ0D/u93e6lH
 Bk3qjTPL7pDsG66bk8oiM6LqBVYLzs1G/PwIQF+jP2tJ694GCHU4g5SjNLKnac4X4niyR3OerrQ
 vtMQRUra1dvwohlu4jyDGlmgOgBSKaC6GtA1X9iTEXbYYHpOye6C3w241sGuCSZZCFymN0iuPuR
 meziPm8lHskOueJygdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11331-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.214.198:received,202.46.23.25:received,100.90.174.1:received,205.220.180.131:received,104.64.211.4:from];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[202.46.23.25:received,100.90.174.1:received,205.220.180.131:received,209.85.214.198:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6DC965685F

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


