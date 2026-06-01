Return-Path: <dmaengine+bounces-11102-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IiaAsSCHWqTbQkAu9opvQ
	(envelope-from <dmaengine+bounces-11102-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 15:01:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5861FBB9
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE8863090A82
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20143A382D;
	Mon,  1 Jun 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0mrGx4K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EhmiALvL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E03A168F
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318563; cv=none; b=ji1idAi4CZyCcgoZb5Wx/HfHQYytc52Ld64mfF1KoBFnQsfRGS1AQ5GVxNT65Eh21uNUlpUBrz1uPFdQ1pzNCVQyo8hBL8Hc4swqtNdAusgzzNe5q88KJb9kFV6PlJrzcI3Kz3/L+ygo1zKv4/fQUxmTOlitPxnp+Tb2qMVButc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318563; c=relaxed/simple;
	bh=O0ITinEiBDoqyNtfUbyM/puvl4+BRtjPN1CGKUba4DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxRZJQJ3WfKP2xIjwW6rK5h58JQKeqAUsipRU6lHmra3MnMJwm014++vWBXtgAwD1f0Ds+1GUwBt/EAhM2oagvpFOj66dEYLA/W1KEmTZeNOD+nnNg2myXp91pM+YvEz7+vNjIhldRfcJS3gqsKx6vgZ8qrEoi6Xxfz9MwGZacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0mrGx4K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EhmiALvL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518e7aa1214107
	for <dmaengine@vger.kernel.org>; Mon, 1 Jun 2026 12:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=; b=N0mrGx4K4JtV1ruv
	EJChM2z5p99YNBJaVb5kSHMspT7rNu0cFrhujlGmLyB8pj4x11xQDOFc/cbtBWOd
	y3PTnGbkusssw8IEwL4ZHcyF2fbKlsy/vhF/1sYVtY9n+AUeww/ku1d0/r60JHMi
	GPeq+zQlrauSVBDOyFY0tyhWTBbezwMRwbolP6sBdBcqipa9Ie9YLDUZiFf+0PQ4
	TtP8QPrsrXAlJsFIjd7HKKxFws5bn8IHkXX3fANZi1RDMl/CrjIGPolBYywNR7Qo
	wMNouhWDPrqcns2fyxqIA2rIpkv4eis/JGgU86kA7ED1VsVaeb/GTzL7Wsuw10+y
	zzSKNg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s990xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 12:56:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c331eda3so17036555ad.2
        for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318561; x=1780923361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=EhmiALvLy41HwzENteYKy9qeTxfaVbr1ZpujHB+Os6BWqqdWI57Eq3H7Iw+Hc7oOkU
         zB7aKvrn+L/h/lKvoKsQZlHhx/7k6SItlmyOgzs0ZjcU68IHW1aZPtugmROQ1aEWJGci
         XQh6r3lmngNixvMDW5Y6UO3cPdh4gsAsIZd4xhFraYsZrbstGpWgVkAvOjfeTikZIOCJ
         JoSpOycnh1wKg//iHL3KCPV9pTT2TRL1BM4SiyyyhnqIjCPwdRMXhlUtDTQ/DVvE2qcu
         e5e0pIgDrUkeEqfJ1WQrV3jGJ+lr5HNh2d1kUrNASxgSb+z7OUVrd0vpUNachm/iGMjO
         wg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318561; x=1780923361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=DNnq/1gptgKwkux3Ayk7DD0IHjrmDpXmwFDo0ltmwx3P/ftwCBWh+W24DrddNBN8ib
         VCg7SGdBFTxbR/7wHAcQncTwe/VKjckAWgcW1cJxgDI5c3Cu34My77iw4vRyBS27aT8C
         CEnIMIVRNSCseVnC+O9k56JZkYL0jks/Lx18RAzqWFKf/wX0rnt+0iIBUkiNjspcL9kI
         JktF8AcL/6ZSkATnwWcUak5NkyDVNDTUUs+i+KrphZzPnsnFp3zvIaFX2F8vbRgMwJOe
         nXQdjKxWa+ItayoSnkYf9YLE19v8IcDLDvpVqR94eZevW7cLg7Ku5TDoQIzW6TLEcZjZ
         paWg==
X-Forwarded-Encrypted: i=1; AFNElJ8pG8PF3sX44O6giaFXLiCjQz3zpb86nQN8/uIIDfD2fJbc+zS/bq8qWu4A5QOrWd+xdQFmpkYq63s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kpZFGC5pZWzInhGDws/xWe8j4Ly1nXOqf/uxIU2nuWcAWiU4
	DXMociA7HRz7DO8X7Ct69nhiaL+Nd+m9mscapGj43HWQu7mypPTuM86mMy9Y1zkwCo/tGaCwjiK
	GZEboC6AvZX7sCRDrmdiym+mwvYBqeeCC5Lf2eKQZZt+FevwtieU4+gTlDReewYw=
X-Gm-Gg: Acq92OH6AecdwZEndUbYIVF5pQDP4aodeLPyAJtZ1hk5x6h26D1mvTaQ0DUU3IQqJJB
	WM+MX10cTjvDkvfizgjegtSWDgeUnIQq4M74yEeQ2f+ei7AXc69ipA4jqy3lArdZjyNXTj3y8CD
	LhBZO0v467lAFCnzxhyrRPZf5RsHxh8wtNBIwR+O/rs14+edAngt2w8I88N2sUWKmC+0ZQChF07
	nSF2V0/LOu0Ht8h2TTuc/3xx/2YYkz/rW/KZaIjgT1Z1o9RivP65OU8wuJiY9oUp0FCJmsK9xcl
	801RNL6qQlJlvk2vKAsEKxOyXy9yNnRnwKQvzYfzGcg43XFuZG3Vvd4PFLRx9BhA9IYysmr2FQA
	Z9NfDCtwk3oAb/dwEN7PW2Mj3jIvDBkJRQQidHZ+I+KjUAY4=
X-Received: by 2002:a17:903:3585:b0:2bf:2243:d4e9 with SMTP id d9443c01a7336-2bf367c1458mr133131065ad.13.1780318561102;
        Mon, 01 Jun 2026 05:56:01 -0700 (PDT)
X-Received: by 2002:a17:903:3585:b0:2bf:2243:d4e9 with SMTP id d9443c01a7336-2bf367c1458mr133130675ad.13.1780318560657;
        Mon, 01 Jun 2026 05:56:00 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:56:00 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:10 +0530
Subject: [PATCH v3 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-8-0fe3f8d9ec48@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=2571;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jZ5sk6mDCOuUmvLcAvbMml5Kmz0BhTO2YLQnfm6VPW0=;
 b=oCFQRf5uugbIlMfn3dajQc67joQaFaK47HWl9OtR23I+WDu/VDYFCfc8DgIwVAldaSgNeGgh8
 cpaBde0NDQjBkq82ad5QmDXqDZjCQv6UyY5uUwbTAtOzs4wkKkbGtqX
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: 1ejLOSBVvnH9Fzrc6Cjmfoozb1mEYozw
X-Proofpoint-GUID: 1ejLOSBVvnH9Fzrc6Cjmfoozb1mEYozw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfXz4FZzYwWge4r
 uSL+4RUB8+LlJ58wjTdqP1VEV3tgDs7iX4pTtHM33tdYbZVlbhAxPKeHgkvdykXZCG2DWiZ7q9W
 3GHCdoZMlk5GHU1Y74bKInINVgjLjqVKml0Hxt17geFC5jV8zwedgMipg7iQBKOH54oxvwmWAJa
 PWn94npzCssMVpMk3/kylOu0vbJ21xKhz6rfpSxzshAZlywcQ2BFhO31lHH6BsFvFZuLW1T0UKj
 LTj3B5C9is9YVZuN24gijYXrk+i5ibwV/3F5Gn3Wu7gMEhcXRXMuK3Zw2w50nxS+BOrDjk5d0xn
 aVm9L6xLmZG3QZZdqVppdqb3G3h4CY7cOUOh3aoV8zjzV3Cr1yQyL19hzLmobTF2Q3UakfkrS3m
 y766EK6V1dy8Zf3+2y9od21H6yQuXKfN/0TQIDG1elQHen9KZEMKI4P1RBg1xspweSVO1FBmom5
 PGbM5QWQvmat+1KG5ew==
X-Authority-Analysis: v=2.4 cv=Zo7d7d7G c=1 sm=1 tr=0 ts=6a1d8161 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
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
	TAGGED_FROM(0.00)[bounces-11102-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 8CE5861FBB9
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


