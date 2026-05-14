Return-Path: <dmaengine+bounces-10474-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJNrBMEhBmodfgIAu9opvQ
	(envelope-from <dmaengine+bounces-10474-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 21:25:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2254658B
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 21:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9750309B9F1
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621A13AA1AE;
	Thu, 14 May 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQh4De6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ehkT0fze"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE13603DB
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786647; cv=none; b=m/VK0hu/lv0tUh54q7s1TbZTGjR7aJ1UavwjXv2rAVl80SBgX3CNLRq52r5tv0RQh69M4eDl70kmFVqEn4JkYrLufmQsmrRdYw+79ZWnf5G0cwjxS64j6YiW5FriVBllf3pUyzGk72EqItFYMildSWpofy/ODNWsKr7hTVUeONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786647; c=relaxed/simple;
	bh=O7Nv9vX15koThNNmsXV5Ll2RptDkHxpOaS5DSqN+Wxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJogvs3IneN3LnI0rxNiX4wKDLVrzq8QRMy0rohFNAZDBX6qzWinL5W1+mlW7qsV4i/hgAVJUzjMurKkym2Gi1TNjHbUWPWZJ+6MRpOPrdapXe/Vhp/tdbPBXB1sQmF9J1g/gnEJjvmBqZjBlCnzq94XjvdZmE0NIpn4K5hKQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQh4De6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ehkT0fze; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpMCN3670819
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XJbLX3SOQ5nHO6qbquKX49XEzMv+jauXaF/R269IlRU=; b=IQh4De6OZU4oFh5r
	b2tUh0L5kOZYXaA8McIvyh67oioRwUukG7m1eo2GxGCrvOEvrmDlJEh6Psd2BDbv
	uCuaUhBIEUSzyhKBqUO3OWw/EEuLyRRrXCtF3VjSiXY+wUtXIlOXbWSlrp/Yd7B2
	51Ly9Ra+7T7VV+ozidLzDWznGhsLp0yaQ6uOJ53AVU83LGnZQtt1AFAc+ibQ0+9a
	mSmfGYlbDHRXAjVxp22AAFFAzst9FzT5A8l6rC6OMKu4v8X/zWqnKm2Eh/iWGJ5w
	NIdc8xow8mG37kAY9ZRVmpUsg4fz7/j1kYMmQXQusV7Y7iHd86v18utnXP234hh8
	zZihfg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s03v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so109136835ad.1
        for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778786645; x=1779391445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJbLX3SOQ5nHO6qbquKX49XEzMv+jauXaF/R269IlRU=;
        b=ehkT0fzecu7KgC6+NbKWdbF0y1vh8q3e+05FqlB1xXDTSbW4YvvQWEcDpVT82oW5Hk
         B6FRT5+TVRtDNwAl0jQesWTDtgU12QFt28kR4WzJxQ1SIz9c1fQQWxQabR7u9Zx6g00w
         OnFCbg1ZsggqbX9ZW7V0pVkRM/4B10oj4N+yHG8izVwT33Ds5LBz+2qUwSm4237uOHUi
         LGZ2USWEdP7Onkt3RNxVGLUFVNmEBT5UmxMSl/4YbZi/fNUD0HhD9aYfbaPU2RILsdBo
         /SC2vPpVRj6MqQf5tJAGqOq2NOhJBEAaQcLyVGdQvkFlQrlXQnjM2IHOVcezLxlwPRHl
         KsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786645; x=1779391445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJbLX3SOQ5nHO6qbquKX49XEzMv+jauXaF/R269IlRU=;
        b=Sj2PWyIq4ZRc38YwU7HPtUjOFKrsuaf8J8pMsHt28PiPZodmgMJI3L8kwR/axstzJZ
         CcnaEPB5j0X1+JYK/acWbT7WHlvJxpZrNwC3gJe2witRwWPGB75CegtA2wzzrX8JSAmn
         vz/jrcw2wozw3iWoNdEXKymNk+0wdAdBRqUWdv0UY4lZ0FWKrxMBAc9cpLK6OtLrrSM3
         RDJguAtuzjzd/q5A6Oc7e4V8XIPNtgA4d0Bmji2a8J3v1ZnbAgAYRqg2tpcIVrOisbiB
         XpMkFk2K+fuI2218begnUOcqsYDWwbsGebnKHLRXetmb00Bhp7MNnoGmcKOR81bLgWr0
         BLiw==
X-Forwarded-Encrypted: i=1; AFNElJ+aFODd5tTIjcv6OvgcCTLNHTYys+I42Po45UgxqqwoPa9HDYr/W0/L8+1mc4lwE1gp8CQ4/ZMK3KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GrG3v+bySb0RdMHap/xJ2YQz1XFRqOndVZKMP/80mz++ihhw
	7rY46Z3Wx/GyedLX8XSYr8P7HxwFLxRPm5M3SKJglEflr857xTi3SaRouQ8sjCLOS+HdXgyyrQf
	Oa6Uxs+W4WXahXV7yWRueVSQvVXKz+IM5Mzhlj11+LaxwrZsvUHX2OOvVRkuoSck=
X-Gm-Gg: Acq92OEezLL4zyKC94C5O8WmCBcYI8vjhPjW23q0nDQiJmQjR/YwLavRVk/KGtSxE34
	6IPxQArKljcXR3tQ2rhm1PM9Yk+Fw1smQiTD5y08RSk3nWERkWf3kF0BupipkqGdVk2PaTwoYPZ
	fFed/VVGFAOS8j2SsMS0+FXi9uPu1Tx7Ib0EAe6xcPpo4PMgu7uZe5kTYhXw857fS1+0zexQgSA
	hwiggr7M0BLKW8+vrjscnyk8Bb08qUYpLK2UIeb2LFgFsBt/DAibWJBjaZBKh4Xb5WJ3YwYTLzf
	9VRGovUJIXj/upeG1dAYskiuynpt3uhRtWm2jOpNaV20oamoRLUnndIBq+TZC0yH6CmUTcKoh8a
	7M27pOL3GwoVgkrOOUAgWqG/ZlU7vGtO8Yu67WyrD5IurVUGWxxKs1vgleuLInqp3Sg==
X-Received: by 2002:a17:902:9042:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2bd7e77b6b6mr6497415ad.6.1778786644755;
        Thu, 14 May 2026 12:24:04 -0700 (PDT)
X-Received: by 2002:a17:902:9042:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2bd7e77b6b6mr6497175ad.6.1778786644310;
        Thu, 14 May 2026 12:24:04 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f291sm35506535ad.15.2026.05.14.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:24:03 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 15 May 2026 00:53:37 +0530
Subject: [PATCH 2/3] dt-bindings: bam-dma: Increase maxItems to seven for
 iommus
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-shikra_qcrypto-v1-2-80f07b345c29@oss.qualcomm.com>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
In-Reply-To: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5MyBTYWx0ZWRfX43G52/hStoso
 ucix6OTshzBSq3+LAh/lumP0zSGeb2/w7dGBkRUxobp2GQZmtSfjAD7hIvQXR6YdD4jqsdesJP2
 +OzRLEAnicxwWt0yVg6ZhGx1prIUFrCgIMViUzW7TrdTjt6FMN16kuYVzmcgHz953gBbNg4Crvn
 UTcx7n6cmg2akpYHZrd0UO1+S6/OfqqiN/VXt/ymJRbLTUIXatqufIS3KmIcoiP07N0I7bSDr6Y
 ISSImGRLTdEFA3C0XA2InDFibBr2fG60x73BxaK4pDCJttQNSOdWSw+QKIu28SASwRL53EbkVkz
 lJhmd9CTDY7ChuBFPSOOJVqeB9FfhMvcINbO4I9E7npK1IIoyvfEUOfMdSSEKDxePBCumfn+OxI
 iKAvqe3K+MoVsRgZK/4cRWVcaYcU4lPGA8apwLi0KVsog5FaeFtKE2ueHr3q4FYxoZqNUlTV8xq
 PHRHHZyB5dUf1r6cP6g==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a062155 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=8lsXshAdeER6dGNyxukA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: YQ0y9IZH_rasjzlhUQWgwUjDJjHaTYoD
X-Proofpoint-ORIG-GUID: YQ0y9IZH_rasjzlhUQWgwUjDJjHaTYoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140193
X-Rspamd-Queue-Id: ADC2254658B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10474-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Action: no action

Shikra bam dma engine support seven iommu entries.
Increase maxItems property for iommus to pass dtbs_check errors.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 6493a6968bb4..ffdb308352c3 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -46,7 +46,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 6
+    maxItems: 7
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.34.1


