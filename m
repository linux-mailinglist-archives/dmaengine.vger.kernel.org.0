Return-Path: <dmaengine+bounces-7942-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76DCDC483
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFC031321C1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5234313E2B;
	Wed, 24 Dec 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnHRrwtg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVgI5z5o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C13376A5
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580340; cv=none; b=A2VPSVzLMMvG8/E8l1nBOyfXhD+shs2APAgt/LF5hONSQ+w2zzovq7nFYeLBLYmh+OFzPJzqPEhYeEM+Ef1dpGfl8jpphqsZgLHtU8gmmJmOZ2ahDAb/vj9AK+vyELhvUb+UzhY9+cSW3wU96aYfWzzH/qCgwmNZmo4VorvKZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580340; c=relaxed/simple;
	bh=YfaPnbAe61xlYslBRJ26Zrc2VbtjGDLPshZ+NcYAkQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBQ8Kwr6aHe4X3IUgCWejqLHvVnO9g1rhfLCFqgSX2Cp8ws4JaoBe9fjeyKnYYZbE6LNMgExji0r848x0xPBtry3rP64pDuIObWJVSjLd5zUX0x10Y+gTiOCxlTZBMK1Spcc+19eprVMmBj68u6OZfAGITwMzhbg0Yp1xxKRLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnHRrwtg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVgI5z5o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BOBeSYc461342
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 12:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hZ2cs4VkVRA
	MTsA0Qesft7K83KHzwixE02LoQ4FET38=; b=GnHRrwtgWFcxf9UxKkqLDyk4Zy7
	57IOL/pe+gJAghrDNpFxzYQE5rWVfwKSFsN+fwwOKBlDxbxwi1vD8Ye2AXD7/uuf
	qMNZnXeoIhvH0Y8l3sgTzCyh8UFmukjfWPkCG1mYcYacm6klfDMM6mKYBvHAZoCL
	b6z9FM4gba/5lNMF5C4FLabaFaGgoSzY+wJhDkX8BUz5JIpy6JK3+mJ6BeRWnthh
	Bgp2MTweMpTsa6dtS6NDjB41Z7C59hhmUsLEyoIt1LO9qd8tkaoEzvllbk6oBPZG
	PGkY7WvphJsC+KmjnSIUFBQPkZsEJfVip47wd7AeepZWRQ5OV+XByKO7/8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8fu6j0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 12:45:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee09693109so114739891cf.3
        for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 04:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580337; x=1767185137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ2cs4VkVRAMTsA0Qesft7K83KHzwixE02LoQ4FET38=;
        b=OVgI5z5oc9gRKgshwuh5NNR6Bh53i/SIxBLnIs3jzveDGnx4mi6FoWUC/EdNg0Um/i
         0saU6zwl8jFMC1Pbs892AFzfwioO/ZXVDbKL9FGV6rJlIbQl8Q+iNPUZwYbi/YqA78Ey
         ru0NPdOWT62czuot3BsKxRkPsGZHq0WxPmHdVakrnOU0UloUgtvpiXxcJZRaJBlgu2A9
         BCL4DSyvkjUhf6zkz+YH53/zdihVNig9jkDaTcq7Waxdr6q634oEqk+OKNoz43pWDNMx
         Qcu9z6T04gRFHBPowXzWzeIBQlNMMixgdIZmopl9grVhHLxkHjeQe6GDhaJIpQ8lu3rh
         nZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580337; x=1767185137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ2cs4VkVRAMTsA0Qesft7K83KHzwixE02LoQ4FET38=;
        b=WwDzyswoYnmZNNdcqOx5/Y+KoM2yt9X9xp71R9jmsol+FjoTgPBGfzQw4PT4TUVW60
         MgWHoS91yzswmRTkMOv2HtBfm9ggnl8B986nhqotRZD7DGGYLMpw6kJauxfShWepFWW5
         S3fku2o4VCECX82kKdl4A3vwvQKYARDeNQuw30hdawijBCA1Rk55g+/SZ24lhHsWsO5Q
         vgD7ywsKOkxRjVs2lLuJ0ZVWTrsPjv2h9QeAXts/E/bjJPh1WOpZEpF9sagvspO+Xv5L
         XNLfy3KwmghzILZRTM8bYf2/jMp3+L7UerkZHYKok4WXHM8XUR0YXL8Brt7SVhyTtmHC
         8HyA==
X-Forwarded-Encrypted: i=1; AJvYcCXUMdejPhh+lve8zJFs96ia6v/qaPTn/Wqq8+UMZxyFtQIyEyW36hnyq5whd6uqkJKJVMAo2xNr3WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9SgSC6xQmGDeKlVNdMlApJVA+pfC0p6HbJfjuTBwCjyVWHRr
	VyoRibZVqZwBjVBAfxWzQq06fdA4sMtbUekBiGyjUL/08P1DbmvJ5JS0UaYMebB1vQK9K0gsPp8
	RqFnE7Q+Y0+nr1Ysu11nLGeuNQi36A1MhF77LELiBIbRQnfEtutuEBPrcDRpDF0dPP7NmZxk=
