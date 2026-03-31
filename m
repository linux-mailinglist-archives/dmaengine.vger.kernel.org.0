Return-Path: <dmaengine+bounces-9775-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II3+CGK2y2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9775-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:56:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 999683692B5
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28441309F6A3
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F83DD501;
	Tue, 31 Mar 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQ2CQPPy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142C3AA1A8;
	Tue, 31 Mar 2026 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957713; cv=none; b=ZlsGsZgqoV2WPNHz5+eua3G4ewKk8luHqPFLi1m3aTmPshwekVjeIZ093NTOCFUWJDrjDRfb9PBc4v/TRlHqBgvR5lynjrCqHBoI7pVcYl2t/MFDzZjTt+XWcHkoNDwiRHMTsehajw3JLxYa1Mu4/QZa8U5blXLtNPmPNKy4t5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957713; c=relaxed/simple;
	bh=8hkkRqkED6s4fNr/UdpaSlLsFW7mDD5Bq/m3M+8QuSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ge1zm9uIrDx5lyoh2E+cIl63tBxMxgBOYQS2w4Ssy7dJryWxjEIB6nIpCcNy0H1Z2NOeHzx4EhXfRHp2+40o/kV5IMjAjeEhb87W6NKX0JpjTmI0XAKv95tDYAB0u+aC51FK6sxJ1hdiIFmp3/JtbpgftWPQ/rF7O9dxHkNh4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HQ2CQPPy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8B0Wk058382;
	Tue, 31 Mar 2026 11:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wytVJC3ShD2
	5GSoHro9KhTpoqcx3xwCJ8CUBne86Gu4=; b=HQ2CQPPysvff/kgnUICSh76Sc8Q
	wNYlTnw1COeAZboFZMFhDLNUn8F7vDHxQT/BCIX166lnGdlLErHGcTEfvbI/NZRK
	Pqf5OcVWPfTeLoWB3BuW55fZd0gknGIk5zaWzNYCT/IrWbyIZhOcPFHj6QEcEK5D
	tvQ1sfRAV54PsIcFVRjg1V2iVJtbAbwS8nz6VJR5GQpTlD70slYbX+B1B8g9BRys
	2uDWEWwxKjGFJwWD3J3UEL+0DjAjD3mu2+7pw5mJZSaVlZFwPBqAg3YAtUy94KGY
	TOEZzL0S05YNV39sdHCnzjBvL8UjA9EoVKJzQ6vO7u6FW7DRE4kru0pTaeA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8ahkrucr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:25 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 62VBmM1B011316;
	Tue, 31 Mar 2026 11:48:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qk1vem5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:22 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 62VBmMYg011310;
	Tue, 31 Mar 2026 11:48:22 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62VBmMvM011307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:22 +0000 (GMT)
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id 58E3C2579A; Tue, 31 Mar 2026 17:18:21 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v6 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for multi-owner I2C transfers
Date: Tue, 31 Mar 2026 17:17:40 +0530
Message-Id: <20260331114742.2896317-3-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExNCBTYWx0ZWRfX9Dd28/okfEFT
 qQH4hL9xPSK/zgTSzBPrrlrQkeei6r2X1Eiys+56wEwrp8ADbX/QfhNa2ZyC4KiEiAUUoyXuV/g
 1WAzOVIAK2WUsHGLtUaLxX7c5hHlP1WKQNMKi2i7XVoQDPXahc9JkTW8yj5YfAGbCJOboUs88Pt
 Az+XJ8/yfwo+aIjmWnMqwqmOtvxbjTA3WdkjNpCLohIvRctEbbQWVj5gg8hMy7esl3IHG9gjIGL
 zTkaf4/4IvJ9d4nixSR2qkyf2KaudurxD1r+6SKVLRbF5Atdu/v9KvI1u+fRBGofT7o2xB0sPoy
 BXZ88sGJNNGQc3nJK+CzxohGLMh3IvunYdqAaATOqgqXvcn/ZA7M3HP3vorp5vaYoIb6m+eTOL0
 8iOmvIVMr7jPX9Nz87TpOHHxg4TIiRKbVQAhnoBsLpdzY+ACW20hT1CnbwCdDpotmMPGCbZtbCs
 3V9Wawr+CXmCq4d2Ilg==
X-Authority-Analysis: v=2.4 cv=K4wv3iWI c=1 sm=1 tr=0 ts=69cbb48a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=mSgB-p_1VGLq_7tLs9EA:9
X-Proofpoint-ORIG-GUID: KTaOPoN9Od7DZSzgQNaOBqO80y4xZe-y
X-Proofpoint-GUID: KTaOPoN9Od7DZSzgQNaOBqO80y4xZe-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310114
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9775-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 999683692B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some platforms use a QUP-based I2C controller in a configuration where the
controller is shared with another system processor (described in DT using
qcom,qup-multi-owner). In such setups, GPI hardware lock/unlock TREs can be
used to serialize access to the controller.

