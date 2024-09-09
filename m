Return-Path: <dmaengine+bounces-3105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846697137A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204D0283C43
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B31B375C;
	Mon,  9 Sep 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OxDcyNCi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEDA1B3B1A;
	Mon,  9 Sep 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874061; cv=none; b=gZdeAhky/HG5mNv150/1it2v9yJHxZdzS6oNkvg7U+XsGEum3RRFDCNkPFVsAFMA24OHSebF24tvOco/XM9FFtJ+hpjIdRA9zhn6qJHw9TP2t4dw28md9bcMIpJ7uvpIV5aDRMIGWuAR5RvsPiKKEqw/I/LWUt610aXBlrFlOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874061; c=relaxed/simple;
	bh=bMT0Lf+IEVPb6101oZqnZxl6hVZSrPoKrNJ/7Cc5dUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYyS9hMXeiCRVajqrasFvsD0n2JrpFcWkX/LkqKlIV4IIjUR+drDOKclTV3uy58/0XODyoUpFFLxi+8tCVbpDZkfTiO8pT3r/a/oCH2PEUUVN8gIIFmfis98UTAP+K+OlXD4OdBTSBx6B3lPXT6tyRO3aOIcPOSqumrm9u9PhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OxDcyNCi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899Jr8H029497;
	Mon, 9 Sep 2024 09:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V9JzWg/Wm74Xx81auLsLwJtZBHapDTV8Ju68iF/p7W8=; b=OxDcyNCiSV9eTFQR
	KzQumuNs7LTSa1yoDcuLQcwy7usirW8Q2WGZMRJu4p3A3pXwCkp34x4/gaPbbWUv
	AxDl/ILXqJ93Y++4/+fQkZr3QMFN0BiArbXHRPu+NAdekjWs7yGh+t/NbMpvfkRs
	S/9wuv/Ybn+jycQg/qbwYIBNLlN/rsK840IYv2zQYvM0LPBYK15WQPocwzSWaRLq
	pXagG7G+p+cXTDkiFOJnMn3cqNK1gg4j5yhQj0RZnuqoYbVSKYXlAEy672hf5FlL
	1SyT27C41F82evcta0mryiz+nN9PM4uOxCbERl36XColhOOaYfFeDqWpXQRpLOKN
	UzZwqw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpjbey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899RTJS001021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:29 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:24 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 04/11] crypto: qce - Add bam dma support for crypto register r/w
Date: Mon, 9 Sep 2024 14:56:25 +0530
Message-ID: <20240909092632.2776160-5-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rq6IimvAMOP2BkoSuXJuA3O7pFiQNeN4
X-Proofpoint-GUID: rq6IimvAMOP2BkoSuXJuA3O7pFiQNeN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090074

Add BAM/DMA support for crypto register read/write.
With this change multiple crypto register will get
Written/Read using bam in one go.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


