Return-Path: <dmaengine+bounces-521-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A812E812EE4
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EF11C21591
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3941215;
	Thu, 14 Dec 2023 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JjREF5AS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6610A;
	Thu, 14 Dec 2023 03:42:56 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE2Zhpl028436;
	Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=WaiTCMI
	lwBzz3QD9XyU7WfgPTYiAHJS73KKGC/MIv6o=; b=JjREF5ASf9+u0znvw40OFzx
	CtoFlwU4Rl6RyLVsvt43nK6kMAC58Tm08PjLItnJ5VRe2dP/QL/aGukAM1yqPUJU
	xpO+Ez7mTDFRXGbcsvnfjPIt/pndpXv8QOrVSjVQvHpP8FsbqfEawNEIK2HvgoFS
	Mv9g+aL3BI505wB8nDQryO8fgVB4kN2QtxGBlIzrEFOMcnGIpPzw9SKRC4Miknqf
	KaByJ7zFxz9naGd+U/XQEFveyKcohGJUabZAWnmgCLlts9pubfEwzH6d/SMwPkky
	SbP/isaGIoJ5a8mnRYJmyiLhqHjwi87vjgtkXjtsKnFOoHX3NxaJG/KdWLwBXCA=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq66h68y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghaN003046;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktcgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghRc002912;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBghDi002823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 8E6104162E; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 04/11] crypto: qce - Convert register r/w for sha via BAM/DMA
Date: Thu, 14 Dec 2023 17:12:32 +0530
Message-Id: <20231214114239.2635325-5-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: mbzBO874YgDXLDPfmnSG3Rq8VInt4Wka
X-Proofpoint-ORIG-GUID: mbzBO874YgDXLDPfmnSG3Rq8VInt4Wka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140080

Convert register read/write for sha via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/common.c | 26 +++++++++++++++++---------
 drivers/crypto/qce/sha.c    | 12 ++++++++++++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index d1da6b1938f3..d485762a3fdc 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -157,17 +157,19 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	__be32 mackey[QCE_SHA_HMAC_KEY_SIZE / sizeof(__be32)] = {0};
 	u32 auth_cfg = 0, config;
 	unsigned int iv_words;
+	int ret;
 
 	/* if not the last, the size has to be on the block boundary */
 	if (!rctx->last_blk && req->nbytes % blocksize)
 		return -EINVAL;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	if (IS_CMAC(rctx->flags)) {
-		qce_write(qce, REG_AUTH_SEG_CFG, 0);
-		qce_write(qce, REG_ENCR_SEG_CFG, 0);
-		qce_write(qce, REG_ENCR_SEG_SIZE, 0);
+		qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, 0, 1);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, 0, 1);
 		qce_clear_array(qce, REG_AUTH_IV0, 16);
 		qce_clear_array(qce, REG_AUTH_KEY0, 16);
 		qce_clear_array(qce, REG_AUTH_BYTECNT0, 4);
@@ -213,18 +215,24 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 		auth_cfg &= ~BIT(AUTH_FIRST_SHIFT);
 
 go_proc:
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
-	qce_write(qce, REG_AUTH_SEG_SIZE, req->nbytes);
-	qce_write(qce, REG_AUTH_SEG_START, 0);
-	qce_write(qce, REG_ENCR_SEG_CFG, 0);
-	qce_write(qce, REG_SEG_SIZE, req->nbytes);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_SIZE, req->nbytes, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_START, 0, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, 0, 1);
+	qce_write_reg_dma(qce, REG_SEG_SIZE, req->nbytes, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	qce_crypto_go(qce, true);
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in sha cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index fc72af8aa9a7..f850c6206a31 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -41,6 +41,7 @@ static void qce_ahash_done(void *data)
 	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(async_req->tfm);
 	struct qce_device *qce = tmpl->qce;
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
 	struct qce_result_dump *result = qce->dma.result_buf;
 	unsigned int digestsize = crypto_ahash_digestsize(ahash);
 	int error;
@@ -60,6 +61,17 @@ static void qce_ahash_done(void *data)
 	rctx->byte_count[0] = cpu_to_be32(result->auth_byte_count[0]);
 	rctx->byte_count[1] = cpu_to_be32(result->auth_byte_count[1]);
 
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
 		dev_dbg(qce->dev, "ahash operation error (%x)\n", status);
-- 
2.34.1


