Return-Path: <dmaengine+bounces-7831-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8871CCF56A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9BB630A5E3E
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ABB2ECD1B;
	Fri, 19 Dec 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFDeXbjr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RSY/Rca6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DC3081CA
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138926; cv=none; b=iz+EzIPmb55kB6nIwNDATHhok/Nj6g7hsjIW9iF91SX0YsKI4SnLALwevP4KJ+Gou6DWobNHfTGOLyVG/O71dloqLMljvxzEI5PqVHwsBXuaOcw+dGgtwPMw3Iv30XNZL0voy2tc7HK6L2AUdDNuLuvXLlX45vbZ/UmLxhmNwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138926; c=relaxed/simple;
	bh=P9G/XM66hhWIjOFw9n0h55XNqJdzX7mEFBNxYddp5xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=La3+tx6fubjw76eMhLlkz8tAK0Mf4UXCJ/vRCdOxfOcCnHL+a4XBqFiyQlG4OoIl+kRbjByKbVF3NaW88sGVxlXuF+JPf0cu91DSVwr6NCbPKGO4lu/1QDkOOVBQtxePjAtOZqT8bpaDik/VIPKZuMqMovt7qJgFNP7+oJ9Yo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFDeXbjr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RSY/Rca6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4buUI3975405
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AsfR0Ng+trtCxWXr8RJfsUoS0vYwVZ8Rep8jGuwkJXE=; b=TFDeXbjrFrYgpgLQ
	kK3ETByF+XbgHvp/3dLKBWVjxW3fH82gF1t+lmI53Pr5Agcbtq+N9wq2Wwb0RmfI
	vqZh9sYkrEzaIPNNmBH7vSGypn4na/+f14Nvsf78mtYHIsqlTYAH5YX8ioYNVGVW
	fTVWUmitFXyDtuZtS8ow7tJfvaegetHjjjALTn3sVgd0dD91rb9tJDLJrZKEFoSW
	oon0J3WKd/v2l4cosJq9e1wIy9Zpd0YXK+G3Kg/4aWUQJlQHUH89i5V28jaxD+Wi
	HIbFak5aOAfH29Su5+1+WYJtUTwZbsX8akWvcMGju2zjF0x5Ydq7eaXfeai5UCtj
	NFKrog==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2fj6aq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1f42515ffso35399701cf.0
        for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 02:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766138921; x=1766743721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsfR0Ng+trtCxWXr8RJfsUoS0vYwVZ8Rep8jGuwkJXE=;
        b=RSY/Rca6dE+/4UM+TcljecSNEusDRjfhRUymCQr9k8lpb4a8GQLi6gK7ZqS/WwGYCD
         cEVKonrABzANf2ZPEWlCZwlhgcPCEHLU2STG2IWmnqn183OWiETaqnZZGACvybEJIdvQ
         OVroMaJ+20XeVXMJ4Iet2dKztv+uvCv9799ePVK6fhP/ZjmyyJ+ZCY9OcMOjzYjJWzom
         HoQxrLuVaTeE1XBnGVVHupCAxTkUs9tubuXR3AeDpKMhyjJmXgCROs4suJe1nIbzJeRc
         oZyww7VOIM6mPCbUZVUr+ThH3X16DM/cCBDgfhfS2GRNc/4iE5nrGsppuQETDzFYJc+N
         rwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766138921; x=1766743721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AsfR0Ng+trtCxWXr8RJfsUoS0vYwVZ8Rep8jGuwkJXE=;
        b=cQuSH7J3FJi7VF99hVVXtgXzJPNLZWZCmRFikkFGZdOQqwZqvtMUcKifjllrj/W+1a
         QZXDojjrUhGGVsqwH3utc3Rd1XYzdohJQuJ0HTZvO+hSnLeVsP81ALL//TpmqVGQ1anj
         jv/OcHWEHbEoqX2dzEDYV2rmNTp6NkEsjX4yBl2KvgsMnOntnTpQXBfah2b7+fH6Jne/
         Tew60roACENEaFFEmrzOdS3BAPaqv1blZ34M8E1+glxX2zdsFdriWhfdNLOrDJBN3wt4
         +6W+AnF8M8nwhEJD4qRhhPUy1+RECRI8jbiZO66qSzm+ULB6ScT1vAPjtk36q5pNGcg9
         LDyQ==
