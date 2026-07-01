Return-Path: <dmaengine+bounces-11937-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cupBFkx4RWoPAwsAu9opvQ
	(envelope-from <dmaengine+bounces-11937-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:27:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0F6F1767
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TifYpNU8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gn8Qz9kW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11937-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11937-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 884B8304E49E
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894A9431E51;
	Wed,  1 Jul 2026 20:17:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276CD3BCD0A
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 20:17:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937063; cv=none; b=B5t7zzLvSuWJpofP+UfD1C5psUUnc2Tc2R9d6wrd1DIEubYhTqc0nPO0TWGRW0HR9+CQioS2r2eMW19emY4U6t5ut10VTfNRY+hI34e/7A3cmeSZlkWz3YHuDwIbbp4fiz9oe43PdgifVtiDmVFWA8c7VqtJkkzQRfa0h2WCC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937063; c=relaxed/simple;
	bh=fUfTQ+WGGqb9ciSQbpp28uE1qLiRFaDJmt4FAE0yCHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOmSluKlfzfSypSqBESRQk9ApIvAHCfVXmgu6gvL3VQOt7to2fMCPMgoElbWzeR3hFPvV/G633wc1JVRhsQUHFMcspy8FTT/msMbreWvSV7AsGVt8gUv44fDPSpsZ8Hhch7+T6PeYbiP4uHP0XPwl40otqeocoHVSdK5WkXWq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TifYpNU8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gn8Qz9kW; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmvFd1590185
	for <dmaengine@vger.kernel.org>; Wed, 1 Jul 2026 20:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hIELCf9duknysKswcBTO3BHzbOM16+pkKsWIvb8AmDE=; b=TifYpNU8yhMH0nWe
	tBrcEwKQl4WmWmPsPzppe1M5omDMVDtEt4HwlaKGJ5q5DNOVp/kEIC5QtbWFu2NR
	TeG9CwOqTU45vvqWFNCHozxviaQRgL8uBTVwD2583ccZiQCurwK3d8NfZs3ANUdJ
	SXMCboVQc81nWk1JsbIfPihFogNJb7V2RvQPZGGYIKpKq+XOWaWtc6LmIyWI1oZP
	ZjKT1sWwVgASZqida9xHLs2wVJEvKYP6Am8Ns97Ncruj13doGdmK+L7W1XcrYPuU
	iNs3i1+eMrEuqSyEB4bp8Vdmt6M9eubEL7u2TEi7pjC5wZBaiNd8YcPwKX+2Tp4N
	nn4tfQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q09p51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 20:17:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c860544c077so1617980a12.3
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782937061; x=1783541861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIELCf9duknysKswcBTO3BHzbOM16+pkKsWIvb8AmDE=;
        b=gn8Qz9kWq0DFs90gf8cdEtEfHaGbaICONRbZHUYmZ4UGzt9Tm5tdEvuyhvtxElxNRv
         6MwOD3j7MOWPvu8A2bdJfEpfWOnarKJEq/cGm2dwSSWqvGsImTZAccuC684aArrcp5iL
         C1+gZ2T2CeDWG6uLHY8ATqmoDMW0r9BKSG+4liQ3/KTmY5+V5WL4hHpuzmFL1+8oGmY9
         sLxZiSFkcP8t50/stH76Cx6IZdFd0oGTq/OUtdepG9t9zpUkuQw8T0pnTvFZJ0BYdp72
         O4N5jlWt0KDNcY24kjKyi9+G8PpDsQB4OH9jygu/dQa+noqWJbfI6v7pC8M6rWivz8+A
         WbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937061; x=1783541861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIELCf9duknysKswcBTO3BHzbOM16+pkKsWIvb8AmDE=;
        b=lhwIFD2omZU/z2jxuNAKY4X6lWuvB1hNYikIpjVw0VsIoM7wlXaL57pQqajGpTdC3J
         9N0xAbRfMpSIYbk7hfMirF7cKrRF2XgwEOe9tixJ+pwVcno8cKF0MBI7OVMeIEo7deuR
         C5U2/9mQPxeLFvrRzaOL9QfZNd2w18QQcG/8nRPHMBfCFzOrMsn7xxWt6I2yMcHTfeoi
         o/VhRHZe7W11gWDSTShmg1K78YVx38+Qu0g960fJAoSZ9QDyF4N1CRrzjFD5YzTgw9mA
         QMeTAr2AF5VaPhmGT0sT2p2KH1pmaX7mlgujAcHwh3T1/O1WtsaNx5Ak3egIg4T/giyh
         l28w==
X-Forwarded-Encrypted: i=1; AFNElJ8IEMZXWHt71mUnml/JNv3TKYxiPPsI389WyBfv1pWpyC0d4ZVb0S06f1a5Hoe2xZSZfnPv05Fe4wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLkle59kPedTJz3b46r3sQwBD3//5+30YrzPOCRi16KweI4C9
	isiBCM98lcxBtMfMkJF0393wAESGr4KYNwbu6atYGlx5c4uV/4+IpV//+T2eHmrTtrqtfK2CWaD
	VEEUzGpPMWBwEr0uYNy6qexcaRZQY3QszReTpER9S3mYL3Ldv0TETiF3ND2cYhZMooSrytiM=
X-Gm-Gg: AfdE7cmLO0+q+YAFtz/96GMxFLmkosr4msCPZkbDeYMGXD3Iflvc4RbcHcysNiZElHY
	zyR9e9quvEY+gqOu6n/8TpQZdzS+ed5QvTcZaN2PJbFDX25c2o0HIsERKpa5D968otHbNFJ00xb
	mH5FY1I4o6ckxQF86grVK+9J9K85BT/va0iOMvAYeCj5a5NfMJRmWNUnU2IfWT9bFKQgVz6QLD4
	yTyvhr56TtMQmBa0+NJW2kpfaCc7TPuU7od3q7lymCBKfgcHzr0rDbmQWbaWXGF3XlOp0kX3+08
	XQHubD7jNpLPya7J3d3y0V5IJJjcycbMFohSBpPgwm1JSVuTChe4J0jqBUEBYBIjn54jROsVu8J
	RJ99hgQ2WqH2CNmAh4A9a0vMvCmcv/GsTM9MLS7lwwn1N
X-Received: by 2002:a05:6a20:7490:b0:3bd:203b:b587 with SMTP id adf61e73a8af0-3bff42828a1mr2740852637.40.1782937060628;
        Wed, 01 Jul 2026 13:17:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:7490:b0:3bd:203b:b587 with SMTP id adf61e73a8af0-3bff42828a1mr2740802637.40.1782937060021;
        Wed, 01 Jul 2026 13:17:40 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc79231sm948685eec.31.2026.07.01.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:17:39 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 01:47:12 +0530
Subject: [PATCH v2 2/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Document Shikra ICE
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-shikra_crypto_changse-v2-2-66173f2f28b3@qti.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a4575e5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qMhC6LGQ_1aKn5J9HqIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 2AslPGzdPS6m8mEQQtVkXp0FUgM3d1lR
X-Proofpoint-GUID: 2AslPGzdPS6m8mEQQtVkXp0FUgM3d1lR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfXz4kyDebO5eKJ
 KjHllW10G4M+4yTlBmP+rP0yIkQFKe1WgMEyJOMwgx03ON6et1jNsuxa7+AFhpAcd3/1Fz9bwqC
 BBUxxNe7oa1Ezz3PvCzY9lyTnTQ6Ccu72nsgyvGdpC8VwPo1XuBBTS50h4WtWyHot++pl4tJH/j
 Cl5iNHdtn66DfOpPWLpcmdzL1EvYDAAjxv1gZuJgsFS4HbBZUAICp/7sxagxjh9mHZNuJlohSj5
 rmsg7UK7kaFeJ5ttScSirWv1xJI6Wy3Uz/r+/RX4H383aVXwfi2ha+zino8AK3QjvFDoF0+NTHZ
 NnxLzYvZ3v0CT9Exr0YXAomgWOksUvfhQsum6RSRu1o2rVZFl4XVqWF8l7fabfXLLktOZqp027l
 MOkWjw2fn8zfHcQUHrcvfcV2vtaib102Gxr89bKZIhvb/SeooCzjB1vntR6udS5z51NIPLEcyCS
 FwzNhv3b/hpgk0mbPEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfX5HiiuhQ4Bd2g
 e3jLHf48iYAI466AfEQ3lQ7pXSCgiLh9W0pQ63IwChf2HcnOtEmNApFtXC31U40hM+GgBo5cBcZ
 Ubnx0l2M0gBvDGRRl388ipOcOQ9DmcI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010216
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11937-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64C0F6F1767

Document the Inline Crypto Engine (ICE) on the Qualcomm Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 4f3689a24410..9e6d3af42971 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,sa8775p-inline-crypto-engine
           - qcom,sc7180-inline-crypto-engine
           - qcom,sc7280-inline-crypto-engine
+          - qcom,shikra-inline-crypto-engine
           - qcom,sm8450-inline-crypto-engine
           - qcom,sm8550-inline-crypto-engine
           - qcom,sm8650-inline-crypto-engine

-- 
2.34.1


