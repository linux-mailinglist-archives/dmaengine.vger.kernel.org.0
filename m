Return-Path: <dmaengine+bounces-10110-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMJMAo9V62mmLQAAu9opvQ
	(envelope-from <dmaengine+bounces-10110-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:35:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92345DC87
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 199673003611
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647403B9D9A;
	Fri, 24 Apr 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8uRfAwV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYCke4GQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D03BC680
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030513; cv=none; b=sRqZvEt5JyWFtqN+uSHEtzL8rGDhJ1uiCtEKuYpARIQAIwEg8MPtaJoxML/z5/WO6bpG/M/2CXRrsX4yJeTIiN8wLZy4CNAbIKbZeH0RUaCzfUgQxxeJTWIJQmsZyoKkn86KiXZ04m0JAecxu0xy4miu4NxG5GgQqAQSTxKRuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030513; c=relaxed/simple;
	bh=1+hwOvp8L+mZq2tI43pSkxj8ajhPg4gIxb0JWVm3tFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/3u1zZKOXqbBGp0BxaMRMc6iW2lyoLaSwmxjMV4pvyjw/v110rZaDbXBDTV77fOBW/gaHjf9UCp7PMEk8a/IzBMz5m209gPFjHawZuXzHBMpNMcVwDAZRvIGZZ0/xkWEMOivp37KuzmkoX5jQ5tKv4VG1kXwX6Dwvr/rTrowi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8uRfAwV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jYCke4GQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O8NZPg4012134
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VDKwjFJfEwBBY39KCK7JSKoRCKazpHWw05t8Msb32n4=; b=B8uRfAwVqXrgBHBg
	l6CM/eSxM9d/Awj7v0mfJM0MNE+SviepEWM9OiCuLgQIfp9UUWvlajACclM8SPg4
	E4OVqYLuvou9AfNpy0yY0By4+H48jDqvBFB9RUmk621DnbXXZRfN7WWs3VnaTnkS
	tMMPUy0ghLz0U+F3kmlUtucPXnRES/obhJrlHz64DEL/40T1HBHcChoRx/jPBtAY
	noCsGdyhtQyCwgHCENimOLXCKoELOkiynePPykL+N98Fn9D3STmFmO/UtQhOX37R
	46l5jEHWw72ypTqzaBusKZ11/D+XoAX1y6+PgFI6FYGu9ALR43iDTT5Fazo+rkNp
	h/YlYg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpq9v5ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:35:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso7709519a91.0
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777030505; x=1777635305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDKwjFJfEwBBY39KCK7JSKoRCKazpHWw05t8Msb32n4=;
        b=jYCke4GQtLYtDPHG+i9T3pGCCVuI8idcMAUax0zPwmlgRd0l/TViCo40Y56Mkq6M2L
         cR8bWCYn+1+SNqRgfNKvli9qAJAvWbDuANYjNAtqW9IAqSMO0x8vfeqAjbQ6GQBFM/Ve
         W0yAmkByKknVe2u1Q37QBf8eeKYCSXhGX46KyIUbCxrkM2fkB4SQJUk/PVGp8ZuBFN1C
         F4nuuw+FUizJriBCH/lYuAxYYkssNZ1fnoUs1YwUaN6wQqg0OsBjs3VDDVJR8vphE//f
         hgn3HSXxzL08UtfvW9/5RYdnfznvzy3wDHNbzORunJXIePVinKQEFY4+4Om6QYIXNXpD
         56EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030505; x=1777635305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VDKwjFJfEwBBY39KCK7JSKoRCKazpHWw05t8Msb32n4=;
        b=ryZmD7134q6B+94QUrLgoJzEKiF6Vx9lt5KAb+cJK+X7y9XyIVUysc0CH917pDEpVm
         74+sA9QjCrhlD7XhIxnyt+dKSthTju4eNEmfywG4IDT1lSg7+0ynUcjTpXQPM4CE8LEm
         isGmimb5uVwTC+fjYID9LRLxLfV0uFsZ4fIlXflC60NB7SGA90TNj5PeN7VdMcY+bgaN
         FoH66b7KtEgoTy4EDNCdnJW4PYOQP+WfxK3N81rxe315Q6r/vLYKK9LejHn/rEYL07zK
         eGlx03C/y0AP6/JxkBMMd+oNloyRl0DgyvlFj0ZVYP9Fv+ccraYR0uK6ID4XqERIWfCW
         Jzhw==
X-Forwarded-Encrypted: i=1; AFNElJ+665zgv/0a8t2Lz+Se20lB6Tzl1+bhsGldloo8zm8krGfFHsANMO4O0hX2fzaCOQdCXg7elcBk6O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyDDo2X4LJoO/exJqoJF/vc4GzYr8ma7expoRiRkaJXQjLhPz
	UlN6XAbZPo5t204NPAZ3CG+RRZDsoElRjxV88zhq4m3OA1xzmOVbno3xLmFyyYfQi3+11xW7Ld9
	0BkERM6+LGH2kGeGqm5DcBx5RvM80IUc6eG35pWa85davxQpzuesT+nhb1/M2EGU=
X-Gm-Gg: AeBDiesUvmMt5Nl05M8cbZ7KJKXJ8WUmJr7DQARyexsHaVZ3unP7BMc6NcZxvyu1jPm
	H695CtxQMeOC9FxjIuC7AY70TtqS6tefsztfFucAY04ishat4MoZ7QFKHINV8Tmsyi1J2v90R9C
	qiJT7Upx9qkeP9X4U64stIPIRY2B4/jUh8qUBh8HkOXMKZhMWxl9+PeLGUWZ2qGBFEaMtT6+/cS
	WK/WTXUrzw8l5fo6KLlVvKFBxAUJYxTh8Oinx9Xu+ZefdAqLaeBJiwJsgoA0D1jR5urDxdZ7q/n
	j8k9Xwi9vITFDBkfYjavEHja4Efq0iPX9iynfjzP3X4FKtNNqPaJ+ljT1dsITYecRXpFPF4RYcb
	y8lO5JuFOimXFZ3e/J3Yq5+k+qI7Bp2GS88DtMa7806k/7UGnvAYB8iOOZ+rEyZYOog==
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-361403d61camr31243757a91.3.1777030505288;
        Fri, 24 Apr 2026 04:35:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-361403d61camr31243725a91.3.1777030504818;
        Fri, 24 Apr 2026 04:35:04 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186adddsm24204734a91.2.2026.04.24.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:35:04 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 17:04:17 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: kaanapali: Add qcrypto node support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-knp_qce-v1-3-813e18f8f355@oss.qualcomm.com>
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
In-Reply-To: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMCBTYWx0ZWRfX5Fh5wpuHZek3
 VpzG4rO5A6dz35qScxESkYPe//OeJt+pZ4m7ffiAJOx1uUCpCOh2+/5cWqa8pIqRbeRv7TEYGCZ
 J1OSR3/DoHa2MB8+pGf9NSGPbAoxbfX/Bzc0dyENCkRqsMCc/cjEn8RN13wN5rJrkBbjZ6xi6IE
 /UUha4h5wxukcvhOimuCYNCceun/V9hz1lp118MqVKzSQyBG1F6wCEJo7vdwhqGpm3yuzT+i9oG
 9o6v2YmxD6RFKnGOaA4HVj9Bc2e2MXY61Nx0uMiWTLMwNhoQ/SUdCIwc3Gql5MJhIOxBEbUF9Ng
 npNQPMTbq6p+oI+pla9Y22dbV8qjNFbtqiqR/C3rY0wYcIUWN4GPRqs6EY16IzZz7IjvgHPXfRj
 2u8EQ8IQM3qiZiZr4Zicat5zXv6qK3/FMOeKt/oR45Sqlmxj141PO0IsPziGgcV7at/IGg+Rf7I
 cWDmTMgVqU6qPASSx1A==
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=69eb556a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=lX4hch5PzS7iFd4KNucA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: PAEpECddIeG-AsqE_3vUZ6CO6frWXh1y
X-Proofpoint-ORIG-GUID: PAEpECddIeG-AsqE_3vUZ6CO6frWXh1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240110
X-Rspamd-Queue-Id: BB92345DC87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10110-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,1dfa000:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,1dc4000:email,1f40000:email,1d88000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add qcrypto and cryptobam support for kaanapali target.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 7cc326aa1a1a..941c9b131a4e 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2541,6 +2541,31 @@ ice: crypto@1d88000 {
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v2.0.0";
+			reg = <0x0 0x01dc4000 0x0 0x22000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&apps_smmu 0xc0 0x0>,
+				 <&apps_smmu 0xc1 0x0>;
+			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
+			qcom,controlled-remotely;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,kaanapali-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01dfa000 0x0 0x6000>;
+			interconnects = <&aggre_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "memory";
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0xc0 0x0>,
+				 <&apps_smmu 0xc1 0x0>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;

-- 
2.34.1