X-Gm-Message-State: AOJu0Ywll7wgFvUfuDf7x2o5DSHY1eX7BegTF94UPr4O1Ei4L+8o0kN8
	MWjsLY8rJpiCdd22NjFlZ0s0Vfsy3EQ5cwcmVrTL/WhcCXuuxvYlJGxFbyXPQ1g5f7gPt/PSNgv
	ylVtU62QCZ7vWBfsJvDEr3dGmqVJZaUV6CDGjMT5+PGg1o5yNueS78J6kbdtOsfw=
X-Gm-Gg: AY/fxX4O4E/j/52gyxwBkQZJMVfIC5TEdqEHb4Z0htzv1Wo4DcxT5kFmwt9Qzz0sBpe
	UrSNPQk80emrX1P70a1cOKk9119+vMfRmkURv4OeOtUhmkO2aVMpQie/VK8mdZJ2nTy9Ts9v8Ns
	hGxcaNKtzUHH1ha9bs5vNb1mX+maqehCQSTX3jzq29UqG6ViGd1FswcNjEeyd8yDSqFDwT5ROpC
	P39wt07NtEuwjQmP2D2CwvLfekpbx3RA+kM1CRaTR3ohmlrxwyKWSiF+CVkgg985QbpZKkMFi0N
	jtx9/H5SBLV640HnuncQWZcMt/54905g2s754j/SCS2p9rJLoSz7HsHl7lyJ32tmSpYTeSjivVq
	V18Yjph2KqZnKYdbkieb8SJqHSWn5ESF1zBLR4w==
X-Received: by 2002:a05:622a:110e:b0:4f1:dddb:db6c with SMTP id d75a77b69052e-4f4abcd2b29mr28277681cf.17.1766138921180;
        Fri, 19 Dec 2025 02:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWIIZH6dn2g0LJ7sXhg7c9rCUSr4NrjHFbJy6f9ZZtbiONrsZjv0bkNSmQnx+9j6jPiwdXA==
X-Received: by 2002:a05:622a:110e:b0:4f1:dddb:db6c with SMTP id d75a77b69052e-4f4abcd2b29mr28277501cf.17.1766138920762;
        Fri, 19 Dec 2025 02:08:40 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:a48:678b:dad2:b2eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm4209571f8f.27.2025.12.19.02.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:08:40 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:07:49 +0100
Subject: [PATCH v10 10/12] crypto: qce - Add BAM DMA support for crypto
 register I/O
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-qcom-qce-cmd-descr-v10-10-ff7e4bf7dad4@oss.qualcomm.com>
References: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
In-Reply-To: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6295;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/pYNdX79IsEIfqFLc24whwQ5VhyXqWC/xkdLuNIvPWk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpRSQWWy6tmDN6lEKJplrycxbz3c3ipqiwC7uVN
 C4G4SJfw0SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaUUkFgAKCRAFnS7L/zaE
 w+O8D/4sEb2NQwa5xHp1gAD5kXSpQRLSDjZtPoAONLsTSMLr3gDDE6XsCixHEZh0P1rp44AY5BP
 QOXs5KuYSdM20vviONmVFZ4vzvf0iuUwYaaJgaSl8ajE8XX6DSkSYU/BBUz8OXoYpaVgOxhbUvV
 7dJan1tMesdNmlH0ZM6pHhLta31CzNDwvrXIrdUQJ5Dy5cSbcL5IKipKBVGbsHreb8qHOh0SASP
 nC8/3x5KMPUgrWHcNIXq8pTiTnttaESioP6AZ7sZmISo0OqI6MlU3GGJBbR3rOHbhYPH+mUFykk
 Dmwt9tNPAwGYHgtWWlCvN83RhFdWhI4yf+4j0N0X02xQoIZgqDEaRtvRGc3H+C3SNJtJ2tnIe/f
 FBAhqW6cLgyWJPve7N+rLw2JakryNZIFPMMX5hlSZ7PlJbRG0qu+6ulsVxE31Oyxkbg5OBuRC4j
 wKpVsz55WilzEHK8VGHFljMynKI+gEPQo5xxTNFS2ko/4tNgPRe3doq+t8qAO73RvbkK9HY+SG9
 Uenf1KXuYj6t5Npd/a1oh9/JAfWO1A8fCQXQMlRWQMoJGBtYLudKdsw1akwVY0DkuYAGzTtblhq
 VRh7pPUMmfjI94YjUsskfxXExOTf5/A24F2r7Tal26r+3sDSv9aYAvS6/kL30t3D08uP5dnP7y8
 Y9X72FCrnKj5Kuw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=NODYOk6g c=1 sm=1 tr=0 ts=6945242a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=qGjQl-v-kXvwofw7MDAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bWttCpEC0PSBzziP5rz34-lgXOp8MMCC
