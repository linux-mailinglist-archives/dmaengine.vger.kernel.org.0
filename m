Return-Path: <dmaengine+bounces-12480-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OvPYFr4KVmqWyQAAu9opvQ
	(envelope-from <dmaengine+bounces-12480-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:09:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6F575338E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=O8Nlq3G7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LGhbXap1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12480-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12480-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CF13140D19
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9A363096;
	Tue, 14 Jul 2026 10:06:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF24363C50
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023567; cv=none; b=P1yHYIBh/GgrCKdAJML4NNkalBDOoMeuamaR/RULLy4p7b28BLwKG/WEHOB6ZENExkRCRkDOM6wjtscMLa72WUEs/0aKLN8sB02VpLS6Bf7JWEJZfxE4kgEjTyvlCWPhcsfqvWY3ksarFObU1jSNk90itUgVRmIG5Ls4ixefJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023567; c=relaxed/simple;
	bh=zjzyQGqtQEvToFUvVoo7pZ24KQzxayJOTmTLKhS4AOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdpMMLaXtXlOnR5Ai1gDksgm3UV6rpXf48WDMxrI+2HMMW1bui4fGrPkDVQL7EA+nugwOR24ZAxoGuI6cDStoTBrr6QCreGabgdi11SjIBonAdzgCAwfYgExvkrDZUFCz7erytl2DAWGdfZ4Y9jAARH9DJMl0vOwpL0FeUNnDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8Nlq3G7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LGhbXap1; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6TCc14006942
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7SkMYn1pW8LZr6abBIJ2z33PKYxNNOhX0ZIHoUiS7dk=; b=O8Nlq3G7P7bg6KCW
	3181XiVgN7wWxHVczLpCGpmC8BSECUY6uhB2Mg4zIa2jSJPQnJh0VWL6aYVFBP/c
	aTT4tScsp+ipRcaeFp9EUCwm0/En9xPYRCKONMLh0nxkeMP5HXfqOp+rFJzmr2M8
	/Tt/3FF0F2IGCUaUOAdjyxEVhllIsg3iWTQTTg3jNmGUiFFy+hvmNTb6I8OGCxAr
	B/AHXMolzI2CrnEiCj17KsAHOrMHavwCtKlxJGLGBMMvFRN3fTEzKXg5ER5BqVcs
	VW/DY8/2ak8JdZITaEl6IRgXhceK0KApPfuLTkkSgpAYkJRN9f0joO77oDOUPsom
	RCn6zw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44cu6vk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:06:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c354050c34so73850645ad.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784023564; x=1784628364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SkMYn1pW8LZr6abBIJ2z33PKYxNNOhX0ZIHoUiS7dk=;
        b=LGhbXap1j7MlzOM/bJ/BksaQHVJZsXLNrtNDg9DGnWbhlJ6PeA5r7qfSSCUlw8bxxr
         vsjT34em38Sq094irDtBTmAHY6oO+IvLKE1p58myzvvdZDhF5cvo5iKYpMAE5VuzsOVd
         Qop4PAhmDzMevgt1EbsgImUQpogHy0QbKkLXnWqEdD37H1f24GiLePuqseKf9zIuELS9
         aKjFJHyZ2aNSpdJqMyg75o0s7UMkU47CsKAwaIc5r8O5FxOcGLd2ABcfdM5yWPVa1yLK
         MrP5aLqI3KbGaO8O2UWWOBm0EacU9TNfc0CDQWcYyPWzT8JRmKEPnLlJlv2yUfR8JTYA
         2cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023564; x=1784628364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SkMYn1pW8LZr6abBIJ2z33PKYxNNOhX0ZIHoUiS7dk=;
        b=snWhDlFGIPahJb9EXwGSMPRK6zK9g3Qv0fi4eRrtFBxDD+xBLXU0bFxXbkxIKGiJ9/
         a0GhM3/JRdyG+7nJqRvphy5jrJ4XbDKVKP5a5M5Zstt8miDroRDLf/H6CvOS/E8F6pyD
         lzraw5ckyGowWU7gfc+ewu5LelagyxOwXcVdQlmmDbcqxTZ4BAj2in9cqM+buJ3ydfnS
         ZTU1TLZmft5no6GQ0KKTCZxuWwhA8tCOjatcktve79eloa51G3S5wLtDF4IFUXEGUD7f
         1S2kcjf8iFo+V2smmxB8ecndUhOHHxBr/BJ2QVnb0Q9O6FjkKTA/ioX0/2hHrpo4Kha7
         ChbA==
X-Forwarded-Encrypted: i=1; AHgh+Rpvl4/0bXteWsxxTeq3b0cxgYo/PIC5dvPspkNQo3vcaQdo6ChgD/6vWE+2hV1C/OLIZg65tK6m+0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NvDElRHEUdjzB9ln8rqeySJg/MRDj9bNfTk81bnWGvfJ8pXu
	QIsF9J3FxD/AOLEc8D4iLhPq/xslCQ+OuFoqOgd9+qfPEwy1giSgQn6cS4X2EmgjbNVhi9mMcEd
	QOvmrZos+H0Qqfzg1TYRUi3tp5FHCMq8JPEY+nUAgtZn2uaCvvZySOk2JKSqXHEA=
X-Gm-Gg: AfdE7ck+ptz7T7Tpf0ynaNdAzf9x+Kq3YWkeUNzzoxgFHGDXR4wgPOLqk5BdrbJEYbo
	NGrjyfBmlMD2efpoKlSJ/7PpJrrbPKIGtItnfTJF9I4X1Uex2fprG8KJIvPn1euJA/KdQPK/Rdh
	IxA6dAijnQstB0UMZCj41CJBVDzAC1R0EkKZbOUIXDoNcCTt2aP/dPxb2GvqZRinQuI22jzHBPe
	TiopXdNFT+srLGMqWk+jFDg6cJ1nsc0dkcyPbm3ai21j+m0uxjCKqgTrCG7W8+4SDnAiAjmKWAY
	wz5M0AbUgvAY3XlczA3+8MIy31jt45u854xnS+esQ2SNrAPivU4+cOiGBd8me0u8nBZKu0Kvxuk
	l5i8wXsdofUlVBUFTxtBtXU4jY85gNts12CjWWzGFXvwu
X-Received: by 2002:a17:90b:3d8b:b0:387:e0bb:5803 with SMTP id 98e67ed59e1d1-38dc7bc3194mr11380414a91.42.1784023564191;
        Tue, 14 Jul 2026 03:06:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8b:b0:387:e0bb:5803 with SMTP id 98e67ed59e1d1-38dc7bc3194mr11380375a91.42.1784023563734;
        Tue, 14 Jul 2026 03:06:03 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm112653485ad.19.2026.07.14.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:06:03 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:35:15 +0530
Subject: [PATCH v4 4/6] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-b4-shikra_crypto_changse-v4-4-06a4ea97c209@oss.qualcomm.com>
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
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: wXc_I886ezmFsve9mm3_KNWEFyJmAHL-
X-Proofpoint-ORIG-GUID: wXc_I886ezmFsve9mm3_KNWEFyJmAHL-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX+PIkcY/qAdMo
 nArvSK8Chx+/E8dIUONqAN6Gufjd00F/rsBioq6/g/a7ePlVMA7TER9B0mmtVreIMg8piSYW+0Q
 GHipyWtE+lSw8rl0YHhquqLj5Yqs3L0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfXzDpBHF4mcUS8
 I70khNGHJwCyZd1490RUwo7CXVz1/sqgcRM6cdRtRiSuKRoHL7OHec7/woZkVAPZnbIRnrZS5xL
 P7P6gDiWYgFn+Q5a8DQMlqGNHezOnD3HNq9Y7UP1qTXfqegi+aLnYblLmhVISAcVUPd5pLE4IGH
 j9E0T9t5l8owq0ByhTmuIJatv8dTacqmllYR9+4yWKCiP7/nj4E0+/T4a2uFvyS1aJpwdYPaF1k
 ttD2OVd75O49PmUlKB/sKCVHF/SW+sE2sYtCGUjbdF7AQaX96Mv2GNnll/Wdmd7FQ1ebp+jxxIz
 USEfxNMi04x6JFeXH4NcvnJquFhuJ9OctFjnt0x1gBAQSB/s2T+TEEs+6N9RW9YzEzd4P5c6JRC
 WuvQEowPfI/0WkmqwEVaquUmGdhWRAE8JXenh6sQkMkVcWdMKWQHHUPuKjYwlkq6SmjI3p95dnM
 Gv2SbjHDiyCUs4g2WXA==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a560a0c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mnL63iHeaYg7R5sIRJMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140105
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
	TAGGED_FROM(0.00)[bounces-12480-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: EA6F575338E

Document the crypto engine on the Qualcomm Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


