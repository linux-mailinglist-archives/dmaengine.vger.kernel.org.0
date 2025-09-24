Return-Path: <dmaengine+bounces-6706-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C6B9CB2F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 01:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568251B20A07
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39EB29E0E7;
	Wed, 24 Sep 2025 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR+MTacN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF9258CE7
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757483; cv=none; b=dTDS+vrD2TcaDNe3yAdAP8weTG6lYQa/7m1jaF0n3EIXg7TLFy3aWDkEwFavKRsym5qpTv60XMum+K03t5lyuB0K/A7a2kLUvAA3lUJHqU9yJzwF5IeUzCnD9k3nUN85oJxb2HVetxfKEm63pTct3QmJvCQhXKszj3CXIPDVf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757483; c=relaxed/simple;
	bh=+vfSzZt3jkmxZ01JyNHaIM5Mu98blH6EPZ4R49GXXak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pDUqTyp3WPaxkNyDuDzw7Uqb4IoQRK8t1P7Z3i53RMn7aF02/PDXtEY3UUcVCilWll44lOTPpK7BxZsrTL9BQ0ntJAcU3m6XxgXTdm54ArJrzNS0Pb5EHPcuYte5qiNW/6p9gQisnvZdfccuhgW9d+4XLvQL5Z2hL/vEX4QMXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WR+MTacN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCpFOu020144
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X2impUdlHgs08G5cM438Hc
	r93z30loujiAfWpv10igQ=; b=WR+MTacNCAwIG5u2ElFkkGcwFRIq9QzY83z2pw
	8R+bDxAbmqHH42uBnS2GufXahMaqwRincUrSi8aEgbsTDOs8vjkE9ysmuUuOOZzd
	1IatvjytQF4zTaFhI8XTajGOyal8N972wbyy3r1WUTsfFDMdWwdToALYB9ss/DB2
	t6AIqhFWY4nlKdc4pwRZIdTZfnWQPQjZC7YaTdxOnR4rMPHjmN3DFZVRw5IVlt10
	53DVP2jqScTfUTli6/ANyhJqL5J0MIbnbd23twjuEKk1KqupXwVu2g3OrZ2qehqf
	eJ+ufaHBvmSFfjvJVPh7TWp37VZuJ+aLakc/6jR9M8a8lpHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy9tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:44:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244570600a1so3475205ad.1
        for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 16:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757481; x=1759362281;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2impUdlHgs08G5cM438Hcr93z30loujiAfWpv10igQ=;
        b=RfkYCqM2oITYqA88trnLhQnYi/R8IDkSNlypKnRm/FK6uxDhHcj3HJB6CqT4sRAKKU
         kkv3llmrZHj4l+QN6yw0BvRTiSrZP3MnXxzphqgmSd1szwlyyruf8EY+TdLhUki4MEnA
         3GK4C0em0ysYY8r8pQAoRAMdMZDBvXGrD8w/czyiPTq90pfS0jYWFhIMOm0sxNevy0jV
         1BlH8lVbalTXK89XmkFxHI1VIeEGnbpOEwGQc5lQKsGgB/7O4wzedbZbvdnrW0fisrxv
         K/Q6wA8Fwtv7F49Mro8wZwCpbfYR09wxTBSgod6jJ/N/rgxA1dCnbEHTcBGFv2JwS9lN
         7jKg==
X-Forwarded-Encrypted: i=1; AJvYcCXcMFDc4S2fvO3jk/k5I7uBYsBJ0428t/XMXs6Emb4MiV9pCUsCzW16Vs8b0gXzjUBdGbFVivy28EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKawtra/DEJjP/23MFXsjZmBvF5BF8YYmO4VOgmiPAg0xL+1f8
	zoxLfDFdGjyoYCmazyB8TzSNDbaHgt2azDTO7Oh6niEjbTKCc9NhA2QNo1d1U9WPH+5EEyvyNnH
	X4UmeqjHW19D3D6++ICOW2w/7AUAIOHrv2zOayYKCHH31ryVHFDeFdQXKoFHiBjU=