X-Gm-Gg: AY/fxX59B2HY+tpbc9sXu7RsJYymTepRFTO/4UH41Vp+bV4UsMtg+SGoOBIiAq1z0tp
	JOo5bgk38Z9k+PWhkIrzAWTEAui90e+ullFJ+79KkWQrwKNM0lgvQQ4LZ76U9NIFXDhFuz4bdtN
	EvdhJx48yvf6jF243ydQHFMimmlW1n/ZZJic4jn3XUoLRisxMGS+Jfx5RHKbxOuRQ8zlJ8QYLXV
	8wvcDp2CX5vndE2zBwW+4q+jEUSZiEqzxl87ZC6daJ1avlR5fUn/9wtHd+4IcwrbA2OAxupejyH
	9hwN1qmbKkEn0sOHIw6mosmsBH5yIR+HwUpB3AavH55+FYQVvsIL3IE3hqXOcPRdsAcTIABNa4Q
	pNHBguWYQIhhPHSm4U+8DFIIJ0c3l5HEouk/VCo3bKJBLOvPGBLY2HbJM8bdYt7HoedexiQ==
X-Received: by 2002:a05:622a:1f15:b0:4f1:ca7d:b4eb with SMTP id d75a77b69052e-4f4abd975f2mr260538771cf.49.1766580337087;
        Wed, 24 Dec 2025 04:45:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvs4oWi+xwBghfxxgl8akUEo9LzvP+UPpm88enCfJY2jH70XQyzwE+PXBxFlYLbEV8AIKAkA==
X-Received: by 2002:a05:622a:1f15:b0:4f1:ca7d:b4eb with SMTP id d75a77b69052e-4f4abd975f2mr260538481cf.49.1766580336662;
        Wed, 24 Dec 2025 04:45:36 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a6050dsm1777975966b.9.2025.12.24.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:45:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/2] dmaengine: xilinx: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:45:33 +0100
Message-ID: <20251224124531.208682-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=YfaPnbAe61xlYslBRJ26Zrc2VbtjGDLPshZ+NcYAkQ0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+BsuD5QewwIIKIESGEmFPgYuGm4DQz4s4Azj
 czrB+jM8luJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgbAAKCRDBN2bmhouD
 1yYCD/9wav6ZBlyG8Oiuiy8gQbhgzIg3Bf3qDKrQavxN8BrzbEOltTHw1n/s7ZiwL+T/yEyHbwx
 aP5cOM6HdumIrCQp8Hlp0js9pxtlD+q1eQOA+E75GwQ3SCL6fIYPqWkQanJ4TM0mLh7+OV5uvho
 6TJRHYF4DBXdxU0P/8TkJmWm7deCvS39ECZ/pB7uyqPLvgsP5FVl+RtFoqrTiRkOwa6WeIPj9TR
 yERHx2nBsam1UGm7GE/CmAOVm2aVCSGGkfkfuR3CHQPiF+oCRnnUDKmQe5Kyn5Ft7Qydxm6biv5
 8OC5auNOLHPFvshojh/9WEx9mwGRGfyjiTS2RrOs9DHOW069yvdvxH3XpWnItG1YB12Ex3+uBAK
 RdVhryJ0P59KFT8PwnQbxW2CAS6FtBCpRjSq17zGMYSSixeMkT8CN1U3KagEH7QdKEC9hQdNbMi
 ECjF9Q60tlVIV45ybt2bp1KL5VATPFgcf99XnUQlAxpDCNWOXVgiEuT2/rzO6n/c7NWQ9+b5Rb3
 RNi+sngpKfGYj6MDbkr8NBwIvm5qY3dpgOu26lnAI5YWa+/O/XPyXHFZmHEMN78F31w22lw55K3
 mxS5WKZLLNgALhyAwKOblVEv8Rw1HT29bDTKqb8x1lOxsV1GAIJcK73Kw/AhxYuOSHnlEVjeHDL QaO4Mw9zGv6nhMg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aLE9s16q6UkaDAjd5T64vN0mIJl7Kry7
X-Proofpoint-ORIG-GUID: aLE9s16q6UkaDAjd5T64vN0mIJl7Kry7
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694be072 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tFfeZFaV2qJb7BekgtkA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfX8Cc1/sz684dp
 c4EBol3VmrgKQHihW0dVu+CQOAAOOFXoVkQMZk8hI3qX87LXmZSL+b6SDdn3C4cnGT5aSX6d+wQ
 Qe78RmuxUxK9Q1X8jqF87Mnuv5iXR7R00XQTkDJ7/S46UIAQxO7tOyicMxP7v2LgkBXs21x3NYD
 qm2S+hqgy81IGydwa2i29TFXnIx56cLSPWb+LEM/f90qUShEa72/6HqNNVVKwL4NEUdu5fhVQNs
 dDJcMKVo3JqNI17Z5ktTcDh/5Gn58HpbnXlI6FR8+7AUH3B97RlGeY2ZF0Nq2fsnUNmjA+NDOKj
 ++rmpEYhS0kDakpts5UZGlPpKYW04Bk5RkUINUiDjhEyAg5y0bnTN3/pbDRyC0paU3PEAFZpOMF
 Z+4vF9Vq1XQCQ1IsPJ7vUOKGhpqW2NQX1ytsyTETmZ3HJcIBndN26yKRFf1iVf9wjKFtwIpREvM
 LkOcxVGAkqqC45hPuug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 89a8254d9cdc..21c8bff07dcf 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3159,7 +3159,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 					= axivdma_clk_init;
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
-	struct device_node *child, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	u32 num_frames, addr_width = XILINX_DMA_DFAULT_ADDRWIDTH, len_width;
 	int i, err;
 
@@ -3299,12 +3299,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, xdev);
 
 	/* Initialize the channels */
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		err = xilinx_dma_child_probe(xdev, child);
-		if (err < 0) {
-			of_node_put(child);
+		if (err < 0)
 			goto error;
-		}
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-- 
2.51.0


