Return-Path: <dmaengine+bounces-11052-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ83KNQsG2pa/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11052-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:30:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 651FE611DEC
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E15C430A4C82
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40063C2799;
	Sat, 30 May 2026 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4LOmhoC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J4gdjuxr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824EB3C1401
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165683; cv=none; b=IgvZS3C9y5saWCGFKxLKcLdjaiMZVV0X7GE+TeHFXNzADnxEL9izSCSdw6Zl0FgQin7vFy31Z36VVrRghG0T/hHPxCzTn/zhMZzy4oWASubnTlQ7y6DQ9yDaB802ZJQRh9LGrej/RW/i0isezTfksb6doMs6UC/PW8Wiyl1Z2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165683; c=relaxed/simple;
	bh=mjrd/5WRTtizVxAileTEcsI3Pcwm5BCTvACtsLVlxwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzpAn7xcNXcYJBJJq+Of7B41nssYuNuzbbLuKPGCDYfqawXd0gGCj3rI1iD6SOQFZwafqvDg27tRx7rp2Mxo3JzGRUZDq+9M214duEMzkvRYn9fPeMzm6eGbDNmRr3o4sgU5lYIT0M3CS9qJd7WsrSA8atpAI4uj74e+MUvs6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F4LOmhoC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J4gdjuxr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOQbH3468230
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=; b=F4LOmhoC//1ULH2m
	z0OXsKvYwjH6BFxsiunaCfeQSbEaiNDoel5UdLClSRtJQdCMyEUg4QGp/lQuVuxs
	N87bKUqYXzDfTTYAjdxtf557PVOsycOfn9Sh9RVfXOOohVOh7cyZLeSdutG4MCS7
	ISRvfi95+0zSjC0XHRuamiJ0hKuhiB/q48VVjfh9pkWSl2G9VJ6x5uINHDqaZknV
	taomnxc42mteUR6FV2aofHnLNsS3mDcHrnuRO5iT1bNrCO/XFBjv66IDauLBVn8u
	R7tMdM/s2hHIBDTfyS3XOe8WteqyS7U/pj9zz2nSVFFSQcNjsohy5fExI9u5ye1P
	cODV6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr989n1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2beff6b6e74so38362695ad.1
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165680; x=1780770480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=J4gdjuxrdODYs6/ulWEu1JylI8cXk/+84+SyHmcGKhr3YF5hfJozuz9rgTW0CMvxn+
         9pSUyXe9okcaH3tEdIHFVdQyDcgIaffvzd9iXw+ScbSdBsjz7tXnGETtkI09fJQaVMoe
         DJo1gPcwG1M8YLZmax3pDCEDBXu33N+qm+1b8a85X9EyjtT4SAm0UXTYkJi5hRLdvl+w
         PN857RYYPNedju1w0dR7ESZ8z5oqU6WgbS+HFTq4BB1WEGnBEim74wJ96bdbzfBahyDK
         yP+pJuzMJgrRBqeXRdSHeuIYPSiJlrD7yO7SVpXaf29HthqOniund3m9WnWU9isHFWCk
         zksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165680; x=1780770480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=KJtkTKog9ce/SotY1diADnMpm5q4EcFp8w2NJwNTO6XW2vAdwLwIDXr8OmOwTT34Bz
         gMlBQRMFzsZNyVjZlyMl2L0LAh5dc1IvOx+XpK6O12IyJV6159+UCVqBXAXg45Fi/72f
         +4zKzNv3ANj8Le0jjuZCX+eZvRhBoNijyFM0F/GrEKnlC9xMv0IQl3hOvXI/kUXjpDGI
         KWUe+PVzfRVlMbmh0/lUMmTm/6RREMR/IvoF6Pkihn/o9nuW8mKGnKT1/0COZQt+tIby
         5tSOYaTp+E1xd6XHHM+I5B173yVkOHc2QPRTnMC04KlXEYEME8RWtMt5Dp8LNwo52j8F
         ckSg==
