Return-Path: <dmaengine+bounces-10640-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCvOCzwLD2omEgYAu9opvQ
	(envelope-from <dmaengine+bounces-10640-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:40:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF05A6120
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECD1432E434E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D73E172A;
	Thu, 21 May 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RHZOZukV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfXV3Dem"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8BC29D294
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369494; cv=none; b=lxlKy/bbg8c+6g9ysqyHcx2pKQR6RT5Z5kwaM2krnNRrqSJM4zB13hTv6ln36bJv1FHV5Sdiwf/Zi+/MCJbfT+5O6CBkloQoqDcd8HMDmJxHD51FuweeOnb6r90+ivDerBGoUcUmWKZ4iNMOohHV4NEHmXyScPiihehSnn4th2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369494; c=relaxed/simple;
	bh=cmb+NBPdV34mI8XyHRuMaeHAtTIUx30FJhXF5CpewcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0mfeNP6sqoBihfjt2TZDL6x2ou5ctOzFCP9kTsASeDwJJRQub0mv2G+n8qE+mSBDM7mDuEk6XCB33r2GOQJfQnGwbcLWCsq4nAuoTq/wpK3e7l7TInLQs14o9Svmltx7k7g5PImVYPQDdS+KZ3hfZhlfvV9IstPAjKLrYMqkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RHZOZukV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfXV3Dem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9A3l22633671
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oh56qnIxN9olLqtfYhYt0e21nfWmA+zC+Yu/IM5YCDU=; b=RHZOZukVNQtCk+vp
	9x2qqBQ6uAoDc7kMTczNp4Rzyg5ZVAQ6jgGdY87zhdVYmQFCR6zv2ngcLd2UPWYg
	bDiAQr7KT1Ys/eNCylwCIfUwvOeD0FGVkHUZggH3Q8GLOFH8mv31coOwQi3kuOE8
	w0SHUtwPmnaci/VTcnuFN94k+V25nRhWSk1FkYyX+9BVBRFUFncpDROWqcmcci5Q
	OOlLxfktyr6mfiGTdN5P5qhAS6wBu+GPStEwM6xtLjelFnQHc0hALv4lcsIzumns
	rarjbsAPf88bVDkIbHPNEvWHff8Hhbbhr38dPDUbviBPnQunXXC4B2X5xwS6ORpW
	ABwBsg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8d599-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 13:18:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso3681470b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779369492; x=1779974292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh56qnIxN9olLqtfYhYt0e21nfWmA+zC+Yu/IM5YCDU=;
        b=MfXV3DemNr3+85U41blbRf9a3UKAfWXQ05gLI0b5Enlum/SlcBrAA/8JK7AVkZ5b4+
         R8kLNEC2OSugO6zex1l6tT0M5v7IUQTYPWb82zBXC4YNsMf1hQzA70/xm7MEst59HmfD
         +36+NKKdHRlnNda1WUbAA/dhmsJhIKTv0q8LTez8ur0IfqqgeOIBp6EUtzmbJuVy9Kmk
         2JsY+QwTjtz4Oc/sGnjhK/gSlF9VZ2oUVl4z+Td2Eesh/0KWqVDbAq9m9e9+S/LzjAO4
         6ZGM0QQlpIVAtYAv3KmmsNy4WuRUtXLbDWIqSvEREg1x5BiOSx1NNsPJrKp0yfYMCp1b
         u6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369492; x=1779974292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oh56qnIxN9olLqtfYhYt0e21nfWmA+zC+Yu/IM5YCDU=;
        b=kVJtuZpYMsUMr6S4m6cYt75lZOFPAR0AronubYUBdgrsvOIOzHIJ8W1w6/OXCNwBO9
         /rESWaPDFoCX4tfetNte1fbJPT3YfPWLFuSfXsAA6DT28LIjGnMw2YPLVn2Aw4FFYdub
         kCtoaMCY7x6AQ4ycj4p4KFwYuJVlx9/AxyRIIu3QUwAbgpgndq2lBkO7dLmqqa8+1h6p
         VwrvgfvUrv8VxibnPoNkEpFAwqqVISWJ9G9hwhkadKTkIEXU3oyChxM2PPXqSrWWVjVp
         QNlZ70b91DbPK/Nlj1WCs29ZxlfNfvJWHmRcqP8GEw/wEsltOWrGO1732QWbfttoIq2Z
         BMrg==
X-Forwarded-Encrypted: i=1; AFNElJ+YL62E/bCDAjxCMZaXnZVqsnEUXFmHUwmNmb+1d/idFyuPgIVXA+YPjppHyYPU39FRjf2XxfzxAGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdsLOy/XLdJpSkJHFWeX7XVQyC/7IzNuhE2Hm2Ty3UuAcC5R3
	/ySWUPKJhADP+kUpg3pPkd68bZkRyRm7/P1URBSBiTfREG/jYGnelNiP2V4FMuyed5bkOrd3Av8
	O3+An+lM886YU/NgNXFJdOsMWAO+0tLiev+ymxOfkWmDp28b0oy9JwKervgvaspw=
X-Gm-Gg: Acq92OF0ebuRu/+Dfy9M4rcZ4JrKUGGfPMd5VFKiOoeBX4ktMNSFQiuFhR2csh3zkfB
	y2Duu1nfH2WKbDd+lFy9XqJDL0mDXNTiHpL/GFTQzV5hzw4m4KHTMGRU+u8wwa2KTz6g8DUSeud
	Dgf4yuxvLW50KAoFuuws8VkMoP/15kjEiGYVCN4HWtUK3rFDKj4TaJrAw38u0nTHnadGOWsj1Z5
	sM9sxgmaGkoxVb+45vd1W1wZADy8cP+2N18/QVORfEnHn/u5MSDJ52HC5IjGl0tXZyLDNgsn9ZB
	I7LX8+1FDT5gVK06IA0PC/AiIytPl7Gq/Q74kW5Y6sUeJ56qr9GVTFlKKC541k7dopSogadQ2p1
	1h80t+uVGrQ8b3xQldm2QU5EZILUHug/m9siATTGroHpWMQO3RMHrDnE=
X-Received: by 2002:a05:6a00:391b:b0:835:4291:6975 with SMTP id d2e1a72fcca58-8414ae15668mr2866499b3a.39.1779369491582;
        Thu, 21 May 2026 06:18:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:391b:b0:835:4291:6975 with SMTP id d2e1a72fcca58-8414ae15668mr2866449b3a.39.1779369491072;
        Thu, 21 May 2026 06:18:11 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e22f1esm1687731b3a.47.2026.05.21.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:18:10 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:47:08 +0530
Subject: [PATCH 1/5] dt-bindings: crypto: qcom,inline-crypto-engine:
 Document Shikra ICE
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-shikra_crypto_changse-v1-1-0154cc9cc0de@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: yNOPRQpiSZrSOGY9Qsj1Grztv7YzxX_C
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0f0614 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=qMhC6LGQ_1aKn5J9HqIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMiBTYWx0ZWRfX+FoDpEgUeq0u
 ZpXpL0A4/KySjY57jgW6XSe8S8SIHEzdzN/8r7rDpOGZAzTLk9T4OHGPUAavh1tq18NfdN8pY5w
 c+9BWnov+BaKbreoglVV68CZicKtvuZnYdu2vM6zmmCJt+4n9An4/UBzN/2GYv4pqSgyshSPrHw
 M/LEsikmC6eMWUPyVSvD1neLdbTYEEYvBvKqB61e9KadP4vTEtyw2z+GO/2BPZzHFObHaNh8DTw
 XM5vLG8ZXabCRgxTul9Ej2g1uP3GdfcCgXsLZ/Qj6YCgGXmWr5V2kTdH1RH0wzOVyIAinERKct5
 PkAwWGT7QNVBFgTFRkRW7y731vlLPcPd1RfX50llOmJ8V26+U4geB3PtLST3yt1puvnhD1LJrxu
 esBK7AysQpVWE8G6R/5kMM0rcITKSJyu5DatYkTCbHDutiYmFxrUu81Z9mF/LmlUOFqz9hJ1pZC
 FX+ue7gd37kbJOGHWbg==
X-Proofpoint-GUID: yNOPRQpiSZrSOGY9Qsj1Grztv7YzxX_C
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10640-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
X-Rspamd-Queue-Id: 85CF05A6120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the Inline Crypto Engine (ICE) on the Qualcomm Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index ccb6b8dd8e11..c0b083da78bf 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,sa8775p-inline-crypto-engine
           - qcom,sc7180-inline-crypto-engine
           - qcom,sc7280-inline-crypto-engine
+          - qcom,shikra-inline-crypto-engine
           - qcom,sm8450-inline-crypto-engine
           - qcom,sm8550-inline-crypto-engine
           - qcom,sm8650-inline-crypto-engine

-- 
2.34.1


