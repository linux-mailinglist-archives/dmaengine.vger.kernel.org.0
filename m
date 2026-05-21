Return-Path: <dmaengine+bounces-10641-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAnnMu4MD2omEgYAu9opvQ
	(envelope-from <dmaengine+bounces-10641-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:47:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396D5A6367
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF073285517
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C043E5A35;
	Thu, 21 May 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OTioy4hU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jnSiL2ql"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806103E5A2F
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369500; cv=none; b=aIXjjp1dRZYy3LOZUG9kWVaaNCeAeb3MFw0lvQLfbhwnoMcBOuRjUU5x9acqNdulzOKbmLig70bvfRrYjt/cCuxHMzkC4K4tk4RoLcGGo75dyyoBrhBh9nI92EcChL2kMGDAiWlcckgOwmq6cNWBmVarTj7A2FylkSNWN1ep9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369500; c=relaxed/simple;
	bh=0YDjfixzRUzNZsXvICDQpY5Ug8aZ7Cv4WOB9kd2NRTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLkhNMaKfgLb7EOv9uR4khnM/X7CouIksVmFoY3CXnadfJQsiEkNGEPLORnmTi3P+jsl9cWhkomstadFEvP0F/fAYn9Mq/blMTIIZaN5FLjJGxxjp4L1mqVuQ5APv6H5TwIQqkLwd+SIQLSAkLkiiciDFATtQTXaVUMVKG9Rseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OTioy4hU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jnSiL2ql; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9AMa13556019
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LvGF2bXqo6ZRSC7J2AyuJceqO+H/uXluc3B9TCf2lc8=; b=OTioy4hU61nC3c2Y
	Jc1lRg25MruHGX8ACM7Z9ujNfmiiRV7sDVNLVf5XXI381R9k1JZF1UObosQXLHMY
	eBoMz8RnEf+xedIriOqpTk/ANRDEYb9HTC7zniX2aR04PSq0gtZFEfIllBk31eOz
	aeD0vR+U0kNUN/s5E4gBi90q/Ou+fQ1mYEJrgkTIKCkBQ/iJd8rPugDUw/x4l8aF
	K3O+DBf89WSD177ZB8T3CciPYJlek1jGwvNmRgQil3yUEhUTltdJw1s9Ffj+WYHc
	3tAH35bFVYYvAgD3TY/MxUufGMptJDxkiubvgZwII8SxCStvM/lbIYkTsVwZZLUD
	t1ghIg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6mnmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso431225a12.3
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779369497; x=1779974297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvGF2bXqo6ZRSC7J2AyuJceqO+H/uXluc3B9TCf2lc8=;
        b=jnSiL2ql1BrUVQDLnLUErK5ZlLPi9XhlH7Kydv4lbZsUHhb/G3jf0+K8iNjGhCAAM2
         dLwZsi5gjFRw/BlyxZCt3I9YXSfYaiCe6/neNU/oCsAJNhrfMEqr88tBvHDrELQ8/HUR
         tFPTD1N2NcWW1eMWdK7WEOlVrbqh9S5VpItRsTwx10GxriUtzfH/51VvBJ4T/8WPzv5w
         4uUw0K8xuVBLZP/+cKmj7jSqocURP0NHnYSz+Ql7Iz2UlIYvGBR2vCWVLA7glc2ZNYdp
         +q+mEQQY9m/kSUFZpnHQ5o3Xxlu319xEagbbDZwhek/AoaGh13WfjFgPZ18ILf/2tmgN
         kaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369497; x=1779974297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LvGF2bXqo6ZRSC7J2AyuJceqO+H/uXluc3B9TCf2lc8=;
        b=RVMnQBz7n3BqH+xD2ujG6iiZQJFVcvbK/ucFnq0fKqMG0byy8nxgADLgMnUqAjU7Pt
         q85G1S158HCyDQ0ZhkdHBK8lDETMPFSsaf4Z0trpc+d6uq+4HhsApmcymbzEbApmIcy5
         rczR4aIUTrYcU+77uiKDXZfCsPo1QMgl3HiFCdJwuhm/EAehwXsIWZ+oIBlqaQKHP5y+
         yfoJY9cbgjmnsiOX2OsMcf9tl9K/lu6l9eqnyoBusvAyYJ7Qbs9Nldo6JX89yethYkwP
         QvnHkv+zPAD7JGE0XnRigONVgux6+L6d82UZND+lkVTyGFY++4FSRaziCjIk9DpJVvnB
         RpWA==
X-Forwarded-Encrypted: i=1; AFNElJ/+OxkA1J1w5YmtG5wktE+lJnz5lSZOyNwRfX7kgG8Mnc44rp+eQX1dGTO1rdNCv+yhQW/WN3GAxnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkRg88xEf3hg4gJlIIJ5+8Qsf+BqTaLmZ5fxHo+T3UV+gQA/F
	FcsQyg5BVtVXfUEaRcHplE0JBzvGjpCesHvRauNUFTq6aOHrjxwmNEW7Wssz8GMRAs0cxw0hcgD
	kqPGgKAke3v4w6+FGNJyrpuwPpzS8XQuMFWrE5taK8bnYc5Aw6HF/FcUnC20BiEQ=
X-Gm-Gg: Acq92OF9Qcz5bXGC5iILeOBO6ji9aWNVfcb2mdIJDLghYZqRv1e8VEREd5B7l/ZVbPh
	1d7SzTp/OhOjKC24kp9ogAFzMeLohOTGn8T2RAIKEtBgcf2Ver9sNx6FOvyMEXBBvf+F72/tUMx
	DF3lfrRBPqqT2TZ6nZOvFbd6ilhuVzpVELHVydvHh1aOIXt3yQC3ArW+uTn+qLWT6e92fXDQVFV
	Sxo2BKeZn2KiLGr80x2zinAX3yl3xEkSsZhytShfhiuGoMvuiBrs00HtPUKJyhPRp4EQ6Lfjv5w
	wT1UcE8NWGXUxmsI3zVyHjoX61JyVSl522nqQV3U3OvNsdsegx9p3FPcEQY6JGRnygC/Zdz3l6u
	wyTE2y4nnMrmZCYlGga1At2WfkfcvjYDJ9d4OraPPCPQtwRBaWn11gkfrcbyYAg/KUw==
X-Received: by 2002:a05:6a00:1306:b0:838:127d:a16e with SMTP id d2e1a72fcca58-8414acda8acmr3150906b3a.17.1779369497115;
        Thu, 21 May 2026 06:18:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:1306:b0:838:127d:a16e with SMTP id d2e1a72fcca58-8414acda8acmr3150875b3a.17.1779369496635;
        Thu, 21 May 2026 06:18:16 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e22f1esm1687731b3a.47.2026.05.21.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:18:16 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:47:09 +0530
Subject: [PATCH 2/5] dt-bindings: crypto: qcom,prng: Document Shikra TRNG
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-shikra_crypto_changse-v1-2-0154cc9cc0de@oss.qualcomm.com>
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
In-Reply-To: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0f0619 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mVMjwrqIa5QPTF8STQQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: lIE97iqJKzbigjl77LJ1DooDuoNINH_U
X-Proofpoint-GUID: lIE97iqJKzbigjl77LJ1DooDuoNINH_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMiBTYWx0ZWRfX4OZzL1F91fj9
 rPAnfvTZxj0WBhEwWkwAifFXaGrPZyBEunQJqkGcvfWcEHySOskn/4lBcZV90jvRsiKTCENv57a
 H5FRiDG2cjpEGIj3yRolQewHDDv0+gBzsXxdE4T1tC9u5biYLpeSUd782p7lOw0Ud6zCpbG6XjM
 DhBxTuxH4VJhFNVAmn8rUA9O9vwRA16hAVMSyzsIV8YLT7vBcYOiAYi031iZFmQxDj78cNUfTwC
 4OiFDulgdHF8cTnlEZfCwOp7sLxEDGcreWtmOvvlGw3A3rtQqNq4ZUHXfGtkdDd6RPJgtdQiB5B
 5DC9zNoIoQfyshNrY3ppFUGbdZlDsRw7qGZTmQl0gCmzGETGONrUAy9VXqYT+wyjUcWW+DybwY7
 3JWw1iPxxk6rQZESTOBHI8Gq07hTUNwpgrrTlvRx7c4X4sj5DUW17/kCtAzzLCDlX2t1MHEDanM
 BsMBQa/OfILq3lNVCCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210132
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10641-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7396D5A6367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document shikra compatible for the True Random Number Generator.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index d054cc114707..3698525d3857 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sa8255p-trng
               - qcom,sa8775p-trng
               - qcom,sc7280-trng
+              - qcom,shikra-trng
               - qcom,sm8450-trng
               - qcom,sm8550-trng
               - qcom,sm8650-trng

-- 
2.34.1


