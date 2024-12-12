Return-Path: <dmaengine+bounces-3953-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373C9EDE36
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABE91888D0D
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA855185B72;
	Thu, 12 Dec 2024 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mJULLp+h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD815AAC1;
	Thu, 12 Dec 2024 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977054; cv=none; b=YSg2UTwdPk7oK+yNexL9kTHFjhVu7x34QljWX5Gx11inBp3wwQ5+g8pKNnD8aiHTXwOB7jSeUugBSTszfbXee0B2WE/Ee71l29kj8/HSjcbDq6BkDz86di22ZpC00Hw/JTD20yhr2MSEt19q5FNF5ly5fgp5o87/pSUwAQsaxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977054; c=relaxed/simple;
	bh=jiuwOtA29OZDQmTmUWQafx1CcsdwXpmoliIkiQQwSNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4I0jNf8yLhEDtDS5rKBmFc41YQZwHK7IYfpTlix8ChbBAc/7BAY6oMfC3V/u3YtHSqkJzhNRFkVww6E4QcHgZBuysVrQhmXLBZ+aWWHWeUK/jXd2bSlk7IFFs/dUGmOyxj4f6QQ9j549HYp0J89xbOaeCz61+c8UKpJjSOsp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mJULLp+h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHD33F032186;
	Thu, 12 Dec 2024 04:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eg62PpWxa12kuq6q421H7vY7fjMaNp4w3uu0gMxOjYY=; b=mJULLp+h/D/CO1Zp
	recv8/i+YEGrLx1Lu/fOu6I46GeasvBdjuXFfiPfiVJKCqUz9yes4LOO+m7oj69d
	6za8x9pHb7kiI7zyZHoojIPVfetYqDavKOfbYSEHt4nTEiyhTIHTd+cHugjyXAx8
	TGV/qVv3/eDO5CbWk4x4aRY8LbuCEX1xpPZLhOVl60D943vzE8tzafmbPzr9s2F0
	mETo1/yEYmLVSC6Ozn3GTDH0FXi4ij9VB6o8eOxktHnn+Cns3WILmqmtGvoqR01C
	vpyBVJDN8Z+d0oRUr/zPtClBCxnQMs+HW0cr+an1hQBZbwrdU2ghTr2L7cVpRW4W
	03PMkw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfaxba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4HNxH006047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:23 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:18 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 05/12] crypto: qce - Add bam dma support for crypto register r/w
Date: Thu, 12 Dec 2024 09:46:32 +0530
Message-ID: <20241212041639.4109039-6-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: z5k2VsbseAbzpuc3P5_f6yWuPkCqZ4Pd
X-Proofpoint-ORIG-GUID: z5k2VsbseAbzpuc3P5_f6yWuPkCqZ4Pd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120028

Add BAM/DMA support for crypto register read/write.
With this change multiple crypto register will get
Written/Read using bam in one go.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v5]

* No Change

Change in [v4]

* No change 
 
Change in [v3]

* Fixed alignment issue

* Removed type casting in qce_read_reg_dma()
  and qce_write_reg_dma()

Change in [v2]

