Return-Path: <dmaengine+bounces-12046-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EV1BO4aSS2r4VgEAu9opvQ
	(envelope-from <dmaengine+bounces-12046-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:33:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C570FE28
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:33:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mBGbEjEo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=col0qm8z;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12046-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12046-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE51B3031915
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23041F7FE;
	Mon,  6 Jul 2026 11:32:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658C414DE8
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337541; cv=none; b=EYQ18I4Kco9qjwY1LeHLo7CujTFQvhJHiL9LcV9J30ursNheY2CRhDWDmiB96S7ObTp8gP43eL6Ihs4RXxBUR/7mBLbPrrup9donQoFcfEsamzuYRmH85F5y2djpWNKK5Oi3N/jilREnMRf6igDl6pdFATpCNGYaUpyEQlW9Mmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337541; c=relaxed/simple;
	bh=Tw77m65ctMpu+WdJ5WWdw8xSnLCdE2h/81HKHaG+/qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNPnRhjMMR5sakgG0Spy5avV4YWVL1lm1DOBoUP98XzY4QoJYU5hqZbw/yK7OPLtIunRiVT6zr7WSUXclSmsc/g0gFBIj/2eClEWE9+hiFVIytNfBPVAnZKxR8+85hNZnx75h+/VXNOl2iiW41NeBm89H+/AmJ/c2bqCgTlZiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBGbEjEo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=col0qm8z; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxT3p219060
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EQSWpZpdZx1gdCMr14mQLPTR4DAVhMyhocFoNcUqucE=; b=mBGbEjEoRT5FKNQz
	4i8cFalxOlXZT7iErgvRyE24n9Hcg/kOqIY/S9wrLk+49HF1XKiMzOwpbhmjm9md
	ybFlQIQliBzJw6iy+LPwAN0Nks0H5xQ8uo86Zd8YehxXp5gAqLNUy+4o0pjPPPWz
	rTMuZJ5+8Hfsv6mM1gJAwzheh8weWvAP6SB8x12dXosiRWRFyLXUuNPHE1pQ0Lb6
	5fIbs0o553OTffegrMhMs/4aexvGDyZr8yhPe0x9o0tVPfqeNPL94TiFRIumQQf/
	FhaSUPqcDCpJZaMJ6iGwgrd6GQe50ljrZWCOuX4AWv1AtKGdJY/t0IJedxZeQxkq
	DWaIZQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs8tqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-847a2509456so5002528b3a.1
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337538; x=1783942338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQSWpZpdZx1gdCMr14mQLPTR4DAVhMyhocFoNcUqucE=;
        b=col0qm8zA4pT+AoQU68LJaCO7+oRtrV+2BklBeEGVSB1gnQrsAtzQDWzp8WLlT3E3w
         5tIIegVBnL+ssd67MiQXKkF1Rv4MCts/wV3fcjnOuMgOm5i1YRY/5Yf5l7GmBDGk1LNs
         BgLui1a1YPJ8XknEBQldmWnL1gEjPB5AWT6GZ2IPA4AfxLJP/IjFnIZ6medHBlbdV/lK
         Oq2nIrmDyAR9QVb5JAdAncPbTcgPp8uT8To6ekvZsA/haRBNYK2+GXBw233uo/aplmPJ
         rj944dIhpKWyGdUs+4kLTAop3BrQEqWFMWiwuUlv1yz8I8RUwZ/P/Y5gZ2aeHqX0ehYT
         zpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337538; x=1783942338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EQSWpZpdZx1gdCMr14mQLPTR4DAVhMyhocFoNcUqucE=;
        b=gkeL3ks6+rQBuhmTcC9mIGM/OToxKEvC/e8c4BE3VdeR7xq+FimtDkjuNjctyIJbzu
         tFSszhKGUiQ2zlrlTvWPtaQ2fmbFanahxQDKbNmr4FF5Lb3lvwDH6mjjKzBhpRRn62XR
         hKyNgC4/U7hR22C2bEdvLQBeoIsu9HjjdBpajCVzg24uLz9USssnDzZgO9YTF/l9tBBA
         2/tnqLVxTJhCRT1KrDHnCtwZyJzpVMlgSSxJHGD6xSmw1ghPsCaznvgxcaPQXrwhOS8S
         DIJfROMNiedOBeMrILCiOMDeR3gVl9tjnMTzFo50U8F3wNC9lLgnBB3/sqJrzgHTba5m
         zNHg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/RwUSbhoQM0jxWBeHHPZ3SRqprsLTxZBOC8Bjo7xzxHduRu3mOklS3Y7yYvhN/ysmqs72RQadQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCx5qJQvExrei4nU3WcG+5kBm/6NHa+3N+FKvDvEkv+mLtinyG
	nN4IldqesWlZ4afWRm5xUEWY90aXGjygDSM40JXhBinhB4AZAjrm8G934GHdnbYBSwxtzDr1Iqy
	P3UHqt33ZrhRPqUivBaGfcVxJHXosawRLdfsV4vK6irHaFn7JdGJ5qmo92xr9UKE=
X-Gm-Gg: AfdE7cnJ528OfxaMhfUoqCbVMvQJrOoAfhsUbCIjNnRjys/0TVjyjvlk3azo/LV9MtK
	Pb2NLpf4wv/yis7Of+p7e5hQYSU13+t5VF5AcjB/RVmWlL3w9Mn/WX9oY9sL7Ap3jn4fTrrDn5e
	M9TydL8+pZ/JM9jxlkTq7hkxizwYr254OU14KHCFKtWqvdHooX5r8BMomr5BLlmJFPrCdjhj+ZK
	JqqqbKuHg+gxefZ0kAgnl2GGgYX6pmMW5TV4g4obHt2FRU+F88OW0fYHLaFZs6j+otkwBsa28sq
	VJ2EoSZF47daJPDBRV3YzsJZ+KqR74LaXYMLfsEsZp606WDoqYbFhkQW4ahsmUPJDRPpIyV0eRV
	gkveYLtVafzomX3sRf/TN8Iiy49RMVBJPJTjFlhRMl2Nm
X-Received: by 2002:a05:6a00:3027:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-84826bf903cmr128482b3a.10.1783337538065;
        Mon, 06 Jul 2026 04:32:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:3027:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-84826bf903cmr128452b3a.10.1783337537616;
        Mon, 06 Jul 2026 04:32:17 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:16 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 17:01:30 +0530
Subject: [PATCH v3 2/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Document Shikra ICE
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-shikra_crypto_changse-v3-2-23b4c2054227@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: yQT6BQSib2_ylTH9f-Vb8MeohwQXJh0G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX6poRKBL8o1CY
 FsPqoNwuVHYtju+zNinjF37HnixhPYUf4DqbMRAwyNMHbhH9yjoGCLZ1soauUWG49T3jDejRHB1
 hEliWqCD/EHuady/hAoclV4E3UZB1ilVgbK6Dp/rUwNRWFAVJlAzEbDfXLZpilspGlAemQX+dit
 HO9IvyQNQfXaGEPlTzLcKhImzg1FRJipFywnvDZaoMqWhhlFz1gInZ1kpsVIbXCUllmqvroH5l6
 1BOHfxhgIUM6GZPmhQVbkUS46cRWDmSqY13WlNl7h7sHH7aEXgDskYgETxT+TQ4740fksK2Qriv
 z98ICWsbn0AbCZio5uM7YOQbc9pwa3l3EGQ5IzUjCKFlE+ZoyVwZQtCF+RgAz+dNreEC4rQjAcJ
 QbJuyCOw+i0UMSrrBn8udDPwWOoSbq61+EuVqy4nqN/jX2w6pMovz1g4jyPDadmJElPDiXnsBmh
 RnreCYKJtuID1HBZ99w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX9VSLj66Ti5T9
 WfTTpSCN/KBkKyOWC5i7VLDgLOGZN4pWk3Dud6K15yIUFPuzpDex8Z7GNWdSXScwS1PrDriaJsK
 WKJDktZdu5RIcORwtPcPtLSVxsnSppc=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4b9242 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hDoUnBfku3VNtUQ37LIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: yQT6BQSib2_ylTH9f-Vb8MeohwQXJh0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12046-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: D37C570FE28

Document the Inline Crypto Engine (ICE) on the Qualcomm Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


