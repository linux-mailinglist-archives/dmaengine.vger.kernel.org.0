Return-Path: <dmaengine+bounces-518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B4812EDC
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE4282352
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C13405CF;
	Thu, 14 Dec 2023 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XU9f9D2w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC5B2;
	Thu, 14 Dec 2023 03:42:55 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE6Td47021597;
	Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=9RohmAJ
	7e6YEt6pDOa8r9PuoQD0ErczCjS53ByZGL1g=; b=XU9f9D2wEllVCpwQxull19E
	0UtqvKOX1/o7yG2wx4MaRL6F2vi4D9PjvYQLNm+sv7JXfUqnCAvkoHMNc9VmcLuF
	ZLTxOYs/JHKX9p69WTqQKK5sFifmFlacu8FiAl8+3eRJw+OX+AZwvft9i56scTxb
	/mMLhwUacUtHAqI7cwRVK6LQnDhnKkPu8r22yYocPaz8lxuolqOKPKqj1rsaNp/C
	NZ+jrnicUHiS2mbPkSGvEhEl2/MmEeGTP78mmR1VIgeYCghhw7ubWs1l9VhxSZDg
	P33f1UV4UKuNiU4jPxOxVyXfXOAJbKALkkhbO/xXwekutY30+eEl0PWBngwoMMQ=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre19yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghGo003058;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktcgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgh1A002935;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBghpn002829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 8BF1641610; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 03/11] crypto: qce - Convert register r/w for skcipher via BAM/DMA
Date: Thu, 14 Dec 2023 17:12:31 +0530
Message-Id: <20231214114239.2635325-4-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XbkDumnWttJApC3mNuMir68lNvMhNZqO
X-Proofpoint-GUID: XbkDumnWttJApC3mNuMir68lNvMhNZqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080

Convert register read/write for skcipher via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/common.c   | 42 +++++++++++++++++++++--------------
 drivers/crypto/qce/skcipher.c | 12 ++++++++++
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 04253a8d3340..d1da6b1938f3 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -34,7 +34,7 @@ static inline void qce_write_array(struct qce_device *qce, u32 offset,
 	int i;
 
 	for (i = 0; i < len; i++)
-		qce_write(qce, offset + i * sizeof(u32), val[i]);
+		qce_write_reg_dma(qce, offset + i * sizeof(u32), val[i], 1);
 }
 
 static inline void
@@ -43,7 +43,7 @@ qce_clear_array(struct qce_device *qce, u32 offset, unsigned int len)
 	int i;
 
 	for (i = 0; i < len; i++)
-		qce_write(qce, offset + i * sizeof(u32), 0);
+		qce_write_reg_dma(qce, offset + i * sizeof(u32), 0, 1);
 }
 
 static u32 qce_config_reg(struct qce_device *qce, int little)
@@ -86,16 +86,16 @@ static void qce_setup_config(struct qce_device *qce)
 	config = qce_config_reg(qce, 0);
 
 	/* clear status */
-	qce_write(qce, REG_STATUS, 0);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_STATUS, 0, 1);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 }
 
 static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
 {
 	if (result_dump)
-		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
+		qce_write_reg_dma(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT), 1);
 	else
-		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
+		qce_write_reg_dma(qce, REG_GOPROC, BIT(GO_SHIFT), 1);
 }
 
 #if defined(CONFIG_CRYPTO_DEV_QCE_SHA) || defined(CONFIG_CRYPTO_DEV_QCE_AEAD)
@@ -308,7 +308,7 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
 	/* Set data unit size to cryptlen. Anything else causes
 	 * crypto engine to return back incorrect results.
 	 */
-	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
+	qce_write_reg_dma(qce, REG_ENCR_XTS_DU_SIZE, cryptlen, 1);
 }
 
 static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
@@ -325,7 +325,9 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	u32 encr_cfg = 0, auth_cfg = 0, config;
 	unsigned int ivsize = rctx->ivsize;
 	unsigned long flags = rctx->flags;
+	int ret;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	if (IS_XTS(flags))
@@ -336,7 +338,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	qce_cpu_to_be32p_array(enckey, ctx->enc_key, keylen);
 	enckey_words = keylen / sizeof(u32);
 
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
 
 	encr_cfg = qce_encr_cfg(flags, keylen);
 
@@ -369,25 +371,31 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	if (IS_ENCRYPT(flags))
 		encr_cfg |= BIT(ENCODE_SHIFT);
 
-	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
-	qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
-	qce_write(qce, REG_ENCR_SEG_START, 0);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, encr_cfg, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_START, 0, 1);
 
 	if (IS_CTR(flags)) {
-		qce_write(qce, REG_CNTR_MASK, ~0);
-		qce_write(qce, REG_CNTR_MASK0, ~0);
-		qce_write(qce, REG_CNTR_MASK1, ~0);
-		qce_write(qce, REG_CNTR_MASK2, ~0);
+		qce_write_reg_dma(qce, REG_CNTR_MASK, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK0, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK1, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK2, ~0, 1);
 	}
 
-	qce_write(qce, REG_SEG_SIZE, rctx->cryptlen);
+	qce_write_reg_dma(qce, REG_SEG_SIZE, rctx->cryptlen, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	qce_crypto_go(qce, true);
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in skcipher cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 5b493fdc1e74..fa7ee5db9aa0 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -31,6 +31,7 @@ static void qce_skcipher_done(void *data)
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(crypto_skcipher_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
 	struct qce_result_dump *result_buf = qce->dma.result_buf;
 	enum dma_data_direction dir_src, dir_dst;
 	u32 status;
@@ -52,6 +53,17 @@ static void qce_skcipher_done(void *data)
 
 	sg_free_table(&rctx->dst_tbl);
 
+	if (qce_bam_txn->qce_read_sgl_cnt)
+		dma_unmap_sg(qce->dev,
+			     qce_bam_txn->qce_reg_read_sgl,
+			qce_bam_txn->qce_read_sgl_cnt,
+			DMA_DEV_TO_MEM);
+	if (qce_bam_txn->qce_write_sgl_cnt)
+		dma_unmap_sg(qce->dev,
+			     qce_bam_txn->qce_reg_write_sgl,
+			qce_bam_txn->qce_write_sgl_cnt,
+			DMA_MEM_TO_DEV);
+
 	error = qce_check_status(qce, &status);
 	if (error < 0)
 		dev_dbg(qce->dev, "skcipher operation error (%x)\n", status);
-- 
2.34.1