* Added initial support for bam api for
  register read/write

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/core.h |   9 ++
 drivers/crypto/qce/dma.c  | 227 ++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h  |  24 +++-
 3 files changed, 259 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 25e2af45c047..bf28dedd1509 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -40,6 +40,8 @@ struct qce_device {
 	int burst_size;
 	unsigned int pipe_pair_id;
 	dma_addr_t base_dma;
+	__le32 *reg_read_buf;
+	dma_addr_t reg_buf_phys;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
@@ -59,4 +61,11 @@ struct qce_algo_ops {
 	int (*async_req_handle)(struct crypto_async_request *async_req);
 };
 
+int qce_write_reg_dma(struct qce_device *qce, unsigned int offset, u32 val,
+		      int cnt);
+int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
+		     int cnt);
+void qce_clear_bam_transaction(struct qce_device *qce);
+int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
+struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
 #endif /* _CORE_H_ */
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 46db5bf366b4..e4e672d65302 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -4,12 +4,214 @@
  */
 
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
+#define QCE_REG_BUF_DMA_ADDR(qce, vaddr) \
+	((qce)->reg_buf_phys + \
+	 ((uint8_t *)(vaddr) - (uint8_t *)(qce)->reg_read_buf))
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
+
+	memset(&qce_bam_txn->qce_bam_ce_index, 0, sizeof(u32) * 8);
+}
+
+static int qce_dma_prep_cmd_sg(struct qce_device *qce, struct dma_chan *chan,
+			       struct scatterlist *qce_bam_sgl,
+			       int qce_sgl_cnt, unsigned long flags,
+			       enum dma_transfer_direction dir_eng,
+			       dma_async_tx_callback cb, void *cb_param)
+{
+	struct dma_async_tx_descriptor *dma_desc;
+	struct qce_desc_info *desc;
+	dma_cookie_t cookie;
+
+	desc = qce->dma.qce_bam_txn->qce_desc;
+
+	if (dir_eng == DMA_MEM_TO_DEV)
+		desc->dir = DMA_TO_DEVICE;
+	if (dir_eng == DMA_DEV_TO_MEM)
+		desc->dir = DMA_FROM_DEVICE;
+
+	if (!qce_bam_sgl || !qce_sgl_cnt)
+		return -EINVAL;
+
+	if (!dma_map_sg(qce->dev, qce_bam_sgl,
+			qce_sgl_cnt, desc->dir)) {
+		dev_err(qce->dev, "failure in mapping sgl for cmd desc\n");
+		return -ENOMEM;
+	}
+
+	dma_desc = dmaengine_prep_slave_sg(chan, qce_bam_sgl, qce_sgl_cnt,
+					   dir_eng, flags);
+	if (!dma_desc) {
+		pr_err("%s:failure in prep cmd desc\n", __func__);
+		dma_unmap_sg(qce->dev, qce_bam_sgl, qce_sgl_cnt, desc->dir);
+		kfree(desc);
+		return -EINVAL;
+	}
+
+	desc->dma_desc = dma_desc;
+	desc->dma_desc->callback = cb;
+	desc->dma_desc->callback_param = cb_param;
+
+	cookie = dmaengine_submit(desc->dma_desc);
+
+	return dma_submit_error(cookie);
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
+{
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
+	struct dma_chan *chan = qce->dma.rxchan;
+	unsigned long desc_flags;
+	int ret = 0;
+
+	desc_flags = DMA_PREP_CMD;
+
+	/* For command descriptor always use consumer pipe
+	 * it recomended as per HPG
+	 */
+
+	if (qce_bam_txn->qce_read_sgl_cnt) {
+		ret = qce_dma_prep_cmd_sg(qce, chan, qce_bam_txn->qce_reg_read_sgl,
+					  qce_bam_txn->qce_read_sgl_cnt,
+					  desc_flags, DMA_DEV_TO_MEM,
+					  NULL, NULL);
+		if (ret) {
+			pr_err("error while submiting cmd desc for rx\n");
+			return ret;
+		}
+	}
+
+	if (qce_bam_txn->qce_write_sgl_cnt) {
+		ret = qce_dma_prep_cmd_sg(qce, chan, qce_bam_txn->qce_reg_write_sgl,
+					  qce_bam_txn->qce_write_sgl_cnt,
+					  desc_flags, DMA_MEM_TO_DEV,
+					  NULL, NULL);
+	}
+
+	if (ret) {
+		pr_err("error while submiting cmd desc for tx\n");
+		return ret;
+	}
+
+	qce_dma_issue_pending(&qce->dma);
+
+	if (qce_bam_txn->qce_read_sgl_cnt)
+		dma_unmap_sg(qce->dev, qce_bam_txn->qce_reg_read_sgl,
+			     qce_bam_txn->qce_read_sgl_cnt,
+			     DMA_FROM_DEVICE);
+	if (qce_bam_txn->qce_write_sgl_cnt)
+		dma_unmap_sg(qce->dev, qce_bam_txn->qce_reg_write_sgl,
+			     qce_bam_txn->qce_write_sgl_cnt,
+			     DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static void qce_prep_dma_command_desc(struct qce_device *qce, struct qce_dma_data *dma,
+				      bool read, unsigned int addr, void *buff, int size)
+{
+	struct qce_bam_transaction *qce_bam_txn = dma->qce_bam_txn;
+	struct bam_cmd_element *qce_bam_ce_buffer;
+	int qce_bam_ce_size, cnt, index;
+
+	index = qce_bam_txn->qce_bam_ce_index;
+	qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce[index];
+	if (read)
+		bam_prep_ce(qce_bam_ce_buffer, addr, BAM_READ_COMMAND,
+			    QCE_REG_BUF_DMA_ADDR(qce,
+						 (unsigned int *)buff));
+	else
+		bam_prep_ce_le32(qce_bam_ce_buffer, addr, BAM_WRITE_COMMAND,
+				 *((__le32 *)buff));
+
+	if (read) {
+		cnt = qce_bam_txn->qce_read_sgl_cnt;
+		qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce
+			[qce_bam_txn->qce_pre_bam_ce_index];
+		qce_bam_txn->qce_bam_ce_index += size;
+		qce_bam_ce_size = (qce_bam_txn->qce_bam_ce_index -
+				qce_bam_txn->qce_pre_bam_ce_index) *
+			sizeof(struct bam_cmd_element);
+
+		sg_set_buf(&qce_bam_txn->qce_reg_read_sgl[cnt],
+			   qce_bam_ce_buffer,
+				qce_bam_ce_size);
+
+		++qce_bam_txn->qce_read_sgl_cnt;
+		qce_bam_txn->qce_pre_bam_ce_index =
+					qce_bam_txn->qce_bam_ce_index;
+	} else {
+		cnt = qce_bam_txn->qce_write_sgl_cnt;
+		qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce
+			[qce_bam_txn->qce_pre_bam_ce_index];
+		qce_bam_txn->qce_bam_ce_index += size;
+		qce_bam_ce_size = (qce_bam_txn->qce_bam_ce_index -
+				qce_bam_txn->qce_pre_bam_ce_index) *
+			sizeof(struct bam_cmd_element);
+
+		sg_set_buf(&qce_bam_txn->qce_reg_write_sgl[cnt],
+			   qce_bam_ce_buffer,
+				qce_bam_ce_size);
+
+		++qce_bam_txn->qce_write_sgl_cnt;
+		qce_bam_txn->qce_pre_bam_ce_index =
+					qce_bam_txn->qce_bam_ce_index;
+	}
+}
+
+int qce_write_reg_dma(struct qce_device *qce,
+		      unsigned int offset, u32 val, int cnt)
+{
+	qce_prep_dma_command_desc(qce, &qce->dma, false, (qce->base_dma + offset),
+				  &val, cnt);
+	return 0;
+}
+
+int qce_read_reg_dma(struct qce_device *qce,
+		     unsigned int offset, void *buff, int cnt)
+{
+	qce_prep_dma_command_desc(qce, &qce->dma, true, (qce->base_dma + offset),
+				  qce->reg_read_buf, cnt);
+	memcpy(buff, qce->reg_read_buf, 4);
+
+	return 0;
+}
+
+struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma)
+{
+	struct qce_bam_transaction *qce_bam_txn;
+
+	dma->qce_bam_txn = kmalloc(sizeof(*qce_bam_txn), GFP_KERNEL);
+	if (!dma->qce_bam_txn)
+		return NULL;
+
+	dma->qce_bam_txn->qce_desc = kzalloc(sizeof(*dma->qce_bam_txn->qce_desc),
+					     GFP_KERNEL);
+	if (!dma->qce_bam_txn->qce_desc) {
+		kfree(dma->qce_bam_txn);
+		return NULL;
+	}
+
+	sg_init_table(dma->qce_bam_txn->qce_reg_write_sgl,
+		      QCE_BAM_CMD_SGL_SIZE);
+
+	sg_init_table(dma->qce_bam_txn->qce_reg_read_sgl,
+		      QCE_BAM_CMD_SGL_SIZE);
+
+	return dma->qce_bam_txn;
+}
+
 int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 {
+	struct qce_device *qce = container_of(dma, struct qce_device, dma);
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
@@ -31,7 +233,22 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
 
+	dma->qce_bam_txn = qce_alloc_bam_txn(dma);
+	if (!dma->qce_bam_txn) {
+		pr_err("Failed to allocate bam transaction\n");
+		return -ENOMEM;
+	}
+
+	qce->reg_read_buf = dmam_alloc_coherent(qce->dev, QCE_MAX_REG_READ *
+						sizeof(*qce->reg_read_buf),
+						&qce->reg_buf_phys, GFP_KERNEL);
+	if (!qce->reg_read_buf) {
+		pr_err("Failed to allocate reg_read_buf\n");
+		return -ENOMEM;
+	}
+
 	return 0;
+
 error_nomem:
 	dma_release_channel(dma->rxchan);
 error_rx:
@@ -41,9 +258,19 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 void qce_dma_release(struct qce_dma_data *dma)
 {
+	struct qce_device *qce = container_of(dma,
+			struct qce_device, dma);
+
 	dma_release_channel(dma->txchan);
 	dma_release_channel(dma->rxchan);
 	kfree(dma->result_buf);
+	if (qce->reg_read_buf)
+		dmam_free_coherent(qce->dev, QCE_MAX_REG_READ *
+				   sizeof(*qce->reg_read_buf),
+				   qce->reg_read_buf,
+				   qce->reg_buf_phys);
+	kfree(dma->qce_bam_txn->qce_desc);
+	kfree(dma->qce_bam_txn);
 }
 
 struct scatterlist *
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 786402169360..f10991590b3f 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -7,6 +7,7 @@
 #define _DMA_H_
 
 #include <linux/dmaengine.h>
+#include <linux/dma/qcom_bam_dma.h>
 
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
@@ -14,6 +15,10 @@
 #define QCE_AUTHIV_REGS_CNT		16
 #define QCE_AUTH_BYTECOUNT_REGS_CNT	4
 #define QCE_CNTRIV_REGS_CNT		4
+#define QCE_BAM_CMD_SGL_SIZE           64
+#define QCE_BAM_CMD_ELEMENT_SIZE       64
+#define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
+#define QCE_MAX_REG_READ               8
 
 struct qce_result_dump {
 	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
@@ -27,13 +32,30 @@ struct qce_result_dump {
 #define QCE_RESULT_BUF_SZ	\
 		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
 
+struct qce_bam_transaction {
+	struct bam_cmd_element qce_bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];
+	struct scatterlist qce_reg_write_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct scatterlist qce_reg_read_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct qce_desc_info *qce_desc;
+	u32 qce_bam_ce_index;
+	u32 qce_pre_bam_ce_index;
+	u32 qce_write_sgl_cnt;
+	u32 qce_read_sgl_cnt;
+};
+
 struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
+	struct qce_bam_transaction *qce_bam_txn;
 	void *ignore_buf;
 };
 
+struct qce_desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_data_direction dir;
+};
+
 int qce_dma_request(struct device *dev, struct qce_dma_data *dma);
 void qce_dma_release(struct qce_dma_data *dma);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
@@ -44,5 +66,5 @@ int qce_dma_terminate_all(struct qce_dma_data *dma);
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
-
+void qce_dma_issue_cmd_desc_pending(struct qce_dma_data *dma, bool read);
 #endif /* _DMA_H_ */
-- 
2.34.1


