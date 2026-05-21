Return-Path: <dmaengine+bounces-10642-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBNkLPgMD2p7EgYAu9opvQ
	(envelope-from <dmaengine+bounces-10642-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:47:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B15A6380
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B086319C43B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB733E9286;
	Thu, 21 May 2026 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YzlVVREp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bh1hvIfz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248743E5590
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369505; cv=none; b=aKXC7XZgv5c3Q9tmgbwOA8xBE67acFaOSSh1glOlPluGFzRwEY1rGF/ttXzV0mnwEoAfvNiDR4GD2rvVai6LEFfFyCZKCnsCXs+5WS56hItFRGBl7oT1GO/Xw/0h6bub5zyvM9q5aCbxXxDxOzhhLptBH6Yhrd3WMTM0XjiYsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369505; c=relaxed/simple;
	bh=NTwlaax/lh6AG78S/JgsCIhqbIXpaLk3tcWX2JG/xaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tP0IE02HlBrs2Ki/hl/xSKARlBcNOkQy2poeBIvtRyAdDvMbOf2+E3Ak0tIr+QWoc/82tigib3MTprwGaw+udOLRPa1hFgUO6MMhc6iB4W9L1InSxK4upOVUpn7VCV2HMJHCDsH/Aida32fAJ3aUT9SQL9nAeYv00yil2aUJlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YzlVVREp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bh1hvIfz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99xBr2632726
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMQJhPfnLBvDiSVCVF4l3ibrl3mzFihtcnE5yfd3vx8=; b=YzlVVREpIkFlU72G
	eaaDHr8OlGNN9XqSQxBleR+N//2LDh2Ce4STJzEVdNEI4KYKnaWha2PdXQHZr37f
	LlL7PpEIaiC2Pot5ICYHIER4/PSHJL/R5zYqeb/SstmJ5iO5CLpgwth8tKxWBnkG
	mLEHazhEoqi0daBpuXpb59Vbk4jBZa8fisESsSrcn/Ht9d/uWdTHruXlWXTe8Leq
	X9/iwt7RoN6Pke0itZSXpcKINtortlnkRMGwi5PDcgREuTYQugIvQOXRgBlWx6ir
	3xADQ4ghm5rcoJcLle3uSjnKq7L5teRKV0apHO9UO0W+Jk9oZ42b1uu7F5kOXZ9e
	SidbSg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8d5ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-83836443305so3082810b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779369503; x=1779974303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMQJhPfnLBvDiSVCVF4l3ibrl3mzFihtcnE5yfd3vx8=;
        b=Bh1hvIfzV0GAsi5DZwlI/3eLUx53+v4T7Mnjj5bO6EKjHSbCFLWpvnr0mAVrBOpkQ/
         FRtVcx0kgHp4t66n2XzWbMUH/dmkyktWzW11zsx2jbsOkcABa9lcjwZ7BM9PS4aZhlQ/
         h7CHCLDpe/HQkTdbvLz9OzM8O5IuGAZk2ZKGG7SLsEWuFbC6AM3LakUPfwG2Lp1GRN6d
         1BJ+5ubOtM9EXIDzbhwg7SWMpg4lJXyPJIA8+mQ5ooAMYOslj9TbVEydkts3kGgCewRR
         AaVQxEOV87LIuCH1ejuM6YwpWxFhH0hDOdeCvuauAl0WMZkVxc5X+m2dzMVxOPhw0qeH
         LIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369503; x=1779974303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMQJhPfnLBvDiSVCVF4l3ibrl3mzFihtcnE5yfd3vx8=;
        b=M3Zv6/6TbQzNK6t/ZwLlicqSi6doESiQ/0/HH+uYayc82X7ORhpZReND82tCDC/MKZ
         7Yf/kMmZMvHQZjz3xIGAz7lVBocsH60dzEqoSJau6cgdJnrdYFC+KInJTytMrY6ejk+P
         EjuT9SP3vPZT30Fe+d7XaEYrmtMwM5GnZY0b6keN7figwoG1mNDqLQSeKomzD4GB8gz9
         tjetZALg1SyYyW4XNUG8B44C2q8ZnBPx/Z/OuEoXqsj9N0dO1q2mHThXhaqgX2S2/E8I
         IZo9M7FtcVM7ME9OGxTJDyNibWjlpNtVm98+MFYhWOX2yCmlwC/XcPfRMDc4yVVqKSCN
         V/8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ZQRNFb+KFTkXxqKCuES4yDw35dFszfAqz1XW8O/GVRFFqa5nmwDoEWohqSRihpOICzYUW4Is2UUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybJKctcum1sqhKf0EgOw4Y+TPVCSmJjcbFUQ/772dNk9YgfZQ
	1fuIeCItWxm2XJC4LMuTzFG5Uoq1L3qOf4fw7WVHUOSp76rHDnGzinE6wKdLo+cj/A2mGjwu2cE
	V+E3SS3GvJkDmRqCK1hBQZldf40Nnre1J6i2XvoCWnl6HLXJdc670o7WcWy4WAaI=
X-Gm-Gg: Acq92OF7zX6ldmx9LuRao2HlrUmLYsHPPLNYpMqZgWh9gAqtBPBRgALXKSs/9Zyajcd
	rAxVPM73BBEG4uLbHsj66bNgCMG89F7PTswAECaFhYSGZUKhVB0TAC/ytlfxtge4MxzRoo88koN
	mzdGC+n1+m66vBOd9qdj/YOA4G9hBJJG2Y1abJus0o4zrzaGZE4nUnEE9B7U6GSmKQOk2ZdduS+
	L6mRvW+nGjQoAuFsoBsSlCZG/TP6BacyUCE4jmR1jJrPeRm+Fy7Ydr3LfW9mcTHb1af27KSFuo8
	suXCKISGRz7KRZwXNodZr1CKTUv39tTzvgLYOXGccVjVdSIq40pEHLEM9/VydDmKQZa2VbrkR6L
	/UsAbNpYDwObq0AIa4yuujTD019wORiC3PDPQeiW5omkkBefndX3S0HM=
X-Received: by 2002:a05:6a00:3394:b0:839:dd77:3505 with SMTP id d2e1a72fcca58-8414ad0bcd3mr3150655b3a.22.1779369502775;
        Thu, 21 May 2026 06:18:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3394:b0:839:dd77:3505 with SMTP id d2e1a72fcca58-8414ad0bcd3mr3150613b3a.22.1779369502244;
        Thu, 21 May 2026 06:18:22 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e22f1esm1687731b3a.47.2026.05.21.06.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:18:21 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:47:10 +0530
Subject: [PATCH 3/5] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-shikra_crypto_changse-v1-3-0154cc9cc0de@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: UgLxoHUABVJ3f27_ctPzgoL6kuwHLfTE
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0f061f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mnL63iHeaYg7R5sIRJMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMiBTYWx0ZWRfX8i5wlA8sF6/c
 QeUXyzvLqOAUFliDp6OS9UKbCZeVy/Dj/Y3eT1jzyKKl/C0MiLosvgE6Q/h+B+CzCEvOacMkG9Y
 aFFqlqibLIEG5FRZolVStxmo94D8mqAfX8jrmN/aIwJXs97gXfnfkgpriiU7Dii4p1N79iHTSDk
 5VLWq/xfvnY27FXj6Pdl508NfqXNIL5FokO3/ztP0XrOE/MmRcumC4ben7Qlk1QP813yp0AID9+
 PA5YPhMuFG8gJPmOqDPzlBScGZJWWXQ0gm9CTNI+YQYuOg2yrFhbwnsCtuopUcZsQpkJslrqLUP
 o76jFoLG7NKzaa8ilzPKcw8ENl/8gLZVSFjbGfA+weX5j27nTTqz//ZTtlH1uZpGT0jcSL/jm3H
 6zWVQkkM0nUtrj1JGg0bbbf2D5KtxSwZrELN569XQm/e30FXv4LYnYhXRrKf7Meeg0l8zhEf0+J
 1U+8VpY432hueclxzxA==
X-Proofpoint-GUID: UgLxoHUABVJ3f27_ctPzgoL6kuwHLfTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210132
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10642-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 324B15A6380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


