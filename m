Return-Path: <dmaengine+bounces-12050-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qyytD7+sS2pfYQEAu9opvQ
	(envelope-from <dmaengine+bounces-12050-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:25:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A27113A8
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NZmmDXSm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KpxD1iTK;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12050-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12050-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8733444561
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0542376C;
	Mon,  6 Jul 2026 11:32:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0924403135
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337566; cv=none; b=m0acsnD4iloLviuquJKwuzUR22xieA1GqdZBht4E6IAh7BBVU2iG4q6f7EuaWnVAx6EHf5mZ+C3V/Eh4IrBaYe9mg+rfY8YQibHvcOdECw1/sYrbm0NOEP5g2zxbbg1BhWXlopCorQ3fC+aTzRb3PR8jBxayzRkhiJrt9v82Qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337566; c=relaxed/simple;
	bh=GYBtHdAfmrTdiirah8LRW7CT3SS4Dm/ZvWHw8lcOR9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uojPGRjcLm1rS9PhbWv/jzVJi+bFtneS1IupWvb+DlpNz/Ys6eMUyPE+TypLIORNxgMYeGf+gTCe1QxVr7Rvv+m4BjhhGY1m9WYoz2N01vvxCAP1AFah6E+SABJTCQSA3pgiqTWt8IlqijVLGQNtPU6EY0rWgRJ/Yk9YHnCgnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZmmDXSm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KpxD1iTK; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxIvi387415
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+52xMxNLQjypHGjCHfpQGl3UABCxpAIWFYZGy+rwJc=; b=NZmmDXSmzrivJIPd
	ZyZ0MVwKD/gP6BFrJxyqG5n4FwkftO9QAGxtEdYaNcL6y+aAcDvwRaHBnM+zOpfD
	Xg2A/tN512eMRk27ltjDJ51g5/7gVrlKUZXaAW43w8fG+TPa4zi4wSCr49zj30BM
	SePssU1S9FOZ/L45S7Bx2PSDEBF9Q6tINSmNy/Z/lp4ZhR50WnIgoxmZBOTho+3B
	C/6dQeIrIwUvPcz+Bw/rnni24NlhXzjbghVpiYsUoguG7FT8zj9ZgvC9bbnAyUsb
	/nCYYL1XDEk0vZC8+1gKcr+s1qPUfOsMDO0v+MZ41fRReIvmaVg1VURJUqUGtH9C
	vIKGZQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0bw1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845e3ede1f9so3261518b3a.0
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337563; x=1783942363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+52xMxNLQjypHGjCHfpQGl3UABCxpAIWFYZGy+rwJc=;
        b=KpxD1iTKtDkA3avPgQnpDNkhZKnDCb6Rl4TPkuIlSF5MVi528Sr8i6Z3+/iJD2HWIg
         QGMu7M7Uf0zM3ZayBpVmhVwzootIz8GZjabaEPpWWkGTLbl+S60/rCEht6/RglPNahBt
         lzRifZxVce5zfLPMeBaVosxRSktgtgcep3rfZri25sh/zmgHSjTJNTyIgKOatkEzVz0H
         r4o00BiUvn/ALScLIPU9mAB0IbnAv4yho+mVy//OR0pMdWqvs8LW6pQjixLBefSBsY8o
         SSz+n8Bs6758XohO3ICFGTS6cGo6QBhGYzICziDkee0TiLg5cXC/9fGAXKqYEs7o9jiT
         L2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337563; x=1783942363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+52xMxNLQjypHGjCHfpQGl3UABCxpAIWFYZGy+rwJc=;
        b=Bcjc5lArKkHsuYyVy1x/8HZ3dQNnoMK0Cr+MWzJuy0r7LR2SeJhw6TbFwNcHzJlMqw
         UrqIhDfRKPFrge1yj4Hs+Z839rPzpya/La+uxcZ89RpdShmzK89rf/IcwuXUnU6EZ9qN
         rXfJSVnks4OYPaWmZikDHV0OnCCHtSgUW3A8FjVokOfkjXFTO9Vdq260zo9w9H7fXqPP
         jDMXvdEYWYZ9t7YMuQfp/XGHdr5jN4g3T5vo4uSUQqQ1iuGjEBqkvlVrL8idBQ+lqo3H
         ubFAhCH7gtPzaQIHPCv5ZA5jGweSLLbLE+Y9+oKFqM4aqYEGqW1fPXG8WSLFCo/dGtaI
         cBig==
X-Forwarded-Encrypted: i=1; AHgh+RoaWcp4DD4SmjuPx5FGMu0Z+hbQ3o7ZJLCoFjE5KXdwaNJAD25xeAHhRs6uVp2ZRUzwBlHlzBARITk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2Ij+ecN2JaPW5+gMYplnSAt85HUck2Q0Yq447awynq4a78VQ
	Gt6QbzZBlZtDEpVkjqD7rQOzUXh1XgrhnYd2UDIWnOKQpsM+EF1YAoTcNEi3CDz/DmgQdAiGzKo
	tzz7QFK7SFf1Jb6TsdFOsjuYR4+wMJh2VHc5e9l/oBJEdoexxs9ksdRxHFmPxEyw=
X-Gm-Gg: AfdE7cnqn95IG8NPkzowBBukIS7nBADuzGd4Kf8l/AAAhTniwo3HXHOf1GOrXZg1ihN
	A4gpp/PqknOKuIalMX8kM5Ri/V+sgwIVKfcd6sInxznibXolx5L0QSZA/nVrIwhv2EELzHZ/uLg
	jAHohRJq6rXWQfyHC2ROXqcJrvpZqDfjHqCnqAN6oBm/YiouSJKeiG0rTIwCYkPEc+jRaBwOxko
	KILAfwvfjGeDPFWEa5UFZ41fwP8zRF+1K70rDWEA5FvqrDmlbljSplUrw/I6c2ujuqtVZ5hXp/l
	FltGrDQ+5VBhlj3lOkr6aNcYnAkTbnRn6orYUTeRT9GIvNsxVVGDvcWYRKBjrIM2irAM2LR+DwH
	tW0Cq4yKf8MD5UytV4abz2Blc6tCiHfEk503+4klI5qXl
X-Received: by 2002:a05:6a00:f8d:b0:845:44ec:a648 with SMTP id d2e1a72fcca58-84826c0e777mr151330b3a.21.1783337562909;
        Mon, 06 Jul 2026 04:32:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:f8d:b0:845:44ec:a648 with SMTP id d2e1a72fcca58-84826c0e777mr151295b3a.21.1783337562368;
        Mon, 06 Jul 2026 04:32:42 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:42 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 17:01:34 +0530
Subject: [PATCH v3 6/6] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE
 nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-shikra_crypto_changse-v3-6-23b4c2054227@oss.qualcomm.com>
References: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
In-Reply-To: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX1NVSCSnBDAdK
 5Kct7Jwk766Djv2jqmqLyjqu+brBwNlV4Oz55vYkHHBPWXoYn0SN1mfnSiQ2c8zKGvfqjHsCW9p
 FDSdtktzApRYcKnfX+tQ73e13/GzRulVqaskACzS7OFF4z7HTS8ryvpFprSykWMP/nhwo2jGSlm
 pp9SexgHS7Z3kLsBwuBKyxpo2MELa/YPyn7ZwKWDJV5XOApQLiQHvpPM+9SXHXSt2pnoF5EpJuh
 k7MuI15eW4ahZ+3T+Gm40DBkzBUQXpDGkfwQ5juQ3v18bX3oEGB3O/+5zWUCfzsLIKP++X6jQRu
 ASwTPWEqk5OJAHnCpK1/9CcozVQGzPeutthL4YCqyDtMUxsDIzbMV2v5C3laXMZEyG4RkM5UNNt
 Aon7K5xQDtY58wyVhVdLq6taqgc+sJRlSaK7XHJPAe/jB/yEDFZvwNYWsDink9OGi4R3HFCg5sv
 R6cVPLE+zMWo8lIlJcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX7Y6/KYfKF3Zf
 8m1tOlaOOP0ifh+XG8Tgxb+XDMTSGrw5prPUCnHqKnoD6OQ6tla8q7ePG8eyCrsgn1oBzi7+oc0
 PjuHPD6t4JZoAm9wprWfsEZhsrHZfgo=
X-Proofpoint-GUID: hNm2q9tj3ZrpV6CMcUtcz_nPdrFTKwYZ
X-Proofpoint-ORIG-GUID: hNm2q9tj3ZrpV6CMcUtcz_nPdrFTKwYZ
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4b925b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UqF9ul3sJ95V4vUiljcA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12050-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 708A27113A8

Add device tree nodes describing the crypto hardware blocks present
on the Qualcomm Shikra platform:

- BAM DMA controller used by the Qualcomm crypto engine
- QCE (crypto) engine with DMA support
- TRNG hardware random number generator
- Inline crypto engine (ICE)

Also connect the SDHC controller to ICE via "qcom,ice" property to
support inline encryption.

On Shikra, different BAM pipe pairs (for example 0x84/0x94 and
0x86/0x96) may still resolve to the same resulting SID due SMMU-side
optimization. They are still distinct pipe pairs and therefore require
separate DT IOMMU entries.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 4e5bc9e17c8e..a95e2140416c 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -482,6 +482,41 @@ config_noc: interconnect@1900000 {
 			#interconnect-cells = <2>;
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9f 0x0>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <16>;
+			qcom,num-ees = <4>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,shikra-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9f 0x0>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 0
+					 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names = "memory";
+		};
+
 		qfprom: efuse@1b44000 {
 			compatible = "qcom,shikra-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b44000 0x0 0x3000>;
@@ -521,6 +556,11 @@ spmi_bus: spmi@1c40000 {
 			qcom,ee = <0>;
 		};
 
+		rng: rng@4454000 {
+			compatible = "qcom,shikra-trng", "qcom,trng";
+			reg = <0x0 0x04454000 0x0 0x1000>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -582,6 +622,7 @@ &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
 			mmc-hs400-enhanced-strobe;
 
 			resets = <&gcc GCC_SDCC1_BCR>;
+			qcom,ice = <&sdhc_ice>;
 
 			status = "disabled";
 
@@ -604,6 +645,17 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@4748000 {
+			compatible = "qcom,shikra-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x04748000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core",
+				      "iface";
+			power-domains = <&rpmpd RPMHPD_CX>;
+		};
+
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;

-- 
2.34.1


