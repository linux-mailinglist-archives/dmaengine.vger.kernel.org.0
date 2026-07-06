Return-Path: <dmaengine+bounces-12049-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8SZiDMiSS2oKVwEAu9opvQ
	(envelope-from <dmaengine+bounces-12049-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:34:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C897D70FE58
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=I5IQXplB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="g/pYXUAT";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12049-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12049-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AF4A3041806
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A541F7E6;
	Mon,  6 Jul 2026 11:32:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E673BB66C
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337560; cv=none; b=p2urWqE/ITd+dcktsipYunLc4wXBgO3Ae8uD/ADDY9MEvq5Z4l2xXRoUZHU8RX9JELXHnVrXfn4/uvBY//0OxIj31dG2U8ftefa9QRvKZrMG8iUcNs7RqF4jGAkzh+y0RQCbryYk70bnxYfmZQxHd3ZnGl9XXKTX51GaT0GWpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337560; c=relaxed/simple;
	bh=cAJA12cau20p7KLPFzYEIrSS6Dvfi3o2tA5fDVTUt8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4B17xYdLIEhW4SxKAUsFSuyK8ax4gP1WPzvJqkOAli2jW11OGY4KY1l7ritCdEwWEcVCAncXilPQBxiimbh/7yKuz6KBVhrzEhEFTDPVl0vJm1mtTxSP2TfbtE5uMOmST+cXfbZtnxvyhx9n9SJirw+o0h88chIT61wtJvecDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5IQXplB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/pYXUAT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxDlK395287
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q9s3aaO7TdbWU8wQVqIVUSSkTdkTZOTjFslg4CjFXd8=; b=I5IQXplBqJ+g4WvD
	3xBaHm3WYz+gjMJuVflFBf3Uzhhp+ZP7N5HgyS1J8+0beIOs8KN4pP/AaDIlz7p7
	mx0achNEF+v/zf50Yaf17n2/2+Z9b2+3JHAyYcNxs9csB7mAp+9rFlzK2CBtVR2U
	7IEtkJI2ScOmzzlPRkwE/IKZMBQw4sc+HwtTwrdpGkUeVmfljLNKRW7LXveV5kAq
	FYdToZ8QU5vLEDlb7T6fxUjklZCWI9DA3ao3k5dfnVZT9li0tv1KTSRaEJGKtS46
	d5uMH1x7JlgukHG4pOemzmVdwnVcCoYwC2Angzh5Kn4JycmuSrkGWRLA+w+CWOyk
	OG3OyQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpgfex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:37 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847e32ef4caso4621693b3a.2
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337557; x=1783942357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9s3aaO7TdbWU8wQVqIVUSSkTdkTZOTjFslg4CjFXd8=;
        b=g/pYXUATlZKda2OR3Pl2/Lxwshw5IlQu3Z22BL54jyQ69fP2mlhqjHv0p6ChJlbB7m
         oVXZ3jWP9R4CMWptcWZG1VXPlQx0Y16J6SHUZq1E+S2xsHeGoOFbAAK7lo4+imIonaIv
         89i4wsU63tjgQJwUFLH/JTAYc+BFfVYsHfqZffroFZqQkMlRwdo6bytiJEGZ0fQXvdWD
         0DOxwIcGisWhoCfqPw1DUjYKyIho29fkYHeTWxpyOR1WcEwEYzn9mIJRYw13XBV1s6c5
         WEKEnbQOfJFKWXddWh4I/mehYgFGGsJyK+rnHvp3K2TbjDbIAXKQJMaG2BVD4gyrzMje
         hBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337557; x=1783942357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q9s3aaO7TdbWU8wQVqIVUSSkTdkTZOTjFslg4CjFXd8=;
        b=VC8W8wUd3W58UiZXV5umNNa0/4eT5goChJ+8wNcjRIZSgxWDryhUvr5SUHi46iwCCD
         C/wVlRQ5AW7Cr+YFhB/JsNFwQCTayPm7Gt9C8Qcr0B5yGeLfVpppOQIQSAwasGfpokPj
         u6KpxcIV4YkdwZDYyDFm72io6+cdo3AIpLQsBLcfjTIHmA5RTbyp7KSIlTKJ4TaJG6JO
         ARotbhIAN8cJAnuhjVyoHUZosQI/rOXxetTAY+Mu19Ie7MvRrN0kAs0EdteL78ZreHR8
         xj5zidBwMbWRrSs0C8LTPDUYz+g3WSE9sDutSth/5JmI6NA4xFp978PvGTAVPX6rVXXl
         NjrA==
X-Forwarded-Encrypted: i=1; AHgh+RrcWLuNlO6vRX4URBx/ntomIluJwNzCGfxu+L4CczJAoKNjRvVlR5640BYyatidyT5GggrTLA4gF6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2KL3ZVdufIAG3v5oJr92nCflRLEw41Ex9ZPQ39rVf83Vin2z
	wnUkZu0Iy6TPgOw8pG+moXsZCJvIeoR+WhE2QJ7JFIJBc7+mwAMbM0KDvCJzHLszuDGvrmda46/
	k9mHdDNZqqqKLK9MnYCnPThM2JRGtnE7NgHWPfhCCbv6SzXGsaRVsAfwkk62ty1U=
X-Gm-Gg: AfdE7cmFeLdwHDIaWc0o1HuXBquzEfjJI2fCBHlRXbSFhF8MJurctbB7YxZhiOGg8ex
	fQnd1zs+R5oFhRs5K6iH9s7uw0HNbuB9ndOVezbf9EjTeUG0MxLTmPicnQa4b60mC3ZvzzOEIbF
	ji/a17vgh7YU2S0lyzRze/3XTQqZq1AxbDKi4p0dx69e/8FGNVRPOdx2DMoyQXT3oKyfCmE6laZ
	p1i4YJNaTviKi6pbfbmO9LFXMV0PLWhkqwTC+XlA/HUGYh6WWI0com0hwbvdNAEyC1Kg3FJ0Wyj
	fYFJuZxk7f8PcH27b7WLPB+y7iJaMiXSRF91LYZ1ffxxzROM1+Qhabz4GKy9ZQVsdzCpmkd9Hrv
	yZfw48RsliVG+j8L+80OtGugBMAmlbbNckqfp+9RaT3Rk
X-Received: by 2002:a05:6a00:1493:b0:847:80f5:c616 with SMTP id d2e1a72fcca58-84826bb45eamr152662b3a.10.1783337556682;
        Mon, 06 Jul 2026 04:32:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1493:b0:847:80f5:c616 with SMTP id d2e1a72fcca58-84826bb45eamr152613b3a.10.1783337556043;
        Mon, 06 Jul 2026 04:32:36 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:35 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 17:01:33 +0530
Subject: [PATCH v3 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to 7
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-shikra_crypto_changse-v3-5-23b4c2054227@oss.qualcomm.com>
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
        dmaengine@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4b9255 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=56hBLZIh0n9IShKQQEcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: nRAAus0pUyzirMDm2dbxTV0DP1j_OSnV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX6eXx53psg9Zu
 QMbYyzGfoVjb1Bsi35+D1pQ2lLd92i5jwuHvtq/RylJ21/X9lova9jFLB1hHgBz4RJ5NGyg8XvR
 2v+BGGjP6p/VBZZdlHONcAU3ARhvBEkstpqfG71OfAsW2/npaQK4m+sFSwMmTpR0SiTQsA63RED
 IvDuMb/xvC/RXoYYfDZbPv+FwYf4U7avYvp+VRgkS7fMJ/Gmdu8G88Aa1wx5ftWNdu5z+O9IPSG
 pw+spetyO2G4JOQg03yahPfQIWHUT4HyyUvS4+86IXaYkmBcBapOCOD6Prv6st+AFtTut5zjDUO
 WNPzlQqvLE4CSUEBGkrk22GKjrn3idNcq902sh2aCec6/UUEL1u9f2VNq4xK0Y5PhDAtYfpY45M
 Z2LFf4IAWn/Z69sj68JA4BpFxK0nPGAGmusTuawJbMfYCHjpOpe7URSyG/j5dpQpk/1WA5w4yfZ
 u0plcRQK9BC4yrP9M6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX896ap2AEt5RQ
 VX/cGOI/AnGkHPMq18YWNJ1BU2t27zX31UZqOBp6HtKrxR4+G5aFzo0HhNZVCYTDKW19VtMFuNp
 d0xMif72LskS/HvAwZ0ZUlXZyZzs/A8=
X-Proofpoint-GUID: nRAAus0pUyzirMDm2dbxTV0DP1j_OSnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12049-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: C897D70FE58

Qualcomm Shikra platform describes the BAM DMA node with 7 iommus
entries. The current schema limit to 6, so update the binding to allow
up to 7 entries.

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


