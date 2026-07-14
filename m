Return-Path: <dmaengine+bounces-12481-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D7anOhgKVmp7yQAAu9opvQ
	(envelope-from <dmaengine+bounces-12481-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:06:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A475332D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:06:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cMxlrDUu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ftNVt4qq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12481-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12481-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617BA301475E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357B363C55;
	Tue, 14 Jul 2026 10:06:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1336402D
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023574; cv=none; b=lXjJtmqiNOckLofkhjygIDKYDCbBQ9SLlRcM8DkohIh0bQMclmHmcEEZ2V14thHAankAfMhGmpB4i/8NLAn6/ML8xRDAYBihmIxCkK4uxQS2u5WJe/5AcgNdaaiECbiltS3k1+053LOKCLxNFi502xW1NvxP63gXRQNU7Sjfwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023574; c=relaxed/simple;
	bh=UoSRo1GW6MYk2CQkM+hrKXykAmZ+r0PsRTTvloWVEdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpsEkPk1ZP5MjZnPpbTdbi0zkalImkpmUwfWULLjglC93oF36qXqdyxVVEJSN2O22oncQHoeOthiJDkHQQFFxPbgm8FG3YUshn2ERH1L1APKuMy9SCGUYoX1Ibs2vnHKPr+26mnT0pAJcXQfHUQEs4zMr7vkxwhnp0dqoewzcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMxlrDUu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ftNVt4qq; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SS9D3625233
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6ytOIDKhwkP2y8jVaN1ZuW7AxSttUCjFdaRma57k3Q=; b=cMxlrDUuEEEfhQiR
	xftx2pzAUcDNd4SpwQMFGiO0lAP3EBjagcqcMMHYgo1Gdcjlw4oYsFX/q0/8mg69
	Qc493r/zU2IBvMbja8P+SQ+HvDATPSodWNiSCk+MmDCbmpPvp1AaSyvFgCJJuwha
	7pkfpMXStKn2KBy/r6w3sh8Q4vyddf0rtVA1XNgMzmeMRHnV82k/CfdKO3dom1ly
	I3SlQ8W86dVwKnZTvx1h1FHw2Jfc4vCkG3Xt5/IeGCe9/4GOmIse5GzGmRUlJx+C
	mRc6rgrmBF59g7gvFy4QwnYGMmKSnTKBwRrcQxvNqxVsajUJUP7Rn2/ep50wOOE8
	sMLQ9w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa93r9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca3673560so77252465ad.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784023570; x=1784628370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6ytOIDKhwkP2y8jVaN1ZuW7AxSttUCjFdaRma57k3Q=;
        b=ftNVt4qq2AmWMuzAS8jRQeBXjSdbpp8cKU0ISjLVUurcJOwaRQwexcA08L2L7dq3vc
         tlUIyyT8ycZhvWc3m9SidzwElswAPl/lrpxVxbXktk4yiccfhF6+6PomowWhtKvbbOQh
         9XN46W78dOGTrpWaRJ27SigwugpCFUaMVedXaKu4BWdZpjcCCtmfS0pfUSE9ZDjrJ4QE
         579n8abER9l6qi2da7izk6M09F7DamcZU4YaoTZU4xCbQuEfm+NJj3rsBaTSl2vLlK8T
         pzDzAzO9TGpqjPSjLjWPCdeG/g7nHPg8tJlBZSJDQV5IzTPAg1QFN3M1Z2fupNwgwyEh
         BK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023570; x=1784628370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T6ytOIDKhwkP2y8jVaN1ZuW7AxSttUCjFdaRma57k3Q=;
        b=OTngwp6RNtd7ZfX6t9zFjqZLdLLzdQuwVcsoXk2C9/NPsPjjwdlfqL+i9gS6wTUeuB
         jyO79DnOUftUQKx97CoBBD3wLrv0uTriqhFFNOqE6+chgoCi6Lnsw1/dnO4VWTph7coP
         8mFLMjTXhnwCMZiFuZpbrdINULPrGcp7WFzhN8l8lCDD5m4iluXd+hH2UFa5g7dhR3H8
         IcT4TNz4eqlqqRrcxORi2H4uTrRZQ24wqf05wnXk8nC7J+PYKaVOL6DLPATEE1rBJhXG
         24+OanqOjPchbTRKuyIZ/Qc1mtjphYjZxBPXtnckph7g3mB/04iHqmQNpuITMqGPrAKG
         cqVw==
X-Forwarded-Encrypted: i=1; AHgh+RrmNRJErM7XH6rucHhniEQFjGNbLTZ43ovB2sWYGEUIa9jm8MB45c2rZHFHLEHpXIJFklwtViHKdoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeZy4S3SA2ehDSVE5YN64vmbKSIZglkE0kylmvQp21/jX+NNO
	B0tw2hFlwdIFaQqhUDHocsXgNeYojL0mX6oct4dgtG5QnSr7K0rTP8Om1hIcA8W0QGOnrSamPqd
	OHUk62u/CZ5S/VcjAzrPUdgMqNgmoIhw6jqLstIiRjiRAxttATiB2v293UslFb0s=
X-Gm-Gg: AfdE7cnbcMpY04eAtsIpvUDFTwUNB5pFGO1478igpLxJzp/lnyXLg6UMgHMl794niLC
	XVRqR0axm7bqtbzYS867IHsf39QQlEqfeWyGn1/sLvlfOswRyPy+mfkcz41BdwoWNmXza2tRGAM
	79UdyQlqL9HwLPnnMIR+TdrFfLA2oNuF/kqcIKEzewuu5BFhLQad1m9MUvLCnl7mR5hspW9KgjG
	gp4ya6jWxA5rZoMeEyzODm3Hqw7ToYVXAyUC0s65IRsewTrEZW/MpCq5mkX7Bf6E+nMnDjZFBRD
	jaizBgS+AVPScDc7T+nVFzpOOw7pozaHRai7KViR5ee2Zyluggt+umz+nT28SLd/ndpG6TebV8Z
	7O4Kohp6yLMwK/p7vnLuGMvzc5mbaWYwtztJV1gS72lwe
X-Received: by 2002:a17:902:f70f:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2cef11ec5b1mr20323125ad.20.1784023569976;
        Tue, 14 Jul 2026 03:06:09 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2cef11ec5b1mr20322545ad.20.1784023569452;
        Tue, 14 Jul 2026 03:06:09 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm112653485ad.19.2026.07.14.03.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:06:09 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:35:16 +0530
Subject: [PATCH v4 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to 7
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-b4-shikra_crypto_changse-v4-5-06a4ea97c209@oss.qualcomm.com>
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
In-Reply-To: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX3V3LFoo75r4U
 FS5CPOWAG6j9VqcPuLoHYfHsGZgMq7RkYB7/aCQNXXQv6YvsQz8z1eUE6ayO8jKaR4jafJ0NI1i
 CV5zSn6ryLdj4Et6M6VUT8VTA8Kzh3o=
X-Proofpoint-GUID: olVjL1muMDBRrfdcwknmqg71kPz4X6W0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfXyu7BTQoDdpgU
 edrXqyABn3yRzCBldB9FLBIQd8IsiQ1Esdo7JI8bVILLkDf3KXCiPTzSebjo1snIV8nF2++rTVm
 vF9UQF0I1nfuU89sLYEOyIbExLWGpYTkQKh5B5sNMPWotkHPfjw/iVQi+dMZEPf6r2OShlIpER1
 MZeJcUDRxzyWtsNYmh8GYDC5czxw0XAb6YDdvr2d/KyvQuXOXcjx4so/yBHaC32maOoakLeXiH4
 wizjaI39gjKahEgXt0zNxqNQfRs8taah+PxXxmPUuK3sLDNJdNvaw6zqPB4dnC489G0KHeF+OkI
 Ze2thhSZinWfp6Zt919AQUGSySqqbCuw/yf5vNcqwlmlYX+Gn1aqtJiHdeJQD/g0Xwo4bSYyQu5
 FBp3jEP7BOiLcJc5BFfYZ3wcD4C9WvW795+cGTudMvd+zgShR69qOlvFaHocVeSNY+EA5L273tO
 KBr5vV7/DRY+/YYjnOg==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a560a12 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=h8YGW4MSmiDDVbuT7RUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: olVjL1muMDBRrfdcwknmqg71kPz4X6W0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12481-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 560A475332D

Qualcomm Shikra platform describes the BAM DMA node with 7 iommus
entries. The current schema limit to 6, so update the binding to allow
up to 7 entries.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


