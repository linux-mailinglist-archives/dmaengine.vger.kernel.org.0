Return-Path: <dmaengine+bounces-4121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840EA11F99
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A82E161763
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C92242258;
	Wed, 15 Jan 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NmoaClgj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C729244F9F;
	Wed, 15 Jan 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937068; cv=none; b=InrU4HEvle10TMW3tLXBZgzX69Rhy2t7bau7P5p7TSoOB5WhoiCfSGAHJ/cRcXQzJB1nINkzloyl1jn3ED1Ul1vkGN97jWBLfGbzSUPvFhB+95+coO3XOqQtktWchAzUtup1FrJdBrJjHuC7S+jeLRcxLaBcI1hPiZd4S7PEeJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937068; c=relaxed/simple;
	bh=sO9D8fvsiEu32zhNDjC1c1/XLKfISrFoGnJ1V20zA4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1vidP6dl5dM82hzVZZCX1zgw8ugo6cbJsSZajbtL2gB0aivxOrAeOPI5rJERkMDukVDCzbwXkF2c3kxEkfn3urWZVLczmjWKdmylxydGiTiZY11lELJXCF0Vir8CI5/5yT1xGckdzBKujaeMdKZxFPbeBmSk6nokn5tl3cq/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NmoaClgj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F9cehK017830;
	Wed, 15 Jan 2025 10:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FkLi5JNXfYMDVu7rBMqAOhhklXoZcJk+axtzCHGxj+s=; b=NmoaClgjIcoUzVQg
	biTlGduHbwWGp1ci8vj6pXZG2VNGYKL1EpeiKtIB8nl9kpFbPa6ZzIJB/rYW7aMB
	KfUZqzIRFdQyJnKiRHPbpxbkdkEXBWjJqOcON1kQfWNzqeCeFFDUthov7krFSB/x
	QgjK082w5MofpnjkdRTAdb30u1WFedZC9USgiXOE70wJbidrr/MCBsrLJYWkndHb
	DEsOzMRedDwoI4q41Ljsc7Z4ckJRr22rgY5pU4inAc4z55T0O+Yl92kA+3EfVBAf
	oMjOf5kIJ2jzogSv8P+quqDUnQWcmgPDHu/wtiu/bbJ1q4c0PD2is1oCGnYZgnf5
	jVUxhQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446ajn041h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAUt3E006651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:55 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:30:50 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 05/12] crypto: qce - Add bam dma support for crypto register r/w
Date: Wed, 15 Jan 2025 15:59:57 +0530
Message-ID: <20250115103004.3350561-6-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: suChfvPP-RfBo6slCguLU0Cz1UW3H-tk
X-Proofpoint-ORIG-GUID: suChfvPP-RfBo6slCguLU0Cz1UW3H-tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Add BAM/DMA support for crypto register read/write.
With this change multiple crypto register will get
Written/Read using bam in one go.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* No Change

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

 drivers/crypto/qce/core.h |  10 ++
 drivers/crypto/qce/dma.c  | 226 ++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h  |  24 ++++
 3 files changed, 260 insertions(+)

diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 0b6350b6076e..4559232bdf71 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -43,6 +43,8 @@ struct qce_device {
 	int burst_size;
 	unsigned int pipe_pair_id;
 	dma_addr_t base_dma;
+	__le32 *reg_read_buf;
+	dma_addr_t reg_buf_phys;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
@@ -62,4 +64,12 @@ struct qce_algo_ops {
 	int (*async_req_handle)(struct crypto_async_request *async_req);
 };
 
+int qce_write_reg_dma(struct qce_device *qce, unsigned int offset, u32 val,
+		      int cnt);
+int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
+		     int cnt);
+void qce_clear_bam_transaction(struct qce_device *qce);
+int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
+struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
+
 #endif /* _CORE_H_ */
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 1dec7aea852d..225ac5619249 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -5,21 +5,233 @@
 
 #include <linux/device.h>
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
+	 * it recommended as per HPG
+	 */
+
+	if (qce_bam_txn->qce_read_sgl_cnt) {
+		ret = qce_dma_prep_cmd_sg(qce, chan, qce_bam_txn->qce_reg_read_sgl,
+					  qce_bam_txn->qce_read_sgl_cnt,
+					  desc_flags, DMA_DEV_TO_MEM,
+					  NULL, NULL);
+		if (ret) {
+			pr_err("error while submitting cmd desc for rx\n");
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
+		pr_err("error while submitting cmd desc for tx\n");
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
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
+	struct qce_device *qce = container_of(dma,
+			struct qce_device, dma);
 
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
+
 }
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 {
+	struct qce_device *qce = container_of(dma, struct qce_device, dma);
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
@@ -41,6 +253,20 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
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
 	return devm_add_action_or_reset(dev, qce_dma_release, dma);
 
 error_nomem:
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e..2ec04e3df4ba 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -7,6 +7,7 @@
 #define _DMA_H_
 
 #include <linux/dmaengine.h>
+#include <linux/dma/qcom_bam_dma.h>
 
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
@@ -14,6 +15,11 @@
 #define QCE_AUTHIV_REGS_CNT		16
 #define QCE_AUTH_BYTECOUNT_REGS_CNT	4
 #define QCE_CNTRIV_REGS_CNT		4
+#define QCE_BAM_CMD_SGL_SIZE           64
+#define QCE_BAM_CMD_ELEMENT_SIZE       64
+#define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
+#define QCE_MAX_REG_READ               8
+
 
 struct qce_result_dump {
 	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
@@ -27,13 +33,30 @@ struct qce_result_dump {
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
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
@@ -44,4 +67,5 @@ struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
 
+void qce_dma_issue_cmd_desc_pending(struct qce_dma_data *dma, bool read);
 #endif /* _DMA_H_ */
-- 
2.34.1