X-Proofpoint-GUID: bWttCpEC0PSBzziP5rz34-lgXOp8MMCC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfXylNDsa/2+mTf
 nN6NjmLMerCenC+5SOn57nzretifCSd8ElKBBDECfhWXo8LAT2dMRJzbBkb6NBA6xIZBchDyr4R
 7fUtlbSiKR37v3WRWvqAtOVf3nGNnpDUfPT1g+w3zH2aDR//sU4YV+ErscjTCayDt9NbFAp4qk4
 L5bu9XjmDOJ+hHj0qkgjDN2Jy2OZ3iiKjvPQGFADbvgX+9cmXy2+fxLxTgpLjjrHoneCXoasz7q
 NN8wacZE14LJgczhOLZMgRMSQRsg9FaIBOId5DGi5UaRH7pmC/SB+8ys0n0uiqiRhkXEDFakpVc
 pX2yJ5W5DfuwqdgP33Y7sV9TcsilEOZvGuprc6ZQCxi5S9nrQtVxMuwSTMUo4nb85tcJbNU5VkB
 YgcaCDggWx9G9TqKwPILNWFG3GKAMskixDXm2xY5Iy9zZHA6DLtk+oQ7sYQ0XZRac3yULkRYMfl
 kvzPmKLUMXlzpEnDxlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190083

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the infrastructure for performing register I/O over BAM DMA,
not CPU. No functional change yet.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.h |   4 ++
 drivers/crypto/qce/dma.c  | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h  |   5 +++
 3 files changed, 118 insertions(+)

diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index a80e12eac6c87e5321cce16c56a4bf5003474ef0..d238097f834e4605f3825f23d0316d4196439116 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -30,6 +30,8 @@
  * @base_dma: base DMA address
  * @base_phys: base physical address
  * @dma_size: size of memory mapped for DMA
