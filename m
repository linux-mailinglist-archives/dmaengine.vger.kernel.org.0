Return-Path: <dmaengine+bounces-10431-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIs5G5/IBGodOgIAu9opvQ
	(envelope-from <dmaengine+bounces-10431-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:53:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CC539556
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05E133027C40
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924D3AE1BB;
	Wed, 13 May 2026 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PuDx3Hpo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdDOJb2N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E363F4112
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698368; cv=none; b=K6liS5cvvtCeo7vDpH25qAvQvihXLcGWz6PjLzLxvywoDIK63lL218MBNpZTaE/IpKQyIEeRDEzt6HWs1yvb0z0NdFie13rw9MMkuK+G33cpZv/OaJ5vlBRhNbdjf/oQjaXQbsyR6fwPx5+QNachYxQoPNlYo+OOmSu6xgaksJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698368; c=relaxed/simple;
	bh=z4FbzAvY5pZ8H9vX/hG/UlmCYedeJ/87e4jZmsMaSQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qlzl9PqZNTLXWXRPU14emzU2YD9aAFhSWXdD8jexe2I6vrgUnEiTKom6iogkW4WDsOcETxRUOXGk2fzO7cIavJ6vhdzIxPfXRWVDvcaIjkzZgZUyBPS9VtcGJT5Yc3BV0l/uoKu/3snIZfUuPNWsQEJMh6i43lbCUbCMSqGm5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PuDx3Hpo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OdDOJb2N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGAqA42524309
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0155eQw0dZoNoYFIRd4SUlBiyD780i2JRkpc7pEGBWk=; b=PuDx3HpobMVhh6cf
	vYT9Nj5kLtyTR1tHGzpFz57KQTgeR5WMujDJwuD7GfLT12USLXMqCqRe3bgbaL98
	PujkNrcyjHbSA7iT7KkX0i9ibsTa63r83KLbHRNntM0Gxu+QVDF3fxapVeumLypB
	Q/QMp93UZnpuh3NJkETwAufNZdYFHnwNNRtezfaIr8Qhbyt1JuK1Ikucs7VcvhqV
	ew779iTXrnZTmxn0FCLdQNZEUTMltRj7QRWAIs+IJ2KDd3+5MMpUOcTxe7cccJEw
	SUouCwroPyV6/3Kk9GXIpCPjodyjZP90C0LgDNsJiyslWVBeQTiS9xI0U5JOQb2O
	JZW4WA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjgpu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367f715cbd0so4122212a91.0
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698364; x=1779303164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0155eQw0dZoNoYFIRd4SUlBiyD780i2JRkpc7pEGBWk=;
        b=OdDOJb2N41iKLTeSkAFv1fvX6RbOZ7JA5bcvmd3kio3foIpJ61W6UJRQjkAEpbLndC
         oYfb0Ebbma2HkdkXbAXwa3TixjQWge/Vm4WXELTW6UCn5Nli0JI3Y0RqcKjl4LYiNTmk
         spApSI59DtO+EFt3IHzzifVOcQyIMTAQ5Jq8+SSY2dDW4nJlFYJ4CbJXv2muUAyv1jqa
         qHZMTBYCnaaoxq0vVZW55m/Rv5YXeaQUAwFy7l3WagzOPw42lagSIWcewq04CSMaIpMF
         4YH9J8lFMCNkz1eiS/1iT6kr7YmkWwYw00IT0K0Xh309iEeQwennwxIVeVsazBxUxshB
         528g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698364; x=1779303164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0155eQw0dZoNoYFIRd4SUlBiyD780i2JRkpc7pEGBWk=;
        b=pMreRpbGb7ViOXwxgpP0uSPEfiu8R3/kN0PXcy6ttAMWTtQ0tLCUI6GS7jUDFvmA8Y
         iGe58W+QRexfrWqSrSQd8MF9z5V9kEHc9LZAGoHnTvsix7hjGdbXmqmcZlJ27MKJ1aSQ
         /T5OYAJMjkUoUtHM+9gpgxlPn2+amCViArXLvOPNmTxlxb66UkL5yE+UhuD8yFkDfiBO
         AfXxCG0IQpmJyob05AT7oidWn+eXWGIiGcvHZLlrEgIjey+85J5n1zNmDMJrOMIGhomR
         6Tq1yNSzO9lnO8WBJyLG1QOtE8UckoGgl9kXRF5CrOdE0cEhIuur3KGaZNvQ0XIGInjB
         Tu0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uxAzqGRTtYK5LxTvP/QWRMqgy8qad5cCDzmw5hTO8DjzyRNc5HxVhgULHipq+DcR8vWpjTDL5iZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35DlUt/94AM8REl9PzTFd0nNfMTkCEb+zQphDhfkKEc01FE9M
	ZGM0lgWa0KgyYVrmrpudrFnALyVqDFcIcsFaTMp6jx5Aj5u8Oji2qYcM0Gf3E/ZY8jELjpGz0P/
	zCO8DqLe9xV/uuszPMVJYgamb1wdzl6li7tk8SArb6eRXBlFcx6ef+L8GhxFT4vgdUCCQidw=
X-Gm-Gg: Acq92OE8wOBjDqek3lzlnZ91ogADdfBGQQoMnKxjXGlKsbajFhG9kaJFfb2ceRk2IjK
	HRgztcXGFavGrS2ZplA1IS9bgvqXdwqqX5QJq3ybGQXSiPo7etHeumC7j7awd/326Szvxjzx9VS
	4KH0hZFLWhuI/QxBtLKGHd31YHYEas/AIvMVRyjeloyXB2U1xPjXqb8J5lLw68QsigRp9Q6ELj+
	0oCVkA1qgXzwEJnvu8YkmOEjWqMfu33HnVKePA5SdWVIE8eJexAeUj4F53OyoQD001ijesjcQFd
	A10u/HpdxD0y+YEpnt09gWLwkP88xpTcNn7dAuuqiQCnJd7gINF6hGMMh/QJzFGgv5hyf1jYpKE
	zMfgnDbVAKjJQFYzegu984dQLcofEaZeiNMoY8iQq0r5jby5hERsKId4=
X-Received: by 2002:a17:90a:fc44:b0:368:4cb2:17b8 with SMTP id 98e67ed59e1d1-368f40835b7mr5264313a91.21.1778698364342;
        Wed, 13 May 2026 11:52:44 -0700 (PDT)
X-Received: by 2002:a17:90a:fc44:b0:368:4cb2:17b8 with SMTP id 98e67ed59e1d1-368f40835b7mr5264290a91.21.1778698363854;
        Wed, 13 May 2026 11:52:43 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee626a04sm3660219a91.14.2026.05.13.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:52:43 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:22:20 +0530
Subject: [PATCH v2 1/3] dt-bindings: dma: qcom,bam-dma: Document BAM v2.0.0
 compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-knp_qce-v2-1-890e3372eef8@oss.qualcomm.com>
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
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
X-Proofpoint-GUID: ki57r2v-lJPT0okuaLmPHEMoygNTddmR
X-Proofpoint-ORIG-GUID: ki57r2v-lJPT0okuaLmPHEMoygNTddmR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfX00l/lkRRJNzv
 ueHmJwGM3ukmiqsEQCVGZUE6SUy/0Qq9kG5FwE+MoP2m5nNbfS16HrxXw/BHQLHnAe4JqHlazFA
 B05z1raNfR0sehMxJ3M2x/qDRnlCGjz+W6+cBU7ADtqCbWdGGkAOyYhQkO9uBnku8bRQzzcvwIy
 hPyz3Zb9O2pF/vkmbUDXZhgoOg1TRLup9wx1sQvoGRJUwJ+kFvsQesMtKti/qDqutpgrjvQTfo9
 1iDK7fIBb5mtaXH+4RbDOsMU/lgyDuWD0QNTmJQwFeugPoMn7ijWi4rh/IP9iUvpwiURlLJHtkG
 SHFIefzJvCXOTk+xwB/Zic7V7jC6ewk17g1rBcgtgl2OB1HlJWPrPBj3Xb16iFDZUOK8gcbRvXk
 d/iQoGK2rF6l/nBsHI8AQfapLMYDxhcZ4MUH9h/XMq5U7QgSUMVnReqdgxeIF+HffXSAw/NxOnS
 zz6/MFAj+SzZk4e+LcQ==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04c87d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QMZoEd0Ms9iLIoMSFykA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130186
X-Rspamd-Queue-Id: EA7CC539556
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
	TAGGED_FROM(0.00)[bounces-10431-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,1dc4000:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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


