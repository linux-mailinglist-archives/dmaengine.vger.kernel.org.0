Return-Path: <dmaengine+bounces-12095-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y/NMMobcTWoX/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12095-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:13:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2DE721BAF
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:13:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IV2lbcv9;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12095-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12095-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 291AA303BB0C
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38E3B6344;
	Wed,  8 Jul 2026 05:11:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9451F03DE;
	Wed,  8 Jul 2026 05:11:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487465; cv=none; b=UF7X/WQZX1IeOz/fLAJVPKzToukiEGYuanyLtXjMSpWQE7bqPJmqGi2TbHbSothlT9EZTTJIbePizFQ9uf6f0cShbx12CbI++rfUcuMXxs1es/kkb9wUu773ySk6t1wTEI/bcYdkCrSHOdojlL/5WVZR99y0X71bNnIsQYMu5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487465; c=relaxed/simple;
	bh=+M+VBTGmJH3pssGzJwn3afkEBzxTAHkdcYmSXJ+BF3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUnUWvmJOh7uTQIgACMRL8URVcfbJ+X4+2KOz4WlvENkHv1gTdDmVJLQm/qkX7+5sOoyQEZZboSWFvO3mbiA+EcTVMlwXAkjjFr5sdG+t1jT4J2D/laOqSZEpD4Cywy4gcpZ9U7buPBbqXu0ERRX7Rtblupgn17GhX/bGMgKPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV2lbcv9; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842Zud1491290;
	Wed, 8 Jul 2026 05:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nsyG7JrgV1e
	njL2vvk7uJ0MFosI6TzEZe426t3m7oXg=; b=IV2lbcv9zyqV8d4LGGlpj9szEem
	0GYqUlA0iMlYL5HTT6Hvra4bm1PI55XtdT+rrclX6efWWXTwIwV7fI4QbCIiIOIc
	oT1+7Y2S1DKUwgN37KphYchplsRu3oY5vZAzzN0ARR4MW4rcIoJ91TGvsn37IHJt
	EcJdgOwSanD4phm5yMLWgsebAJVBZ64jciILrAw5PFSMCE/60pjZRZmzZdgtKAqu
	VYORgh5k1CYsle/6BfD53dCw9dSPl2sWHRxnt3MKhJiM1odpfmR4oOCJ67IAIMCE
	kxHPvraGjlaVVcbQjpyE29tqQ6WAKdxTpPr/vTIKYshTLwPwJ3BgTGXONLg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5g91qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:58 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6685AsJJ016141;
	Wed, 8 Jul 2026 05:10:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8kcry6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:54 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6685AsUL016131;
	Wed, 8 Jul 2026 05:10:54 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6685AsUo016129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:54 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 4120F2181C; Wed,  8 Jul 2026 10:40:53 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for multi-owner I2C transfers
Date: Wed,  8 Jul 2026 10:40:08 +0530
Message-ID: <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX4oNswM/9/ZRS
 WyHXR7dPn0TkABONd7XVtCpRXLrGgaV0WlR/sOnacAh8dJTJ7nW1+tGDEoGPoPs3+ACTk1DdQqp
 Vh2YlYe+1fwz0GpezyH1ar0SeotHz6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX++LVIGfTpNhG
 x4yRLTaW/xRSD/ZHcTautUWD7R0qcECbqQExZxSVDQdvKkX+T5R+nPuNssSJjDx29RPHQ4VQsG4
 3JlDpwGbvHBnEJkdrUrdhbCOk1Lo5LWE9kQeaFmUHGR6mHT5sjno7dzuu4+36pXg/Qaqk3J64/0
 FMYZ2ej6MGzMd60gvkY6TijNr9JSsWfnqACJMljgQFLT1EH9bj2FOOgavyez+36FXlZ12r9xp5r
 /PE7UTlCzul5+yn79dIPXPThx7g56vaPFmau/gf9a2nJHN/gYXCIpdFyNkHYqJyCUgb3GNxbKQP
 N9AY/OuMbxNpPtXTijJstig7/BRtkePlzpp3rVZwaeOMb29iFbP7i1Hg1ID7wQWe/IlKib+n/dd
 HD5OPSoTIkqVUo+L+whSb+rpW92y5CzRhPm4F1ksqfAeDrslM3nb94Kqv0lizcL4i2hhR2mZNRW
 pL4ZCGhzHZfODZGbk9Q==
X-Proofpoint-ORIG-GUID: x6kPvgfdEWJ4b6ihovi6gdLIZ7pqGxJT
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4ddbe2 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=mSgB-p_1VGLq_7tLs9EA:9
X-Proofpoint-GUID: x6kPvgfdEWJ4b6ihovi6gdLIZ7pqGxJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12095-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,iscas.ac.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B2DE721BAF

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
 include/linux/dma/qcom-gpi-dma.h | 20 ++++++++++++++-
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..1e70d2adfdff 100644
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
index 332be28427e4..f10fa93713f9 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2020, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef QCOM_GPI_DMA_H
@@ -54,6 +55,21 @@ enum i2c_op {
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
@@ -67,7 +83,8 @@ enum i2c_op {
  * @set_config: set peripheral config
  * @rx_len: receive length for buffer
  * @op: i2c cmd
- * @multi_msg: is part of multi i2c r-w msgs
+ * @muli-msg: is part of multi i2c r-w msgs
+ * @lock_action: request lock/unlock TRE sequencing for this transfer
  */
 struct gpi_i2c_config {
 	u8 set_config;
@@ -81,6 +98,7 @@ struct gpi_i2c_config {
 	u32 rx_len;
 	enum i2c_op op;
 	bool multi_msg;
+	enum gpi_lock_action lock_action;
 };
 
 #endif /* QCOM_GPI_DMA_H */
-- 
2.43.0


