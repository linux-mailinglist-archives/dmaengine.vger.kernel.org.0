Return-Path: <dmaengine+bounces-6714-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB32B9F111
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB931C20436
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B343009E7;
	Thu, 25 Sep 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQd5RTU0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D362FFFA8
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801669; cv=none; b=hqVv7mg0DWq4MmYYXZ76CXLnSFHp1FVIvdJUVihvTfhr5Z+Hm9BVUjhQmn3NRx9lt4Q50MxvBoivk5yKwTDR6wBTxje38x7TvioCHnDFrH+EBcOBweB4YvBX3raK362ZCUzW4ySynLlXTMZ783sUM8Z6TAgbsMYlcntSpYjeWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801669; c=relaxed/simple;
	bh=kC/yVveCilSBPp6hlDQx2LgjfgqnNgwryalEGynvTXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqJmG+1H85yiIGPCm1WH1mdfRYyDijSoF1zjZtXnt9ZLyEY+lh1bbj7mcTxtyD7eoMiSFGCofp1o2TghqGw1Qx03NF/RTQDz1P6casrDUsEsJFSQ7wc0mrSpkJhpRcwfCQsnxELdjXRY1s0yzCcIlepYI5dtKa4x7Je5dhC3x1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQd5RTU0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9D5ml021670
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 12:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V5Y/1hDv/kk
	whStoArQzbwxZMpsCaPsP3PcuweIKGKM=; b=KQd5RTU0OCqSYbA43dZVLV3JTs4
	jPaYCGg+CdtSPzBqIUsysFroSkKtfrv4OQIcUYd9dy4eoLMVeGqkzOdjd7jb5Wan
	/dQ3lsiu1T3Tqm0eIuVf1iKQCGphZ0qVgVNvO6SOkWV5JC2f4dQkqOwumUJbNeii
	aK52A+q297HKtLA6xY8pAI/R3i2T4n0JCxMmwEFTg6eaRa1dZkIOa5tXll/ZTbCL
	0eegsQ6es0OVUQC6kuaynoKwg+4KNyMxNHcfv9ugIdiYcdYTL4VX6jS1YQ7ryHxV
	VYkmsUEUhw+2Yorkej22OcJQ7upJkJIDtoeseTvZc9Z7ZIp3LCbMhmrTc9Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budafj2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 12:01:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244570600a1so11355505ad.1
        for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801664; x=1759406464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5Y/1hDv/kkwhStoArQzbwxZMpsCaPsP3PcuweIKGKM=;
        b=jTDtxJl+O7mRZa2b/1mjUvMz0X6fEnWvqQyjRUHxpDXvWNO6oQYlFxmPQSruGwLQMB
         Byc8SRQRjlqDtlZ99us9hy5WJVP7q/exg58qe5J8AeRfIlboJCvXoH/6FIv6vXQkVFR3
         FnJcs0VEpAjrNr2IRYnEpVtPrgUtCl1NUNRASwG2CI8a1yVQswXvJVjDeqNHm+o+m77Y
         nREMfTeun1FXub3LHP2LAw3jsqG5DVwWkPGe5rNFPIgCidXG+YsR3BAzPtJuy28s/Xwg
         kLoGrAwI+vrbwsLSH61DTV1mCjVGVhv4ELPuAAoGRo2tApGjKBuQnxOVpVxbo7BNvP/8
         YVig==
X-Forwarded-Encrypted: i=1; AJvYcCXnD7uGBt16W4wtLRs8Wt2D6/ZEEuLYgFHF2rA1nKrJ0rAvNp6LECMUu6/kL9yyBEhPVGxCmHLAO2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8w7X/0bRwLrwjGzBRQiQr1CTnsghquvh7ntXzhRE5Z2e8vz+e
	RYZMIwWe6KLgUq2a1G0c4MGdnUdYr4NcmALSJVMLm3byUkVpIEY4ylBrIro29hJcsHRGU6i4hxE
	0uTuY3rtLjaDGYNB4n8JF3TG9+FZeaYSMF1pwwpF3bXWSk1FcGPTBCl/dZ2P6YEU=
