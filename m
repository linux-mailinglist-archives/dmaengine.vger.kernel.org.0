Return-Path: <dmaengine+bounces-3103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2656971371
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0B31C226B6
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE8B1B253B;
	Mon,  9 Sep 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FuKdlf/7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6241B1D4E;
	Mon,  9 Sep 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874051; cv=none; b=tSKQEsIZ3YY/75CpfZukqKVVL2yFKdcIkhrQ+EnCt+j/4A8aKPaXxQ1UKh431fLpo7JIe5h4qwLcVQCFxeLeQS2fSlokN7MtSyWzdOIzUHYGWOpA6oFzznI7FHuLpQaA4tkDb/64GMt8g8hwJrd/EAXTeabCLHKL7/kYT05obZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874051; c=relaxed/simple;
	bh=2FOrRs+Obp+laL7MNhOLn/LOybHVWAb1znEuF3w3b+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J01ic8kFuzlZ8mtGUcjJRXHbHXTSgaFun2AT6vmABZfZESpU0JjWoZtC2KmXe6+moZXyS6ompowxPw7KDPjdhgzIpnQ+Yx7oM1dZPq+679YQH1DpwTVQRwP5oTGxqZ6Cmxa7ZZfWW8fjLJAcnyhqIVQO1fuG2q67PJeYaohvkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FuKdlf/7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JokX026347;
	Mon, 9 Sep 2024 09:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	StcCFfw3j6a2oYSlduMwJl1z6r6WRQsHPnStzKci6aw=; b=FuKdlf/7VybdrLV3
	+nPu1AzCilXUjwOArSpvuXKTsSovSSqHofp4nE6C99oo9oG3UZOwOsHVrvegM+TR
	CHqrO/LJILhlpLjDtS1NKobrbsUBBASQTPRFe0YIEuI4OKkafb49EwXX/EEiiVnu
	jPTQaHYrlw1RQ0Ec6Un+1cpGuLM0HoJhUwoAjbQVfds/FzhPlQqA644vCf3VPvGO
	JguLB1oTTCk4+c6RnoLeta7WxVMKyhCl8FucCoJnmCS+dLMAItD0NVJs6hF3nof9
	dy+9Nih+VHRYRopyoEa3dno7a38qV4ww2TYP/9JQOCENeRmtMgh9WoFOj2M9sQxZ
	Tmd2dg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5dshdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899RK56002807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:20 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:15 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 02/11] dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag support
Date: Mon, 9 Sep 2024 14:56:23 +0530
Message-ID: <20240909092632.2776160-3-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TzvIPbOpt_S89LUvXp6DBHaQSgf_8Gwo
X-Proofpoint-GUID: TzvIPbOpt_S89LUvXp6DBHaQSgf_8Gwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090074

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
feature. So adding check for the same and setting bam_pipe_lock
based on BAM SW Version.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* Added BAM_SW_VERSION read for major & minor
  version

* Added bam_pipe_lock flag 

Change in [v3]

* Moved lock/unlock bit set inside loop

Change in [v2]

* No change
 
Change in [v1]

* Added initial support for BAM pipe lock/unlock

 drivers/dma/qcom/bam_dma.c | 25 ++++++++++++++++++++++++-
 include/linux/dmaengine.h  |  6 ++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 3a2965939531..d30416a26d8e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -53,11 +53,20 @@ struct bam_desc_hw {
 
 #define BAM_DMA_AUTOSUSPEND_DELAY 100
 
+#define SW_VERSION_MAJOR_SHIFT	28
+#define SW_VERSION_MINOR_SHIFT	16
+#define SW_VERSION_MAJOR_MASK	(0xf << SW_VERSION_MAJOR_SHIFT)
+#define SW_VERSION_MINOR_MASK	0xf
+#define SW_MAJOR_1	0x1
+#define SW_VERSION_4	0x4
+
 #define DESC_FLAG_INT BIT(15)
 #define DESC_FLAG_EOT BIT(14)
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_LOCK BIT(10)
+#define DESC_FLAG_UNLOCK BIT(9)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -393,6 +402,7 @@ struct bam_device {
 	u32 ee;
 	bool controlled_remotely;
 	bool powered_remotely;
+	bool bam_pipe_lock;
 	u32 active_channels;
 	u32 bam_sw_version;
 
@@ -696,9 +706,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		unsigned int curr_offset = 0;
 
 		do {
-			if (flags & DMA_PREP_CMD)
+			if (flags & DMA_PREP_CMD) {
 				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
 
+				if (bdev->bam_pipe_lock && flags & DMA_PREP_LOCK)
+					desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
+				else if (bdev->bam_pipe_lock && flags & DMA_PREP_UNLOCK)
+					desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
+			}
+
 			desc->addr = cpu_to_le32(sg_dma_address(sg) +
 						 curr_offset);
 
@@ -1242,6 +1258,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 {
 	struct bam_device *bdev;
 	const struct of_device_id *match;
+	u32 sw_major, sw_minor;
 	int ret, i;
 
 	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1305,6 +1322,12 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
 	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
+	sw_major = (bdev->bam_sw_version & SW_VERSION_MAJOR_MASK) >> SW_VERSION_MAJOR_SHIFT;
+	sw_minor = (bdev->bam_sw_version >> SW_VERSION_MINOR_SHIFT) & SW_VERSION_MINOR_MASK;
+
+	if (sw_major == SW_MAJOR_1 && sw_minor >= SW_VERSION_4)
+		bdev->bam_pipe_lock = true;
+
 
 	ret = bam_init(bdev);
 	if (ret)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b137fdb56093..70f23068bfdc 100644
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


