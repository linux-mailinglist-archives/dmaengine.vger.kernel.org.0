Return-Path: <dmaengine+bounces-4120-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF0A11F91
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8093A42D1
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE760244F97;
	Wed, 15 Jan 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bCeTZwfl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E867244F93;
	Wed, 15 Jan 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937061; cv=none; b=fwCEgqquToMG8wywQJY4+ogj1Rl9pSGvLsln1rkLiFZpRMykqkAvYQR6Kg61QJOpXsm5Pwd43PHTntk9YEJdRN9+AKeo2DcWGbnelQS5AOv59ynDqqwhCcmW3wdeY/pebaFP7/evNHik5BbRVkzJB8k/cSoiQfXhGL6YkcQCQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937061; c=relaxed/simple;
	bh=Nz+KIEm0W+Tt+EY+uMZzOB1h1UdBCPbFqkHXBm30qkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO4C7T1pZzhTVBHyhQ3I9yItqxsue+WwF+Hljmcf1uN8bG+GBxL5qGBXDqEn55QtoDski4tslsF6UXP1Vl3RPU5I9XzxGMxj1TBLCVSekHMYkVNVEM4KGaF85qIw9Gsy1Z79V3M24wGAmv2hz9dpPqaAfwpPx/lvga7CrwxXzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bCeTZwfl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FAU0bV001997;
	Wed, 15 Jan 2025 10:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zfVU7S7xMLNXlZcC7P/nCRAf7g6rHacyfVmf09xU6/I=; b=bCeTZwflZc0efMuH
	KazvMDI4N8c5SP4oE0WI1yD/OMWDPxWrdxPAm/oiIugBS4GhDr5J7zagVM1KUmjm
	BOyGJr4HI0f2FIOsdjWRUiX317poXWX/aPqy+D+rffiJiD6cKzg9ugwZRJ4EZzPw
	eSawsn2ftmFiLhVSslxfxUVLT3VfuCWnN0CFNlJQgOjZeweZ1Q99CaxtkPwazxrg
	giIqIFU5Tj4qxOtvPhbTk6DWlaiBR3yR5rjhNzIaSq5K+j272DbCxGJEMwFMuw+J
	h4Gy/pKjk/3p/nFdTW+dkoiSLV8KNGNDPon8ejeV3hUPCIl/Qhginw+A9Ad7K3jY
	NsxGOw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446bamg031-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAUobD025577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:50 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:30:45 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 04/12] crypto: qce - Add support for crypto address read
Date: Wed, 15 Jan 2025 15:59:56 +0530
Message-ID: <20250115103004.3350561-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Hj9jvZA3q8asCQUbK_Pz_f47AKwyq91t
X-Proofpoint-GUID: Hj9jvZA3q8asCQUbK_Pz_f47AKwyq91t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150079

Get crypto base address from DT. This will use for
command descriptor support for crypto register r/w
via BAM/DMA.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* No Change

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

 drivers/crypto/qce/core.c | 16 ++++++++++++++--
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e95e84486d9a..ba856cd0c2d8 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -191,6 +191,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -200,7 +201,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -246,7 +247,18 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	return devm_qce_register_algs(qce);
+	ret = devm_qce_register_algs(qce);
+	if (ret)
+		return ret;
+
+	qce->base_dma = dma_map_resource(dev, res->start,
+					 resource_size(res),
+					 DMA_BIDIRECTIONAL, 0);
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index eb6fa7a8b64a..0b6350b6076e 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -42,6 +42,7 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
-- 
2.34.1