X-Gm-Gg: ASbGncsDbWtaTIWoY7KwaiyzTtWsrBD7fes7YwMMmLtTYxNyJY8g/MsTBfp9KHcCMNT
	uhF156gL6R80EcimFHH2LubanShiLk31iWJTNuZOLAyffFKJXViT1Q+UlzG8qtAMcguM1I71Hl3
	9S0Je8s62Z+uGuHRLoFnY6Dpxz77jK05LcCLp3wbe+HPh4asTMN2iHJJxZemOWHmqcYAbyli8Rg
	h0hDOgUte62fF6FaBuN+9kch1x+BbW5oFIXYzLfsiMApieK4tPE9YRb5JXentxBtRdk8uPhrUaX
	l0MJP11ML+HTyjNuasrmVbGC5wrGwGpMGVDV4GkZkrh2IcTThF6ULrqdYeILtAveGPjW+edNiNM
	=
X-Received: by 2002:a17:903:41ca:b0:265:e815:fcdf with SMTP id d9443c01a7336-27ed722bb4amr25789045ad.17.1758801663762;
        Thu, 25 Sep 2025 05:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEJvZUQFeB94qKQ4oxw3IjetCCgf2TPwA7CQNnsNMgmh4dfmt6RK+z1AGXQJSv6/UtlX0GfA==
X-Received: by 2002:a17:903:41ca:b0:265:e815:fcdf with SMTP id d9443c01a7336-27ed722bb4amr25787385ad.17.1758801661502;
        Thu, 25 Sep 2025 05:01:01 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm22266585ad.112.2025.09.25.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:01:01 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: [PATCH v8 2/2] i2c: i2c-qcom-geni: Add Block event interrupt support
Date: Thu, 25 Sep 2025 17:30:35 +0530
Message-Id: <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ze3jTYkVBItJR-mRDF0jN6I3tw5A2tLW
X-Proofpoint-ORIG-GUID: ze3jTYkVBItJR-mRDF0jN6I3tw5A2tLW
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d52f01 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=B7k2eyGBTX8o-6-HIN8A:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX7QJj/zjReAqj
 v98bWHvBoduSaR+C+nbflmocpKNRmry8LRwWtaiQIMQKMLpdgCzmTOLUpsRgN5Wux9+hqGp0uWR
 aYD3hi2gON+T8BzGqQYCzf7PzF+0EJjnS23/OEvpQ8vv1awVhyeVP2CUE7SmrWu8p72jZ1/GcaK
 ogcI4Cs5/QutUHfUC92W/NMWMYFIjbk3R+4MDZfqsP//VkqQlxVE0BXcx42ntg9Pu6PI5t1p3r1
 eOGK6VeBKnG6xwJArzbVfZ6YmOxYUtAF6v2RV/HckRQ+e25dg07wuGJaF3HYoUzZmAQToORhEZN
 33YXIrDK60DErT/CZOFeh7kEn2Fg9Mc8fnWkWnpo7RYfeIA3ES+uH3nfMHdklZHg6CkxKrwn/vN
 09Kxl7dB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

The I2C driver gets an interrupt upon transfer completion.
When handling multiple messages in a single transfer, this
results in N interrupts for N messages, leading to significant
software interrupt latency.

To mitigate this latency, utilize Block Event Interrupt (BEI)
mechanism. Enabling BEI instructs the hardware to prevent interrupt
generation and BEI is disabled when an interrupt is necessary.

Large I2C transfer can be divided into chunks of messages internally.
Interrupts are not expected for the messages for which BEI bit set,
only the last message triggers an interrupt, indicating the completion of
N messages. This BEI mechanism enhances overall transfer efficiency.

BEI optimizations are currently implemented for I2C write transfers only,
as there is no use case for multiple I2C read messages in a single transfer
at this time.

Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
---