X-Forwarded-Encrypted: i=1; AFNElJ/bcFAYZ8WfBLAQdDHmhOrj7G2fjRFjEya3mY81ceRSDhSBEbc2P9o1dZ+CetIT43+kfc2VTkLNYFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6CgFRovOhrqzC62mqIHO4w3fPVn68dpWcSDY4WHWa3fzHyDN
	Dj1JF/Vk0+NOR9V9cVvamfCLIf3masHsyWWsxO+BzJAok/szm1DueTwypNTAQHXO/uP1JJ973ZR
	pUMu18p1ZzSRuKmG4gAC9txrvtHEptr0PgI+i5CYuN+b5gB/7EsJi+ypFouwbXLEsPdUDJTE=
X-Gm-Gg: Acq92OFAXx3OXg8pjpyig/fDFDzZWwMvN36kYkvoEVKVaiFobjX3Iru3HLVpvoobiC3
	LEWuPe7Eb1W0NEFzkMG5+63ST4CIATGXvAFhWhjyH84rYdI8BMUIhcvJ/33jfMbSjGidyemEfF1
	+5Xyo3/Gt1dJ2WsKdU4Daz3G/gL6/VLg0BamLpTgfl3emfSf9uArACMibIWVkXH5sqSCczpeHNV
	wLqRrkHQsXvRJ1B9GGo7LzZ6MjUzasKb4tQTg9BL0LH/XLtXGBDiadsBeDx/0pRM48fFHfQlxq3
	rxFeB+vXEsfJGy/ajk4KyZ9ykVgqYEIT6blzCVuno1jSomiupLz4f2PEHUglK5hZVmP9YSemg+6
	tmcTnakLi6JU75kjpESKo4lHIP3/PaEucau/D1RqOlTavR/8=
X-Received: by 2002:a17:903:22c5:b0:2c0:c625:4019 with SMTP id d9443c01a7336-2c0c6254474mr318295ad.25.1780165680508;
        Sat, 30 May 2026 11:28:00 -0700 (PDT)
X-Received: by 2002:a17:903:22c5:b0:2c0:c625:4019 with SMTP id d9443c01a7336-2c0c6254474mr317975ad.25.1780165680028;
        Sat, 30 May 2026 11:28:00 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:27:59 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:19 +0530
Subject: [PATCH v2 01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA
 engine for Shikra SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-1-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=857;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=JRwNa7gj/V38SNuXulP2MlFnweDp961hhJdbueICCwE=;
 b=zWWaFqHSP8Vk/mLPkC/+xc6zW/EaqcFc/llcdbnCatLUnMeA1FqnMId5kh8acH2hWQHE/jylm
 oYBDHZraf7hAjAlepPcNqUcUx5R7dmqm3I07Btm9yTucHnPU93ynR3r
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1b2c31 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jyTGefxJr8I4-3Pae4IA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: WkwPiM8ho9zQkc7mOVFRQXpRqToAhEhy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX71EOOOKj9ain
 Rnai15IDeNIMl3+bGRbb3N8L/9CDpcwLj5dOV0PRH/FImcAiIlTXVNwjS+dq/6ZtFhUUHDOPkoQ
 2mdu2koZZI6e6N7Cr5SXwjzJdy70Vw1lQOO1ZYhEJy/0KemFxnIplb51ZuFXwYbuqtFpNiL6GzR
 lTTuFKxR2tvIUYU0FeBWyaVl/L6WTO6UmEBDdQgt/4B2xqizDEQ1oUO2rRl2oxt3sY1vwUNTm5U
 hFll56jYDEdkwLItGkaNlfKNc09pxDY5XlCcaaB0WXWX63SpN4YghtdJsF4F/FOheK2bGfc6qp8
 MFxQhF+XI/cbtrqFkGxM1RIdjFM9hqhxfp1r/1x1Hcqw2SMR5Up0K8SjLUM3osqFaR2s0/PoMU9
 MZtxhLZ8WFngso89EETSti1Si3z9D7meejDERpXV4DqaLWpcn4KvnW6KyLv7RIy9yN4ZOCY0L36
 ZxZ8N2QJ7uq+kyuU06g==
X-Proofpoint-ORIG-GUID: WkwPiM8ho9zQkc7mOVFRQXpRqToAhEhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11052-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 651FE611DEC
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


