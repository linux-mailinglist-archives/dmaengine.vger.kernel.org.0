Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029381045B4
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKTVY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:24:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:50802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKTVY5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:24:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="259158855"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2019 13:24:55 -0800
Subject: [PATCH RFC 12/14] dmaengine: request submit optimization
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:24:55 -0700
Message-ID: <157428509565.36836.4500949956170655742.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adding dsa direct call to dmaengine for optimization. Spectre-v2 makes
indirect branches expensive. Adding direct call to the driver in order
to mitigate that and reduce cycles to initiate a descriptor submit.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c    |    5 +++--
 include/linux/dmaengine.h |    6 +++++-
 include/linux/idxd.h      |   23 +++++++++++++++++++++++
 usr/include/Makefile      |    1 +
 4 files changed, 32 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/idxd.h

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 07fbc98668ae..b9b4621e504a 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmaengine.h>
 #include <uapi/linux/idxd.h>
+#include <linux/idxd.h>
 #include "../dmaengine.h"
 #include "registers.h"
 #include "idxd.h"
@@ -29,8 +30,7 @@ void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res)
 	}
 }
 
-static int idxd_dma_submit_request(struct dma_chan *chan,
-				   struct dma_request *req)
+int idxd_dma_submit_request(struct dma_chan *chan, struct dma_request *req)
 {
 	struct idxd_wq *wq = container_of(chan, struct idxd_wq, dma_chan);
 
@@ -39,6 +39,7 @@ static int idxd_dma_submit_request(struct dma_chan *chan,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(idxd_dma_submit_request);
 
 static int idxd_dma_alloc_chan_resources(struct dma_chan *chan)
 {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 220d241d71ed..cebfa8db60a0 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1395,6 +1395,7 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 }
 #endif
 
+#include <linux/idxd.h>
 /* dmaengine_submit_request - helper routine for caller to submit
  *				a DMA request.
  * @chan: dma channel context
@@ -1412,7 +1413,10 @@ static inline int dmaengine_submit_request(struct dma_chan *chan,
 	if (!ddev->device_submit_request)
 		return -EINVAL;
 
-	return ddev->device_submit_request(chan, req);
+	if (ddev->device_submit_request == idxd_dma_submit_request)
+		return idxd_dma_submit_request(chan, req);
+	else
+		return ddev->device_submit_request(chan, req);
 }
 
 /* dmaengine_submit_request_and_wait - helper routine for caller to submit
diff --git a/include/linux/idxd.h b/include/linux/idxd.h
new file mode 100644
index 000000000000..3b7b3fbe86c8
--- /dev/null
+++ b/include/linux/idxd.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#ifndef _LINUX_IDXD_H_
+#define _LINUX_IDXD_H_
+
+struct dmaengine_result;
+struct dma_request;
+struct dma_chan;
+
+typedef void (*dma_async_tx_callback_result)(void *dma_async_param,
+		const struct dmaengine_result *result);
+
+#if IS_ENABLED(CONFIG_INTEL_IDXD)
+int idxd_dma_submit_request(struct dma_chan *chan, struct dma_request *req);
+#else
+static inline int idxd_dma_submit_request(struct dma_chan *chan,
+					  struct dma_request *req)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 57b20f7b6729..e5cf680efbc2 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -29,6 +29,7 @@ header-test- += linux/android/binderfs.h
 header-test-$(CONFIG_CPU_BIG_ENDIAN) += linux/byteorder/big_endian.h
 header-test-$(CONFIG_CPU_LITTLE_ENDIAN) += linux/byteorder/little_endian.h
 header-test- += linux/coda.h
+header-test- += linux/iadx.h
 header-test- += linux/elfcore.h
 header-test- += linux/errqueue.h
 header-test- += linux/fsmap.h