v7 -> v8:
   - Updated with proper types when calling geni_i2c_gpi_unmap() inside
     geni_i2c_gpi_multi_desc_unmap().

v6 -> v7:
   - The design has been modified to configure BEI for interrupt
     generation either:
     After the last I2C message, if sufficient TREs are available, or
     After a specific I2C message, when no further TREs are available.
   - dma_buf and dma_addr for multi descriptor support is changed from
     static allocation to dynmic allocation.
   - In i2c_gpi_cb_result function, for multi descriptor case, instead of invoking
     complete for everry 8 messages completions, changed the logic to Invoke 'complete'
     for every I2C callback (for submitted I2C messages).
   - For I2C multi descriptor case, updated 'gi2c_gpi_xfer->dma_buf' and
     'gi2c_gpi_xfer->dma_addr' for unmappping in geni_i2c_gpi_multi_desc_unmap.
   - Updated documentation removed for "struct geni_i2c_dev" as per the review comments.

v5 -> v6:
  - Instead of using bei_flag, moved the logic to use with DMA
    supported flags like DMA_PREP_INTERRUPT.
  - Additional parameter comments removed from geni_i2c_gpi_multi_desc_unmap
    function documentation.

v4 -> v5:
  - Block event interrupt flag naming changed from flags to bei_flag.
  - Documentation added for "struct geni_i2c_dev".

v3 -> v4:
  - API's added for Block event interrupt with multi descriptor support for
    I2C is moved from qcom-gpi-dma.h file to I2C geni qcom driver file.
  - gpi_multi_xfer_timeout_handler function is moved from GPI driver to
    I2C driver.
  - geni_i2c_gpi_multi_desc_xfer structure is added as a member of
    struct geni_i2c_dev.

v2 -> v3:
   - In i2c_gpi_cb_result function, moved the logic of
    "!is_tx_multi_xfer" to else.
   - MIN_NUM_OF_MSGS_MULTI_DESC changed from 4 to 2
   - Updated commit description

v1 -> v2:
   - Moved gi2c_gpi_xfer->msg_idx_cnt to separate local variable.
   - Updated goto labels for error scenarios in geni_i2c_gpi function
   - memset tx_multi_xfer to 0.
   - Removed passing current msg index to geni_i2c_gpi
   - Fixed kernel test robot reported compilation issues.

 drivers/i2c/busses/i2c-qcom-geni.c | 248 ++++++++++++++++++++++++++---
 1 file changed, 224 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ff2289b52c84..ddddf9530ace 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -77,6 +77,25 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+#define QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC	2
+
+/**
+ * struct geni_i2c_gpi_multi_desc_xfer - Structure for multi transfer support
+ *
+ * @msg_idx_cnt: Current message index being processed in the transfer
+ * @unmap_msg_cnt: Number of messages that have been unmapped
+ * @irq_cnt: Number of transfer completion interrupts received
+ * @dma_buf: Array of virtual addresses for DMA-safe buffers
+ * @dma_addr: Array of DMA addresses corresponding to the buffers
+ */
+struct geni_i2c_gpi_multi_desc_xfer {
+	u32 msg_idx_cnt;
+	u32 unmap_msg_cnt;
+	u32 irq_cnt;
+	void **dma_buf;
+	dma_addr_t *dma_addr;
+};
+
 struct geni_i2c_dev {
 	struct geni_se se;
 	u32 tx_wm;
@@ -99,6 +118,9 @@ struct geni_i2c_dev {
 	struct dma_chan *rx_c;
 	bool gpi_mode;
 	bool abort_done;
+	bool is_tx_multi_desc_xfer;
+	u32 num_msgs;
+	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
 };
 
 struct geni_i2c_desc {
@@ -499,6 +521,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 static void i2c_gpi_cb_result(void *cb, const struct dmaengine_result *result)
 {
 	struct geni_i2c_dev *gi2c = cb;
+	struct geni_i2c_gpi_multi_desc_xfer *tx_multi_xfer;
 
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(gi2c->se.dev, "DMA txn failed:%d\n", result->result);
@@ -507,6 +530,11 @@ static void i2c_gpi_cb_result(void *cb, const struct dmaengine_result *result)
 		dev_dbg(gi2c->se.dev, "DMA xfer has pending: %d\n", result->residue);
 	}
 
+	if (gi2c->is_tx_multi_desc_xfer) {
+		tx_multi_xfer = &gi2c->i2c_multi_desc_config;
+		tx_multi_xfer->irq_cnt++;
+	}
+
 	complete(&gi2c->done);
 }
 
@@ -525,7 +553,72 @@ static void geni_i2c_gpi_unmap(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	}
 }
 