Add support to emit lock and unlock TREs around I2C transfers and increase
the maximum TRE count to account for the additional elements.

Also simplify the client interface by replacing multiple boolean fields
(shared flag and message position tracking) with a single lock_action
selector (acquire/release/none), as the GPI driver only needs to know
whether to emit lock/unlock TREs for a given transfer.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c           | 44 +++++++++++++++++++++++++++++++-
 include/linux/dma/qcom-gpi-dma.h | 18 +++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 6e30f3aa401e..a1f391dd1747 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2020, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <dt-bindings/dma/qcom-gpi.h>
@@ -67,6 +68,14 @@
 #define TRE_DMA_LEN		GENMASK(23, 0)
 #define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
 
+/* Lock TRE */
+#define TRE_LOCK		BIT(0)
+#define TRE_MINOR_TYPE		GENMASK(19, 16)
+#define TRE_MAJOR_TYPE		GENMASK(23, 20)
+
+/* Unlock TRE */
+#define TRE_UNLOCK		BIT(8)
+
 /* Register offsets from gpi-top */
 #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
 #define GPII_n_CH_k_CNTXT_0_EL_SIZE	GENMASK(31, 24)
@@ -518,7 +527,7 @@ struct gpii {
 	bool ieob_set;
 };
 
-#define MAX_TRE 3
+#define MAX_TRE 5
 
 struct gpi_desc {
 	struct virt_dma_desc vd;
@@ -1625,12 +1634,27 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 			      unsigned long flags)
 {
 	struct gpi_i2c_config *i2c = chan->config;
+	enum gpi_lock_action lock_action = i2c->lock_action;
 	struct device *dev = chan->gpii->gpi_dev->dev;
 	unsigned int tre_idx = 0;
 	dma_addr_t address;
 	struct gpi_tre *tre;
 	unsigned int i;
 
+	/* Optional lock TRE before transfer */
+	if (lock_action == GPI_LOCK_ACQUIRE) {
+		tre = &desc->tre[tre_idx];
+		tre_idx++;
+
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		tre->dword[2] = 0;
+		tre->dword[3] = u32_encode_bits(1, TRE_LOCK);
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
+		tre->dword[3] |= u32_encode_bits(0, TRE_MINOR_TYPE);
+		tre->dword[3] |= u32_encode_bits(3, TRE_MAJOR_TYPE);
+	}
+
 	/* first create config tre if applicable */
 	if (i2c->set_config) {
 		tre = &desc->tre[tre_idx];
@@ -1690,6 +1714,24 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 
 		if (!(flags & DMA_PREP_INTERRUPT))
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
+
+		/* If multi-owner and this is the release boundary, chain it */
+		if (i2c->lock_action == GPI_LOCK_RELEASE)
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
+	}
+
+	/* Optional unlock TRE after transfer */
+	if (lock_action == GPI_LOCK_RELEASE && i2c->op != I2C_READ) {
+		tre = &desc->tre[tre_idx];
+		tre_idx++;
+
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		tre->dword[2] = 0;
+		tre->dword[3] = u32_encode_bits(1, TRE_UNLOCK);
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
+		tre->dword[3] |= u32_encode_bits(1, TRE_MINOR_TYPE);
+		tre->dword[3] |= u32_encode_bits(3, TRE_MAJOR_TYPE);
 	}
 
 	for (i = 0; i < tre_idx; i++)
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 6680dd1a43c6..36cbb85499b4 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2020, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef QCOM_GPI_DMA_H
@@ -51,6 +52,21 @@ enum i2c_op {
 	I2C_READ,
 };
 
+/**
+ * enum gpi_lock_action - request lock/unlock TRE sequencing
+ * @GPI_LOCK_NONE: No lock/unlock TRE requested for this transfer
+ * @GPI_LOCK_ACQUIRE: Emit a lock TRE before the transfer
+ * @GPI_LOCK_RELEASE: Emit an unlock TRE after the transfer
+ *
+ * Used by protocol drivers for multi-owner controller setups (e.g. when
+ * DeviceTree indicates the controller is shared via qcom,qup-multi-owner).
+ */
+enum gpi_lock_action {
+	GPI_LOCK_NONE = 0,
+	GPI_LOCK_ACQUIRE,
+	GPI_LOCK_RELEASE,
+};
+
 /**
  * struct gpi_i2c_config - i2c config for peripheral
  *
@@ -65,6 +81,7 @@ enum i2c_op {
  * @rx_len: receive length for buffer
  * @op: i2c cmd
  * @muli-msg: is part of multi i2c r-w msgs
+ * @lock_action: request lock/unlock TRE sequencing for this transfer
  */
 struct gpi_i2c_config {
 	u8 set_config;
@@ -78,6 +95,7 @@ struct gpi_i2c_config {
 	u32 rx_len;
 	enum i2c_op op;
 	bool multi_msg;
+	enum gpi_lock_action lock_action;
 };
 
 #endif /* QCOM_GPI_DMA_H */
-- 
2.25.1


