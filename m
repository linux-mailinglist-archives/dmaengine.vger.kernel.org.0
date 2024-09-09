Return-Path: <dmaengine+bounces-3111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19C971399
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D532B1F22E6A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5651B5315;
	Mon,  9 Sep 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iku8COHu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6951B3749;
	Mon,  9 Sep 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874109; cv=none; b=gQju6gy7hcvmKxJamtHyKtAuE4ux1ZgeaJ+oNvljz0ZvQpaNLv+hIlNb7L86mQZWBL9/f1/JNDXTWo0MV63qyHn9XqkEWEO5lW38Odipz4BTy+hYT2SdCRb3hkW5QxQc8sRD0S2n/YCSlbVolUsnXz1V323KP+49RdsTV/vvH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874109; c=relaxed/simple;
	bh=fqBHUjGqy0T9ULRhpbjqkuNmsY9KiW54xMeOLokGa/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6/tAdeHVPcV6f6vG9eFucH7t5u+rM9U0fcFCkkig/q3gYmGXAgIorMef0eapRK0/Hgg+tEKnk76EbsN8fpTxJEXxf3CgpffDfFtYN1ZtluMNDIxFKKRZVbQpBlDZzaLNTodlfCj1vQw20z5dlaJYxOZlApuLzmLVQJ6MIjE6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iku8COHu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JqHm005055;
	Mon, 9 Sep 2024 09:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nZIALK+2akZWYrMMVgf/9rd/En/VpP6orXYdUqRw/dk=; b=iku8COHuay+H3nq6
	A/TBA2bA4TQGENzrHulZR8TXj4e6qie4ygRu1MlDzeNKkvvtkLgolKy8loXDfU22
	GZ6IrzmMQgvirzAVgxXAFlpBi4IuGQW/9Bed8/W8RjRqwq74c9CwDFJngOFKM3wv
	NO+VaCh2ZcQWoqbF2opvbS6sPNkDatWYuKqinXhVTu2Bg4tlgMHQS4f0KjiJU1Wv
	V1mZP5XykRfDdCCA1CgkjXV6AY97fMWk7FiBDud9r0FoC1DoPIaDOKTVf/cUBt1/
	CfpBmcuXkgCOROVYBVT5Z+hfbCe6qCOq+F5E/L98yFdiyOG5oBMWvoq8BHzYN3Hx
	BC1+Dg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy512bek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:28:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899S0tZ003817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:28:00 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:56 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 10/11] crypto: qce - Add support for lock/unlock in sha
Date: Mon, 9 Sep 2024 14:56:31 +0530
Message-ID: <20240909092632.2776160-11-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PltVsEUzTzP7_aUhKIifteAo1BkIk_Yz
X-Proofpoint-GUID: PltVsEUzTzP7_aUhKIifteAo1BkIk_Yz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409090075

Add support for lock/unlock on bam pipe in sha.
If multiple EE's(Execution Environment) try to access
the same crypto engine then before accessing the crypto
engine EE's has to lock the bam pipe and then submit the
request to crypto engine. Once request done then EE's has
to unlock the bam pipe so that others EE's can access the
crypto engine.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No change
 
Change in [v3]

* Move qce_bam_release_lock() after qca_dma_terminate_all()
  api

Change in [v2]

* Added qce_bam_acquire_lock() and qce_bam_release_lock()
  api for SHA

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/sha.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index fc72af8aa9a7..abfa63ff18d7 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -60,6 +60,8 @@ static void qce_ahash_done(void *data)
 	rctx->byte_count[0] = cpu_to_be32(result->auth_byte_count[0]);
 	rctx->byte_count[1] = cpu_to_be32(result->auth_byte_count[1]);
 
+	qce_bam_release_lock(qce);
+
 	error = qce_check_status(qce, &status);
 	if (error < 0)
 		dev_dbg(qce->dev, "ahash operation error (%x)\n", status);
@@ -90,6 +92,8 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 		rctx->authklen = AES_KEYSIZE_128;
 	}
 
+	qce_bam_acquire_lock(qce);
+
 	rctx->src_nents = sg_nents_for_len(req->src, req->nbytes);
 	if (rctx->src_nents < 0) {
 		dev_err(qce->dev, "Invalid numbers of src SG.\n");
-- 
2.34.1