X-Gm-Gg: ASbGncstfHD/ujuLiLWfx3YaS7ovuxzCpRJGyRsitPMzDyoLYF8CuhEBLX7MZRfmI/e
	WZ2VV5GilQYe5A2q3yMS4vpIyc2VohPq6eDPlp9RLZqueTpWXVztvLcmmKyIBIMgO6xZxZFkA3w
	443xMsZm82BMgsXyRQxSPro5/JZHkfoEdizS1KhqBJnDVn5IDpgd6scDoJ2Yd7YpIkRDdXZJLRj
	Af2Cj9zbR6xVs//x2HWd0LBwCT0EDwM+Gqc7vUm5HNlYdKmWOMP0XHfaurgHCCIa34GMoM1vyX9
	s3j+QsiqMdHNfufwumJE/okGlMIVzfusyCCSTpDQYdVEeMt3KUZBssxLEBGN3lhlv61ZGoeHMlJ
	k3MD5Wb+ALqjQq0c=
X-Received: by 2002:a17:903:138c:b0:24c:af27:b71 with SMTP id d9443c01a7336-27ed724ab01mr3625175ad.20.1758757480729;
        Wed, 24 Sep 2025 16:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe3osHo06ryw9DSt8Ew/7EWK+5zKQOxMidrxm+DGQQ0iuOMv1YJGJtPULrq73FkfXh0KaDjA==
X-Received: by 2002:a17:903:138c:b0:24c:af27:b71 with SMTP id d9443c01a7336-27ed724ab01mr3625005ad.20.1758757480276;
        Wed, 24 Sep 2025 16:44:40 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad21e9sm4257705ad.144.2025.09.24.16.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:44:39 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:44:36 -0700
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document the Kaanapali GPI DMA
 engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGOC1GgC/x3MUQqDMBCE4avIPnchCtraq0gfEjPWpZjKri2Ce
 Hejjx/8MxsZVGD0LDZS/MXkmzLKW0H96NMbLDGbKlfVri3v/Ekzh58xakQ0TXzAgXI9KwZZr6f
 ulR28gYP61I/nfvK2QGnfD2qdSg5yAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757479; l=995;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=/TajRCKXELmb0GbPNJOnw3zeHwTzpoeuNk1uSE9IkJY=;
 b=3d+GD3HxBx6rRCdZvn2GG3Tne/gAiuEKRNcopvHMA+d0sf54VDRHBlQ2loOOCTHddgGDOcjBZ
 iIS+XxM5+HGCYhgWBofrA3+48ejMlTl9ax7LYssn4yJBd8RPub1s5SS
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: iMrX6htMcTdeV18JHmBfXsvtyNX2dfd4
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d48269 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jIbp_Hnnr6_5fXc8a4MA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: iMrX6htMcTdeV18JHmBfXsvtyNX2dfd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXxLtDHQbdz0ot
 hVSTWf0A9561JsmP3BRVbw1e2vK4YUT6xOAivPkgFlW3+B0yxuHDuW2Zad0TAbIa/vY0d+aTzLS
 G7UZmDAsiB338jQ8KwtDFkYJg9qJCpaHeIVdMLLU3WpL7HFaHjLxSoeXqB5lmkwWgSjKxHebnC4
 85pKIx69tz8Fq265Krd0si1Q9gPR4hwoyKr0eTNDCZJA16k6szktdeV2O+QLdv8zenOxXm/zdvz
 hjh8oyvHyE/5pMjTGlDTy1BkQEGi7d3kyIukD3p4NP23C4fFuuyMPiHb7B0zaNeMZ1Qi7MiDBPv
 AhUQAhqZXPi3ZANkClosDumXjKTHSiVuJErKmXtmvjfIIfTnyOANBBe1bpuKHNY3dKILoASDzEs
 0Abi9GCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

Document the GPI DMA engine on the Kaanapali platform.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..e7b8f59a5264 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,kaanapali-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-bus-e5ede66d8e0e

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