+ * @read_buf: Buffer for DMA to write back to
+ * @read_buf_dma: Mapped address of the read buffer
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -49,6 +51,8 @@ struct qce_device {
 	dma_addr_t base_dma;
 	phys_addr_t base_phys;
 	size_t dma_size;
+	__le32 *read_buf;
+	dma_addr_t read_buf_dma;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index a46264735bb895b6199969e83391383ccbbacc5f..ba7a52fd4c6349d59c075c346f75741defeb6034 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
@@ -11,6 +13,98 @@
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+#define QCE_BAM_CMD_SGL_SIZE		128
+#define QCE_BAM_CMD_ELEMENT_SIZE	128
+#define QCE_MAX_REG_READ		8
+
+struct qce_desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_data_direction dir;
+};
+
+struct qce_bam_transaction {
+	struct bam_cmd_element bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];
+	struct scatterlist wr_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct qce_desc_info *desc;
+	u32 bam_ce_idx;
+	u32 pre_bam_ce_idx;
+	u32 wr_sgl_cnt;
+};
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->wr_sgl_cnt = 0;
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->pre_bam_ce_idx = 0;
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce)
+{
+	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan *chan = qce->dma.rxchan;
+	unsigned long attrs = DMA_PREP_CMD;
+	dma_cookie_t cookie;
+	unsigned int mapped;
+	int ret;
+
+	mapped = dma_map_sg_attrs(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+				  DMA_TO_DEVICE, attrs);
+	if (!mapped)
+		return -ENOMEM;
+
+	dma_desc = dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+					   DMA_MEM_TO_DEV, attrs);
+	if (!dma_desc) {
+		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
+
+	qce_desc->dma_desc = dma_desc;
+	cookie = dmaengine_submit(qce_desc->dma_desc);
+
+	ret = dma_submit_error(cookie);
+	if (ret)
+		return ret;
+
+	qce_dma_issue_pending(&qce->dma);
+
+	return 0;
+}
+
+static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma_data *dma,
+				  unsigned int addr, void *buf)
+{
+	struct qce_bam_transaction *bam_txn = dma->bam_txn;
+	struct bam_cmd_element *bam_ce_buf;
+	int bam_ce_size, cnt, idx;
+
+	idx = bam_txn->bam_ce_idx;
+	bam_ce_buf = &bam_txn->bam_ce[idx];
+	bam_prep_ce_le32(bam_ce_buf, addr, BAM_WRITE_COMMAND, *((__le32 *)buf));
+
+	bam_ce_buf = &bam_txn->bam_ce[bam_txn->pre_bam_ce_idx];
+	bam_txn->bam_ce_idx++;
+	bam_ce_size = (bam_txn->bam_ce_idx - bam_txn->pre_bam_ce_idx) * sizeof(*bam_ce_buf);
+
+	cnt = bam_txn->wr_sgl_cnt;
+
+	sg_set_buf(&bam_txn->wr_sgl[cnt], bam_ce_buf, bam_ce_size);
+
+	++bam_txn->wr_sgl_cnt;
+	bam_txn->pre_bam_ce_idx = bam_txn->bam_ce_idx;
+}
+
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
+{
+	unsigned int reg_addr = ((unsigned int)(qce->base_phys) + offset);
+
+	qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);
+}
 
 int devm_qce_dma_request(struct qce_device *qce)
 {
@@ -31,6 +125,21 @@ int devm_qce_dma_request(struct qce_device *qce)
 	if (!dma->result_buf)
 		return -ENOMEM;
 
+	dma->bam_txn = devm_kzalloc(dev, sizeof(*dma->bam_txn), GFP_KERNEL);
+	if (!dma->bam_txn)
+		return -ENOMEM;
+
+	dma->bam_txn->desc = devm_kzalloc(dev, sizeof(*dma->bam_txn->desc), GFP_KERNEL);
+	if (!dma->bam_txn->desc)
+		return -ENOMEM;
+
+	sg_init_table(dma->bam_txn->wr_sgl, QCE_BAM_CMD_SGL_SIZE);
+
+	qce->read_buf = dmam_alloc_coherent(qce->dev, QCE_MAX_REG_READ * sizeof(*qce->read_buf),
+					    &qce->read_buf_dma, GFP_KERNEL);
+	if (!qce->read_buf)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 483789d9fa98e79d1283de8297bf2fc2a773f3a7..f05dfa9e6b25bd60e32f45079a8bc7e6a4cf81f9 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,7 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_bam_transaction;
 struct qce_device;
 
 /* maximum data transfer block size between BAM and CE */
@@ -32,6 +33,7 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
+	struct qce_bam_transaction *bam_txn;
 };
 
 int devm_qce_dma_request(struct qce_device *qce);
@@ -43,5 +45,8 @@ int qce_dma_terminate_all(struct qce_dma_data *dma);
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val);
+int qce_submit_cmd_desc(struct qce_device *qce);
+void qce_clear_bam_transaction(struct qce_device *qce);
 
 #endif /* _DMA_H_ */

-- 
2.47.3


