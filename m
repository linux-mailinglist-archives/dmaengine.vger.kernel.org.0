Return-Path: <dmaengine+bounces-2856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20C952B6C
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1661C20F9B
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366271CB32C;
	Thu, 15 Aug 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LEdZlbyb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F81AE87C;
	Thu, 15 Aug 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712278; cv=none; b=BXz42CKWt4lObS4+3qDDdVyit4rcEQAhOYsPNEOf8qaRjitTX4ns5VnMdmqDz9fI5bJf517RGAYoaYqaUQiNze6sVckorbrXCQy41Ws6FJotC0t5hvibBZDgtHtisXOFuztDbG5VnMDlexSvxz81FJlUX1vSOC5MS2Xjj3xG8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712278; c=relaxed/simple;
	bh=vl/T7ZGahV2ed87B2vBdq0c1rbggs+bQLu5/eGdHwkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOi5JjHLa0VgxB37C6Cwr0SelhnrZlp4TA099xD8Kh54upJC09IczwDXvahU8jh7UOtAFdnLnG0lEd6rHJtooHiSZ4YgixQj67E9GE5k3QRFXvagyli6Yi97zBQcAglHMhh9b5qbvOBl0nXxDGQpdSQjjJWf5gTM0vO4SBsq168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LEdZlbyb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EMKkqS027601;
	Thu, 15 Aug 2024 08:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7lnRtsX8RcO
	IS0YefxLVrkBHcLfVapkwzjVGjh3VaKw=; b=LEdZlbybL4igAcgBb4YT7AE1G92
	Y+AcFl+Dt0AMnxjBnEoOH/fykcK/mEtdgbxnjNRD+wbeOHJokOLY1pTIa9JWFGLl
	YVhiVz+CglMGk/Jw/0Bc+n2yieE/JDi9tCMPB3LAF43yh0CHkarSUVGoKbrW5a1i
	ox9tCAsCkrT0f178dXzPGDn2yk462TIQ3blKSA1mr6duR1SzvPxhLVgxoZVQv8AQ
	GOPcekFISzybMLEeCYpA9rj146xOoVprXgFjanhobErM0hmWAKjFjM9nSAdqXQ2a
	55w4d7DnmgfRE4pGMPKC/uAHSSYjcQOdUugCsejW8+OjglQPXk6U/rF5gWQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x3etdq3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8u8eC028285;
	Thu, 15 Aug 2024 08:57:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhenmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vSAZ029649;
	Thu, 15 Aug 2024 08:57:28 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vSoK029641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:28 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 9B58441328; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gustavoars@kernel.org, u.kleine-koenig@pengutronix.de, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com, quic_utiwari@quicinc.com
Subject: [PATCH v2 04/16] crypto: qce - Add support for crypto address read
Date: Thu, 15 Aug 2024 14:27:13 +0530
Message-Id: <20240815085725.2740390-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p3P9FvkGCCxxLnxm90hBxU_-mHEuUf__
X-Proofpoint-ORIG-GUID: p3P9FvkGCCxxLnxm90hBxU_-mHEuUf__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150064

Get crypto base address from DT. This will use for
command descriptor support for crypto register r/w
via BAM/DMA

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v2]

* Addressed all comments from v1

Change in [v1]

* Added support to read crypto base address from dt

 drivers/crypto/qce/core.c | 13 ++++++++++++-
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 28b5fd823827..9b23a948078a 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -192,6 +192,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -201,10 +202,16 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
+	qce->base_dma = dma_map_resource(dev, res->start,
+					 resource_size(res),
+					 DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dev, qce->base_dma))
+		return -ENXIO;
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		return ret;
@@ -280,6 +287,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 static void qce_crypto_remove(struct platform_device *pdev)
 {
 	struct qce_device *qce = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	tasklet_kill(&qce->done_tasklet);
 	qce_unregister_algs(qce);
@@ -287,6 +295,9 @@ static void qce_crypto_remove(struct platform_device *pdev)
 	clk_disable_unprepare(qce->bus);
 	clk_disable_unprepare(qce->iface);
 	clk_disable_unprepare(qce->core);
+
+	dma_unmap_resource(&pdev->dev, qce->base_dma, resource_size(res),
+			   DMA_BIDIRECTIONAL, 0);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 228fcd69ec51..25e2af45c047 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -39,6 +39,7 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
-- 
2.34.1


