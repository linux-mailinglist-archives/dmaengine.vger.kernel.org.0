Return-Path: <dmaengine+bounces-12478-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VxbUN3MKVmqKyQAAu9opvQ
	(envelope-from <dmaengine+bounces-12478-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:07:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F4753360
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:07:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=k13I5Q1g;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HqvyvyQ3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12478-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12478-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1BC830F8B05
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF636308D;
	Tue, 14 Jul 2026 10:05:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01657363087
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023555; cv=none; b=ukGcrn+HvO3VKDBPkeZAtZ9HciuUZjMqlzU9egQRSWcO2m1NCnPbc/cOo9IcSKv+/864cEFXa2q1Mo5pyv2Ovu4PzplJHw8w6y2ezuTE4IIWPg1CMQg5tWlTjoC9Le7T1yhRz11ewP1q3/Sn6mQeulK6oVslP829/YGpM4sspB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023555; c=relaxed/simple;
	bh=eaLOALOt3CvzVzqyBJIw46fZOpNHjs/TGcOVYyRBjWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNk9YU7hhO+HQeCwOti3magKhIfz/rOu3mr49blYJdTzQzQf9w04ZzUvmXVE5X75nWS4j9rz3m/lB7XtzMj5It6CKd7xnK8Ei/FW9f/k9VDPEOga3sV+jOK9rFEiyeHq85SzTwYUNYxPCrLwVlF1NK4qoEvdU0mu9fzdqEVVvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k13I5Q1g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HqvyvyQ3; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SOs23625105
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2db7vq0piVVlS+4APeSpwvKH2xENTUkfi168JwODX5Q=; b=k13I5Q1g1Ih60WsZ
	t9cYVlXw/I+Oga6DX5GMnoPGGBp0aMkZdusKzUBjLohNEbJvdAKeoOYpuxAsrEFR
	ytzX7uCwziARrJRUD7RfoDwOpegfL8plvRMdfw/4cadVL2QFfV98O1XPZ2WgJlXt
	YO892B+2F4Cp4RedmAkIC0mu77whOdx/BixhL1x7PdLFfQAF/0eI4UdnZDNQSXMZ
	7Wq9LJnodz0gxN1ppURmnzOnwJG2Ndyz+UOBEjWCkZ3VMK+qD08xamRkc9j4e5un
	6n3wuKn7A1BexXgIu4NfC/vUgW1oiGCXeeDhyhvHpMvgTuIxQ0QEF1bDpIbsC6fc
	1hB4Cw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa93q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:05:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caa9a3cf7aso10062435ad.0
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784023552; x=1784628352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2db7vq0piVVlS+4APeSpwvKH2xENTUkfi168JwODX5Q=;
        b=HqvyvyQ3YeCw8B+SRFLbhayWwUnD095MGdtazm/Y3TpNHm9s/bq0XGbMqRdObdJuw7
         u1MXqUYJvW4PkjnmpKxF0QBCS09YmqcYsdFwmPHhzBmsqT99jxkiLqwah/1BfhnP1LEZ
         kOmWZauK2YgwGgAH1HzvK4ER91aB5CeI9X6gQdyzJEowEj83AeJtORvebEDbpmzAaMcT
         e+DecLC00Cstz75mFiHQpFgIST1gUucnbpDCIYrDoLdEhUIvE6hLXPFIjLSyZSLwJNSc
         TeuhrcLYUGZvuKZplyV1t5IKDopxEULRa2bLmBkdQT7NIAST8LXEUH1lWUJIT7BDrXFS
         GSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023552; x=1784628352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2db7vq0piVVlS+4APeSpwvKH2xENTUkfi168JwODX5Q=;
        b=Rrbat8J39wjH65m7+lTPp2EKZBGIv00GVuF5XPz9RmA2d9xc0lezh0soKiTQ6+Fx7I
         vXgR8ev5I0HcLUMfBmkrJBvlgelTjPRGIZXfeEn7rFUJl4kSdi1K91RUzu+bV9Wa4d5K
         imK+Pm+NBg5Y2CKlDeCgXoqh9Xx/AyrR14iiX8OccwoQJdnRG5WMXBnkWT8/QywOxjMY
         e8jt3suImB0yR/VKfoegK4b70QugMJAmbpKtUnPvwdcZdw+Hz1kLTt2GdY67K7rwSyPR
         9S80tvjuvzlF8ynNmggq1l0jdp+iGItkPaA1gpS3JAYIbpA58X4psQKBNM2OGLBrHmxg
         GJRQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Bxeu6+XNgb8PH973eF2cUnriOBHgOcX3uxK2ovfrroV9gCWG9m7erQegWyZrwVh1E7Q4zP59PyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVpotB97XL7YfPQJVrWYnugQEWuXH8L9GC3+7yIZ3wCjy2I4m
	MwN14ppdnNb8PxdwKW842M978P/1Yb/YPGrtNVOPQfBX6UrcwM8Ip61ysWwrU+wgry/RwOc854p
	4bgZ3ip3xzbQatWSF9PHVjxQ+F/my1LAFvHAvdkrp4at76P0/OwbW0AACQackDGg=
X-Gm-Gg: AfdE7ck8etNJq4TS+Z2PWxVsLSkpDqSfj4DMa+4l5EvViO+Km7UP1v5WJ8/V+nUEXbd
	oPrLmkVWcKTEWcQIgnYytDdRezEcUbxvA9vBriNPz4IqkTxrD1h8Exx5XYzy2Zi7hCMgoSjrFTG
	z5jidXub1QCGyvcNLSjNVKsumXTiFMQM7Q/QFyf+/ANoQAMgUzPZblmAnoCKwq8aoGGMxWmze4l
	CwmDFmDn/Z77IS20a0z44ed/Z/9CB3XwgIGGI2Cu8WsASlMhF0SnKYVzIQ1RzU6lHjTsOLQTkQ/
	LXM044KVXXFLuz/GPtTJejzojKRyA2CnryikWfkEhSEIZ3mn33IUaQts2BeocwLoFEfD7UbWEKB
	78OYoyDCT247+pTRkxLYpadvRN+Rjkz2zYVXGpqInioTz
X-Received: by 2002:a17:903:110f:b0:2cc:92ae:b36 with SMTP id d9443c01a7336-2ce82970406mr156261035ad.24.1784023552432;
        Tue, 14 Jul 2026 03:05:52 -0700 (PDT)
X-Received: by 2002:a17:903:110f:b0:2cc:92ae:b36 with SMTP id d9443c01a7336-2ce82970406mr156260655ad.24.1784023552026;
        Tue, 14 Jul 2026 03:05:52 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm112653485ad.19.2026.07.14.03.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:05:51 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:35:13 +0530
Subject: [PATCH v4 2/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Document Shikra ICE
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-b4-shikra_crypto_changse-v4-2-06a4ea97c209@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfXzMTqwVslETSC
 7dwGlD8IVuAlfngoJHISb6nOqaWXLuzqEGipI5f3bbDjSs3cK3DJWAWL7rF7CEjGoM1v/Bu7bFN
 DGnyxCCbe0lQrlD/DMc/BRD69YkHLPQ=
X-Proofpoint-GUID: bn44rAUNN0DDoOKzQ6vBNPGqOUqFi3ki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX31OduEZ0zbpI
 U5gX6ibZpKN1sjX6P2XlocJU+VRtXBMVj4TRLQxIFCwi9Fs2FbZpiNeIKBzU1qkVzX0oT+3scUK
 Be1Y3Hpxy1+/It9uP0ij/R0MgmoyB+XE5DVe6tk6Fvbv51D/AIEPo+/oRiN2AYbAb1QjGfK0mD1
 CJM9qyr4bQA5zGPcfVGpxM/uwROK3a3v2MpUoYW7SKVgGz/gC9Jxol737F2EqnBvyQypgkwsmrX
 mpkTzk/qQNyYUebPIudblDQ4BI/nD00Kvyk3PD6F1Wij4CcaOS90ZFBjfVieS2sTPahQOsH3SFt
 Sss1owM3EBTnbN37Zd7YyhFb0sFyMkMiQ9SWimJ5XT5U2LEFVtxN38ZBOg/aTmJCinvaYSN27gi
 60NXlFXscRQ3W3S/Y+1dfTXuHaUs7pKFU12HRfRLGG+oEZb9XgmTrJmJ6LcgJjXToGj7g5um+pw
 b3TUODKko1AzCFGFo6g==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a560a01 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hDoUnBfku3VNtUQ37LIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: bn44rAUNN0DDoOKzQ6vBNPGqOUqFi3ki
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12478-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 311F4753360

Document the Inline Crypto Engine (ICE) on the Qualcomm Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index cce21aae6499..ed2dd99eb1b1 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -23,6 +23,7 @@ properties:
           - qcom,sa8775p-inline-crypto-engine
           - qcom,sc7180-inline-crypto-engine
           - qcom,sc7280-inline-crypto-engine
+          - qcom,shikra-inline-crypto-engine
           - qcom,sm8450-inline-crypto-engine
           - qcom,sm8550-inline-crypto-engine
           - qcom,sm8650-inline-crypto-engine

-- 
2.34.1


