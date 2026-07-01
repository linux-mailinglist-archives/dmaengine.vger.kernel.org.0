Return-Path: <dmaengine+bounces-11939-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FrAcCoJ3RWrvAgsAu9opvQ
	(envelope-from <dmaengine+bounces-11939-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:24:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808656F171B
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:24:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="fGxbE1/f";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UXj8A6JW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11939-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11939-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3FF307E6F1
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 20:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909A3B3C18;
	Wed,  1 Jul 2026 20:18:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458383B47E3
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 20:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937080; cv=none; b=ZVcLa8sDKI8DU/48/ZKCg+SZpvV9wc5KLdxApGWdlMXTJH3aGbzg4UZraL4bnIvWW0/SsqCfbd0UAK0hZQRU44xph7qMxM6AuHH/W/c169/aahN424KBtMuAMuHo5k4fKw7clIhOQagaPazDqRfZ+ZLavIXwl/mktjrh307+S9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937080; c=relaxed/simple;
	bh=NTwlaax/lh6AG78S/JgsCIhqbIXpaLk3tcWX2JG/xaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1f2LxAzQ76pD71BTgRqN1gI07lXwTJJ8oNNX5cffrSvh8oS7y1xbLauoDu+Qdp33jpmo1ApqGqEgh5JyY8XxcdWlb4Ls+fSQ4S16bdLGKNh+ZF7fjrD12mPkmlpdHxhWzAkmve5ZYlDf+YQrlok187ohFTfgKeMSG95ccRorX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fGxbE1/f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UXj8A6JW; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Gmxuu1627988
	for <dmaengine@vger.kernel.org>; Wed, 1 Jul 2026 20:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMQJhPfnLBvDiSVCVF4l3ibrl3mzFihtcnE5yfd3vx8=; b=fGxbE1/fRr3FWGh+
	r4JCOH5y5L0dT59tKsu84L+rDTy4LasQHxN+1xjRKtuatVOAsnIi5LicfdpmSD3f
	8gP1F00OdcUTuA8GbDpEDiI31q7iHugaP8ZpNeC8mBtkvXujrc+dHC8vzI5FKSm9
	xnfsKxNaXI8jfztw0nViruUc9ax/SzmDvUCzgFUafExlzyoZu4g7CBjxg/6id/5D
	pd4grU12qfEJisnPF/nSVWzkDavz33Xx6XpnR9kZmYdHzrcpmeroJQ1+y4tnRJ6F
	sATBfI7K9ijgNsjhliFiZ5V22WInttHziO7npBIn5+gcGsZjN4uVbRvPtBVG0jXF
	AEkNrw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f563090tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 20:17:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9aa197d5easo1836090a12.1
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782937078; x=1783541878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMQJhPfnLBvDiSVCVF4l3ibrl3mzFihtcnE5yfd3vx8=;
        b=UXj8A6JWIPVWKZIE55haaZ5SwzGC0XUmZOmOeqCX7FOu22NjZKfvKwi5JlwmfguVNm
         akgleHEphLOw68sapfK0AQAOEeQnuaIiSIfOPGIIB69j3qdk1yCHwq1LhvsetulT9khs
         vJIfPwo/BVYKRz8DRV2wa9blheJsE6m2LUG3b+7fT/l1a+lhAO4UXqCnjrAaQaysU+sK
         0WkGUW3qV5CjhNlF/7Skj2IHc8nbkQYBCKU4uQ9+Rpeo3V0B+lmJQvtWFpHuG9WU+Bv3
         PFC7sIcFta6tC72S72dh7XY7nNHYPo5HmKfo4zPF2pmY4OPWs3fCuvA84MUmmpL88SSD
         NXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937078; x=1783541878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMQJhPfnLBvDiSVCVF4l3ibrl3mzFihtcnE5yfd3vx8=;
        b=SfpT8h6AQt8HC/2GJn2xbK7spTY2VGlCkRkllh+JOYTNxJNHPpG8u3o5zkpR/Y94ro
         LA+iuVs6U4tkT34+UA3VdAehyMmfH/yPVN7W/HEN0dLB04AC8GocqpGEBVCcMj+G2DeR
         70CmXRsRVnEkxiDJCDesolQxk5Os/KIPyfHaavLBbmr9lbdFZC1/lyx481oVGylFywEw
         9RHvRadGN4llu1gbVNlD6ToOorRdHBXG+9NYE2su25MXoZ+dtnplvqkIU6vrFDsJfOWv
         NjxSroAHlfLj1uZIPRsh1BLOzbBKFWT+YMRshqrHfzT8KNo9r8Uf/LBmC9ebnPyKfG9J
         yxag==
X-Forwarded-Encrypted: i=1; AHgh+Rr+dfE0zfllKHxqu4tHl7C3BVMRys+MmjSxcbPQ5P1LYm8iuum4bifl9Vcp1zOvy3nmsCoj7BZHoOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYms14xuEsj3UJNgsd7fCJXCN0ii70IyATHJND+G6RcVSjrIX
	ouqQlUwyGohawZibnMzYGE5uJ6CvyEU+v8o/CO7u+bDU3AJAXA4yU7v6Mi3FmXA+hZ56KBDWO4+
	MZmZran0kDMzT6jzw+lkNal1qqVi1vHcjSKo8lpGHsxRQPU+i0JQBGM0784G0fo1fM/iTYbs=
X-Gm-Gg: AfdE7clGkf5lfJkcswoQVmbKvqQHgO1c6BokixK56t6pXDeZnsbkBQCwWovzLVtVt21
	yK03aTlK/3wQbQ4beWX092Sr8eNJdKFqYatK6qZHJosWis3ZHkbG2AdB5WRmtIilyJAP8tIDZVY
	fnmz8OcoNGzorEFvQLTQMY0sT8C5tlu4+SAgsDbSoDeuFryKptHnVmMAOAkOYcr59pxDzNJCbZv
	CVlMsTcneBTLwTjYlZYy+yjt/AXMt/tSpTnD2c4N9oFW9pGmA4lhdCbShuvvIFW6cXbxrSsTT7U
	PanaWyL5kfFaZXO0wsm5L2iF7aIKg4IOWH6XsCzyBIN5xkyPuq7nTrBcuQB+CDUqjbMMj07ySMm
	54w1SYIOy0IqGJo0PeV3VqQtxDjOujzZTzTZ9tXCbZ4O2
X-Received: by 2002:a17:90a:d44c:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-3809052f69cmr5463853a91.11.1782937077761;
        Wed, 01 Jul 2026 13:17:57 -0700 (PDT)
X-Received: by 2002:a17:90a:d44c:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-3809052f69cmr5463808a91.11.1782937077283;
        Wed, 01 Jul 2026 13:17:57 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc79231sm948685eec.31.2026.07.01.13.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:17:55 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 01:47:14 +0530
Subject: [PATCH v2 4/6] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-shikra_crypto_changse-v2-4-66173f2f28b3@qti.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JdiMa0KV c=1 sm=1 tr=0 ts=6a4575f6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=mnL63iHeaYg7R5sIRJMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfX8nwX65RqzVDe
 Lf+zYgatgLQgnJhKb81C7/JNHAGztfyDzlN3Kcjwai417MFXwUOGRXEwgWd51Ww5M+UAY81tm6T
 auL04RpEiWTpqnoDfyLALIrryg5m5jA=
X-Proofpoint-ORIG-GUID: Kqif5YY1K4AQMqlt-ROvbL03yx0QebsP
X-Proofpoint-GUID: Kqif5YY1K4AQMqlt-ROvbL03yx0QebsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfX4Ii6qjrL7ad9
 lrGth6ex6Iku2WNMaF38VdV9h5VdAiIhzQqdcuFMFv9BYOF716jQSJ//y+kLNn1jjLRvyQSf5sr
 BK3Y1z3aHri9k+aXqqAoopPMjzxulq+xFv/mMTOdXu4w34ohzU7q2wTec174rh7ViP/JdmCkK7j
 PWkYNMS5LSftCwX8ZHYqXFptLHMme1AIFIuHKPvF459E2rUoXasdoWl5EO1iFuanLzNKpdg4s6e
 jGgW2k+PQIU/gE+C5UgGUcNxVbRM/o7E2ySsdlM66v1lEM+xMA9pA/Dvj11M0kyNudGn4xmktb5
 1dsFerbVCoftKdJbSyhVwuENH69LvaTlX0IhKGNdrsZGk3UdpFNfN3VwsZD2EWbkIuMFQreJ8tX
 0XWUx09EJifsyU73QVwnExUwsOt4TmOfRxGM7xpEVzOTs4epIcxhEwEnR+3SGO6/F7HiF0iMW1B
 xY014MQ05Meskr85WDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010216
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11939-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,qti.qualcomm.com:mid];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808656F171B

Document the crypto engine on the Qualcomm Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 08febd66c22b..5a653757ee75 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -54,6 +54,7 @@ properties:
               - qcom,qcs8300-qce
               - qcom,sa8775p-qce
               - qcom,sc7280-qce
+              - qcom,shikra-qce
               - qcom,sm6350-qce
               - qcom,sm8250-qce
               - qcom,sm8350-qce

-- 
2.34.1


