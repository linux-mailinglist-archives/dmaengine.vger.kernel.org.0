Return-Path: <dmaengine+bounces-10793-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N31BChXE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10793-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:53:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782925C3F4A
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF550303672C
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933AF3264FB;
	Sun, 24 May 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TzqOMA7E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QC6n3htE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26308318ED7
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652230; cv=none; b=hf+e10et23356DIjOzMoS+3obSc3/D5/t47aDowobG1o/vj0PiqtOuDZMru6e7+dM0893/+rt+lljfi9J9nj/JMthcKAqxZQ3L3uhfvjYcd5w8OmFbQsr39aKd7/6mwQb6cjIi5JW6uZjh8O2GJKhNN9Mso6Wnc4chP+UrR3cBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652230; c=relaxed/simple;
	bh=Vz2BIF9TW4ki6ziv8QKNjfSxoTLe7EEEgTXv+K8gJlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlcTtjO94N8mCr5ZlOjnx6woL29ynnnEcJreEnk8TAOzN/e9tiyKyFTYalJBS2fFFIverV7mARuqd3Jft1V5zhVupdiFezV9DrfInlLr+FbgJ07aeDVPcYEpQVTngt8kKp9I7tDCRzEfajSDSprl75n3oHLS/xqwhzPUQRCXSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TzqOMA7E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QC6n3htE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJFvv4253167
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rlad6Hzrp4mTjFgHb04nT42FLPFWGLcPO3WBhYIif38=; b=TzqOMA7EUZjQeR+1
	jU7v54wSvs7zdsKYZl4Of+z058pKt+czMcmAInCzPKmDehbJEcR5pElDNwyNk9ju
	nyy3E4MaNAP9YceXK4HS/2w+6mY8XRKt4ZJgn9q/zM+Mv8Nn/QHnIpe5OB0Lc7M4
	quvKZoXp9lsib94mwcZYyDEmesiaPPe6l78NW5toydJ452LtfotGJ/79HF5T1Ohn
	ArJEHo/7hgikONlkcKW0ivNXwGbr/LUkCqLXnqB+wD02FH63sRj+k5m+1xpfd333
	QC6qAhLfCQTiH1promgP8UlPiQrGZ56Knafirs25ISH+tairfKJeNshBT8HHUyqU
	yYnuBA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9kr8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so8030017a91.3
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652228; x=1780257028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rlad6Hzrp4mTjFgHb04nT42FLPFWGLcPO3WBhYIif38=;
        b=QC6n3htEuEK4GTgunl7I/zvYMRWeZIh3Rnt9P6Hx18M97+VggfvWnSLy0nNQ+raY8H
         nAETv83P4ciQO3OjC0ijQstbgPBGE8XtgGF/KjSuMJq3/DfWOL9U1ETEF+jUgcK39BXW
         XbvRHeME+LFNp3DPIUW0ONGMj3OOUUFCC3X/L8SZvx/oM1kqzenS+fLMCH96dtaS+Ksh
         zis9W5TlwB/hB4VZW653pELvRQQPv19D7XnfzkuQ4AFBFnjLRpGD0Nrk1KiU2/5xdBLi
         qiq69sw1YSZ/BShK3CuOv9Q2VluJsUZ6mYuXm3CiHteFeRd+1ki9nw6NSKEaY5Y4RvBS
         l+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652228; x=1780257028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rlad6Hzrp4mTjFgHb04nT42FLPFWGLcPO3WBhYIif38=;
        b=tOTlf3ILd37pIArH6JF3GB6nWmPoh5UcXs2hhDS5AM51T48LwWfpuGKNmdtsyODo8Z
         U+fY72HRtKAEqB44Z8OFfQsJt0hxDDwkVXmiS+fUhsdOdaq9nSKj/suEmhnqjwHmwpnu
         H+4bOWB8etTOYD5mMNpiyaixDANBWo+G7BZkVrlk23OvUNmmtz59omzVfS/vDAgTKJix
         UguK9+Vf3VydZu+YZaiQISInNtUdOPkvIHJoyLMI9CqivDkBXMRBIDs5S5mSH4fc5MjJ
         IbwtPFR/k1AZofe7ErarnRWUxnpt8FyCFixb7wauEg3eBtgWLGXWaS932t/v2HILYvIV
         kvsg==
