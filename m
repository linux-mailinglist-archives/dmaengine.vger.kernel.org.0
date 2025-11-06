Return-Path: <dmaengine+bounces-7070-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C927EC38EEA
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 04:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 735834E480F
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BE1EEE6;
	Thu,  6 Nov 2025 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdLAfYJk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HbcT+XQK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41F3C38
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398054; cv=none; b=AzxX5mXxrQA5Iw/FYeota19Mbn+7oZbyCwulA4+rximQ9FQ/LMMYQJXtVltLLIutqCRu0qMSmErh3bl3jg/MkxDHEZA4vz3mXgk/K74I4USnpm6eVOn9SDXzDVo8h7RjopCt3KZ0F8Y44pQ7RvOVsBIg2SZakvRrDwZVBg6zy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398054; c=relaxed/simple;
	bh=YK1LS/nDg6RooL2XQvj5xJvpZ2yxWM7TCRt02SGpA1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BtkkUm3F1nOYBVv9bk4RHA/u2CVXaTl90018KEpwdvbgR3gCjGw06tz2LKJ/ZPkd/iIjP0pOCQTaLXALPnn587s92vt2UUWie7rlnqg3XCgtQNB+TkZxQEsC0JYsq1oh78So7rRbOFvZOfTnooufrRalOTngH2/QJerqfOhQc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdLAfYJk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HbcT+XQK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFAR61657011
	for <dmaengine@vger.kernel.org>; Thu, 6 Nov 2025 03:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xp+eOpdBP5YViuKYG+hCDq
	2cAhMK9zpyuiSB/SJ26gI=; b=EdLAfYJkm0IyS1U0z6v/7o1DwWq7Dx4kTgHSN/
	eZEWQH0IekrxKvOXnG1oLo6jYM1rtH6x39/sIgSUM9T/Jd53eR6vqoSstl/NELSO
	KpiLhj6QIRkaVzewa+KHjdu4NbGj7PrrdngJfvf3hcuh0JRmrYAS92E0GpaWtOeA
	tUWwB4PFcwEvKf1fyVupreL3RVPtOeqtVEvT7QqFrXrzvL7/GsedTZJzjUEUh8G5
	2uN3ir6cfBxt5tqxjHfm2w/z7/re4jSCnwo4dVT6+WLUcktAOmrCeQ5BrBTD4HHr
	/MsaCQSgIW+bOnK10azM9IG6iAYyak0P9rmwzQBxMlM2diew==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8831a4q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 03:00:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-782063922ceso700747b3a.0
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762398051; x=1763002851; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp+eOpdBP5YViuKYG+hCDq2cAhMK9zpyuiSB/SJ26gI=;
        b=HbcT+XQKh47XHlz4/4jMN0AqDVX//FBRR2/7eOGIQH954JGU4R1l5foUEyrD7b9o6B
         nNPfXYgLr2yVzj/wPgt/Ndm4c1azLLcdyo6r6YUKlw32KqalQaTTVhfxORDBSEIbZcZN
         azL8JVQb3r+cEn1PALGoDc5k5BNd9+ORRFuOcy3W013MDVJtfTrDdc08TaX3McqA0oej
         O29KTBcROu4U1kjk4lpRjz2XJ4O1NgrxKWGdLoXud2Zk4pZCWnQ5+cRPgqVjZ87VQVgu
         lwU2TAyxLIwtEyeMHhpUjj43r6oZr4sxomN2YnknxoToExPCBxku4yvKQX8Hmo85FbgD
         rmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762398051; x=1763002851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp+eOpdBP5YViuKYG+hCDq2cAhMK9zpyuiSB/SJ26gI=;
        b=uQTT9SiXNN83fax/7Jk6CxPdBfFZVXYZ8os9XIiMLc1OQEHcLcPPYzMgeh3Oq7thUI
         V6P1Yw+EdjKY1tF0silV7BdMlBTfP5DZUrcm4fygJ/GLG11Nv0dAWSTHwIRcFxc3yjGG
         4RSfgA+WgmODC4iJsUqnOYo2FUq8xOcswpyG3oDurNTP+/dXLvqdgGYwu5kavdJuLGh6
         tjYKM5XgcXAWujWwGJzqENclsVub6PoMdVGWEJOj5a7KpgWiEXui/XNLxYUEYxM6lWcx
         8E2lySKY5D2yLfFK/F8/alpt4UlnNeEpIq0Cxr3lao41rD4AkIGNXeWOl1+j4qn5stLy
         vK1A==
X-Forwarded-Encrypted: i=1; AJvYcCWQHNtBV8XsETHvdodne+TUWZsK8q6GuOtZQ6T0T6IfHVERSEDy3Rb8/SpvLle4AvH6mUgsLf1dLek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAVmBIG+LVXD3h2rUifmMtEL1GS1DyotkgE3cwNEvYmYxq8Gt
	4CyfqQH1KtZjrew7kllDc40fDo/g+m8Ds/UMa/wghAea9eiWFznSRm2xEhV8SbJEAA5Pmfb+V6m
	RhHiJ7/mfsGI0a7bfsjDCoG8qdXEKpLQoZ+BPlrNLBxrbtKG7R8M9+UmjLpUSg/g=
