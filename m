Return-Path: <dmaengine+bounces-523-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCD812EEB
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EB81C20B91
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9D41237;
	Thu, 14 Dec 2023 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rb0G1WOH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD9113;
	Thu, 14 Dec 2023 03:42:57 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8vLAZ014002;
	Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=wFSa4Xb
	hxhY/eUFYQapfTu49LcidIL4qfDML5fBRy48=; b=Rb0G1WOHvRZOvOIQ3cti9Tg
	1sFPayY1LExNQUEVdcacA94O8rv9SP5myUlFUVIAeu3M1qTBvG54uBnngkSJWWpq
	Y9zNURoGiCVkHy8vxDYhkwv/XDBgwcuZU+5r/Lxrd0uN0QyVv5A4ilI7kRuem59m
	JbH56gLtCJWqwUTfFaAjTpyCZ3Qg/MF0i4DEORMDZ75wkMxwpIxoy8Y1Za6M1s1L
	62o8oLyZCWCO3gd4aQW7iwl/AV2Bwr2qw12/0X8MBge5pwkOHFq/WUauIACZwRoo
	jIQ649S364hg5T3dPIKlAYwAKDCpjiRAzqX43+Bbvt5xH9XCjbxsUg8Kcy2W3BQ=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyqgt159w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgiLV003250;
	Thu, 14 Dec 2023 11:42:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktchd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgh1C002935;
	Thu, 14 Dec 2023 11:42:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBgic6003206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 9BB7141673; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 08/11] crypto: qce - Add support for lock aquire,lock release api.
Date: Thu, 14 Dec 2023 17:12:36 +0530
Message-Id: <20231214114239.2635325-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: HTiBrGur5d00_fZ2R78aNte1E_sUWF1t
X-Proofpoint-ORIG-GUID: HTiBrGur5d00_fZ2R78aNte1E_sUWF1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080

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
 drivers/crypto/qce/common.c | 38 +++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/core.h   |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index ff96f6ba1fc5..d3b461331b24 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -617,3 +617,41 @@ void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step)
 	*minor = (val & CORE_MINOR_REV_MASK) >> CORE_MINOR_REV_SHIFT;
 	*step = (val & CORE_STEP_REV_MASK) >> CORE_STEP_REV_SHIFT;
 }
+
+int qce_bam_acquire_lock(struct qce_device *qce)
+{
+	u32 val = 0;
+	int ret;
+
+	qce_clear_bam_transaction(qce);
+
+	/* This is just a dummy read to acquire lock bam pipe */
+	qce_read_reg_dma(qce, REG_STATUS2, &val, 1);
+
+	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_LOCK);
+	if (ret) {
+		dev_err(qce->dev, "Error in LOCK cmd descriptor\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int qce_bam_release_lock(struct qce_device *qce)
+{
+	u32 val = 0;
+	int ret;
+
+	qce_clear_bam_transaction(qce);
+
+	/* This just dummy read to release lock on bam pipe*/
+	qce_read_reg_dma(qce, REG_STATUS2, &val, 1);
+
+	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_UNLOCK);
+	if (ret) {
+		dev_err(qce->dev, "Error in LOCK cmd descriptor\n");
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