X-Forwarded-Encrypted: i=1; AFNElJ/1VmlYK5wqsd9VT7ssAkp74U6wthyismi5rArD7tZ5t8cu9n4pci/vnAjjs2G+OrUYrVvq/90IZdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDDLLnGUyXUYhf1tWC4aC5ZyVZiaNQIXc0O01RRar3wtZO3TZ
	vHaoxd45H5sCi2U8Qkc98nzLMkUj9yedT54QjZGI0yt8FOgOQTLmstINWUaujZcIS0htoXS4cHR
	nyQM3ItW9Npnkd5QcM5i+epSpd/w4CVjkZgRDbY/0FcCwZuhAxpxGas8D1bMT8BA=
X-Gm-Gg: Acq92OHYCDs0FGGCJ0/tM9T+kEXdKJ0lC8EzTAgGHU5dm3K3/KrsjPQxsYLMawEBTnt
	ujCnPrjdJ+pK8R/caADsoCyiDNXG/+z5lRlABN6KTwYNCSWZkiXaz4NQ5yBoFKcoexZNVD5X9sQ
	PGFK2I2ERFCehZNKaMcTUs4vueiNXuAtvmxIakQXpIXv3nb24JdFJxtLgREhCyn40TTuLmq9zWj
	4VBQQWbk3qj5aVSMHvcYk4rW4qfft7pVoN5D0+27mvTlcd7zShervQP+hKMbaR6fLFmmGsUhZgt
	zhPkbd9+CeX/TAv4xi5s1po7x8CX8fakKu4HQ9r5vAVp1thcK5frGhzYczUUmJtlYKDlt3ikyVo
	khu1+dJCR5vX0ptj25APtKeULmp5nGYHv9d6p
X-Received: by 2002:a17:90b:3887:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-36a6787b0dcmr11506413a91.23.1779652227793;
        Sun, 24 May 2026 12:50:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3887:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-36a6787b0dcmr11506390a91.23.1779652227058;
        Sun, 24 May 2026 12:50:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:26 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:15 +0530
Subject: [PATCH 11/16] arm64: dts: qcom: shikra-cqs: Enable CDSP, LPAICP
 and MPSS
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-11-f51a9838dbaa@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1019;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=GucbWW/nFHFiZEGD33wM3Rnwy0m6WPWGvo2JLbPdcsg=;
 b=YtSelh8auZ7dVbUaHH25HcPzgxjdYFncvYyVzuCZoNg4OFHJajNckigAF0yuiXoxr2kmgm9DR
 fo9e0R00o+aDH5ZUa2oFGCNiRCEJnr33h7K+yjKzpj5T+UCAhnfMNDq
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: 5YZ3nhLjzP3jroPg9MXN1wf80l8LdqdZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXwgeFnr85RmKg
 +K4oj6vunRHKqjTlVSR1Rluvmc3yE6nZ+Jmj85ewhp0eevIkgLOAnRKz90pddioqGJoDqNbHbFZ
 7S6KpyQ1amdFgBvzC/If61dGn7nfa4dFh49jBRfaKtn8b+WULwxmIz9RiHkb1q8ZzxIgWqLasXq
 fTlkU1ksbkYzlWHhWNnDEoYQq59Refrj1e9W9JCOPhhv0czW8eYM+Att0stztqHxFSB5bhVuWpe
 wiI158nwdv4OP7b8vE2qRp6bSP9F/CHQiuOp/yuMogu2KGPL1ArtVEIU3es4Jn4p+Mvon1J3TUm
 HIZSv1jzZesAVjRcFCISX5ANfsUK+J7s6OuXscvc17zDFCi8U76gq8Tcc/NnyCNIL1INzes8kSo
 LlFH2/ql/2be+l7hiIH5Sxw9y1FPESPsnVyFfHPScveOiAyvEro5CjW/Ws+TVfGXjfYHQzZGqTO
 qD4toqCfHJzehtXIfMw==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a135684 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0ebg2YenFEddjv6MTxsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5YZ3nhLjzP3jroPg9MXN1wf80l8LdqdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10793-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 782925C3F4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

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

-- 
2.34.1


