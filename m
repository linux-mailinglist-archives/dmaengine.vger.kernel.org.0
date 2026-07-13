Return-Path: <dmaengine+bounces-12430-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 88flALs+VWrvlwAAu9opvQ
	(envelope-from <dmaengine+bounces-12430-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:38:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A501374EC57
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:38:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oKQKw3Vw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=g2fBLNZG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12430-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12430-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B363041491
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CD357CF9;
	Mon, 13 Jul 2026 19:37:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994023D7F4
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971461; cv=none; b=FSEGHftNkBX/QW+8/nM269BcLecxn5GGf4Phro6TeFX27K43TFujoUSlQtCK/nlUoqHaOvroHHBzubLu6cIz/xvcZFKE8HbLDbK5LX7bD9Pv/Br3/2Udto1rcba6kk49ZdFUnIRv9jUnkmGrwKTByVtqPYlv8UvGR/qkvMmbQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971461; c=relaxed/simple;
	bh=do0tzTludNgpGS/opTf3SCuV5bhJp5iWnrGtxTlST74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7Qa+ITM18sz8W3QWeke9R6xXYP66VFSymc2yQkhO245jVP613GXDZA9xPg7o/0rnx6r7mNysul4vIHVfhkBp57FIIBx8d2yFxQ/rueHJrnXahLr4UcOF8VacQb4Ujp6WEFY7vrL5c3Hc1j+Q7ofCEy8NQ+FBBI4da2Q1wMMjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKQKw3Vw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g2fBLNZG; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9OTd2247772
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CJNfEpph7JMPeJCP0Eo5JXk7HW2DFwVqyvqs385kgkM=; b=oKQKw3VwQqBvMGBU
	CihsrWCq8Mb1BckigcRWToTIWDoi6wUYjouCU7KhEJN2zQUxaNhs6axXJHgtf1Sx
	ui2/Q1PgvNcwNnapT/RbwSBpK57xvjuXz80yiRJ/7boV8KAO/Nh1K0GybVXVk9Vj
	aBRJxQ0kON+p3SDCpjCTHOJcLBtNsRN0BiMyOfNsc2/vIFgEApY2UxvdJC5UFZ6b
	geckV5BEoSR6GiPz27kKqYjiJkH1ykUfVoupsP39zB36t3D1ILRRu6t6PKCWIIY1
	w9RwZKnO7iVkIW2mWoqK6qACvptX/j1OUM4XoEta0KgktwRSu4Rb6o30pzZIXRxl
	fxeugg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3jc5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4578414a91.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971459; x=1784576259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJNfEpph7JMPeJCP0Eo5JXk7HW2DFwVqyvqs385kgkM=;
        b=g2fBLNZGdQwwlSv4AEOdXNS6STJMvRy9vHGuLFBM1bVO71uHWp1MM+lzlpvGiQ0tUP
         P1l/5j7Iy8l5DZdo42bVRz4x/hUdaAnS8FX2+O9mIxXQyJLwaX4B7DIuZfyOWdsWsZFB
         j3N8DiDDOArnELXlC5h01Qou5Ey8h3ab1liQCLWIqqx8f56ATFY46lUQ92e5g/BcbPqP
         9cuI5nh4P6WP0/WLai/gVxx2dLlHC/kkNiWlNJjAOxDGFOXN11kb/fzpq405l7e8ThVC
         yb0J59ohDn/2ZyJmggCvBbAFeuGT4Taenqy2XnVMsK0dxJjScPdbX27mbF/0UgCsAFjs
         GiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971459; x=1784576259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJNfEpph7JMPeJCP0Eo5JXk7HW2DFwVqyvqs385kgkM=;
        b=OpSd90WNYo1G+D+Wfq5zcQ/y36ur4C/mTrtqLp81twoqd4GI+0PqQZcOB6t1oBY/U6
         uq/hCQg2EdPu34oVKB0TjOhNimVrtyzCqgqP1Y8/5p1fne9Za4olr5tdthLBOIdLjo3X
         Lu5836QdLCwiP6UxWn0cNZr6gtPfBraCUx2734enX93Ym+mgnfvH28w/TYdZRqRU8qWi
         aEXNYxzxcF+6NU85Z+8QKB3IcCFBFDWKomTjJAji/W9QUhvqSUzcwXWLNFFKD+SsxQhQ
         pKI3r5AyecFXKqZquTkhjVIh9amu57ZaGcUG2yYmFi8aF7kWVBk/mnXmeTBI8iyb3Ma3
         Iwlw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2AkTCSvs6hqe3aS4SFIgQrFzIamXLqmtzUr0BjopomF9Vvr5SkaDEGQYcYZyDl79S2f9jqhgm7Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXq3SHWcmXCQlvi/UKrESxiiO9/h9skFKt0uYNXSvCz8ayfP1M
	ibCWtTOqxjiDGJgXSPLXdFc82pd2R+uTSJ6EbxCsrf9QmHB87UGn2yW1JxOC0ArkS1yHinyDpLF
	zT8Q0ly+yFtgIl7ModWzsoFs8+SWc2ExGTRUa+Na5vyuXMbfKpTAL6tETE1jtTh0=
X-Gm-Gg: AfdE7clTvAN6mODGVrlWWGqxtJ/lH/JCeLayYzAg6E7wtRKDzWS0Phh0vrQy7cR9WFa
	9/Q/z/ctEtyoaHGjHMZfCsCfp0I11bq5tl8oXift8XiNPiOp9OCKRwsRPS1NBko3iUX9dYZenZN
	ammqltokHmS1v4T1bPkO0HFl/QPtbGO5qvwHkNmETfq4JoTA86T6C15Je7HEBHufB/Z6/noX9Gy
	I4LIeUIuaTWzKMqTZay0Xj2I3dnS+98tMxzSogQkctlesyoFZe+dqZ7nZbzLTJKXOxPJo1gICnF
	FVDiyXay+nGy91d18Ti/Amb3/v4qcSnGEKTgpHvbWUHijB0qEkLjDAvTrJkW1j9ArhU2wc7gQp9
	LDzq7Z9u3tVdmbvyjxBuMZg8oNQ==
X-Received: by 2002:a17:90b:1d45:b0:38d:e28e:a625 with SMTP id 98e67ed59e1d1-38de28ec08emr5880916a91.16.1783971458783;
        Mon, 13 Jul 2026 12:37:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:38d:e28e:a625 with SMTP id 98e67ed59e1d1-38de28ec08emr5880872a91.16.1783971458109;
        Mon, 13 Jul 2026 12:37:38 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:54 +0530
Subject: [PATCH v6 05/11] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-5-bee265d3499b@oss.qualcomm.com>
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
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=2339;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=x9fBogSqQcJioAYXHmlLdEWBKjDZV1eFUot6gF6WwrY=;
 b=lI7UXLVv/TSry+HZZng1Czwu8BQjTDMxBdjJZJlE5346b/LBsksE51Wsyp52OFL6dulU73dig
 fi6pIIxh/m7AK+xt6ynT3pVN4MnbAu/U6AJSbnD7chGdTw2tVtQsls4
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: Sz9dvsmUzcsEVwnavL0B0GUrCsaK5VM3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfXxgS63CFtbIY+
 2Sv7Xt9jZXClANl/DCakELmX/uqT9bsP91Oc+nyPG5TMnfEthcJui6lhBhKS9ZzJTMdVdn6btxd
 vlT1/DIgv7/AAgrk24YeK32oXYmwxjU=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a553e83 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX5EyfogrnYOm3
 I5Db/peJY7lI30da8Lg2Bq2fypCJenBwRgXCUcAoXQWReKoytJTJPvOpNDvcm/6VCqinN5+1+gQ
 LFkaKFxLddJ6MaLsNgUraMVCCbtdzsrbenoR4Q0h7wHqBLLdhXmPFlTDMF9IA85U0rZ5P5OEmbV
 6oJi7LOf8+vr2kwtKBfiA3cLSogreEBVBVhLP3Uxw92OLZnuEepF/wvE4wp0Vft9ywQdxBqGcTD
 KnikwpZ4u3XiJYsBKZNVFZ6NVrGg27SVrMf9edw2CnSulqy0ddFK+43nd2jUJpXRatoikz83GAO
 49eRx+oDHXW3klGA4VSkIvFXff/4JngR7hW7agOxUl3KqZqV/bmFm8u9l6umnbRau8dcoI7/xLu
 VHCrqxHjMhe9TCXJfnN09myr08IEbNUMQ52rh6cplDvAUe8zbmw26CzYZP5rDJMau8xnd43v/Yn
 R+jcvv6kUOP7Ut2E/cg==
X-Proofpoint-GUID: Sz9dvsmUzcsEVwnavL0B0GUrCsaK5VM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12430-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:vishnu.santhosh@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A501374EC57

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 26ae21d4c7e3..53dddf35963e 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -428,6 +428,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 263 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lmcu {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+
+		interrupts = <GIC_SPI 287 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <26>;
+
+		lmcu_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		lmcu_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1


