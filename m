Return-Path: <dmaengine+bounces-7941-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD75CDC420
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 13:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3048300EDE9
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB463358B7;
	Wed, 24 Dec 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFkkXYGA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jc4BFGA2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF753358AA
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580338; cv=none; b=bZwy/u/VWtosRq3xjr5BfWrV+io9r24QKXOHp26uemreq3DRCuugHh52Aax32Tq6qe0B4+uCN9SfeP4/n2f1O+ZAVA+K7Q34ryDkIu+XnNAkDLCoromuPKH3Cc1cE87e6w6VYMQE7dLx9mhTv1XTW9xVYsnQ9z/RLidkg4S3UMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580338; c=relaxed/simple;
	bh=9zcpzey/wbo2n2NG7vk52Reue7c2cbJAJeguA6lv1Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7fjVG4z52jbZe0iaVqyEQEnzt94/gCpbjTsD+MNgDhFtdxH+WXqh7Huv6xMZZaIJTLhrxtE+79XusY2bk2e8Hm0vBmaUsn/xFemHf6CUZVOZ0GNY2HNgEO3iz/HIrLWOyQYb650f5Gz/J1Bfv4pqXMpmlRe90INK+kpp3sIgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFkkXYGA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jc4BFGA2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO3wTnT3796796
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 12:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MD4+4dTtOWYC4DkHPGbCwOgkR+4yQ1iA13H
	nXjKESLc=; b=lFkkXYGA4/bjPOl5rVodkdi04IsWD4QIPpS8qMTCAiebZqipiaM
	GXF0j88CYqAni3F0u/6dEnNubMoZLB5vuaO1NUNfElbETW14JJRwtGRkS8ExJbtJ
	TUjkSDxb3VgHrY5LacKdkuHDe5FpqUjVNw53mZ5klLttn5AgGQVL1w6qBBjHMXj+
	BZD6fCfL6afXR7sg7sMCsUgLhlzEASboFRHfTBQEyc8HYPzJa35iPcET74rdMZA1
	77Erd1CZlcrV4sDHAtKf9aWuddFbh/SGn7/57UOzK9eyPlIs1q7N0/GEU37MSp+M
	tb7NiLyaioCVqgBAGsoujPVKjdTZ0YoYbyA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b88r696r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 12:45:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee416413a8so64623951cf.1
        for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 04:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580336; x=1767185136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MD4+4dTtOWYC4DkHPGbCwOgkR+4yQ1iA13HnXjKESLc=;
        b=Jc4BFGA2byinfJ53wKX/vU/cQzqVrXX7iIlUj/sQ4dlevGC+XL8b3cbzaHPax+xKJI
         PtRjrN3KMtQSE5X0PpHipeV6fwG+Kwxbkl5zn/ylYCZ9gYchk8qPyzm3rpEovZ/Os12J
         1f/9QBAAYf/KWjX9cknEJ64OcxJYWFpPujwc6oFzYgh33BJX23r40C9LpPLkpKZnuZcx
         gGVj/88ajcEzkXQ4Py35k+E3VLG0JKa1qgdotMLV+suLYjfxxadOP3GeZ/RFxe4rmUZ9
         ZxXgVVkI77skI9J39H4nrrx2Yd4GZ/p57rH7DISWx96/8/sBGBnICNq+kIs6+vhPho9V
         AzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580336; x=1767185136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD4+4dTtOWYC4DkHPGbCwOgkR+4yQ1iA13HnXjKESLc=;
        b=vQoSWhVwtx0Yza6bjmSKP4oJZ2OylgX9evKE4oN4pTYcEE3uaUKuAO/FLgdq7j1hvS
         YKDhPSO49dGUQcCBraACTuiJPBi6axWDZKvhik/M+17alS9pIdeeqBNVvHBeW/jgeSJo
         cOG8jNvWjdAb+k3S3eD0tbtcX0FhTAsbUKqJxmuDA4G1IRR4iGkmXTBa1PyXvoMbpY1T
         5jsv+vZc0XSFjAplfVxS+FBwT39J4ysdqRffwQdVtc/kCYa6ydbvdxJb+19FWYA17hqL
         LqaEwlZjuEH67jKzbScpoBqHugwaWjeeSm52eIy5LKexxGCJkSjZvE2XdtE/BSjOse7t
         T1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnvmxf9EuLc/sStNV3N1U+5rN4pXcstiTC9O9D73sXRNxtw3G087aUJw1gVBb/C7GtP9sqmoXvJx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdQVUfG4VhMCUoQAFQwFLz4Xzb20u0KTjBeKGvtIeasRxmZ+x
	H09B2S0mHFS+bSOogTIMoMFWypdgFBjOk04EfyDL1Sq8sD3Vj5LP2mea5Iy/nN+2WNm109bsMcS
	oACYgD9yR9+E1WQYF63g+FTsRSoP22hiRvWPQQi2D9miGKeigYLzgJvL011A1Uxg=
X-Gm-Gg: AY/fxX6ML6yo59map8e3P55AVMf1c/EnCAQ7E3E5/Co1LhVfVFDVgMqoXCtWRaCDbk8
	uOGUbNZ2MDs9L7aMXVZ7o/lUJv2CibtW2IuBJV93icSxI3hoOz06CeKde5aPJKOu/0RSieCES1v
	o5+qOTlnU9mze1vACibJn7tgAyiDl8guloSoyooZebEO5jAL3iDjKhCmsGBL4uyLxywtclI84xE
	ke6H7/LEceQ1+ThdUI+NtMlssBVkLlwVz0f/OYacd1+bHMwV7ZcN1v5TVqK9OnYY7TjdvnkB8c5
	OPtd/iVFeGXRYV+VNIHyPFDmP1gJU9kkOV2Pjleb5snOJW4jhk1KSayf3B459odHbLbfw0gihQq
	7dDMXD9qqAhNo071KvwMMGNrKojFXuSOVI3peaJm1eT9FVM5Xug5vPG0ADm1cwlK6UPz/CQ==
