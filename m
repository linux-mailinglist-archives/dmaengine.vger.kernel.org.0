Return-Path: <dmaengine+bounces-2869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D2952BA4
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21960B20EBF
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71901D417E;
	Thu, 15 Aug 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dIGNq3H6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68351D0DD8;
	Thu, 15 Aug 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712281; cv=none; b=Prr0yGhbpgNbapaXOx0udeyp7K+S8ZzosIpO2l95dgfwpfbXOjuvlwPJiSpXY2eGvGBbuO0le0bXpJs/kgHq7mHrHY4kN3nQgetZUDn9Ulb9XLmAzec1FWfowDC/l8bnoOWIKwes0RzUPKZmQz4pQU23fFIGXV/REm1S3l0mHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712281; c=relaxed/simple;
	bh=8DzmmDgvzMOMxgsJ4h1uWZjqNzmY5kKbeqoW2QUeu6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTioBjy4Fx/ZiFClTsC0PcBmegYmiuCl2sDV4vPp6d4l2AZ9DNuo2FJOqasOBr0CO1TSdBehZLX/tU4OR+N86cxPykxG2rgWirdM1aIbQzu0+d3LXlxMxgo/hP6zzk3e0nyk896CIodd8Mc7BKK6ULOlzjGmWurisQ7xgFKuSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dIGNq3H6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F2iSLC026519;
	Thu, 15 Aug 2024 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ddo6MkkNLKO
	N5R8ZiswcZUBiw16m2NhV1gLIOeCd1ec=; b=dIGNq3H6wR94KkSwzVk1UfVALQj
	vL0qtGDnBTx02viG8YsHFQ+8K3/rUVK7rT7j9TGW+v+wsbUOHU9TLsC9uTD2uGKS
	7PiWoJr3oDFjkLO6Hf5bjlQbhqpCeFcgh7+kyQ+rLuqtXTzcLt7/jzFwEP4bqdHb
	7UiA2qkqsX/9ikF2BwpTKU/IvldU9hrbjrTIW+IrRa55C38BPBL6Nfu9bjNh2mh4
	eaHkAovXq6VsKXdGZ0UH95FChe5fUrOG+IW6VRzHlvf9HS0XIiKbl+2atAIz/Lzm
	3X3YgjSTEAydI2zEWrF3t0lVmGyjImovplEiKZZ8ABc797NsNla7mRLoP+g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411957rpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8vURF029769;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhennm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8tC76027521;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vTQq029696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:29 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id AF736417F8; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 10/16] crypto: qce - Add support for lock aquire,lock release api.
Date: Thu, 15 Aug 2024 14:27:19 +0530
Message-Id: <20240815085725.2740390-11-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: aEbxav2zSqw_lQbPUAIT3L4L-aZrDzsX
X-Proofpoint-ORIG-GUID: aEbxav2zSqw_lQbPUAIT3L4L-aZrDzsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150064

Add support for lock acquire and lock release api.
When multiple EE's(Execution Environment) want to access
CE5 then there will be race condition b/w multiple EE's.

Since each EE's having their dedicated BAM pipe, BAM allows
Locking and Unlocking on BAM pipe. So if one EE's requesting
for CE5 access then that EE's first has to LOCK the BAM pipe
while setting LOCK bit on command descriptor and then access
it. After finishing the request EE's has to UNLOCK the BAM pipe
so in this way we race condition will not happen.

Added these two API qce_bam_acquire_lock() and qce_bam_release_lock()
for the same.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* No chnage

Change in [v1]

* Added initial support for lock_acquire and lock_release
  api.

 drivers/crypto/qce/common.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/core.h   |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index ff96f6ba1fc5..a8eaffe41101 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -617,3 +617,39 @@ void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step)
 	*minor = (val & CORE_MINOR_REV_MASK) >> CORE_MINOR_REV_SHIFT;
 	*step = (val & CORE_STEP_REV_MASK) >> CORE_STEP_REV_SHIFT;
 }
+
+int qce_bam_acquire_lock(struct qce_device *qce)
+{
+	int ret;
+
+	qce_clear_bam_transaction(qce);
+
+	/* This is just a dummy write to acquire lock on bam pipe */
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
+
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
-- 
2.34.1


