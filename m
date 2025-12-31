Return-Path: <dmaengine+bounces-7988-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9101CEC06A
	for <lists+dmaengine@lfdr.de>; Wed, 31 Dec 2025 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA36D301339D
	for <lists+dmaengine@lfdr.de>; Wed, 31 Dec 2025 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9C3148B8;
	Wed, 31 Dec 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AstAZ2O+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dfy8yM+j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE401DE4DC
	for <dmaengine@vger.kernel.org>; Wed, 31 Dec 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767187898; cv=none; b=aBEGeZAdBtjywpcnXeRDFDrwgviytjAxj1OG3s2LNiODKUz/JV74VaR0vthIfJQg4zU2gWFsF8BDDjU+g2P2dENK0KIJ7NOePg1R1sK/ff1tXD4++AImJygCx1VfxGGhoXbEriS6BMx4JvMEIyvyw4brCmbWFwX126aQg/BYfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767187898; c=relaxed/simple;
	bh=+fwyYkzIQVQolQaFntwnItchopxmfbkwdjIsllj/oSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gzc2quqw//awPyy06dHdlELd+PZV3WZy8kTINtMzR5AgbHNrnGBc5oog0x3lUw3z22CUkfR+yu5wmuh+nki62TI+xQjLyXx7pIIIiaTLdksgHh3dVvYKNgId1zWjYDSf0HtixXOQPmFecE3RrVCMqVU2OTeNJwI5V45D6Qr3KOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AstAZ2O+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dfy8yM+j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVCtIFj1685822
	for <dmaengine@vger.kernel.org>; Wed, 31 Dec 2025 13:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6khf3y+B5eud9mBSQzrAbO323CbiIqLJSaQ
	Bz7nQTq4=; b=AstAZ2O+J7a1ooJUoTFeoP8PmkH9LEMKrg2dLf8V1FCTQD4lpDb
	MmBgWmA0DC9SGUcllZgA6IT9RWFW2Ed2CF4rKRowJoQ/JilyYLGUhp7mjQRZN6gc
	ko7YFjDpivY/UeIyUnPrX5jl7q0wcgOfUEG0NYOyqc4fwk1U91ikmvDNNGlDW6f6
	19514qriCykK6kDtEcNUZRdt7A0i2B0Ix3WowFFf9iVAZEAt8PTvuh5lXP2fVisD
	kJsEjXh31SlSZA1wHN0fc900AVxb1fDrmWDzZznPaq206yiJLBM+UNT4QvlRcqhi
	8+auQOHWN2JiU92QXnN4acBgUKDAqQcwURg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdmd69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 31 Dec 2025 13:31:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so13831734a91.3
        for <dmaengine@vger.kernel.org>; Wed, 31 Dec 2025 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767187895; x=1767792695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6khf3y+B5eud9mBSQzrAbO323CbiIqLJSaQBz7nQTq4=;
        b=Dfy8yM+jh0oMBo2EIrALdd3mLFrfQmPBYLtfLQSePPezZ6W2BolP8UMxm/yuVR5k++
         DVZS4Xu6EHukAHu9wEdRzXnjETBn/C3fZP63VJAUFYw1qxT+6dU1C1IEabwu7dUvmpgr
         oIF9UkT7FbANEoLmg/C6vtTLqTXtDxSlCtenelq0jSMNuImMuWGYnU4z9D/6dG9M4cSt
         0SzwIBO7fzhVJLdSdknA8ArR4W3E4zFUXiG61WZpl/3tjG0P2l4l7b/PwtOYeveStL9F
         L+ZmAvtn4qA+pC+2wfcMlPV2buD2lnbpfWMDMVXgplzgA5Ryjulf+SQvUK6Q4Lqy1Abh
         Cz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767187895; x=1767792695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6khf3y+B5eud9mBSQzrAbO323CbiIqLJSaQBz7nQTq4=;
        b=OFmw9VGu0BsNb7RTL4LUxIm6Lxz9qXyfhMRxN2Wc+drRlSkvLnYSsPzBw7Y/90rW2d
         +gihd8pob7IeFwwB8QReLGov4ggynLDeXflrfHVVUeTUpykRGP57jNU+m1S8adrZrMFU
         VOKukWvfoCQRjV9pjKuuBlOBlmWl14i0UooZPYUzNMAdB8bOzC2k4aTv4egDXYlbztn/
         WT70sy3YK8Fwe7RhiLGVOJenxUmAhDvMd6Pvp7jvesTlPFhQxqlCZQyCOMs3JKxq3Hlw
         LxX7mI1dBynrAHuMz8jzy8IebyFtkhRIx2nFiKGvOrtLM3KN+ptFOVns+DU2FK2KJ0uZ
         Drhw==
X-Forwarded-Encrypted: i=1; AJvYcCUlI/xbr7Sd8QBbnsJK3q4hfxkOVeI2TeJ/pgKOAF8Kt1RzTtc6H9BQu3HcDVWgee6Yttn3UAM3MiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNbxKMCeaupL0Uew+hrwY54c1jHz2GxHqLq00gUbAz2zRSDhC
	EHn9gmkhgi2q5u3J++G0l/zOomZK/g+/ZJPknQ5iiaQGRMUH0IDiFDNpo81MdcGP/NgHCg0s052
	DwFPMw3rdVkVQnfj6q340N7Th5xONGepMSmvLKKGvw/6ZFO2id01+Bopk1CJ3apA=
