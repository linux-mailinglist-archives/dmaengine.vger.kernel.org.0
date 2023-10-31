Return-Path: <dmaengine+bounces-27-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8585C7DC4A9
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244322815BD
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641746B7;
	Tue, 31 Oct 2023 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207DA56
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:55:20 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090A3DA;
	Mon, 30 Oct 2023 19:55:18 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvFgpUV_1698720914;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFgpUV_1698720914)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:55:15 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: dave.jiang@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	tony.luck@intel.com,
	fenghua.yu@intel.com
Cc: jing.lin@intel.com,
	ashok.raj@intel.com,
	sanjay.k.kumar@intel.com,
	megha.dey@intel.com,
	jacob.jun.pan@intel.com,
	yi.l.liu@intel.com,
	tglx@linutronix.de
Subject: [PATCH v4 2/2] dmaengine: idxd: Fix incorrect descriptions for GRPCFG register
Date: Tue, 31 Oct 2023 10:55:11 +0800
Message-Id: <20231031025511.1516342-3-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231031025511.1516342-1-guanjun@linux.alibaba.com>
References: <20231031025511.1516342-1-guanjun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

Fix incorrect descriptions for the GRPCFG register which has three
sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
No functional changes

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/registers.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 7b54a3939ea1..315c004f58e4 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -440,12 +440,14 @@ union wqcfg {
 /*
  * This macro calculates the offset into the GRPCFG register
  * idxd - struct idxd *
- * n - wq id
- * ofs - the index of the 32b dword for the config register
+ * n - group id
+ * ofs - the index of the 64b qword for the config register
  *
- * The WQCFG register block is divided into groups per each wq. The n index
- * allows us to move to the register group that's for that particular wq.
- * Each register is 32bits. The ofs gives us the number of register to access.
+ * The GRPCFG register block is divided into three sub-registers, which
+ * are GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index allows us to move
+ * to the register block that contains the three sub-registers.
+ * Each register block is 64bits. And the ofs gives us the offset
+ * within the GRPWQCFG register to access.
  */
 #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
 					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))
-- 
2.39.3