X-Gm-Gg: ASbGncuFh0S7FI2JEW4eNH/GeeOkv2bh5wsad1Ropwj0boPgAFDLjufczr6cCi50mjt
	+/BLa3aLwHN+t+NGaCGd7dQnRLZaGtH3D8ZURACMs2ybrIrpKU8h+h27exTS0XKTO3NvxIdExdq
	wSruKUO0QNFanTbpgLUCUIR0SduO4hAZuuaVYHtGlbSaLzrATbiKyuixcsJ6+t1fk5+/HLNjWI7
	moEeO3OUopzIPMHJXi7JGlBTgCZ0r6CMCR129FgQF1VYDZzXB0c9yjvTGohU6gw9xcM4XrSsPpX
	OeqeTyAZfby28rplD/gNTLWenyufL4r3s44O2R9BdWo+8pgD+3Dt9Z1uyQRPiT+DvGap293QC7z
	NbQwvmiAIOS2lrUDLMmIa5tHVrrKYheOUK93AO0ieGUak4Itz6A==
X-Received: by 2002:a05:6a00:1489:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ae1f09d94cmr6631215b3a.16.1762398051099;
        Wed, 05 Nov 2025 19:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgwrrg7cp91QSvUVFSqI/IEjRGJMmXj5Dw11j5JffWyzYZoKZhr6Euy+Lve0sw8DvpR3/+Yw==
X-Received: by 2002:a05:6a00:1489:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ae1f09d94cmr6631178b3a.16.1762398050533;
        Wed, 05 Nov 2025 19:00:50 -0800 (PST)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af80343b12sm894909b3a.31.2025.11.05.19.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:00:50 -0800 (PST)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 19:00:42 -0800
Subject: [PATCH v2] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for
 Kaanapali and Glymur SoCs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-knp-bus-v2-1-ed3095c7013a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFkPDGkC/z2NQQ6CMBBFr0K6toQZpARX3sOwKHUqjdpiR4iGc
 HdLF24mecn7b1bBFB2xOBWriLQ4dsEnwEMhzKj9jaS7JhZYYQNQNfLuJznMLC1BjVZZBViLZE+
 RrPvk0qVPPGgmOUTtzbjv0zZro+N3iN/8b4Fdzumqw+M/vYAEadGiUaR027XnwFy+Zv0w4fks0
 xH9tm0/eKmRFLwAAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762398049; l=1331;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=VGiAXykF6nW9JWD/DX6DfJ9GU1iNRdm3YR11WtNZFPw=;
 b=0coQCqFLnaySDJSF7ZD0a+eqcoDPKj9Q1RxsWIBuTh1d17VVJgVndJK+onsi/4mJjZuQ4UFkH
 KxrSOkdU0vUBrrFrqpGjvrzsEtNcJ6zDlOl2mhrPoBSEV3NP7WVZjel
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: dwksd1BqhQsXXJ9oOI14HYME2Ygh64V-
X-Proofpoint-GUID: dwksd1BqhQsXXJ9oOI14HYME2Ygh64V-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyMyBTYWx0ZWRfXwes6/4E7O3XJ
 Q67DCcZPK5l2dUpt/CQxpWp203cBqpTHlBJzsUQa7uo8JqHj2WgtYLnd1RvZOOO4Ad47LnCTjgj
 /BqRUhrNFRovq8faqreDka31kvw6OI65QcGSKv9LmNTbyiD1C/7t4Gcic6Ltls3dVCIfAC/ExDL
 ZxhA2vv/4o1F8FnWZh/TpW5VP4m1hgHFDvlgR9ccA3pJpUOlR9XFr5lBksFahBQBfA4xu0VpVXh
 3pPFqItljKoaRECSEfsJDHHQ3CW91J62LaYR5APLogzGQfr+MqR3ML1yrZcknFeQu04iwuuNTGz
 tzbp3EE4Xx88bZy12IzxxJx5A34WO/9f0yv5S3xHd401DgMrNc+G4Zxg8xRJeIGS/9A64eDPuUZ
 6ZHmhRpfAbxA7h3VP1GlNgTloeUK3A==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690c0f63 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Y-Bf7sG_Jlmm6xCwmVkA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060023

From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

Document the GPI DMA engine on the Kaanapali and Glymur platforms.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- squash glymur binding: https://lore.kernel.org/all/20250920133305.412974-1-pankaj.patil@oss.qualcomm.com/
- Link to v1: https://lore.kernel.org/r/20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..4cd867854a5f 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,8 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,glymur-gpi-dma
+              - qcom,kaanapali-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma

---
base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
change-id: 20251105-knp-bus-fe132f6f6123

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


