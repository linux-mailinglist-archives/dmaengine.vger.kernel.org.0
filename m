Return-Path: <dmaengine+bounces-3956-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9B9EDE45
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF23F1885594
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477317E900;
	Thu, 12 Dec 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EFKAy7vh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9D188CD8;
	Thu, 12 Dec 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977075; cv=none; b=ehune2itv8SLq/rxJQXrIkX1R02YM9NOvU9rarrk/7Y5HIbU+Cfz8Rhv6PvTvybjP2G6zFfW8wugI0z/1gkY9KHidc13FT6cCkwZlnwy1k+ukVjLboKa+YbnsjiG2fJ6pNsI4lLwIt9uQLpzDCRBLFKnLc2KzWylp8TG4AcU/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977075; c=relaxed/simple;
	bh=AEeQhq62gnQa6rnTAp5qfnm2oICPN/nEaLRgov+d74k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blYa+/chHvZJ6jrD5ZrMgAnbXavfyo2bzBaWVorfLyveaIvf7SFEMCENh2NW1N0BbwRptzB7pgEiQwFaqokeZMfMbYBbnD5i/42jib7cixAajLhuJXIxWg3XgcM+k35gL4acitIy+eUqfIQzLnl+GP8729Jv8pgv0ZduATHkvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EFKAy7vh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC2s8T5001463;
	Thu, 12 Dec 2024 04:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LOLHzKmE90Bk37nnkiPD8heRwd6MNnfeBl2XoqbnCs0=; b=EFKAy7vhlCK2rcCT
	cOjrtqcEWC9FDj/DebHMnMLqn45B0bZDoagbK9J5ZS5QLBHiFgYGHq/8e1gqnue1
	TRV1L0hAy+1TKhWlWQJpL29QP9O7zcGzmURnybs9YYWiZGy4hemKI8Qf7J0RnbEh
	u8ag9dTcYFf7nTip6ptc2wBp6fgFdpL+eaCx/QIrPjVRj9ZmauaP8mAYv71g8hsE
	3QMzegB7UKaKqwumvOZOaDFo0f6TuM4MU0gZNbMbvOMfJIzadMwc/xfV3DHXpHDa
	h+5MDDWBOceol81rLNRol5BL+tHd4nea8RbUgUyNX0OFUhnytOW5H08r1VK1vEqP
	w4YWTQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes05db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4HhW3006614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:43 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:38 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 09/12] crypto: qce - Add LOCK and UNLOCK flag support
Date: Thu, 12 Dec 2024 09:46:36 +0530
Message-ID: <20241212041639.4109039-10-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: YHkwYqHN_BqPrNHeQVv3rkeogp9Lfuek
X-Proofpoint-ORIG-GUID: YHkwYqHN_BqPrNHeQVv3rkeogp9Lfuek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120027

Add LOCK and UNLOCK flag support while preapring
command descriptor for writing crypto register.

added qce_bam_acquire_lock() and qce_bam_release_lock()
which will do dummy write to a crypto register for
acquiring lock and releaseing lock.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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
 drivers/crypto/qce/core.h   |  2 ++
 drivers/crypto/qce/dma.c    |  7 ++++++-
 drivers/crypto/qce/dma.h    |  2 ++
 4 files changed, 45 insertions(+), 1 deletion(-)

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
index bf28dedd1509..d01d810b60ad 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -68,4 +68,6 @@ int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
 void qce_clear_bam_transaction(struct qce_device *qce);
 int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
 struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
+int qce_bam_acquire_lock(struct qce_device *qce);
+int qce_bam_release_lock(struct qce_device *qce);
 #endif /* _CORE_H_ */
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index e4e672d65302..93d455d1d5b4 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -72,7 +72,12 @@ int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
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
 	 * it recomended as per HPG
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index f10991590b3f..ad8a18a720b1 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -19,6 +19,8 @@
 #define QCE_BAM_CMD_ELEMENT_SIZE       64
 #define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
 #define QCE_MAX_REG_READ               8
+#define QCE_DMA_DESC_FLAG_LOCK          (0x0002)
+#define QCE_DMA_DESC_FLAG_UNLOCK        (0x0001)
 
 struct qce_result_dump {
 	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
-- 
2.34.1