-static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
+/**
+ * geni_i2c_gpi_multi_desc_unmap() - Unmaps DMA buffers post multi message TX transfers
+ * @gi2c: I2C dev handle
+ * @msgs: Array of I2C  messages
+ * @peripheral: Pointer to gpi_i2c_config
+ */
+static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
+					  struct gpi_i2c_config *peripheral)
+{
+	u32 msg_xfer_cnt, wr_idx = 0;
+	struct geni_i2c_gpi_multi_desc_xfer *tx_multi_xfer = &gi2c->i2c_multi_desc_config;
+
+	msg_xfer_cnt = gi2c->err ? tx_multi_xfer->msg_idx_cnt : tx_multi_xfer->irq_cnt;
+
+	/* Unmap the processed DMA buffers based on the received interrupt count */
+	for (; tx_multi_xfer->unmap_msg_cnt < msg_xfer_cnt; tx_multi_xfer->unmap_msg_cnt++) {
+		wr_idx = tx_multi_xfer->unmap_msg_cnt;
+		geni_i2c_gpi_unmap(gi2c, &msgs[wr_idx],
+				   tx_multi_xfer->dma_buf[wr_idx],
+				   tx_multi_xfer->dma_addr[wr_idx],
+				   NULL, 0);
+
+		if (tx_multi_xfer->unmap_msg_cnt == gi2c->num_msgs - 1) {
+			kfree(tx_multi_xfer->dma_buf);
+			kfree(tx_multi_xfer->dma_addr);
+			break;
+		}
+	}
+}
+
+/**
+ * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
+ * @dev: Pointer to the corresponding dev node
+ * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
+ * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_comp: Completion object of the transfer
+ *
+ * This function waits for the completion of each processed transfer messages
+ * based on the interrupts generated upon transfer completion.
+ *
+ * Return: On success returns 0, -ETIMEDOUT on timeout.
+ */
+static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
+						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
+						   u32 transfer_timeout_msecs,
+						   struct completion *transfer_comp)
+{
+	int i;
+	u32 time_left;
+
+	for (i = 0; i < multi_xfer->msg_idx_cnt - 1; i++) {
+		reinit_completion(transfer_comp);
+
+		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
+			time_left = wait_for_completion_timeout(transfer_comp,
+								transfer_timeout_msecs);
+			if (!time_left) {
+				dev_err(dev, "%s: Transfer timeout\n", __func__);
+				return -ETIMEDOUT;
+			}
+		}
+	}
+	return 0;
+}
+
+static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 			struct dma_slave_config *config, dma_addr_t *dma_addr_p,
 			void **buf, unsigned int op, struct dma_chan *dma_chan)
 {
@@ -537,26 +630,45 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	enum dma_transfer_direction dma_dirn;
 	struct dma_async_tx_descriptor *desc;
 	int ret;
+	struct geni_i2c_gpi_multi_desc_xfer *gi2c_gpi_xfer;
+	dma_cookie_t cookie;
+	u32 msg_idx;
 
 	peripheral = config->peripheral_config;
+	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
+	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 1);
-	if (!dma_buf)
-		return -ENOMEM;
+	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
+	if (!dma_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	if (op == I2C_WRITE)
 		map_dirn = DMA_TO_DEVICE;
 	else
 		map_dirn = DMA_FROM_DEVICE;
 
-	addr = dma_map_single(gi2c->se.dev->parent, dma_buf, msg->len, map_dirn);
+	addr = dma_map_single(gi2c->se.dev->parent, dma_buf,
+			      msgs[msg_idx].len, map_dirn);
 	if (dma_mapping_error(gi2c->se.dev->parent, addr)) {
-		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
-		return -ENOMEM;
+		i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (gi2c->is_tx_multi_desc_xfer) {
+		flags = DMA_CTRL_ACK;
+
+		/* BEI bit to be cleared for last TRE */
+		if (msg_idx == gi2c->num_msgs - 1)
+			flags |= DMA_PREP_INTERRUPT;
+	} else {
+		flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	}
 
 	/* set the length as message for rx txn */
-	peripheral->rx_len = msg->len;
+	peripheral->rx_len = msgs[msg_idx].len;
 	peripheral->op = op;
 
 	ret = dmaengine_slave_config(dma_chan, config);
@@ -567,14 +679,21 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 
 	peripheral->set_config = 0;
 	peripheral->multi_msg = true;
-	flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 
 	if (op == I2C_WRITE)
 		dma_dirn = DMA_MEM_TO_DEV;
 	else
 		dma_dirn = DMA_DEV_TO_MEM;
 
-	desc = dmaengine_prep_slave_single(dma_chan, addr, msg->len, dma_dirn, flags);
+	desc = dmaengine_prep_slave_single(dma_chan, addr, msgs[msg_idx].len,
+					   dma_dirn, flags);
+	if (!desc && !(flags & DMA_PREP_INTERRUPT)) {
+		/* Retry with interrupt if not enough TREs */
+		flags |= DMA_PREP_INTERRUPT;
+		desc = dmaengine_prep_slave_single(dma_chan, addr, msgs[msg_idx].len,
+						   dma_dirn, flags);
+	}
+
 	if (!desc) {
 		dev_err(gi2c->se.dev, "prep_slave_sg failed\n");
 		ret = -EIO;
@@ -584,15 +703,48 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	desc->callback_result = i2c_gpi_cb_result;
 	desc->callback_param = gi2c;
 
-	dmaengine_submit(desc);
-	*buf = dma_buf;
-	*dma_addr_p = addr;
+	if (!((msgs[msg_idx].flags & I2C_M_RD) && op == I2C_WRITE))
+		gi2c_gpi_xfer->msg_idx_cnt++;
 
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie)) {
+		dev_err(gi2c->se.dev,
+			"%s: dmaengine_submit failed (%d)\n", __func__, cookie);
+		ret = -EINVAL;
+		goto err_config;
+	}
+
+	if (gi2c->is_tx_multi_desc_xfer) {
+		gi2c_gpi_xfer->dma_buf[msg_idx] = dma_buf;
+		gi2c_gpi_xfer->dma_addr[msg_idx] = addr;
+
+		dma_async_issue_pending(gi2c->tx_c);
+
+		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
+								      XFER_TIMEOUT, &gi2c->done);
+			if (ret) {
+				dev_err(gi2c->se.dev,
+					"I2C multi write msg transfer timeout: %d\n",
+					ret);
+				gi2c->err = ret;
+				return ret;
+			}
+		}
+	} else {
+		/* Non multi descriptor message transfer */
+		*buf = dma_buf;
+		*dma_addr_p = addr;
+	}
 	return 0;
 
 err_config:
-	dma_unmap_single(gi2c->se.dev->parent, addr, msg->len, map_dirn);
-	i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
+	dma_unmap_single(gi2c->se.dev->parent, addr,
+			 msgs[msg_idx].len, map_dirn);
+	i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+
+out:
+	gi2c->err = ret;
 	return ret;
 }
 
@@ -604,6 +756,7 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	unsigned long time_left;
 	dma_addr_t tx_addr, rx_addr;
 	void *tx_buf = NULL, *rx_buf = NULL;
+	struct geni_i2c_gpi_multi_desc_xfer *tx_multi_xfer;
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 
 	config.peripheral_config = &peripheral;
@@ -617,6 +770,41 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	peripheral.set_config = 1;
 	peripheral.multi_msg = false;
 
+	gi2c->num_msgs = num;
+	gi2c->is_tx_multi_desc_xfer = false;
+
+	tx_multi_xfer = &gi2c->i2c_multi_desc_config;
+	memset(tx_multi_xfer, 0, sizeof(struct geni_i2c_gpi_multi_desc_xfer));
+
+	/*
+	 * If number of write messages are two and higher then
+	 * configure hardware for multi descriptor transfers with BEI.
+	 */
+	if (num >= QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC) {
+		gi2c->is_tx_multi_desc_xfer = true;
+		for (i = 0; i < num; i++) {
+			if (msgs[i].flags & I2C_M_RD) {
+				/*
+				 * Multi descriptor transfer with BEI
+				 * support is enabled for write transfers.
+				 * TODO: Add BEI optimization support for
+				 * read transfers later.
+				 */
+				gi2c->is_tx_multi_desc_xfer = false;
+				break;
+			}
+		}
+	}
+
+	if (gi2c->is_tx_multi_desc_xfer) {
+		tx_multi_xfer->dma_buf = kcalloc(num, sizeof(void *), GFP_KERNEL);
+		tx_multi_xfer->dma_addr = kcalloc(num, sizeof(dma_addr_t), GFP_KERNEL);
+		if (!tx_multi_xfer->dma_buf || !tx_multi_xfer->dma_addr) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
+
 	for (i = 0; i < num; i++) {
 		gi2c->cur = &msgs[i];
 		gi2c->err = 0;
@@ -627,14 +815,16 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 			peripheral.stretch = 1;
 
 		peripheral.addr = msgs[i].addr;
+		if (i > 0 && (!(msgs[i].flags & I2C_M_RD)))
+			peripheral.multi_msg = false;
 
-		ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
+		ret =  geni_i2c_gpi(gi2c, msgs, &config,
 				    &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
 		if (ret)
 			goto err;
 
 		if (msgs[i].flags & I2C_M_RD) {
-			ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
+			ret =  geni_i2c_gpi(gi2c, msgs, &config,
 					    &rx_addr, &rx_buf, I2C_READ, gi2c->rx_c);
 			if (ret)
 				goto err;
@@ -642,18 +832,24 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 			dma_async_issue_pending(gi2c->rx_c);
 		}
 
-		dma_async_issue_pending(gi2c->tx_c);
-
-		time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
-		if (!time_left)
-			gi2c->err = -ETIMEDOUT;
+		if (!gi2c->is_tx_multi_desc_xfer) {
+			dma_async_issue_pending(gi2c->tx_c);
+			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+			if (!time_left) {
+				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
+				gi2c->err = -ETIMEDOUT;
+			}
+		}
 
 		if (gi2c->err) {
 			ret = gi2c->err;
 			goto err;
 		}
 
-		geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
+		if (!gi2c->is_tx_multi_desc_xfer)
+			geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
+		else if (tx_multi_xfer->unmap_msg_cnt != tx_multi_xfer->irq_cnt)
+			geni_i2c_gpi_multi_desc_unmap(gi2c, msgs, &peripheral);
 	}
 
 	return num;
@@ -662,7 +858,11 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	dev_err(gi2c->se.dev, "GPI transfer failed: %d\n", ret);
 	dmaengine_terminate_sync(gi2c->rx_c);
 	dmaengine_terminate_sync(gi2c->tx_c);
-	geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
+	if (gi2c->is_tx_multi_desc_xfer)
+		geni_i2c_gpi_multi_desc_unmap(gi2c, msgs, &peripheral);
+	else
+		geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
+
 	return ret;
 }
 
-- 
2.34.1


