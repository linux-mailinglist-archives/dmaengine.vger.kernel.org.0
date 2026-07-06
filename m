Return-Path: <dmaengine+bounces-12048-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HH1hNbaSS2oEVwEAu9opvQ
	(envelope-from <dmaengine+bounces-12048-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:34:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638C70FE47
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bNRM9b93;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BgsHo8vU;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12048-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12048-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEBFA303EA96
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8641F7DB;
	Mon,  6 Jul 2026 11:32:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2441DECF
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337553; cv=none; b=By3JOVV6tPZKzHVoKvGJGQcbW4iUni5CZRukRp8OvoTuMOK/2cXMuUkNadFelbW6+zEZURfnUrzbnTlT3SqPSkUhwaJNzyyu1kpqo+b/MmLX+9bYxmhQS8Ru+R3yDa73ksh9tCr3Pq2Kh+/OJ1RqcaJ+OZvDDR18G+DStdj/Rtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337553; c=relaxed/simple;
	bh=zjzyQGqtQEvToFUvVoo7pZ24KQzxayJOTmTLKhS4AOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bv860PxCa2JV//gp+X8EAYt5egMS/Qg1KZgY0HCIJxscTQjqG2iBLcRpOg7RNyZHGX7N+8fheHZuRZUIDK1nThGzbKeEzrmvheMRwRTjKvs6X0a3dQnPQ4LpCadOD2o7IOilECBnYby7x2ROt5MI1Pi2Mymg6imZfx/4KkluPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNRM9b93; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgsHo8vU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxD7E366713
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7SkMYn1pW8LZr6abBIJ2z33PKYxNNOhX0ZIHoUiS7dk=; b=bNRM9b93C2KoANL5
	Fk6+1X7sDHXqIMPZliAznbS4iL327Fmj4JPnVK1roSk874A8RUVwRab+OugbudZJ
	dHZzZUEPKGlfSrT8+RPR4FaRF/+DNoShXcYrekfr73fqrAAwdwv4oymsMU5wUa6N
	iKNnDbofO1GGfC5EVRDrsYBELG7UmIcxgspDndwkgVJcM1w8ELleBZm965P6DpMk
	ViBEGiUV3Ho11W3dAi1WLENHYrzd9pcpvPptYFaHmSnImTygKH6F4oa4F1M6jNyT
	HKejU7bWF3H58ajYFJ+EL9xS2RNcAIbF1RwG8DqgzukjM9NybTFiLf6jBwzgTi24
	PSq2KA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891urn31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8479c6c6cbeso2688814b3a.0
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337551; x=1783942351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SkMYn1pW8LZr6abBIJ2z33PKYxNNOhX0ZIHoUiS7dk=;
        b=BgsHo8vUJTjtwlowhC2zqO10pAmxq0btNYDrRwdJ+/hK93kTZ+hoNczaXm4+FF3QAv
         I0iUOVKe3k+GhSB2hrJvDnhdCXyRcxfpKKhUbGXDdh1En9kuqUgHL0AJoEJYTz4Qjc8Z
         YgfuMaqxy53SyCVGP2wTkbMV0M4nQ9qy+VtcTfJH/ugrm7isQiziEI61Saci4kUxD++Y
         yw0q4Dely9vNGXL7E2OFeRveCmCtHH4oqwgE9nj5eDRcCbGfwVyz//NOlBBNDkNjIPCg
         EhEE1HuBYB0sHu069ZoiQSgXOkzQcuupyLs6r5osk9NLICSiw5H7/F4XoKvK4AYg6swj
         HOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337551; x=1783942351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SkMYn1pW8LZr6abBIJ2z33PKYxNNOhX0ZIHoUiS7dk=;
        b=MlkuX7ZHx/7hWcFKUhwcC2VLZOlKYd0Vf0CKINtN1mpFt2sZpIBAuGdNkGKP6mkv6H
         DZOnY1XvL3Fc2L2U9JlrhNArKsDAY3l5j2G5ZbITuagUYk/MGdjhv78lSZSMU2tkFOXx
         kWMlpNAqs6iGGFnfZMcBV9FOqulKBg88AOPlJCayF+4glxdqbLJpzbZRTutpV4o+JoBR
         hd10djBxYEBmB5kNWJ5rbL7GaWQ/9rwl76r2lbLryO7gQRJ4zxM5VymO/rekz0ZJwvaA
         m2UmasJfN0Xy37kTTNbmciQL6GORay8mvE3gXbbFrNwsbBxypHJ7YRgt6nYS17ymW4Et
         cVQA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2rNUcCp/uw6a/QKipvzlxRMncvsqcQvvCfHQmtH7Qgkn6blUfgKhMkQQ/L3Ai4Lk3bpRD4ImgDZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgRvoJzQawkRvZRGCPcBUqzseQsGzYy7h1keQ6rSwPcf3bHO2
	fMBAv3Sky1580Dlodh3XR9R/XdIWTfMBp5TEZvQfIlBvG3xZ0Gjf0ZBMSYUVm12MAi42fPUiYOX
	bLArQtJFsJWnRl1AVQjUaLVb1mlzfBk7coZJjZybpfAo81fpcy0TAFVIx1POrRmc=
X-Gm-Gg: AfdE7cnqZ4tpqW8DYwmlzvidOW1nfzsfDADoRsJ4AAkVsbOvSZi5HCwmw6N8Q+cI4o8
	d0KQh6xbCDu5Az4FeDnux7bIFdMwLGI396qzBlUBstRPnM85ZdLXOZLyL+tMNHpUB88PSwFD3qd
	NXHNOYJXT9um5p9dTKWL+vL/cfQ3xa2K5o36zodyZPNdSjnLCeYjjmEMZZ6GL3QovLWFBsh52iW
	BQa4u3uFauqBIhGU+R183GWt9mN8zCgAdetMjhgMd0YeadElIlHv60ruyatlOzLw/oPQfbJ0RuA
	K3haVgZYaKRfPtUQDgInoS5z85a5h87ZgZ36/IrlRvUsfWgi0f+hwBUykPQ8zzPoo6NIO9+6J4R
	Ss++IUNTasljb2mdGFBY2zjttDHRkOGaTDElRMlYNddTr
X-Received: by 2002:a05:6a00:e8a:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-84826c1eaf5mr136621b3a.2.1783337550721;
        Mon, 06 Jul 2026 04:32:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:e8a:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-84826c1eaf5mr136575b3a.2.1783337550254;
        Mon, 06 Jul 2026 04:32:30 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:29 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 17:01:32 +0530
Subject: [PATCH v3 4/6] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-shikra_crypto_changse-v3-4-23b4c2054227@oss.qualcomm.com>
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
X-Proofpoint-GUID: Sa8IlGIettSw_KSV3Q618n7bT50ChJGj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX/xmDGXecilS6
 omCqrVmwBipEu6RKWq+pultTYvWPX3l2GAVHPekBJjxn7/Yz6fdzO8Ms9EFlDtilL+Mo1kmr1eg
 /VVSNNrL3JqsW5KA7loJsfDVcRUFJdk=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b924f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mnL63iHeaYg7R5sIRJMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX49YrwGpGwWpI
 pSr4yU8x9137pB8Nl+8hu1bcLYQbQCv0tA02BRbdNmhftupZti3Rvvlp4SpE5+ahsRkI+AzxgV0
 EE/8pDHqIoTFKhdGhwVmtvymZhbnWri1z6WSU+ifsnEj1fBKHMchvDm7C2J61JZPZkZzItllvUd
 0x6mhrbb+QQAm+Whda8hw1m5bVqn2557xuHLOM9cWh2VDQW19b2Nk8a/MuUFuGOkyi75o8tkZ4F
 unCCxf1SroSLgKztD6W4sBe6hcFPUHv3yywsjF9rDb2licZ8yUG1BSy4s+M5bZ3lG2FOW06CTIY
 J/n5ytNbL7fORvMBP8O6uVMaOvePsSBcYnJbZM2ibCDFChW/yYmF9kAS216K3v4k4LPTjXc82cN
 M8nHryiNpEVfkyGk21QZUJUZSURGZn+7fy3xz/4Y9sWaTDDMLgSC/eo+ASbWKRe37vtaqfMM0F0
 qLL+KxTNEVAsMATySaA==
X-Proofpoint-ORIG-GUID: Sa8IlGIettSw_KSV3Q618n7bT50ChJGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
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
	TAGGED_FROM(0.00)[bounces-12048-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 9638C70FE47

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


