Return-Path: <dmaengine+bounces-524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46864812EEE
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9251C215AE
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0A4176C;
	Thu, 14 Dec 2023 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oKaDCRHu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E555116;
	Thu, 14 Dec 2023 03:42:57 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE7jAth000869;
	Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=zqxmqhO
	kW3xBad0olqFsFOy8DGPOAi52HW52FVOr2pA=; b=oKaDCRHu7jf9wKZNKrncHMA
	lqYIH8CGIWwdZU54bWu3FD2Aa1U/oGp2QKKXTLpyE+Wn7LovFvq+3ftWGyYmQY1J
	WDW1nrzsuC3gzeREoa8tLbT9U4f9+oFg8fQuKhUlnOk+2ausKgwCpGRKOEiLSH8Q
	9UTxU6h3nIMaW7dSYUPbZ3im3zoYvPkg763YRYXZs/X4CZTB2vrBMk0qfZdx16va
	42LRCNwUdIEnVZ4l/jVpuWosW/+mcBeFnTQzDWLT7XXp5j5BdkZhKNfHef4YbH9h
	L9u/O8pBn1/qdTCWzJaXetX1Ybge0jjQDOZF4DdwwmGGTXW8PZ02u4PIpHikvmw=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyqgt159v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBexrB001132;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktcge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBexxx001124;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBghfR002824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 879CC4160F; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 02/11] crypto: qce - Add bam dma support for crypto register r/w
Date: Thu, 14 Dec 2023 17:12:30 +0530
Message-Id: <20231214114239.2635325-3-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 2YlWYnL6coEgzJVeiuOll0GPgWe3jEFX
X-Proofpoint-ORIG-GUID: 2YlWYnL6coEgzJVeiuOll0GPgWe3jEFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080

Add BAM/DMA support for crypto register read/write.
With this change multiple crypto register will get
Written using bam in one go.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/core.h |   9 ++
 drivers/crypto/qce/dma.c  | 233 ++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h  |  24 +++-
 3 files changed, 265 insertions(+), 1 deletion(-)

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
index 46db5bf366b4..85c8d4107afa 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -4,12 +4,220 @@
  */
 
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <crypto/scatterwalk.h>
 
 #include "dma.h"
+#include "core.h"
+
+#define QCE_REG_BUF_DMA_ADDR(qce, vaddr) \
+	((qce)->reg_buf_phys + \
+	 ((uint8_t *)(vaddr) - (uint8_t *)(qce)->reg_read_buf))
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
+
+	qce_bam_txn->qce_bam_ce_index = 0;
+	qce_bam_txn->qce_write_sgl_cnt = 0;
+	qce_bam_txn->qce_read_sgl_cnt = 0;
+	qce_bam_txn->qce_bam_ce_index = 0;
+	qce_bam_txn->qce_pre_bam_ce_index = 0;
+}
+
+static int qce_dma_prep_cmd_sg(struct qce_device *qce, struct dma_chan *chan,
+			       struct scatterlist *qce_bam_sgl,
+				int qce_sgl_cnt, unsigned long flags,
+				enum dma_transfer_direction dir,
+				dma_async_tx_callback cb, void *cb_param)
+{
+	struct dma_async_tx_descriptor *dma_desc;
+	struct qce_desc_info *desc;
+	dma_cookie_t cookie;
+
+	desc = qce->dma.qce_bam_txn->qce_desc;
+
+	if (!qce_bam_sgl || !qce_sgl_cnt)
+		return -EINVAL;
+
+	if (!dma_map_sg(qce->dev, qce_bam_sgl,
+			qce_sgl_cnt, dir)) {
+		dev_err(qce->dev, "failure in mapping sgl for cmd desc\n");
+		return -ENOMEM;
+	}
+
+	dma_desc = dmaengine_prep_slave_sg(chan, qce_bam_sgl, qce_sgl_cnt,
+					   dir, flags);
+	if (!dma_desc) {
+		pr_err("%s:failure in prep cmd desc\n", __func__);
+		dma_unmap_sg(qce->dev, qce_bam_sgl, qce_sgl_cnt, dir);
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
+		ret = qce_dma_prep_cmd_sg(qce, chan,
+					  qce_bam_txn->qce_reg_read_sgl,
+					qce_bam_txn->qce_read_sgl_cnt,
+					desc_flags, DMA_DEV_TO_MEM,
+					NULL, NULL);
+		if (ret) {
+			pr_err("error while submiting cmd desc for rx\n");
+			return ret;
+		}
+	}
+
+	if (qce_bam_txn->qce_write_sgl_cnt) {
+		ret = qce_dma_prep_cmd_sg(qce, chan,
+					  qce_bam_txn->qce_reg_write_sgl,
+					qce_bam_txn->qce_write_sgl_cnt,
+					desc_flags, DMA_MEM_TO_DEV,
+					NULL, NULL);
+	}
+
+	if (ret) {
+		pr_err("error while submiting cmd desc for tx\n");
+		return ret;
+	}
+
+	qce_dma_issue_pending(&qce->dma);
+
+	return ret;
+}
+
+static void qce_prep_dma_command_desc(struct qce_device *qce,
+				      struct qce_dma_data *dma, bool read, unsigned int addr,
+		void *buff, int size)
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
+	void *buff;
+	unsigned int reg_addr;
+
+	buff = &val;
+
+	reg_addr = ((unsigned int)(qce->base_dma) + offset);
+	qce_prep_dma_command_desc(qce, &qce->dma, false, reg_addr, buff, cnt);
+
+	return 0;
+}
+
+int qce_read_reg_dma(struct qce_device *qce,
+		     unsigned int offset, void *buff, int cnt)
+{
+	void *vaddr;
+	unsigned int reg_addr;
+
+	reg_addr = ((unsigned int)(qce->base_dma) + offset);
+	vaddr = qce->reg_read_buf;
+
+	qce_prep_dma_command_desc(qce, &qce->dma, true, reg_addr, vaddr, cnt);
+	memcpy(buff, vaddr, 4);
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
+	dma->qce_bam_txn->qce_desc = kzalloc(sizeof(struct qce_desc_info),
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
+	qce_bam_txn = dma->qce_bam_txn;
+
+	return qce_bam_txn;
+}
 
 int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 {
+	struct qce_device *qce = container_of(dma, struct qce_device, dma);
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
@@ -31,6 +239,21 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
 
+	dma->qce_bam_txn = qce_alloc_bam_txn(dma);
+	if (!dma->qce_bam_txn) {
+		pr_err("Failed to allocate bam transaction\n");
+		return -ENOMEM;
+	}
+
+	qce->reg_read_buf = dmam_alloc_coherent(qce->dev,
+						QCE_MAX_REG_READ *
+				sizeof(*qce->reg_read_buf),
+				&qce->reg_buf_phys, GFP_KERNEL);
+	if (!qce->reg_read_buf) {
+		pr_err("Failed to allocate reg_read_buf\n");
+		return -ENOMEM;
+	}
+
 	return 0;
 error_nomem:
 	dma_release_channel(dma->rxchan);
@@ -41,9 +264,19 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
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
+				sizeof(*qce->reg_read_buf),
+				qce->reg_read_buf,
+				qce->reg_buf_phys);
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