X-Gm-Gg: AY/fxX7aN6OzI16SX7mTCWkPQRGUnTWh93bQxu+W5eii4ScmAgIgzy+OAE50UpQj+ra
	CF85D9L87EdJYgJ1MJRedSgvAXG7alCSzrlWpkrwScXKoerT9XL/d9nWJW1xdDz+e0CAKpbnPgI
	Y9ZraIFIZjWpMjutz2mc60tpojYDivmh0BZxt9p3c67QiJDmv82CihBY3jeRDLpIT0yKalIYCXR
	cpvk+IesvJ7hDgiqw8ZSGb2NHiXYfz2JbpHrzopX05j4D8CkMeJ96a5xr20rLwyXhRSW6eHpim0
	fdKVpZ5U62MhnWtAls6xxLquP1i1ZV/WrRkZ+e9hqu4ZOtbPG7XKKbxV3JsMMYJvn6xCibL0Wpp
	QN5TcjRTatU4vcxs1ZVejq5sfDmJm9iazJbtqzv5Qh7uTDb9k6LkeLyoe2gX6oRM4XrSB4JGR/4
	NKbfEpfC/QpUsjWwwdyNx7iso+1a59EA==
X-Received: by 2002:a05:6a21:e097:b0:342:873d:7e62 with SMTP id adf61e73a8af0-376a7bf0d49mr31957749637.29.1767187895004;
        Wed, 31 Dec 2025 05:31:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdZPuu2jWeVDgwZC7gyRNEWnpwbxhVNb8q0dF01pZ+tfHtG0ZKkQ0Wpw5Hk3SXhVAx2oLhAA==
X-Received: by 2002:a05:6a21:e097:b0:342:873d:7e62 with SMTP id adf61e73a8af0-376a7bf0d49mr31957720637.29.1767187894497;
        Wed, 31 Dec 2025 05:31:34 -0800 (PST)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dccd14sm35919812a91.16.2025.12.31.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 05:31:34 -0800 (PST)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibi.sankar@oss.qualcomm.com
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Update max interrupts lines to 16
Date: Wed, 31 Dec 2025 19:01:14 +0530
Message-Id: <20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767187874; l=763; i=pankaj.patil@oss.qualcomm.com; s=20251121; h=from:subject; bh=+fwyYkzIQVQolQaFntwnItchopxmfbkwdjIsllj/oSU=; b=gbNDDD00R+1ahQOoV7TxMgAdj5zghlu3YA2taoGUF67qsRJpsB2lSBlUR0a/xzjLIEB7laKCu PN0pk5h6PIxDnW5dpzkxxOGZSksmfKJE+g2b0Eu9EaKzqzjmDeJmexj
X-Developer-Key: i=pankaj.patil@oss.qualcomm.com; a=ed25519; pk=pWpEq/tlX6TaKH1UQolvxjRD+Vdib/sEkb8bH8AL6gc=
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=695525b8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2kavYovvU34opV40E9QA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDExOCBTYWx0ZWRfX6FrvJOhV+RP7
 Oi7B2VSesqRSYrzzYEiS4iVfF8p59XjB3/YnayprD6Qn+NM6qusR4N2jrKujpm46OxkOg8/AEML
 jX+d8uGXQQKi3UCFcJ0NmPnFvPbAyZGK/UyWuXFufUJokhyVYljyZ5EUSJAy0443BJmdfvx3Tsy
 Cmd9sPKwddX7JGoOHowznrv+nFCZTqNx0uw3/5+oGDdY4w0xuPfAw9BaplFq9rVaS/VaqBTcliE
 hcFpxzZ6FX8JlWEG6xDwG92ofLGgfk29IoV3A3KMAVdHB4bj/9P0gci4wY2MXV/fibgXq8pMzp6
 E+HAAdeENz0E+f/ydKJYdA4TsYZQCPkuUN/R41FtRZ/0x0Bv8fO97UnMKpwhq1qNzOcmbKBT7Hw
 IueTRncF+ujfS9z18QJHdsmh6jtySDJZIKuKG7iVqUMpCJJ8lNjDSw6f59rff0LU9erJvqwLyvl
 Re6G9ejUaZ76t+qPYeg==
X-Proofpoint-GUID: tlH8QV8q3paZq9N0IyQIj8EOerfUort7
X-Proofpoint-ORIG-GUID: tlH8QV8q3paZq9N0IyQIj8EOerfUort7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310118

Update interrupt maxItems to 16 from 13 per GPI instance to support
Glymur, Qualcomm's latest gen SoC

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..39ea09bd9309 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -58,7 +58,7 @@ properties:
     description:
       Interrupt lines for each GPI instance
     minItems: 1
-    maxItems: 13
+    maxItems: 16
 
   "#dma-cells":
     const: 3
-- 
2.34.1


