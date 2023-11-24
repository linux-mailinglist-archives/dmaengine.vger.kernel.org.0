Return-Path: <dmaengine+bounces-235-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A067F787C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8170EB20BCE
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2022EB08;
	Fri, 24 Nov 2023 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6aVF5B/r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A671B5;
	Fri, 24 Nov 2023 08:02:49 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AODACUB023392;
	Fri, 24 Nov 2023 17:02:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=FIx1Yrt
	cLveCC02iWnLW1Lr8XBOPNYeVOFiiPu2xIQ8=; b=6aVF5B/rBs+91n+/V8KIzyk
	XDKQdZDb32l89xTctlCIVYJDixYEWC8v7grnnBlwcd6sOTEG/N91HqaTlU4i0ipR
	+FB71z+U/SwQVPjfILaCN1dRbIeQENZE3jy4vRdXSpQ9J72EdjJaOyLVO10qJmxd
	Og/zjepnYR6rw80ET33vhtEot7dqrXejT3H+WcToN3osOmsV3Y+uZu2YV7NDhYT6
	kZOStn7gXYmBRpWe+xN0Nmw2JhVcnAhZdZctF0BLzOI2Or9AXnwFXhxGQ2iaTjfh
	LYNpz0scLeyPXm8/0w1j1o+dlmhdZLConsZiFoLSCzcUXRhkcS5WQILuc2H4nPA=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uhr8ahh9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 17:02:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8141310002A;
	Fri, 24 Nov 2023 17:02:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64A46252233;
	Fri, 24 Nov 2023 17:02:36 +0100 (CET)
Received: from localhost (10.201.20.208) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 24 Nov
 2023 17:02:36 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Amelie Delaunay <amelie.delaunay@foss.st.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: dmatest: prevent using swiotlb buffer with nobounce parameter
Date: Fri, 24 Nov 2023 17:02:35 +0100
Message-ID: <20231124160235.2459326-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_02,2023-11-22_01,2023-05-22_02

Source and destination data buffers are allocated with GPF_KERNEL flag.
It means that, if the DDR is more than 2GB, buffers can be allocated above
the 32-bit addressable space. In this case, and if the dma controller is
only 32-bit compatible, swiotlb bounce buffer, located in the 32-bit
addressable space, is used and introduces a memcpy.

To prevent this extra memcpy, due to swiotlb bounce buffer use because
source or destination data buffer is allocated above the 32-bit addressable
space, force source and destination data buffers allocation with GPF_DMA
instead, when nobounce parameter is true.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/dmatest.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e47..a4f608837849 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -21,6 +21,10 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 
+static bool nobounce;
+module_param(nobounce, bool, 0644);
+MODULE_PARM_DESC(nobounce, "Prevent using swiotlb buffer (default: use swiotlb buffer)");
+
 static unsigned int test_buf_size = 16384;
 module_param(test_buf_size, uint, 0644);
 MODULE_PARM_DESC(test_buf_size, "Size of the memcpy test buffer");
@@ -90,6 +94,7 @@ MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
 
 /**
  * struct dmatest_params - test parameters.
+ * @nobounce:		prevent using swiotlb buffer
  * @buf_size:		size of the memcpy test buffer
  * @channel:		bus ID of the channel to test
  * @device:		bus ID of the DMA Engine to test
@@ -106,6 +111,7 @@ MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
  * @polled:		use polling for completion instead of interrupts
  */
 struct dmatest_params {
+	bool		nobounce;
 	unsigned int	buf_size;
 	char		channel[20];
 	char		device[32];
@@ -215,6 +221,7 @@ struct dmatest_done {
 struct dmatest_data {
 	u8		**raw;
 	u8		**aligned;
+	gfp_t		gfp_flags;
 	unsigned int	cnt;
 	unsigned int	off;
 };
@@ -533,7 +540,7 @@ static int dmatest_alloc_test_data(struct dmatest_data *d,
 		goto err;
 
 	for (i = 0; i < d->cnt; i++) {
-		d->raw[i] = kmalloc(buf_size + align, GFP_KERNEL);
+		d->raw[i] = kmalloc(buf_size + align, d->gfp_flags);
 		if (!d->raw[i])
 			goto err;
 
@@ -655,6 +662,13 @@ static int dmatest_func(void *data)
 		goto err_free_coefs;
 	}
 
+	src->gfp_flags = GFP_KERNEL;
+	dst->gfp_flags = GFP_KERNEL;
+	if (params->nobounce) {
+		src->gfp_flags = GFP_DMA;
+		dst->gfp_flags = GFP_DMA;
+	}
+
 	if (dmatest_alloc_test_data(src, buf_size, align) < 0)
 		goto err_free_coefs;
 
@@ -1093,6 +1107,7 @@ static void add_threaded_test(struct dmatest_info *info)
 	struct dmatest_params *params = &info->params;
 
 	/* Copy test parameters */
+	params->nobounce = nobounce;
 	params->buf_size = test_buf_size;
 	strscpy(params->channel, strim(test_channel), sizeof(params->channel));
 	strscpy(params->device, strim(test_device), sizeof(params->device));
-- 
2.25.1


