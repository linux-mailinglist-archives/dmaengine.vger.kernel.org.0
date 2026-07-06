Return-Path: <dmaengine+bounces-12045-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qWfUAkWsS2pHYQEAu9opvQ
	(envelope-from <dmaengine+bounces-12045-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:23:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DB711355
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:23:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Bo2G3XOd;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=e9zzsY5a;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12045-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12045-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43A332E5B2C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4B41DED4;
	Mon,  6 Jul 2026 11:32:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6941F7CA
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337535; cv=none; b=tapiGpBx842q5VrBhyGMV0wuA7DZfHi0LJwr3/TvVcOCiK2jb0TyHvc7zmdpwfLjVOJlgnRGbTigYk/R7rpX5TwP2YO8ZHUx1drb161xCfZ4lqUxjrSJrVtlv1sbdP5/eiIJWLJvwITPo/ytsgxnl+VgdTaooA7wuUomugInXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337535; c=relaxed/simple;
	bh=BDlrAUN+dv5+3Nw0wSTNRFS1ZjZcXmnx3mZxq8ZQoV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdX8Fqfhv9oBQN7kIVRQpm96hFTMln/8JNdY+D5IOptyEfcwq31Ehn8DVPMxUyyZGgQn0ArbiEMfnmVjk0qWY7v0sc+wZRUCdsdo94KBfMuuyKoxABrmIPu/o6hrb16ZAxxlEMlTSm3shtmVrAYnvcScHn4YSFvkXq3RLiSpr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bo2G3XOd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e9zzsY5a; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxPGq369534
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bs/O1MjHi9/C1TWYd/oU2riKYYdfbWdhGH5f0Eox9B0=; b=Bo2G3XOd3wvd1+vn
	o1OXbYwH7u5LOrb9J7Z9FLcCWONijS3X1b2nk4BB3zTuiz3XLdO2LpPSqwGZF4Ec
	kyqUCGMftOkvnMr/zRmO3HMBoyb0C+OIF8/WVZFiR+KlXCkrLotRvGNDShUrMs+c
	n9pW7XdV/i65tzJP1QYwyMHKqmssA5esjAWTTVDXO2vgpoSspxOmB4l7qzwjKhnY
	ScEvT7GUDOk1NEaoiZPJoMLn1hQdbJuQv66m33ntmi7evTcdoeO2o7Qw4R5cnVKH
	551Q8LZxt3opdZ6g4dEoHlGoqhR6wKLDQIO0GgRG7tRDQR+OzjcsS2HRK3uSDuba
	GKLohw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h98tqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845317fa7e6so4488040b3a.3
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337531; x=1783942331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bs/O1MjHi9/C1TWYd/oU2riKYYdfbWdhGH5f0Eox9B0=;
        b=e9zzsY5aScRe9inXpHG3vc3ua5FfVUMs0apkdGHpZwrgn2g9gpjuOEYbLTSjvxXlp2
         DCZs2OgbQaIsgG3FKHGuFX6njYVyo5cTnwuEx3NKelvSFf2lVukZMSLN4/BAO3OLunrV
         Q+vxOB/cqsXDlXQwKlTxAjF+y5wd5KSMLirL/Ocgx5SqNQ5n838XUh4wvtQWvW15uQfq
         Tz6m68jdtr4JhC0K2Yp1a6BdKpX+uk5XStCrXZ/L+mhe/QdZX3fv70QQw16HCBYZ/5T+
         FJMPTCoeqYOBcnFe3joZ7V7Q6MLrRk6pkGPg3L9ORCKzNspR6PRqkQD9Ln/MQWA1NrJH
         gQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337531; x=1783942331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bs/O1MjHi9/C1TWYd/oU2riKYYdfbWdhGH5f0Eox9B0=;
        b=Qq7+fpR8m4vJZHT+p94GbixeEspgLT4Effqq4ZKleH7VNRFdzoSR5u/PH3zlz2ww+g
         gBZCMtBGTNE1XSSLog1xM2ttkCpvts2zOvXqyQ8ykspv/OepnQOyFacwOsUDZwu71fGj
         o3RvQjQe9YGA1BY8kjhpHQ4LrQlpwkXJO2fPVLW1Js3qFh1+dB89a6FUXYTvZZqWpkdZ
         7thtj3ggRFLjoMvBHdqj27bhFB8sfd7OwGI1ReI5OTfkbnpulTGBDJECH0Jkn8zIunTn
         DIX2hXZSt7LfNSyn246H3xRElcdF5m7XJmLZdQIEMevsAIgFbyYq7eRjfESwlohgotBJ
         odDw==
X-Forwarded-Encrypted: i=1; AHgh+RqHxsuRCuInDAtk9DXQ1k0J0gPtCT3lKvNtmLk3W3aQrFXwXQcuLP1eGaLvgj0XzHXfhSMdeyeaDI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLQ+UD1ERIVc8wgwiC+IUZsEKBkbaRMrZWPw0d75KNnQOjOPa
	0uBK4UK0HFzrv+JRZK72Ld9aU2jVp8b/e73B8gwXdC+kseAYnOGvVm2aZtTsmpB23Wn6OqG0Olu
	g6ShVXZOCLpuHNVt6Wm4amG1JvDBUtk9Pf88mlpLlRPoSBk9jrrpKb24aOw+SahI=
X-Gm-Gg: AfdE7cnjbQff1hQk6xbYg2u9cscUkFKYTGrE4VjB2+4jRcVOMjfVXphh7iFAllAaIZl
	urooHmrVvRHFDrRqodGUAApT7Sp7UoqZs9TF4CuUsVFplxAtbQlW1OUuVuJ1+QY/bISYVI+WaJY
	GflB+IvMWsdL6lN6YPu88Zi6h31B5pduib7CBV74e/UtBJnL1kkVK+3rSwVUI8kswN2AbWa8swB
	eeE7aA1iTdkoOGN4/0R6d3cDazoWWnalztVJ2hEHdNJxprj7uRxi2IRvcIL1IGiUp5KrAFT9gFZ
	NszEEaqO+vV+tqkOSj3UyrHtOzrLejfj748MUXV5a2KXelKP+aRn4VhKw2FicDJ9aeM8ojffDFv
	LlQWvUdxZt4Mkildtm+uxQaCz9r8RE8agQYT0f32V77Qm
X-Received: by 2002:a05:6a00:2381:b0:845:dffa:3740 with SMTP id d2e1a72fcca58-84826d1260bmr129672b3a.4.1783337531457;
        Mon, 06 Jul 2026 04:32:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2381:b0:845:dffa:3740 with SMTP id d2e1a72fcca58-84826d1260bmr129633b3a.4.1783337530993;
        Mon, 06 Jul 2026 04:32:10 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:10 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 17:01:29 +0530
Subject: [PATCH v3 1/6] dt-bindings: crypto: qcom,inline-crypto-engine: Fix
 legacy/new SoC strictness split
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-shikra_crypto_changse-v3-1-23b4c2054227@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 0pQkRcWgON700fvu9-ewQi_WCGnCysBt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX9fvtJ4aCP4wx
 KldwZptM50CtP4Sg2JqlWQn6Nn23POjx28Szi42lUk+0V3sR17ZFtjes2SrVyameAoU4iIJfkao
 gXIdvojIKiq2dQe6r+LSywPUtRkmIA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfXyYQ7ZFrsojgt
 EU4HeEnhLOoD8BgvaNDjoLR7/d8q/WSJDAmY0mJgEAsmuJ5VhNytFKd1f6ECpFlSM0L9V0n+5Xs
 /PYHPSo19tYFSXjlNRl7mF73kUFf8pNnY3ZFiGTSF6F6i+hv/lYVOD3TYSZbsVCAT4jijWGYl6p
 UsyZaOhg3MzWgWiN2kabwA5B76PUiYJxEpsTv6ClEcs0jlD7Gnte184qYAmVVjS234ebVAQ/lq7
 gp+xlVxu94TGqRmFA2Q/KFf/VPXOU7pe/8p7GoT2Zoh+uVDw3TQXjXdQg6U0Mbpb8F1r7q9TZtk
 nyyOOZXmD9N3/CEI+3xi/q55BMR9r8ks4NjSQf7sbnwci7TXxH5tgeQwZ3xCrQHDwNYZcINWYAS
 qXhsOPwhMH8JdiQFZ6yt5JsEmOe3PU2dmfIdIN9Yz8+ryXYOTJPbJTfVrz5pt+Kn5ytPrr1exiE
 2BGdtKuF97YcbLU7FGA==
X-Proofpoint-GUID: 0pQkRcWgON700fvu9-ewQi_WCGnCysBt
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b923c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LJhxytyqajTry7azkiQA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
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
	TAGGED_FROM(0.00)[bounces-12045-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 5E1DB711355

Couple of already merged SoCs(like sc7280, sm8750, kaanapali etc.)
describe ICE as single clock historically which are recently updated
with mandatory 2 clocks.

Keep only the known legacy compatibles flexible, and make strict
validation default(of power-domains and 2 clocks) for all other Soc
compatibles.

This ensures old DTs are valid while ensuring any new SoC (like hawi,
milos, eliza) must follow latest requirements by default.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 .../bindings/crypto/qcom,inline-crypto-engine.yaml | 23 ++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index db895c50e2d2..4f3689a24410 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -55,14 +55,25 @@ required:
 
 additionalProperties: false
 
+# Do not extend the list.
+# Legacy SoCs are allowed for single clock.
+# New SoCs must provide both clocks and power domains.
 allOf:
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,eliza-inline-crypto-engine
-              - qcom,milos-inline-crypto-engine
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,kaanapali-inline-crypto-engine
+                - qcom,qcs8300-inline-crypto-engine
+                - qcom,sa8775p-inline-crypto-engine
+                - qcom,sc7180-inline-crypto-engine
+                - qcom,sc7280-inline-crypto-engine
+                - qcom,sm8450-inline-crypto-engine
+                - qcom,sm8550-inline-crypto-engine
+                - qcom,sm8650-inline-crypto-engine
+                - qcom,sm8750-inline-crypto-engine
 
     then:
       required:

-- 
2.34.1