X-Received: by 2002:a05:622a:4d06:b0:4f0:441:96be with SMTP id d75a77b69052e-4f4abd6097cmr255765501cf.51.1766580335663;
        Wed, 24 Dec 2025 04:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvjMIM5yhJoLEQH74M5IK0AdJgrY2gnBRvrxLNfELlqjEcnwKdDd3x3oifm+uyn4I2JE6zkw==
X-Received: by 2002:a05:622a:4d06:b0:4f0:441:96be with SMTP id d75a77b69052e-4f4abd6097cmr255765181cf.51.1766580335233;
        Wed, 24 Dec 2025 04:45:35 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a6050dsm1777975966b.9.2025.12.24.04.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:45:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/2] dmaengine: axi-dmac: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:45:32 +0100
Message-ID: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=9zcpzey/wbo2n2NG7vk52Reue7c2cbJAJeguA6lv1Pg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+Brq/1ZTfyYDb1xnkiLhDH7/pTNXiZHymNo6
 +BtVzGgpjmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgawAKCRDBN2bmhouD
 1+3ZD/9Lw9Z3ImP1PgtCe5vQAGa4CiOnLPTq3fwM69u66tCwwJnPaLMs2LKclNM5QFiTwQj5jG4
 q3KlX9yGcC+xGo0vKE7zz/LxCNGgHF+QIXkMaueMPH8sakYaSBElYGVu2XaQxfabIu3ieZNiWJv
 ojBQDA86XJFYGb4LO7g1BUu60Y01+dQcjNm7oOofytzlPDraEKs2vNCLUFbpgsf5gNokHH5LYlF
 O/IiBSaTW3uQuEnImsDT0S7Be8zY49MUeicDJGX/eIDQWAasDA0YWIf1Pu0d1bGgbMZpiLMXV92
 yjPkWQJX/FFCzahNaKPqTUKyYysAvD+0rmrjaUh6ClrEGROcnDMP5PhbsBqUNfLtov+yK5p09Gd
 iCyUoomhlHwMa8RmIwHhhHs1gTbdu/rVEkT37e0zBXP2VeHtAsGF/GO+YkMCYCmWE+2bvP9p0Sf
 CmZEKoT7goZ+HJEW9C1hIzBTqbccQMBG2c6WwnlbzqTPXiJfN5z2IyD0pSinYmOD5TRQ8Vk2c4h
 joERR0XQPfQvjGmIpVjKULVJGWbaLgvvoKwXkxUT7qvEso01UxQc6RbmUfJVu+JsGaiYUp70YLh
 WJllgrGcpnEKkFnepSzCSOozvljD9aAfDi2RSFmi6nIzKNWTIwvqw7jW5aOIQ2jw8CnQ1vcMkq+ /IrsakAqRyEdLrA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RO_Z4AMQAf1h_dutX0yFs0baC9WvSh9R
X-Proofpoint-ORIG-GUID: RO_Z4AMQAf1h_dutX0yFs0baC9WvSh9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfX1VK7ktvoMRqB
 TvZuQE+2qymFkNONn0aiPIsFeIGPu62HPL5JAPQ5ELG1Y5Oxh1RtRkVhq3TZ+rVHR7eTtt5SOnr
 LoaW9hCXeu5WYHRJXqlkxH/XdbWhQn9Pa9h1PFOga2H+8oy3Vzu+iQmzXWsgfy8xOlWnOB7y6/O
 eVamzjPshlrT7/aW0D1foFznl6IQFZ2NmjbQGcqeP+CgumdRc4otRHN1h9W2Gx9IRdZvRTTFCZ9
 kfHaek/yMDKqKBFPOxPcym7+94N5XPIylLG4tO6Dagezzkbg+ACWDsLtPSiHoCjiq/VdPMzCoak
 Ou6MFdtpJeZ6LJNGWfRFLkBIHkAF3tJ+NSLENZwMYe3Dp+P25d8VMkjPHum1zDi6tZ8Yv4+Av4V
 XQ3RjElr9em/8/9Z7Sf69/5SNSsVk3/gerRiX2WbUuIhPwtLnbxX8EMAPA4rDsdORQDPXdnhq6Q
 Ez3lIE8/y5D5cRCH9Ig==
X-Authority-Analysis: v=2.4 cv=Qahrf8bv c=1 sm=1 tr=0 ts=694be070 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=cJhNrYchChBbACeWSR8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/dma/dma-axi-dmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5b06b0dc67ee..45364b1e47f4 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -925,24 +925,21 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 
 static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
 {
-	struct device_node *of_channels, *of_chan;
-	int ret;
+	struct device_node *of_channels;
+	int ret = 0;
 
 	of_channels = of_get_child_by_name(dev->of_node, "adi,channels");
 	if (of_channels == NULL)
 		return -ENODEV;
 
-	for_each_child_of_node(of_channels, of_chan) {
+	for_each_child_of_node_scoped(of_channels, of_chan) {
 		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
-		if (ret) {
-			of_node_put(of_chan);
-			of_node_put(of_channels);
-			return -EINVAL;
-		}
+		if (ret)
+			break;
 	}
 	of_node_put(of_channels);
 
-	return 0;
+	return ret;
 }
 
 static int axi_dmac_read_chan_config(struct device *dev, struct axi_dmac *dmac)
-- 
2.51.0


