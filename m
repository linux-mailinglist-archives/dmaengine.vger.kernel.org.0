Return-Path: <dmaengine+bounces-10783-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OONHJFtWE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10783-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:49:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBA5C3E18
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA6923009566
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03021CD1E4;
	Sun, 24 May 2026 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LogcTLjl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XCrai2zR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00A317177
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652175; cv=none; b=emvqI7izRHpS64NCOncQdTgdheKvftvQjdwwmLGZV6Dt12qcwhE0dCRifD7llOIbRLHjCBBwYvtX6usxJOoceFQIl1VokTSr8zOzgItSJmgaiHmtqTBnKZXA6DpLtS76xiL14jZSqVhnSX63mknqoGnt8SErX2iaoPRSGhYhGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652175; c=relaxed/simple;
	bh=mjrd/5WRTtizVxAileTEcsI3Pcwm5BCTvACtsLVlxwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyXngLlnz1sGsv1Kdps3Wj6kmSKzxLb7yCCs08Ux2T2zPlzUAXrDwS8EdVVMAjjxfgpIIYItP5JvwuZ81HU1CdVJm3KOD5jhdDcFIT1AEPf6uJ69ZeJcALeIUQXj2UXVDJ3FaseI0pIxrgh6nhfGO/s2RfLe+2msmBZ2wIDeNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LogcTLjl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XCrai2zR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OGwGml2213194
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=; b=LogcTLjlntl1XNsc
	yeqnh5YMUmrxODxq2K4HIRtiksiDZITDHIaGV2J4t9Y5hap7R8JTPgzE3/3zh847
	okoZWGj2T9vhrc4E1t7DDHPjAV9Xw2dJ1xIRthgqd4vV3bRQby6E938tsdcBswku
	ir4Gxrq29FQpejJkxccMOevias7ggrockSi12sM/dZPoLXzxoglSNDJFuIlE6Tgw
	bGW6ISeYds2l74VCrjo6qMGtao0qos+n1jWCpYGoxreIQXi6N7s8wLMooTXSCqiC
	uxLeeVi71KUXy9+d2WZyTQGScNJEkF3eQFU0nDDaDf39lrJRuM6SwdVdRjRwsEdx
	1bIK5A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50fut2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so6957227a91.1
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652172; x=1780256972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=XCrai2zRaSx7adJ2I4QNQkfKAXwE71GguAkz9Df19yG9l1i/Gs6HYX6mg5nproqaxU
         72WHgDwn+PUdKdmjETF3YvwEAO+vu9cifWUBYk4OPUXn+uqjQlAwoglMLcq7OSvvA5Ta
         M6CwTpmplkSOxnhtLXRwAmXaxA339WIDg9H+4OsWR0fN2lFy6MZQpjboybQsZJtQTPPE
         0lnqQglccMCWvvPjv9gkJueJMQ6F9fPJEqynM6QG6CFfaPNdCEzSFrg408HPyLLh2Acv
         5KHmg9Ef8UWdi/xnnHqhHsht8I9fsQitgeS9EBfMvqOjpqV7cautkmSIe+gs4q4AKpXd
         zhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652172; x=1780256972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=g1HHULnDDD5Z2xUwmsgDswyBtamOy1BoR/k7WyOdXJQHmev77szDxLYrgVpIvjvOAR
         Uf2p83FCg+9psz0uHUQH/hI12z5j7feA9joptgJcWKtXPDNHV7zN70IsQvDx8Q3dCGnb
         HuUXNWHBbxSmyQesW6DMV6F5VgzYW9xpQ/D47kUueevZ8mk4ajcdYf2pLpn8V8vAD9LB
         8ugi6zsi957Yx4iA+o83bQeJ/SU3agAe9svZjSa1FOc7lukt1UGsaT1qMR+qVjbahXky
         fP963DEWny6VhXFIxcKFuKxS0Jy7y/4W5gGMZRM+vWeIRGjnbY9ITRZJSQbRiYnk7KeV
         S7sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kJnVkyJmZvUh7FTWvPk9KsT4LOPXLZ+UrWSHeHm4AjhRqE/LY2JT1T/Mrj9/MtMzATbMFoBckeh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqlaE3pH/4yvrmzXlii9zBYeHPk8PNeYx3nxGRPFUOfH14j68
	Pon7NRJdcdKzbhsKiOBgQP8I08jzSbqSv5w9sxRlJ/76Tl2vTCAivy+ZIsEynSr2F9mvr6v8BH0
	MreZ8sOWqSFYOTuQIqyf8Mv+RYan1+WNwFm2C7qtTGVjx0wd7nHNtSOjVo4fTIbA=
