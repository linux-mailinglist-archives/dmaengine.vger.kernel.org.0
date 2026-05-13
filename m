Return-Path: <dmaengine+bounces-10427-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGOmGpnGBGrdNwIAu9opvQ
	(envelope-from <dmaengine+bounces-10427-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:44:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D9A5392F7
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AA583074A38
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE73A963E;
	Wed, 13 May 2026 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pwsWYV/Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BxtC1vRP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6563AB29B
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697629; cv=none; b=aex5ptQV8az+01mRRM6oHkOd+MMOcmxAUa4VRYUYa15BbCHRewVK8yvTtZ6rdW9UeY+10u46Qsc7w5dhojQZxS4kP/MSsERGzyclJKnBcAF4U9oSi8gOJ6K03kjnK8mcBQfkg47hbDqjReseW0upxd6beHuwIdEoq7LkrSsarwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697629; c=relaxed/simple;
	bh=z4FbzAvY5pZ8H9vX/hG/UlmCYedeJ/87e4jZmsMaSQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKbNsWrMggkVxqIh29bcnyYS5n6T1oFWLUuOGiUkb984johVLULf5mAd9nAyrwn7KJxlu0befBIO7VJW5vKFFDTL3vsQnrfdOHyajhIdeSg9dAUG6PQ4C1AHa2v9N765c8EoHI89Xc5lXLrAX9u9yZlYrBg2AK7jKOzl6wBvizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pwsWYV/Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BxtC1vRP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGfQqq1393025
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0155eQw0dZoNoYFIRd4SUlBiyD780i2JRkpc7pEGBWk=; b=pwsWYV/Q630UJTGl
	viB2bEpkDaLz8eeQDVZwmwwbH1eCG2vGGMu9Jq36NSB1bmwFeH9NhWE/K6EpFQnt
	IRjOHLo568lfwTdE9mZZT9KUpwKRGyQh17TcCLvR0VAFvDUcfuzGcGBD+5+xp3ai
	K3dZt5WQN+hnvWkzRf9nk4fvjKvKoQ5Z/d35zktLlIMb8CdnwizBVrRbBW0k3ipH
	MqAKg1Uwyn/9GJ7HJhOplLYDP2gWSbkIFnd+/bR9Ykeuam4YNgt7G0HcSi+tL2IJ
	HXjFKfN0+JO7kI4LcWlYpG1KWBMjYaKUetdNR55+R/xur1hESaAfjPYCWPuUpxix
	AZVIrA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k263645-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8276c91addso2715257a12.2
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778697626; x=1779302426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0155eQw0dZoNoYFIRd4SUlBiyD780i2JRkpc7pEGBWk=;
        b=BxtC1vRPwIcEH9vvyP0QQgTG3OByI79Epzt4oKGI1/bw7k7H1J2PadWQ7Ey5n5cxTS
         AOn2ffdPOgknnzOxy2I+0gFw52Yff2M7AhYU6t47ft3535gyfqUJq/OnAYRG42mokKKN
         0YfPWVrGEm06YUUyJ7quQCggbbYCIn10aF2/rF2FgzMnpq3ayo9IggJV1U3m4eeJ3ckA
         18Vkiti5Bn7wHmrW7+h3ClUP1ImsJS1ze3jj/3voWjqi6utdCrAxt7HXfLAywPGezOwK
         NoOY7g/yDZeChRmbS02LWwW6gplJTB5G3YFkZzIDI+wY342siTuDCpk4K7JQob16UMNJ
         +a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697626; x=1779302426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0155eQw0dZoNoYFIRd4SUlBiyD780i2JRkpc7pEGBWk=;
        b=gx1VAC9RVwKynX7nsQa+DqUQcI4KAtATD4jqBTeU8SCgsBkK3nO0rgfZCe25fDx2nD
         oY3AkjEJPwvTcKWdjP0UTJOtyllRODBfK/CHm5d1Ji1DmrUvg/LarCLPhF6pLf6i2lxW
         y+AVAnWoPWJHPfLer9XcpRQUc4C0Wg8f0Twe0zFsIeybYyQ4lobAKOCQkAWCB6fjvaQe
         lBJ5wh6tXSVgx+9UeploKstaDF1oAHlPhEM9f2nS5RfSGJob2P9qJjAH2fqmw2+lhtHG
         p+1dtORWlA1NCxowbgBXpIwpr3JDTtarW3X0kBKOODK3xYuFcyeMqLRwkaLEDXQbSf6v
         1NEA==
X-Forwarded-Encrypted: i=1; AFNElJ9V8uSEL/RMcQDzvSk7QNvR7IHTmmAMfqZiX5d+3wMX+4x6HPpyAcTy6g+3EojCfvrXNo3wy/SulEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtwNUBls4Nlkqg0sPxXSPVO0lQsyNhBHulikNn6heOCGZ27iW
	0IrKZeWlt7U16eKT6mBEzLVjmSvNggnChFMDSp1TLUOpQfy0JnfZbK4fuPFPYor9u4geHqyXeas
	+r5y84oWBx5Ypl8uFpY+cb2fimE9WsUvIs7M0Z6nip9HqryOG1osPPyX5dg271J8=
X-Gm-Gg: Acq92OEnO+oT9p+1iAAquLNfbaFZxgwRcfBe0a/M8lbpobVpPe++XD97InKfzx/QuC8
	SM7IDCF1LmDIbOXlDJ1tzhDjy1cmLzi+chSjskqyzLovPAJD/Rh92pSEagF/aFUJnyx7WUvVMu/
	TDT2MvpBbePK5PwvJWD72i9Zm+1JsBVYQ1EfJPLryhTJM3Nl2mJJforNupx+d8zOZ9mdHo4TsrA
	Gd2WjcPHhkqNgvzp9G7FZVCRBk/s23nts56D5fCWFs9+xmphRU0P+poCXQ4gkA5uR0wzhZiBGGI
	ke3UhK8e4Hd1d3gNzpVhPxVAh5yGVwll9/ui3atpinxFtPqKqHUFJBbP0fDLz5jCyp6S1ycmgzE
	Lf/x4CAM/eMghSPkEi1hChjGQQtFuK7WdvUuKmFK6zyv27oHlhLjzj/0=
X-Received: by 2002:a05:6a20:748f:b0:3a3:21db:8ee8 with SMTP id adf61e73a8af0-3af7fb6dd28mr5381441637.1.1778697625600;
        Wed, 13 May 2026 11:40:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:748f:b0:3a3:21db:8ee8 with SMTP id adf61e73a8af0-3af7fb6dd28mr5381389637.1.1778697625081;
        Wed, 13 May 2026 11:40:25 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771a8a1sm15271009a12.24.2026.05.13.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:40:24 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:10:03 +0530
Subject: [PATCH 1/3] dt-bindings: dma: qcom,bam-dma: Document BAM v2.0.0
 compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-knp_qce-v1-1-0ebdac98e50c@oss.qualcomm.com>
References: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Arun Neelakantam <aneelaka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04c59a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QMZoEd0Ms9iLIoMSFykA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NSBTYWx0ZWRfXx5Iv0+jtBLo+
 VUlm4GqPNksMtaJVxWjyjTlWJUcYQSK+6U+dmWeL7FIr6XX0/7xUikDKnz3GP6z5c2GwRaUBcm+
 VO/6g34SPDZcJxWm7yUX8RRdhRvX+ckMmVVY4pzp8vbfA3GgkSO8HqtWxYwCfapu5mZllG3WNnQ
 XX/vquWTKSHiL2VigK3zDMNNYaI7Ze3SQp2DaS075ufjMpM98FAjIEvxeQTzQ1T21vfzHdGzC8e
 Ji2B8gh2l1SLzKIn4iLkb+O3VYecu23xQ3+K6ykoB+HqPvMt2FOAc5zY2LFXxgU93c7CBj5AOrp
 LZQKENG0v1ptUF8ESeN7DLzWz97K/7zXwmnFtOIZXVBGdKDzosoe73lSviNLJAQnfv6SMSnFH3Y
 w9rB818afwBN99ljhbXz+jHpBI1fO1dBCnnR9jYvzi9AjR7qB58ZanZUu5LkVILnSlF8ql6U1Ke
 WgKkkbeVFqG6AhxP47w==
X-Proofpoint-ORIG-GUID: zsvycJ4mIWrsQSOW7Hf4M7p_I51H0KeO
X-Proofpoint-GUID: zsvycJ4mIWrsQSOW7Hf4M7p_I51H0KeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130185
X-Rspamd-Queue-Id: 04D9A5392F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10427-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,1dc4000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Document compatible string for bam v2.0.0 version found on kaanapali.
BAM v2.0.0 differs from the earlier v1.7.X revision in terms of register
layout and offsets, requiring a distinct compatible for correct hardware
description.

Also add a new example for BAM v2.0.0 to illustrate a more complete
configuration than the existing v1.4 example. The new example covers
64-bit address and size cells, IOMMU bindings and execution
environment–related properties required on newer platforms.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 6493a6968bb4..0923fb189ada 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -23,6 +23,8 @@ properties:
           - qcom,bam-v1.4.0
           # MSM8916, SDM630
           - qcom,bam-v1.7.0
+          # Kaanapali
+          - qcom,bam-v2.0.0
       - items:
           - enum:
               # SDM845, SM6115, SM8150, SM8250 and QCM2290
@@ -118,4 +120,23 @@ examples:
         #dma-cells = <1>;
         qcom,ee = <0>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@1dc4000 {
+            compatible = "qcom,bam-v2.0.0";
+            reg = <0x0 0x01dc4000 0x0 0x22000>;
+            interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+            #dma-cells = <1>;
+            iommus = <&apps_smmu 0xc0 0>, <&apps_smmu 0xc1 0>;
+            qcom,ee = <0>;
+            qcom,num-ees = <4>;
+            num-channels = <20>;
+            qcom,controlled-remotely;
+        };
+    };
 ...

-- 
2.34.1


