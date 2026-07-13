Return-Path: <dmaengine+bounces-12432-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1848MFI/VWogmAAAu9opvQ
	(envelope-from <dmaengine+bounces-12432-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:41:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A374ECFC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=evfh9MG6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TA0SdxGT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12432-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12432-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4F2316790C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB1357CE6;
	Mon, 13 Jul 2026 19:37:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAA35677E
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971473; cv=none; b=COdX1yz/utm/GkK+qBfGeA6HCcIpBvCJq+glZroDGKsTENTfAOamrW7YlvioHmhDsgGgV7Kl2enPNpYXwWCi4YF2CeJmIP/Du7tXdBtOtkhBvkw/fRNUwRc2OmEtsOZV8ri8toQ4zMLr+zI7BTYsWtWiopbQt64DsgUDON1n6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971473; c=relaxed/simple;
	bh=W+J47DLyzKHe2QopLDHxTslHmL997c14k/yofWkF6Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYaskRKPgM4uj+QY63GJ6kAhOlE9w/opfARGjLcrYGixR/cZzVrVbS8uwF59hIB5ihh++tf1xe65HapsWrYkosqmFXGe79/hK7QUWHujT/mTf4EJzgugVkveZSSGYgX2tvIFGvxDlxvssO17aoDzHQcfBCio/KpFIWCJp/N4DpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evfh9MG6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TA0SdxGT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9Si72435354
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=; b=evfh9MG6JUyN2/v6
	kcm57M2xZK4y8US3pVrShraZJgVU1GSAWUY2PqY4W+jGYIBCGqCHJWGZsKhUqCH/
	O95LOIID3tTCFZ3KasxYPJv5qRyJh5kUvn/wzjeeLwSuacU5XrNS3+9d2DVTfxgQ
	X3gJd9vEkP4O+ZVsLY6I//NNl3+02NLUvAGY/E3uDDfFi9STO7PqemazA39mIO1b
	7jGB5cmsh+sGxbNoFzg2z90e4w1FYl4XvLqmydoYiQHGzmIGvPI3idz43zbEw+rs
	jmtXKQpWtvgQJS6wH9FvCVv/rk1H3ukVQGXKGIUY/IZjRfdKNdkbi2GzBIyOjU3j
	MpUBCA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavtds9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso200222a91.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971470; x=1784576270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=TA0SdxGTxjXNCHAzvCb64wZYdqhXkmF9mHdJCkpgSmzUY+r5EakNWzzznmpgo60K1E
         SLP4RvXCsM4XJEJnPX7usA2OjGRARBwf0hHWJ/M+UxufuFUu9xOY8vnc4LeFpwS44rCV
         89NrKTixpIjtYVIximlxDLMr2wOXROruKQQY5ZIDAUG3GfAbKfkZAJrK85ioRoPnjXtk
         OgjW9OrLmQIbMNECuo/sLFkrZ0vmRksNBzY+rzf+H6PpH4lm5YzIMnexjR1m+1R7AK+I
         X/IjK+7OfrYqJwQYcIqq6VE8lGjVXc7XBJSio0vqdB2szjlvmGVB72UgmFOEJw1LrP6e
         YjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971470; x=1784576270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=ad4XwtSB7PbiP2CMU9nn+ifXZlXkSX1198EPvu32Urk7Q+2EZQDyApxT1LTRsRxrJc
         ZmXxXktuFnlm6NwDMfN0CE03iJ1FXqt6aPqg+zsherAnIjAF1y84pF0B8J2RNqzoD+Cx
         4BOr8cP3oerc6dhgylHOPHonL8q6z4htshiqtRAkYy4bFyUa00uFi2PhGtTY8JqCJje3
         CLJhC/9SUiRdd92rcOjfCp25lyP8yviEyBvPT7b/xU3cfaBcXKEUGTD7EwjSOm0SIOaX
         pn+HG6HaiMzKjHrAtCIorEwddLPIxYEaRcWT+andZYMiL9bXEKk2RQfYf7L0RrkYMw8q
         HHMg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ8Bkkd4O+3kQA07ol9780SwUlO76CoSQmuBXIOd4gdpaR1p4gbHfrgMbYLALVDXGxrovZ3mCZPKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJih7jfEksmPHr8Y7GYA1bIpGI/9b9Bn8aZgUJdH0tx+MC1yha
	ufhcXTe+pWOjZ9DxMw4DLQ7SJigCrMY6FkLOtT1ytIrXwf9x5eVuMBvmjPt8szF5XIJ5jjku90L
	fODOU3MY+oxX1rUzen6Mk4lYPQbcW7waKx78L6yZilBoKZ1hUItibrAJagdfz9VA=
X-Gm-Gg: AfdE7cl4aaHoY4sdoTYkSQCMeVUzPtkhbSz2WZ+BzPitv5DRRMn5w04osiRGkNRSDi+
	0kamdl/OsS6ZwujNRS7ZTrhgGooZ7qch2vdbqfhTsdp2zuxpLLyaRkFqbcBPoojBFneaVJdlA6S
	ZIyYLdTO6Sk2TyGSNHPDFpICnS4wfEa7azzowZkA+S6ckZ21aIKOZ3566EUFZlRWnb2IpTBnSwn
	RvU2eH8erevIHhfHO+EX9Xc5bt7A/WlihQaLAGSnuQegc4FRWpNeVotXkBDvxffzSJpNN3/Ns7s
	LVXXIHBj9Srr6n0C9r1ewt2TPLzO4tHSMeWkGw48X/3djslo0WZforigASkXFlZky8cBDIIuwbF
	O5Ag81GC6cNmnzWknn6Q8Vu1Ggw==
X-Received: by 2002:a17:90b:224a:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-38dc782c68emr8926045a91.7.1783971470503;
        Mon, 13 Jul 2026 12:37:50 -0700 (PDT)
X-Received: by 2002:a17:90b:224a:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-38dc782c68emr8926026a91.7.1783971470044;
        Mon, 13 Jul 2026 12:37:50 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:49 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:56 +0530
Subject: [PATCH v6 07/11] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-7-bee265d3499b@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=2699;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B2Dpn2axDYIMHLk1wigFR9Q2p/KX8LBdfSSHhm53znE=;
 b=wPhxBswjZZAlwtLStujD7+yOreUeucgnGXbxxcJrCntUXmrZDwz1FqCsCxtrq8T036Q9EXAdl
 anBjR+2P0oEDqNnZhlQ/QkESXOJV3ZpIIcYFLvo6FwnM2gxBub9rkhN
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 9qNaWpiSfVs9vU373W6VX3LdpKx5e04s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX3Wnfop2ZNnnL
 ZvMEze5iOR6h4mtEgn3iQ2pCKsgMU4z8++G2PaxVBjiahOxod6kB57Yt5g3M0jhYGyMUE8ry3Uo
 HvnNLMef3WZP2d0iBY9nK+I1THucL2qlOXYvofvljPKd9x/59NQNnKyGZTNN6CfR5gvXYz9IiBH
 9d8yCGGPIA6VaIE1h6KLkpCoA5iBnJXKaKNj6t5IxMUs/+kf572ndr12RbivFBsDB4CleKw4wDh
 3cECV4z+gCKIG48ZjOzALHdMvt6tDJUqfktm7IG2430BBRP6EI86MqpsNa30gDdgKyQh7qWZFYL
 yqKrntm8lLQG9+ynTTf0faMb5EyfkqAw85d7Qqd6GodugCsQIDdRGjElMUtt0ToVJpbTAmTp4be
 YfkuhxX5p9hzULCa2n1XurQHxZ5rWDEnODrJICFqx68XKpyrttV4UjOJDp3dfeAgRyP+bJk8R4O
 XCMOFLm6wwTp3Wve7ag==
X-Proofpoint-ORIG-GUID: 9qNaWpiSfVs9vU373W6VX3LdpKx5e04s
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a553e8f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX8DV5AapkY2Z4
 hqFRAFt32S3NnFMJymPPytTIOUmaSUumZvtZBHZCQEBA7y1EmARNEUsry5s45BB6lPQVW3CCKmh
 t6R4fiv3+mtzlE5+Nb3/4IX+Jg3Ec74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130203
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12432-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D3A374ECFC

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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


