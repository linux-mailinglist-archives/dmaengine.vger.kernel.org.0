Return-Path: <dmaengine+bounces-11940-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8z6VA/R3RWoEAwsAu9opvQ
	(envelope-from <dmaengine+bounces-11940-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:26:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 514FA6F174F
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dEJPQP4I;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DyZCzMsb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11940-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11940-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5095B3151ACF
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED723B6C11;
	Wed,  1 Jul 2026 20:18:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9535EDBD
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 20:18:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937087; cv=none; b=W7paNg2HNOKpchRb0EN4mUoqP1cQqQmzcdO3SPMMf/viInlyCs5LWLl5eCHA86Jq62xVYSwDr2iWtg9yBseREEPPaOWiJdTYZsyh1lz7h35aT7rHEPgUlbuQSDl6pKZOE3mJW6Dm9ErK8RXHMSA7AF0MvXAOIyd6psTumjfd9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937087; c=relaxed/simple;
	bh=Eze2ioRdq2rIO2XoIkqX6nNtdm7cYbxnuQNbvnOoajE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwwlm8C5oaGrDXcEC4NmZ+kyYFRZJQCbaYDWh4UQmXoxn1NsfGC8WMLKk5POOagF1Epxfb21mqrfe4a0yA3NnYvYWbhMS676ondZqIyt/pWrNDRdrKjVCGeGcD4JQTUx2dx7uGmDTNluRLSDuEwSdWBU6p097brPZHNd6p8jg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEJPQP4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DyZCzMsb; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Gmemb1712899
	for <dmaengine@vger.kernel.org>; Wed, 1 Jul 2026 20:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qyrH2W2sfwjDNEPGQYVoT+aVr52hlGBGd2sgUDya5+k=; b=dEJPQP4ITFS8647p
	h1fmsJ6dgeHyDHH0+enPUAWqOCeh1Yr65C8UKnFV8p9o79BhLpbdUvmaurmgO7AY
	DPpkoYFpIF54KImEGqGKZuvM6enoLDQ1kfpnw7mzWtN+1Ts463yYTdLEjGl5SGi0
	bS3bEc0yTsCkStI0rDPtxUm5TLuuv7eGq50XB2VQ4LhtzJzsLtkL/k72Q7PSQgGw
	Fgc54XSFKcWFbeOmMBFbfbcMQzv29pn9KbhCkGOUpRJSJrKUAB6dgRn1h7zBXGMZ
	9wZxbv1C2RX1v10x5uFDO/J/BYWwz0riN6wZY6CFXxdS1gwJmTIfaSTJB5FpxSkz
	sGmYew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd2hbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 20:18:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380b630c505so674915a91.1
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782937085; x=1783541885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyrH2W2sfwjDNEPGQYVoT+aVr52hlGBGd2sgUDya5+k=;
        b=DyZCzMsbFma8dqvNj9z6kgZ/tHWOVe+521VBvxU0VKMTAuJFA/94MuNMMznwmqaULP
         16J+nT9AmNr6Iw7rI1d2R8uJxARP3v2QlWzSx32UF6i7fz07YE+ZGqvyVoQ4P/CAN/h4
         kXW8eM293iERZ5y3qaodbNUykufBM5U4beVZR4T4fM+TpCFpkR1paqS2WNGHOFmZtAXu
         DMWEKXvvieYUBQ1SfBjIUsom0f988yvaTk6ZWZc4ctp8XF9+CHveFacEDgWuRAy/4QE+
         /oMklyK60R8LkuueaSggzu8I6D/j00ubvjzesEBQjn7n3kROy5ey1bkq8bk1l98US12D
         YZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937085; x=1783541885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyrH2W2sfwjDNEPGQYVoT+aVr52hlGBGd2sgUDya5+k=;
        b=PIyFkotEoH3WoV5h9r3FcSYeEdQc5Pb43X2T0ZBQhRNpR0cHTaXS6bdlu0KJvocao+
         ZY0z8Qb7t7oyTsYMCUqHOhkp/ATbIgr0JY6R+73tmR0ZIueiByS6rp8zzj+GFQ/VRxfq
         fnk1MWBjUNfdN6MnyPonZItKDeDmXv8L3LmbARZ6WrVwKKYtsohlInBPlWHRETxusiBs
         KDO30P4iLr3m/YkBkDAlDBg6Kdgs9C7TASywux1GSZRj1USD6rdqw13Q44okxwzwtFS3
         eLY0HxvefGxQuNz8kdXoHCQcZq7ORoJIXt23ey1U4P+LFSwPnwbEdwo4Oa3XcXNIoj4I
         gswQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWcUXj874LmvqVs2NP+sRR3DOuHj3CywOD7m/au4/aeK/JP07jvYZ3SdGMLlEeZYXS6mLk9oORNu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ILQ31zzVlUyAysLaVWeq2pf8odsy1dnkcP7bW5qZVT2FaV6T
	K2p15aiv+RNZyPuq4vg/Foo4G5crsJ6/dFuFhfeqc/LfwksohrPs2W38wJhYv/wvb6SKbsa6k2n
	kok8FiSWx7V9kY8qnrYJ9XmejXRYCLTcUsflr/uTXmylZuMlN1U/idWBtKs+PnA6oHRuPyvE=
X-Gm-Gg: AfdE7ckJgurhwvGikFUDL6ne9CqZf8OFuyFnd9Q38UYCQBmGlrQm/Auez42NGxOxfsG
	qbOw7fXmsjmUOTE3Mxo8u76oRZ76ndKiIEBnJ2oU5Zv1FTyWSL5YUMuZ9nazgTmcnJkU4OwjaQ4
	L3UpLVwKeXUhXM0sTGhDZjJVjJ47guK+/Y4Ide3Hp7GFeMI9XtlltYD06yhPdAIYccnvN6cVHS6
	UjQKDMMTApK06Oqs42qCt382Tp74Fp/+j0R0AL/+Z0VqDw/9BXLaGjFc3SvPzHlXwuu5d414DA5
	yl275a9GfIgdcICh70OYDSSEy4XloGuzoP12rS5rGh2bmRYnN2lF7oIA5zC57dtrtdffKAP79fu
	J8cpyNlX9s/NJJQgC/LxTVjXFCOBpvIq62wccLfN5jl0L
X-Received: by 2002:a17:90b:1fc5:b0:380:a5a9:7586 with SMTP id 98e67ed59e1d1-380aa09529emr3081009a91.6.1782937084660;
        Wed, 01 Jul 2026 13:18:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc5:b0:380:a5a9:7586 with SMTP id 98e67ed59e1d1-380aa09529emr3080968a91.6.1782937084168;
        Wed, 01 Jul 2026 13:18:04 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc79231sm948685eec.31.2026.07.01.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:18:02 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 01:47:15 +0530
Subject: [PATCH v2 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-shikra_crypto_changse-v2-5-66173f2f28b3@qti.qualcomm.com>
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
In-Reply-To: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
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
        dmaengine@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a4575fd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=SaiSOrgfs3erbmmhS0kA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: niiOG_2zVNxAjYaHnPxk3VP1JYAZEV0Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX5sw3a5RJv36I
 iJJ6PGaPCIU+bxSD6wBbL4voaMogDCyj22zAmCP7y2rQ9aCpv0NgRFbLxz5S8YKQ3fKdA2xnnRo
 ZR8oqQLcfWqIWpEr56AqsrbMNBnm73k=
X-Proofpoint-GUID: niiOG_2zVNxAjYaHnPxk3VP1JYAZEV0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX/Qoi0+MtPSRy
 kFibeY9PKQqsYc+1QS9sbPLkXkkmS4GuoC2QC/V2h8AW0fKe7/ap1TdKiyk1IvLzlKxlFJlbgi7
 UwsqyDh2e2p9C3fHI2GxvHNq+Kn/p9u8KRgKYkbVa+yQbY2mf+KAxwhgIcppPP0Cf+TGTI7i19R
 6OKCBZaCpJpa799WcSdzTsXhihfkkm47zXR4WBea5JxMv7ilEjFvAlpU/WW4uuPOANFoNFtSX2k
 FrK9bqFK10aDpaJDSt2MB8nXue+JfxGerANaLCR0aJdqnzKit5v7CLNyhrI5xEKF4b6HsCNZK7J
 FOpFc50s18yIUArCLCQivV7jgxgm6D47CJ/4O6nHpv2/z3/cPExJDPERM/Lp0GaODu4w9Cu36g3
 XHAKzho2RO3yE5bcy1g1+jZF2SIqzmgvfUo+Ai0I/5cL99NPUnC2B07E+NSrG0ePWLlyY+kjlSy
 TQcmACe7CH4gfUtJ6bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010217
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
	TAGGED_FROM(0.00)[bounces-11940-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 514FA6F174F

Upcoming Shikra BAM DMA uses 7 IOMMU entries and not 6, so increase the
`iommus` maxItems constraint.

Fix below error:
dma-controller@1b04000 (qcom,bam-v1.7.4): iommus: [[25, 132, 17], [25,
134, 17], [25, 146, 0], [25, 148, 17], [25, 150, 17], [25, 152, 1], [25,
159, 0]] is too long
      from schema $id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 0923fb189ada..e72adc172af1 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -48,7 +48,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 6
+    maxItems: 7
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.34.1


