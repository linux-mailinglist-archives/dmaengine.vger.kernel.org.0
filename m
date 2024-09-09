Return-Path: <dmaengine+bounces-3104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEFD971376
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A055B22B3B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280A1B375A;
	Mon,  9 Sep 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ENgVuH7d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329081B375C;
	Mon,  9 Sep 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874055; cv=none; b=fCTZU7ng8GsPIaw1TbWmfoa14hmk49B9M98kRs7MnMakcIHJw+zYCHMEFzinohnEI1LOkX8Pba05Yz6U5E1T9QtGyBNxjnLhfpAHD+Tb0Zet+6loK7oqZvO5/EbHyQJZGIxiH+oNUKtITmygPQ6OamHSGIn+NlX1Pbw3G1iPF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874055; c=relaxed/simple;
	bh=OATpeAFQB6pFnhbK3S7CldOkYx6wfZe7ERE/s5bn1DY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT9ZGjkmUh1XXOZqQ1JVGWyGUVdLW9i8tl37kS3BCv0rrpR1dZl44ikGXgDh1FAPbUo+ALhPbj41+VDcvb2qXHrbJz/pMCpoecq9c3yg597sSFNlf1VxZm6Ok0glxJZDWZGdpE5ysk4sagaO86Jf4OQ1NkBe4zLoaj0Aeg+fVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ENgVuH7d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JkQx019854;
	Mon, 9 Sep 2024 09:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNI480aejPtTJ1U16c7ljELhVxOaJ+wJGWviERBnLto=; b=ENgVuH7dfggNKeY7
	5EMzO5q+JXtLOFoum4U/WAJ9nAVuSyxB24ey0UmorJCLxUhmrZXZoUSUsJVQ3sco
	9bskfFYJPH90Bs7VRsXgAIHncA0OsnCqTFO4R0cjdfXhcZXVcwoGcNPM+Azk01GL
	2mgPIS13YkoVqxJQXRsYfpycE6F+luRiZXrcKf2t5FaFy4U6v3gNiKzH4j/UD2/7
	pagCAwLcwZlMIv+Ve2vlnN2Vaxm88rQ9hwjKjoEoqiLlUcUJhAYZmYURok6GWp3y
	wLRnskOvnZAhK1B1Rzj6Im0OX7TVmAPtWokOfLl3rv9oHPVPqHGI8DOXB+6AZ4FA
	kWYdOQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6sjc80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899RPPk000959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:25 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:19 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 03/11] crypto: qce - Add support for crypto address read
Date: Mon, 9 Sep 2024 14:56:24 +0530
Message-ID: <20240909092632.2776160-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
References: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AVi3fRQkDhqPp6n4uaeYPp7bo7muHWyY
X-Proofpoint-ORIG-GUID: AVi3fRQkDhqPp6n4uaeYPp7bo7muHWyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090074

Get crypto base address from DT. This will use for
command descriptor support for crypto register r/w
via BAM/DMA.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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
index 28b5fd823827..2236a057f45c 100644
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