X-Gm-Gg: Acq92OGQdfNiucium3fP0f78Pas90DHpfulcs/NYvZ8AQiVnqYR66j4dpjdwgBoAuoV
	Hc3vW+kfk5F6FNNJglGWD7zfxva0nyijE2yJBBpyVuyQxkvh06K3ZlD4DeYeqpnNx7WFvsoze1p
	tbf+rEwD+SVhrHWYa4o5hKAat8W9mYbteyNSIT0oO571qTtR6AQAVXsPoGdux3G3rIX1vWvnama
	8ublib2WbYLqSwLEn5h3is8QYeudkKrsDQObqK2ciIterywFS/vDUz/XF9kYq7W+/oKZA2Ckq10
	TDnSn/0fuy1yYpTBtndHoFk34PaSCg+a9OZbSo30O4WRJx69Vdf6iwk002NvXhspR00GyyBCsl0
	QsQw+5L9SzMDLPKIuDMSssH3OWLxDJHr8NuMM
X-Received: by 2002:a17:90b:3bc6:b0:368:7327:6326 with SMTP id 98e67ed59e1d1-36a6741ecbamr12524822a91.1.1779652172276;
        Sun, 24 May 2026 12:49:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc6:b0:368:7327:6326 with SMTP id 98e67ed59e1d1-36a6741ecbamr12524797a91.1.1779652171688;
        Sun, 24 May 2026 12:49:31 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:05 +0530
Subject: [PATCH 01/16] dt-bindings: dma: qcom,gpi: Document GPI DMA engine
 for Shikra SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-1-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=857;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=JRwNa7gj/V38SNuXulP2MlFnweDp961hhJdbueICCwE=;
 b=SJMty0KWOEX6DjZ0a71oPFOwID0hjCec2SeHsUbInB/1OE7qDGKizj3oNha3YZZH6bSMaZrvj
 cv5jqYpiPCUA39iEcakFA60bKj9Q/JudQ/Ojlo5t0q16s0LLJdA+U+k
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXy4efLEIWU8Bk
 SpZ6tz+uNfQTqp6uTXQiLeWIYC0E/Qmh3HuvhwBbqE4fmsOdw5IEuVJqbR0j+IGRiZOPRv0hZHv
 PiwJDQru1hmLM2pkUI+GpwivW8cDo75yzCSRD7oeXtS3ritAo5kz2TyCPeeRjsZGFDWaHPSfHYc
 ap1YawpWHWiRxu7JI7royAfG1d4MF1nf4Jgfg6knYTSTj9QmdPKmNSCFP3NQ//PgJlCHQRyeD6E
 lY2IYIfQMjd3oMLuU/7li8bIo5KE8QlnibHUn93PVkn4s50bkdlUDp1mcV/vV61m6QGiNaZSHVH
 fXdQ2OFYtbo+/bQNSwz5wVV5tJCoKunTojbY2KyhCxhgaM8sAVPY+Fq9cCYOKjmgNombLRYd5k1
 RlfgvsExQ/xX99H4Gkf04l5q+sZere2RExPhHBZYIhKbexgtQsf98cEYcxtzRhintExALPVZVlB
 x1Bsyp+SNdV0VyRXAiQ==
X-Proofpoint-ORIG-GUID: xVm8jqzUntZ0mtg7WFfM2DVkwwWceue4
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a13564d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jyTGefxJr8I4-3Pae4IA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: xVm8jqzUntZ0mtg7WFfM2DVkwwWceue4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10783-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 11BBA5C3E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Document the GPI DMA engine on Shikra platform.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8f9a552fe30e..54dca623223d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-gpi-dma
               - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
+              - qcom,shikra-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma

-- 
2.34.1


