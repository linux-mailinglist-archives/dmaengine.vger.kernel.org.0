Return-Path: <dmaengine+bounces-4118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACDA11F88
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EFC7A47C5
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014AA242244;
	Wed, 15 Jan 2025 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EsKlA6aa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8D2442DC;
	Wed, 15 Jan 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937052; cv=none; b=BNJDQPG86IF7wr9hLWClMTsONZUdXtOkzmNE88MkINr6xzvJmrUc1/jrG9PK3MAtUyskIRuhbU3i+gWRjTQ3LGuTOvP5gzAMGDFMskgxhuzC/G+x5Muaf/PAbAg4YuEFnbBSiUZc8DstwU+c/VcxAmgKvoAQCibdvvaAZz3fKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937052; c=relaxed/simple;
	bh=8EuM1/pCqCRMSBxlZb/F0ckW7GRGzxcZMXwvbMxyQKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Foa2lEX3+c9hrRRjG4fy5d8JviXPOvy4rIVyQ/g25GpqrPGDhK7sA431afAXpfmiQiteZj3lRzr8W5/LmfoVxZZ8Aoj580PpRwKeuuHlPTvuVjjuZHzoMxl7Npj4FOVxaFOmPWy6DYgHnXa21+ECrznqDl1m5fCWP3Sv3Svo5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EsKlA6aa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F7Fu9p030727;
	Wed, 15 Jan 2025 10:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7OBGJuqWdgugNOFZpLahb/bK9LU9oT6sSBdaJNNx7Q=; b=EsKlA6aa2MhQE0KI
	njRxgTafZXRmaXBHcUJMzVjILFJRyzz7qPQEwjPk5P18ZNdANP+MGWoZeMXl27oj
	7QT9HJpOOEEbDyNK6Q/Mu74af8bYFTg3yOpI3TFS0ITKk4nTs1i4zJm6CqS/OSHN
	NON8KnZyug20cMPO7il8sfmnB9VR42ouXzwEddUSl2Hl/RvT3dCRDdJmS8PWkG/D
	SUgN4QbQITSdphqFEGLZjlH1Hn29c7EoBfEGjAlQDyW9yTVIzRLvewR2ED0/7uNg
	gizWQLfFxO4aZ7Kwy5MZYIyvdrYtLiBdfuQLvkX89pCv/M5hDlSQw7hcZEthwkKl
	2Brh4w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4468fs0ffw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAUdbu018856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:39 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:30:34 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 02/12] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK flag
Date: Wed, 15 Jan 2025 15:59:54 +0530
Message-ID: <20250115103004.3350561-3-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: M4HOvBJkknH4XR3K35wi1vz_bxXL15C5
X-Proofpoint-ORIG-GUID: M4HOvBJkknH4XR3K35wi1vz_bxXL15C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Add lock and unlock flag support on command descriptor.
Once lock set in requester pipe, then the bam controller
will lock all others pipe and process the request only
from requester pipe. Unlocking only can be performed from
the same pipe.

If DMA_PREP_LOCK flag passed in command descriptor then requester
of this transaction wanted to lock the BAM controller for this
transaction so BAM driver should set LOCK bit for the HW descriptor.

If DMA_PREP_UNLOCK flag passed in command descriptor then requester
of this transaction wanted to unlock the BAM controller.so BAM driver
should set UNLOCK bit for the HW descriptor.

BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
feature.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* Change "BAM" to "DAM"

Change in [v5]

* Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support

Change in [v4]

* This patch was not included in v4

Change in [v3]

* This patch was not included in v3

Change in [v2]

* This patch was not included in v2
 
Change in [v1]

* This patch was not included in v1

 Documentation/driver-api/dmaengine/provider.rst | 15 +++++++++++++++
 include/linux/dmaengine.h                       |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 3085f8b460fa..a032e55d0a4f 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -628,6 +628,21 @@ DMA_CTRL_REUSE
   - This flag is only supported if the channel reports the DMA_LOAD_EOT
     capability.
 
+- DMA_PREP_LOCK
+
+  - If set, the DMA will lock all other pipes not related to the current
+    pipe group, and keep handling the current pipe only.
+
+  - All pipes not within this group will be locked by this pipe upon lock
+    event.
+
+  - only pipes which are in the same group and relate to the same Environment
+    Execution(EE) will not be locked by a certain pipe.
+
+- DMA_PREP_UNLOCK
+
+  - If set, DMA will release all locked pipes
+
 General Design Notes
 ====================
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 346251bf1026..8ebd43a998a7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -200,6 +200,10 @@ struct dma_vec {
  *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
  *  to never be processed and stay in the issued queue forever. The flag is
  *  ignored if the previous transaction is not a repeated transaction.
+ *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
+ *  descriptor.
+ *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
+ *  descriptor.
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -212,6 +216,8 @@ enum dma_ctrl_flags {
 	DMA_PREP_CMD = (1 << 7),
 	DMA_PREP_REPEAT = (1 << 8),
 	DMA_PREP_LOAD_EOT = (1 << 9),
+	DMA_PREP_LOCK = (1 << 10),
+	DMA_PREP_UNLOCK = (1 << 11),
 };
 
 /**
-- 
2.34.1


