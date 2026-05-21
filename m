Return-Path: <dmaengine+bounces-10643-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMr/B/ULD2omEgYAu9opvQ
	(envelope-from <dmaengine+bounces-10643-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:43:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F35A622C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C85D300668E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F93E9F7B;
	Thu, 21 May 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iiytZrnV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jred1Qy/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A33E9C16
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369511; cv=none; b=O73qITRV+HDfnIAVkWJ/XhURPLvgmBarVtJVDZl0rwQ5zTiLB9cYGxHV0kqOQkgGzaoai9g3XcEh14YM6SKCcegh2Tig2WwLcAp/chXs0aIhsRej2PRgN9bl+sZS4Mu4j1baKM56t04dkqVHf/6+976etdRi1Zs1mywlhXlOW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369511; c=relaxed/simple;
	bh=9DP4WFKs+knnsj8ZwN72mVO6jMAGtfHXV3DJ3PDB7UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POBbDRaPK3Ky/IKXCl+lk0RJCVfsHERe+FBhF6ytSw4dygZNjfGhs5Vaql4arofTVGGhThxs0pe44BRQZ6YkdUP8+2o8zYISHE5mRoD+6nvjI4FePMbR4IRCHLth//yHGW9sT1huPTrwuGnS7bsYldDk5Ov38EeVJTk2eGqS7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iiytZrnV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jred1Qy/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99ter517929
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qft0FFiZAPIrfw/5RUm0iFHVPnU1lPS4nRA9O8uAxwk=; b=iiytZrnVOPfSTJQd
	PDAaog2NriTLs9XGkmIrDfo6YuTislvWrv7S2lzZ0N2kGCoGyDlyE0jjy1wd5dMM
	KDOegblQw1R4jSmTBidtUd6E1tn/4/IrN+72c5/hQJacT7d6OLITCW7t666Q1mby
	Q54RANrcDKSLJ5S4Nh9s+xdEDKbGeBYfO1f8YEShPYR8o16FRDqKoCuNBWzg1rq8
	YekZvsMEt3+Q09ES3sT78g2hbzwgAVfYFeAc+i8pbDVOD02lNSXseN2v0poF+fGD
	hfHbQS/vpFt2F6uf02k0Pq7+/TAXmTqBdGhStViSHykAm2niS3IyOq4KPkObYCrT
	pz00iA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa2csg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c828659ecd4so2675428a12.0
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779369508; x=1779974308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qft0FFiZAPIrfw/5RUm0iFHVPnU1lPS4nRA9O8uAxwk=;
        b=Jred1Qy/Tc8FApe3ZHcOwJYrXSsKIe2vIfUAwohskHXE4uyhIf/mPUsr0HhN/Gg/Ro
         fCVPEs/8WJstzaJDQkm0XRw9hcSzDWYJi9Rv6c+EAdUWtM+z9iWUPUtekJcogKnsc49S
         WSQeEldI8r4hGz6NNknvJ0MfGufPmryY+GLRziTf4QAgy2X28dsIdEbXgCdZeOxiR/TA
         LqQ9g1Dm5DWIR9mreJjfKJvjmGip1l7ROfS/FMiqx89tcQFXUfWCdM7j5w0R2iI+hCx6
         hROzXaHnBzOiC/tlNP6KMsBKZfvakubsyCZc4kBxwhSkAb71eTL7bfxSq+D8Q9hTxWvo
         54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369508; x=1779974308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qft0FFiZAPIrfw/5RUm0iFHVPnU1lPS4nRA9O8uAxwk=;
        b=O1sSPzWQJWTD8ryGCjR+wmoY0a7iHnvVVlSxFUR22vD5GMoySYZIQeAaRrek9V1ReO
         oRXRuK2krgtQjnaZE061gxJXia001atJagSQ1KMOyjFTj+xxmj0z4iJWs+vIqQ/1CgM+
         WCJciCwOUA9AqC4PY0QnY9wRpsIhBtS+yWFa+isRwV5j6zVf0LvQKmmvUB3yhqTZW8Br
         cwdolCVOmXysnr1MB9nnH0p/PpezUhrr2zAwmU3+GjOkJx2e1WyxsZRfD+Obyns1NHaq
         /4nIJ3l/9KE9GIMKfRR0WO8k4Ly9Au8XMVUSla8xxInS/vYql0PXb+4Hk6A+RNdUascO
         hnrA==
X-Forwarded-Encrypted: i=1; AFNElJ9zo1z7Cw3fae3xZ21TiA09nYRx5K1zG2p4gM3bqbKJ6DhL8K50EZm71NR16Of9H0AWemHOCtUH+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN440lJMlbVY0vrp+YfWShJwSTnW7SdVIqW9UB0rJoFhZDHPxF
	4zDS6Idaj4GirtMyiA08yttsTvm8JEl2KX958SRtIxVQSL47B9oFkcuUdYo34fGFmaHwiAsPYq5
	lCK3/FVHZk/IE21UxBoMlF81SF1co/ixOfXd04NxWz8rIBJQmbgtmxuluxYPgIak=
X-Gm-Gg: Acq92OFAbf4GafUc2OHmmVmWKG/D6ruswXepl3mIB3RsutjlmsR6xB57kSkL8yVI3iG
	glgEL72KMZQK6SMc3d9cksYUZ3gqZsGQ8V/k6dRqdythp/Ss2W26b8MnyB2Zds/gZ1ew6mWBqkD
	uStzBkwGEJF0N/ZdiNuA6Dy5Cp3fn8hMDjETmn2OEJUBMOTwYjSDOVYPsaDZ4yVzPzSKDXG/UaA
	hrY6wyBeY5b2k2Hf6h8sj7caFQ+Fr8pncbCa/FrbpkpubKTl0g5NgyrBlYQUttbnooWZKgxl30x
	2f5u7GVXFpq0D6NhbsL1ksXyewmetL28LFCrob2DKQoRAVVN8hdRXLKUguFeQcRErTiCmNeIjv7
	a77l8O5SDVe+31ZhJqL9zXDM+PE9yhD7LLKF8nFtZfIrkQXr0GZg2qVA=
X-Received: by 2002:a05:6a20:4307:b0:3a2:d79c:416c with SMTP id adf61e73a8af0-3b30874bfcamr3376059637.32.1779369508312;
        Thu, 21 May 2026 06:18:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:4307:b0:3a2:d79c:416c with SMTP id adf61e73a8af0-3b30874bfcamr3376003637.32.1779369507771;
        Thu, 21 May 2026 06:18:27 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e22f1esm1687731b3a.47.2026.05.21.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:18:27 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:47:11 +0530
Subject: [PATCH 4/5] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-shikra_crypto_changse-v1-4-0154cc9cc0de@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMiBTYWx0ZWRfX4j3fRJbeE0re
 eqQcG+/yyocLkaVB0ce4/jYR+WR1G5NCYkJsvKmKNVFxlXSb66BlX3MmvurzUno/iMgK3Mo8GOG
 qGto3dKpD4d1mvnMh8JFWHGsOtuhnLIQb/L/qJztLKkXL++1AWlI5yILzC4qdo9pqB80AvOM3p2
 4ehScYqgQ6BsKTVdKI2mbdm5PmatCFnt3m1Kfw8X8CHVYjgadaEiYnwddZJhc2LjuhvRQp8RU0O
 3LmcaqFgRODiNSJB8+dvym58+uGp3zF5npI3gtoxxriCN1LqtJaB67Tg2ODJNx0+/Zm4ffpKVJ0
 0aqghgvYF9h0zOrHz3Z3FqRIp0l1pbchpJ0DiAXA/OCNrmEgaLy5J+qh+ddHIOhPEyI1o5aBwKI
 A83JbBf8mxbTav0506w8aiRfz/JUlENXQylhMMvm+Tq1oqNxxMfiVlYi5ZROpVXp9tVz31Miy8X
 dIs2uAEcM5Zi1tPMiDw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0f0625 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Pn01LGb3GYlZyOwDGgsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: DIFP9di225HFYxVyEwow7iwafl-KInAf
X-Proofpoint-GUID: DIFP9di225HFYxVyEwow7iwafl-KInAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210132
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10643-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: C06F35A622C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Shikra bam dma engine support 7 iommu entries and not 6.
Increase maxItems property for iommus to pass dtbs_check errors.

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


