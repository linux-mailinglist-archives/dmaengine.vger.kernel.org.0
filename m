Return-Path: <dmaengine+bounces-4125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DFA11FAD
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB5516470F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911BC28EC98;
	Wed, 15 Jan 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B5KxrUE4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A3242275;
	Wed, 15 Jan 2025 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937089; cv=none; b=PLHj6hO+duQ4pFZgeU3+IzrtbBBqKo+XshIIGpW1lgx9QGr3TFH+c+hHs76LQYLWfeOWg6/VwWDA80mz8u28iwTeQn67oGiuE8jsKYhfAYuG08YQli7jQAHiJTDfuVsaQ8Am/3A1JWzwUjY/C7o9rgrpbd9IEzBcVAi1oct/hq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937089; c=relaxed/simple;
	bh=1fYyHXg+s04Cw44LHZQgBEJ/G2QEC3W88V4ZCYijPYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK2NP5xlX2OTUf5kgQX7bNJpqFIpbv5D/c3UlmoQkgnN9Nn97afFetMiXvYU1s0u83JsyGp+G0pvpCu3V+KzLHX0BPwc0ZGwPcU7kRE41D13C7FuyCdBGDinkse6X/Q6/Ys/zbKbisTcrSNwqj0eeclT6j2DTnFTQx9TgZqJlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B5KxrUE4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F7ojrm024131;
	Wed, 15 Jan 2025 10:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wOidVlLKswFT0WWr9u/8d5tSqG5LWjhR7UtFwlWROXw=; b=B5KxrUE4ATkPfCXf
	+pcc/04EQvfUdKhlF6Qs0vl7KaZdOIZhxOXxyEfgBSlew9nsypVoLHpSYs9uNYTB
	Ff3EnBbOpOMTjUgRBelFqTd6W9/2iIqh1Q1qByNU4kcBBQ5jeZpJKmjFJotbH961
	EUHDJIFWltemfL2SnlrdvVi/qby17jgAnwUbawPGVt0mzppv+Gs2juuD65lu262K
	90LtgVRODKOr0q9x4tVH57wLAkLpp/GgGQii2HNCjuj5Ma81wJJwA99QQ1h80IO/
	Je34PkjST+VUBl2vXePwjIxqbRbLRL/sBzKaWBrnlOJcVV/LC9sPJEIbhGlCskE3
	gNsCuA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446903rcv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAVHua020474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:17 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:31:11 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 09/12] crypto: qce - Add LOCK and UNLOCK flag support
Date: Wed, 15 Jan 2025 16:00:01 +0530
Message-ID: <20250115103004.3350561-10-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 7y57EDm_48DM6ejwYIunQ40MMwoppbAL
X-Proofpoint-ORIG-GUID: 7y57EDm_48DM6ejwYIunQ40MMwoppbAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Add LOCK and UNLOCK flag support while preparing
command descriptor for writing crypto register.

added qce_bam_acquire_lock() and qce_bam_release_lock()
which will do dummy write to a crypto register for
acquiring lock and releasing lock.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* No change

Change in [v5]

* No change

Change in [v4]

* Added qce_bam_acquire_lock() and qce_bam_release_lock()
  api
 
Change in [v3]

* No change

Change in [v2]

* Added initial support for LOCK/UNLOCK flag
  on command descriptor

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/common.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/core.h   |  3 ++-
 drivers/crypto/qce/dma.c    |  7 ++++++-
 drivers/crypto/qce/dma.h    |  2 ++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index ff96f6ba1fc5..dad12e15905f 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -588,6 +588,41 @@ int qce_start(struct crypto_async_request *async_req, u32 type)
 #define STATUS_ERRORS	\
 		(BIT(SW_ERR_SHIFT) | BIT(AXI_ERR_SHIFT) | BIT(HSD_ERR_SHIFT))
 
+int qce_bam_acquire_lock(struct qce_device *qce)
+{
+	int ret;
+
+	qce_clear_bam_transaction(qce);
+
+	/* This is just a dummy write to acquire lock on bam pipe */
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
+	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_LOCK);
+	if (ret) {
+		dev_err(qce->dev, "Error in Locking cmd descriptor\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int qce_bam_release_lock(struct qce_device *qce)
+{
+	int ret;
+
+	qce_clear_bam_transaction(qce);
+
+	/* This just dummy write to release lock on bam pipe*/
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
+
+	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_UNLOCK);
+	if (ret) {
+		dev_err(qce->dev, "Error in Un-Locking cmd descriptor\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int qce_check_status(struct qce_device *qce, u32 *status)
 {
 	int ret = 0;
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 4559232bdf71..8919c6f63163 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -71,5 +71,6 @@ int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
 void qce_clear_bam_transaction(struct qce_device *qce);
 int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
 struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
-
+int qce_bam_acquire_lock(struct qce_device *qce);
+int qce_bam_release_lock(struct qce_device *qce);
 #endif /* _CORE_H_ */
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 225ac5619249..c039a3d93750 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -73,7 +73,12 @@ int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
 	unsigned long desc_flags;
 	int ret = 0;
 
-	desc_flags = DMA_PREP_CMD;
+	if (flags & QCE_DMA_DESC_FLAG_LOCK)
+		desc_flags = DMA_PREP_CMD | DMA_PREP_LOCK;
+	else if (flags & QCE_DMA_DESC_FLAG_UNLOCK)
+		desc_flags = DMA_PREP_CMD | DMA_PREP_UNLOCK;
+	else
+		desc_flags = DMA_PREP_CMD;
 
 	/* For command descriptor always use consumer pipe
 	 * it recommended as per HPG
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 2ec04e3df4ba..198be2deeda5 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -19,6 +19,8 @@
 #define QCE_BAM_CMD_ELEMENT_SIZE       64
 #define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
 #define QCE_MAX_REG_READ               8
+#define QCE_DMA_DESC_FLAG_LOCK          (0x0002)
+#define QCE_DMA_DESC_FLAG_UNLOCK        (0x0001)
 
 
 struct qce_result_dump {
-- 
2.34.1


