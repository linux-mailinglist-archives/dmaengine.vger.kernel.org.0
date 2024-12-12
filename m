Return-Path: <dmaengine+bounces-3952-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC53B9EDE32
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C041888F63
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE831632DA;
	Thu, 12 Dec 2024 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XU0BJT5R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0646158DB1;
	Thu, 12 Dec 2024 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977053; cv=none; b=lr+Pn42ekUa0YJubB/knIqKt3jbt88eE3vOW8cvIE1FOPhrUL2cG65QCpOorAJ5cQctWAn/CpgAWojPXWnAo/mSqOhVpx1xc60wBnJeXUDKorXCfkpjGYPhT1dmqFKqVH1kmsWxm8b/T9HYOjgyvrErV2cSBiV0Sz7aIWkFJox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977053; c=relaxed/simple;
	bh=2II2TuJ/zlTflslIW8yOWNvHjttsp2duvgA0IWqZO5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rs+T40qtjv5RZIB5gA9PVb4XuM89earQA5l+HvOqx2tVFVMNXlpEtpv5QnGf+Pe6IkO6wCwOkbfZg9WvMsYk6xQiGcHQHTsnyg5fRW5S+f6cXOHSNnEndshA4VYG/pOK8Ge7x8wXkdlHuAibg60JR3/Obmmgv+942YMykmcSYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XU0BJT5R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHjojD019210;
	Thu, 12 Dec 2024 04:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7KxDVaFCBYcnQ6eGQ1+drtmAg7MRy06m1+FDtP/kYXM=; b=XU0BJT5RZewh6E5F
	aLDATWf4ve4gMx4Np0+lKqLqSfbkJkYcbcjrrbIDm+zD3DnPZHoJS8lzkDJzbfTC
	k8IsSQKwJjAYfLV9zxUvGTiDE+4hEJOfltDIUc6Wah1Eh+YN9+E5CP0UjFw1MfJL
	442ACXunXQWXtl6E2LKiZ6/YAGJWQGwRsoDutiXNiPC9cIqPJf1NeMbXoQiGnO/S
	Pr+5cL8SNK7eZVC3u6ArDTe5QlkQijBqQKgwYsQ0M8oSgxSWyUqxwkBdIyvSBum9
	cPOneUnzzans3Ij4o7qpv8GK1iAd4uj5nOUaMBA7BhFReGhkp4hRjqTFb37BAjxb
	eRFW1Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdys87e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4HI7B006000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:18 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:13 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 04/12] crypto: qce - Add support for crypto address read
Date: Thu, 12 Dec 2024 09:46:31 +0530
Message-ID: <20241212041639.4109039-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
References: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tAHp7WYeO_JdodnZ0WuKnYse3h8w4UaD
X-Proofpoint-GUID: tAHp7WYeO_JdodnZ0WuKnYse3h8w4UaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120027

Get crypto base address from DT. This will use for
command descriptor support for crypto register r/w
via BAM/DMA.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v5]

* No Change

Change in [v4]

* Added error handling path for dma_map_resource()

Change in [v3]

* Added dma_unmap_resource() in qce_crypto_remove()

Change in [v2]

* Added crypto added read from device tree

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/core.c | 14 ++++++++++++--
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e228a31fe28d..9306e09d0d80 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -192,6 +192,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -201,7 +202,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -261,7 +262,12 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dma;
 
-	return 0;
+	qce->base_dma = dma_map_resource(dev, res->start,
+					 resource_size(res),
+					 DMA_BIDIRECTIONAL, 0);
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (!ret)
+		return 0;
 
 err_dma:
 	qce_dma_release(&qce->dma);
@@ -280,6 +286,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 static void qce_crypto_remove(struct platform_device *pdev)
 {
 	struct qce_device *qce = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	tasklet_kill(&qce->done_tasklet);
 	qce_unregister_algs(qce);
@@ -287,6 +294,9 @@ static void qce_crypto_remove(struct platform_device *pdev)
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


