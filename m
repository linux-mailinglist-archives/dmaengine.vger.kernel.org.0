Return-Path: <dmaengine+bounces-2883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAF955654
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE361F21B0A
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128F13E028;
	Sat, 17 Aug 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVR8yeBp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F5F4EE;
	Sat, 17 Aug 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723881878; cv=none; b=du6adMFkUpr28j/6y7Xe7y+EuMJhrIzJd48mXX8pYU817IjcE0yfs6jmf6gL+3PkBJ74sqZcrymEXecER+eNUd4f1rHJ0onfenyqUVzxChyMBtRFj4giEyXihCVLrbHFILV0/W+PWMTf4GC6jXzevdQYb0GY3SNSm0agMiXeL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723881878; c=relaxed/simple;
	bh=FdYib5VEQQQODf4d8ybgoxWnmuu4TR02wVJBEI4Dl+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCYM949eb51Shha3S4TMmt47i6rcENkMv+6gFBIjtKAnQglW+TJLFUz0kkIs2kpZBtxqrUhY2A1Fu7+/hPxT42gpZpW8Ze4I2N1QitiLML1OmOmHwEyfmM4ldqciXAMW/NQ9Y2X+oDxiKtWJXsFPNS0hZub63z4wSzKqjrOh5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVR8yeBp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd9e6189d5so24591825ad.3;
        Sat, 17 Aug 2024 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723881874; x=1724486674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+7T7ni2pkJssSlH2qzWCRsqGknRGzhjFVUXtBxor2g=;
        b=MVR8yeBpj2A/iQVvw8YO2qlRtPMsw1IpmZ++RtDcqcmrOFIc7v3kjsol7g+z5QUAVi
         v8aFwLmHYTy+0wJk/AM6RfqtWkZ8N+JjEA3sLL0GeoDDSJqC8poq/6vLQyQwNcXLSGYG
         aBNy+P+AlgJqovyx+EOLjNB1YdXrkCjU2TicKrvYpaAcVl7gq8umYHTYQoLpcKVcHIYl
         AEL18EOtoHuvYAvKspCLYIgkbTLjAerOnZdm/PzEc8iaKGaRR+IsIGBeYosFV4XzUGrv
         f7nXgXb5I+L+CjfkXi+snpFm5r+UYjH2jCkaCAlhTXH/F9easUKScaXehrzziT8rVsaw
         B7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723881874; x=1724486674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+7T7ni2pkJssSlH2qzWCRsqGknRGzhjFVUXtBxor2g=;
        b=scmF65WiElydn4UPhip5EDe5EGGBZDAfywDZKIIA2lB7NmQgV1nZJai3wGoKjn9L/+
         bbW+7ulSggSvZ8KsQpuH8YWNPbjCkLwNVXsnxhqTdWcnn7lzNiaQ++YQjGEyshzqlrsg
         OhZlpiA6e+8Z1+6PeNjMcZ3wK7i8klitsjA9UpMWDWGkkJtQzeW0BWyvp2rTA5buTfUF
         hN5GLu2m6I/RXrtauml2TDt1bbhAM/LS9Y4QogR5GWan8t4epBOSHSxJzDK7IwFXWFAI
         4bj+WxTzGKQHaJf8VmmPfRCjuChfiwGl1fYvqshh4nX36jneQncNYWM3wxwjuLv9ZZew
         vJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCViCw5sQiiXKSVjj775MUMrPK+pEmuRTukTTei4jnZLtj0ToyGXgGAkAZrWd+GuCzihruSQniOWGU2RFZn9eqosQX2P3jXvCPCNWcGH4JtNccF4Oas7/6y3a6CyrXAeva2fAZE2PWXuANMKjqqng+6Ue/H15Tp2BK1V1MAeGr5JotzQmSLMhLd2
X-Gm-Message-State: AOJu0YxXHFgVKRiCSNPUYsTVMBzysHT5BLdagQSO4BCLbBjmZkA3imRE
	vE+fvRm/SciTo60Yh5wDobrzMBR2z9n0qp8FWoHqYhTL0wrxwLPTz4ofBa5F
X-Google-Smtp-Source: AGHT+IGWVqrOTKL3I1DalArbYYaBbGAIh5PnYTrZarWCeNfIXmIxyW2mUuqAeqa4pIVotFEVqALnvQ==
X-Received: by 2002:a17:902:ce91:b0:1ff:5049:7353 with SMTP id d9443c01a7336-20203e84428mr64218625ad.19.1723881873892;
        Sat, 17 Aug 2024 01:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:1031:6067:f4e3:ef39:b58b:607e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a4c33sm35314115ad.284.2024.08.17.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 01:04:33 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ricardo@marliere.net
Cc: av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	vkoul@kernel.org,
	olivierdautricourt@gmail.com,
	sr@denx.de,
	ludovic.desroches@microchip.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	wangzhou1@hisilicon.com,
	haijie1@huawei.com,
	fenghua.yu@intel.com,
	dave.jiang@intel.com,
	zhoubinbin@loongson.cn,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	afaerber@suse.de,
	manivannan.sadhasivam@linaro.org,
	Basavaraj.Natikar@amd.com,
	linus.walleij@linaro.org,
	ldewangan@nvidia.com,
	jonathanh@nvidia.com,
	thierry.reding@gmail.com,
	laurent.pinchart@ideasonboard.com,
	michal.simek@amd.com,
	Frank.Li@nxp.com,
	n.shubin@yadro.com,
	yajun.deng@linux.dev,
	quic_jjohnson@quicinc.com,
	lizetao1@huawei.com,
	pliem@maxlinear.com,
	konrad.dybcio@linaro.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	bryan.odonoghue@linaro.org,
	linux@treblig.org,
	dan.carpenter@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH V2] dmaengine: Fix spelling mistakes
Date: Sat, 17 Aug 2024 13:34:08 +0530
Message-Id: <20240817080408.8010-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling mistakes in the DMA engine to improve readability
and clarity without altering functionality.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
V1: https://lore.kernel.org/all/20240810184333.34859-1-av2082000@gmail.com 
V1 -> V2:
- Write the commit description in imperative mode.
---
 drivers/dma/acpi-dma.c                  | 4 ++--
 drivers/dma/altera-msgdma.c             | 4 ++--
 drivers/dma/amba-pl08x.c                | 2 +-
 drivers/dma/at_hdmac.c                  | 6 +++---
 drivers/dma/bcm-sba-raid.c              | 4 ++--
 drivers/dma/bcm2835-dma.c               | 2 +-
 drivers/dma/ep93xx_dma.c                | 4 ++--
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h | 6 +++---
 drivers/dma/hisi_dma.c                  | 2 +-
 drivers/dma/idma64.c                    | 4 ++--
 drivers/dma/idxd/submit.c               | 2 +-
 drivers/dma/ioat/init.c                 | 2 +-
 drivers/dma/lgm/lgm-dma.c               | 2 +-
 drivers/dma/ls2x-apb-dma.c              | 4 ++--
 drivers/dma/mediatek/mtk-cqdma.c        | 4 ++--
 drivers/dma/mediatek/mtk-hsdma.c        | 2 +-
 drivers/dma/mv_xor.c                    | 4 ++--
 drivers/dma/mv_xor.h                    | 2 +-
 drivers/dma/mv_xor_v2.c                 | 2 +-
 drivers/dma/nbpfaxi.c                   | 2 +-
 drivers/dma/of-dma.c                    | 4 ++--
 drivers/dma/owl-dma.c                   | 2 +-
 drivers/dma/ppc4xx/adma.c               | 2 +-
 drivers/dma/ppc4xx/dma.h                | 2 +-
 drivers/dma/ptdma/ptdma.h               | 2 +-
 drivers/dma/qcom/bam_dma.c              | 4 ++--
 drivers/dma/qcom/gpi.c                  | 2 +-
 drivers/dma/qcom/qcom_adm.c             | 2 +-
 drivers/dma/sh/shdmac.c                 | 2 +-
 drivers/dma/ste_dma40.h                 | 2 +-
 drivers/dma/ste_dma40_ll.h              | 2 +-
 drivers/dma/tegra20-apb-dma.c           | 2 +-
 drivers/dma/xgene-dma.c                 | 2 +-
 drivers/dma/xilinx/xilinx_dpdma.c       | 4 ++--
 34 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 5906eae26e2a..a58a1600dd65 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -112,7 +112,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
 }
 
 /**
- * acpi_dma_parse_csrt - parse CSRT to exctract additional DMA resources
+ * acpi_dma_parse_csrt - parse CSRT to extract additional DMA resources
  * @adev:	ACPI device to match with
  * @adma:	struct acpi_dma of the given DMA controller
  *
@@ -305,7 +305,7 @@ EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_free);
  * found.
  *
  * Return:
- * 0, if no information is avaiable, -1 on mismatch, and 1 otherwise.
+ * 0, if no information is available, -1 on mismatch, and 1 otherwise.
  */
 static int acpi_dma_update_dma_spec(struct acpi_dma *adma,
 		struct acpi_dma_spec *dma_spec)
diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 0968176f323d..e6a6566b309e 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -153,7 +153,7 @@ struct msgdma_extended_desc {
 /**
  * struct msgdma_sw_desc - implements a sw descriptor
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @node: node to move from the free list to the tx list
  * @tx_list: transmit list node
  */
@@ -511,7 +511,7 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 	 * of the DMA controller. The descriptor will get flushed to the
 	 * FIFO, once the last word (control word) is written. Since we
 	 * are not 100% sure that memcpy() writes all word in the "correct"
-	 * oder (address from low to high) on all architectures, we make
+	 * order (address from low to high) on all architectures, we make
 	 * sure this control word is written last by single coding it and
 	 * adding some write-barriers here.
 	 */
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 73a5cfb4da8a..38cdbca59485 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2006 ARM Ltd.
  * Copyright (c) 2010 ST-Ericsson SA
- * Copyirght (c) 2017 Linaro Ltd.
+ * Copyright (c) 2017 Linaro Ltd.
  *
  * Author: Peter Pearse <peter.pearse@arm.com>
  * Author: Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 40052d1bd0b5..baebddc740b0 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -339,7 +339,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * @regs: memory mapped register base
  * @clk: dma controller clock
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
- * @all_chan_mask: all channels availlable in a mask
+ * @all_chan_mask: all channels available in a mask
  * @lli_pool: hw lli table
  * @memset_pool: hw memset pool
  * @chan: channels table to store at_dma_chan structures
@@ -668,7 +668,7 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
  * CTRLA is read in turn, next the DSCR is read a second time. If the two
  * consecutive read values of the DSCR are the same then we assume both refers
  * to the very same LLI as well as the CTRLA value read inbetween does. For
- * cyclic tranfers, the assumption is that a full loop is "not so fast". If the
+ * cyclic transfers, the assumption is that a full loop is "not so fast". If the
  * two DSCR values are different, we read again the CTRLA then the DSCR till two
  * consecutive read values from DSCR are equal or till the maximum trials is
  * reach. This algorithm is very unlikely not to find a stable value for DSCR.
@@ -700,7 +700,7 @@ static int atc_get_llis_residue(struct at_dma_chan *atchan,
 			break;
 
 		/*
-		 * DSCR has changed inside the DMA controller, so the previouly
+		 * DSCR has changed inside the DMA controller, so the previously
 		 * read value of CTRLA may refer to an already processed
 		 * descriptor hence could be outdated. We need to update ctrla
 		 * to match the current descriptor.
diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index fbaacb4c19b2..cfa6e1167a1f 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -15,7 +15,7 @@
  * number of hardware rings over one or more SBA hardware devices. By
  * design, the internal buffer size of SBA hardware device is limited
  * but all offload operations supported by SBA can be broken down into
- * multiple small size requests and executed parallely on multiple SBA
+ * multiple small size requests and executed parallelly on multiple SBA
  * hardware devices for achieving high through-put.
  *
  * The Broadcom SBA RAID driver does not require any register programming
@@ -135,7 +135,7 @@ struct sba_device {
 	u32 max_xor_srcs;
 	u32 max_resp_pool_size;
 	u32 max_cmds_pool_size;
-	/* Maibox client and Mailbox channels */
+	/* Mailbox client and Mailbox channels */
 	struct mbox_client client;
 	struct mbox_chan *mchan;
 	struct device *mbox_dev;
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..e1b92b4d7b05 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -369,7 +369,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	/* the last frame requires extra flags */
 	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
 
-	/* detect a size missmatch */
+	/* detect a size mismatch */
 	if (buf_len && (d->size != buf_len))
 		goto error_cb;
 
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d6c60635e90d..4ee337e78c23 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -841,7 +841,7 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	desc = container_of(tx, struct ep93xx_dma_desc, txd);
 
 	/*
-	 * If nothing is currently prosessed, we push this descriptor
+	 * If nothing is currently processed, we push this descriptor
 	 * directly to the hardware. Otherwise we put the descriptor
 	 * to the pending queue.
 	 */
@@ -1025,7 +1025,7 @@ ep93xx_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
  * @chan: channel
  * @sgl: list of buffers to transfer
  * @sg_len: number of entries in @sgl
- * @dir: direction of tha DMA transfer
+ * @dir: direction of the DMA transfer
  * @flags: flags for the descriptor
  * @context: operation context (ignored)
  *
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
index 2c80077cb7c0..36c284a3d184 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
@@ -12,8 +12,8 @@ struct dpaa2_qdma_sd_d {
 	u32 rsv:32;
 	union {
 		struct {
-			u32 ssd:12; /* souce stride distance */
-			u32 sss:12; /* souce stride size */
+			u32 ssd:12; /* source stride distance */
+			u32 sss:12; /* source stride size */
 			u32 rsv1:8;
 		} sdf;
 		struct {
@@ -48,7 +48,7 @@ struct dpaa2_qdma_sd_d {
 #define QDMA_SER_DISABLE	(8) /* no notification */
 #define QDMA_SER_CTX		BIT(8) /* notification by FQD_CTX[fqid] */
 #define QDMA_SER_DEST		(2 << 8) /* notification by destination desc */
-#define QDMA_SER_BOTH		(3 << 8) /* soruce and dest notification */
+#define QDMA_SER_BOTH		(3 << 8) /* source and dest notification */
 #define QDMA_FD_SPF_ENALBE	BIT(30) /* source prefetch enable */
 
 #define QMAN_FD_VA_ENABLE	BIT(14) /* Address used is virtual address */
diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 4c47bff81064..25a4134be36b 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -677,7 +677,7 @@ static void hisi_dma_init_hw_qp(struct hisi_dma_dev *hdma_dev, u32 index)
 		writel_relaxed(tmp, addr);
 
 		/*
-		 * 0 - dma should process FLR whith CPU.
+		 * 0 - dma should process FLR with CPU.
 		 * 1 - dma not process FLR, only cpu process FLR.
 		 */
 		addr = q_base + HISI_DMA_HIP09_DMA_FLR_DISABLE +
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index e3505e56784b..2192b7136c2a 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -290,7 +290,7 @@ static void idma64_desc_fill(struct idma64_chan *idma64c,
 		desc->length += hw->len;
 	} while (i);
 
-	/* Trigger an interrupt after the last block is transfered */
+	/* Trigger an interrupt after the last block is transferred */
 	lli->ctllo |= IDMA64C_CTLL_INT_EN;
 
 	/* Disable LLP transfer in the last block */
@@ -364,7 +364,7 @@ static size_t idma64_active_desc_size(struct idma64_chan *idma64c)
 	if (!i)
 		return bytes;
 
-	/* The current chunk is not fully transfered yet */
+	/* The current chunk is not fully transferred yet */
 	bytes += desc->hw[--i].len;
 
 	return bytes - IDMA64C_CTLH_BLOCK_TS(ctlhi);
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 817a564413b0..94eca25ae9b9 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -134,7 +134,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	 * completing the descriptor will return desc to allocator and
 	 * the desc can be acquired by a different process and the
 	 * desc->list can be modified.  Delete desc from list so the
-	 * list trasversing does not get corrupted by the other process.
+	 * list traversing does not get corrupted by the other process.
 	 */
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del_init(&d->list);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 7b502b60b38b..cc9ddd6c325b 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -905,7 +905,7 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 
 	op = IOAT_OP_XOR_VAL;
 
-	/* validate the sources with the destintation page */
+	/* validate the sources with the destination page */
 	for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
 		xor_val_srcs[i] = xor_srcs[i];
 	xor_val_srcs[i] = dest;
diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 4117c7b67e9c..8173c3f1075a 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -107,7 +107,7 @@
  * If header mode is set in DMA descriptor,
  *   If bit 30 is disabled, HDR_LEN must be configured according to channel
  *     requirement.
- *   If bit 30 is enabled(checksum with heade mode), HDR_LEN has no need to
+ *   If bit 30 is enabled(checksum with header mode), HDR_LEN has no need to
  *     be configured. It will enable check sum for switch
  * If header mode is not set in DMA descriptor,
  *   This register setting doesn't matter
diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
index a49913f3ed3f..9652e8666722 100644
--- a/drivers/dma/ls2x-apb-dma.c
+++ b/drivers/dma/ls2x-apb-dma.c
@@ -33,11 +33,11 @@
 #define LDMA_STOP		BIT(4) /* DMA stop operation */
 #define LDMA_CONFIG_MASK	GENMASK(4, 0) /* DMA controller config bits mask */
 
-/* Bitfields in ndesc_addr field of HW decriptor */
+/* Bitfields in ndesc_addr field of HW descriptor */
 #define LDMA_DESC_EN		BIT(0) /*1: The next descriptor is valid */
 #define LDMA_DESC_ADDR_LOW	GENMASK(31, 1)
 
-/* Bitfields in cmd field of HW decriptor */
+/* Bitfields in cmd field of HW descriptor */
 #define LDMA_INT		BIT(1) /* Enable DMA interrupts */
 #define LDMA_DATA_DIRECTION	BIT(12) /* 1: write to device, 0: read from device */
 
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 529100c5b9f5..b69eabf12a24 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -518,7 +518,7 @@ mtk_cqdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
 		/* setup dma channel */
 		cvd[i]->ch = c;
 
-		/* setup sourece, destination, and length */
+		/* setup source, destination, and length */
 		tlen = (len > MTK_CQDMA_MAX_LEN) ? MTK_CQDMA_MAX_LEN : len;
 		cvd[i]->len = tlen;
 		cvd[i]->src = src;
@@ -617,7 +617,7 @@ static int mtk_cqdma_alloc_chan_resources(struct dma_chan *c)
 	u32 i, min_refcnt = U32_MAX, refcnt;
 	unsigned long flags;
 
-	/* allocate PC with the minimun refcount */
+	/* allocate PC with the minimum refcount */
 	for (i = 0; i < cqdma->dma_channels; ++i) {
 		refcnt = refcount_read(&cqdma->pc[i]->refcnt);
 		if (refcnt < min_refcnt) {
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 36ff11e909ea..58c7961ab9ad 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -226,7 +226,7 @@ struct mtk_hsdma_soc {
  * @pc_refcnt:		     Track how many VCs are using the PC
  * @lock:		     Lock protect agaisting multiple VCs access PC
  * @soc:		     The pointer to area holding differences among
- *			     vaious platform
+ *			     various platform
  */
 struct mtk_hsdma_device {
 	struct dma_device ddev;
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index bcd3b623ac6c..43efce77bb57 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -414,7 +414,7 @@ mv_xor_tx_submit(struct dma_async_tx_descriptor *tx)
 		if (!mv_chan_is_busy(mv_chan)) {
 			u32 current_desc = mv_chan_get_current_desc(mv_chan);
 			/*
-			 * and the curren desc is the end of the chain before
+			 * and the current desc is the end of the chain before
 			 * the append, then we need to start the channel
 			 */
 			if (current_desc == old_chain_tail->async_tx.phys)
@@ -1074,7 +1074,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	if (!mv_chan->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);
 
-	/* discover transaction capabilites from the platform data */
+	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = cap_mask;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index d86086b05b0e..c87cefd38a07 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -99,7 +99,7 @@ struct mv_xor_device {
  * @common: common dmaengine channel object members
  * @slots_allocated: records the actual size of the descriptor slot pool
  * @irq_tasklet: bottom half where mv_xor_slot_cleanup runs
- * @op_in_desc: new mode of driver, each op is writen to descriptor.
+ * @op_in_desc: new mode of driver, each op is written to descriptor.
  */
 struct mv_xor_chan {
 	int			pending;
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 97ebc791a30b..c8c67f4d982c 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -175,7 +175,7 @@ struct mv_xor_v2_device {
  * struct mv_xor_v2_sw_desc - implements a xor SW descriptor
  * @idx: descriptor index
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @free_list: node of the free SW descriprots list
 */
 struct mv_xor_v2_sw_desc {
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index c08916339aa7..3b011a91d48e 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -897,7 +897,7 @@ static int nbpf_config(struct dma_chan *dchan,
 	/*
 	 * We could check config->slave_id to match chan->terminal here,
 	 * but with DT they would be coming from the same source, so
-	 * such a check would be superflous
+	 * such a check would be superfluous
 	 */
 
 	chan->slave_dst_addr = config->dst_addr;
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index e588fff9f21d..423442e55d36 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -26,7 +26,7 @@ static DEFINE_MUTEX(of_dma_lock);
  *
  * Finds a DMA controller with matching device node and number for dma cells
  * in a list of registered DMA controllers. If a match is found a valid pointer
- * to the DMA data stored is retuned. A NULL pointer is returned if no match is
+ * to the DMA data stored is returned. A NULL pointer is returned if no match is
  * found.
  */
 static struct of_dma *of_dma_find_controller(const struct of_phandle_args *dma_spec)
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
  *
  * This function can be used as the of xlate callback for DMA driver which wants
  * to match the channel based on the channel id. When using this xlate function
- * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
+ * the #dma-cells property of the DMA controller dt node needs to be set to 1.
  * The data parameter of of_dma_controller_register must be a pointer to the
  * dma_device struct the function should match upon.
  *
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index e001f4f7aa64..aa436f9e3571 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1156,7 +1156,7 @@ static int owl_dma_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Eventhough the DMA controller is capable of generating 4
+	 * Even though the DMA controller is capable of generating 4
 	 * IRQ's for DMA priority feature, we only use 1 IRQ for
 	 * simplification.
 	 */
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index bbb60a970dab..7b78759ac734 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -9,7 +9,7 @@
  */
 
 /*
- * This driver supports the asynchrounous DMA copy and RAID engines available
+ * This driver supports the asynchronous DMA copy and RAID engines available
  * on the AMCC PPC440SPe Processors.
  * Based on the Intel Xscale(R) family of I/O Processors (IOP 32x, 33x, 134x)
  * ADMA driver written by D.Williams.
diff --git a/drivers/dma/ppc4xx/dma.h b/drivers/dma/ppc4xx/dma.h
index 1ff4be23db0f..b5725481bfa6 100644
--- a/drivers/dma/ppc4xx/dma.h
+++ b/drivers/dma/ppc4xx/dma.h
@@ -14,7 +14,7 @@
 
 /* Number of elements in the array with statical CDBs */
 #define	MAX_STAT_DMA_CDBS	16
-/* Number of DMA engines available on the contoller */
+/* Number of DMA engines available on the controller */
 #define DMA_ENGINES_NUM		2
 
 /* Maximum h/w supported number of destinations */
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 21b4bf895200..39bc37268235 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -192,7 +192,7 @@ struct pt_cmd_queue {
 	/* Queue dma pool */
 	struct dma_pool *dma_pool;
 
-	/* Queue base address (not neccessarily aligned)*/
+	/* Queue base address (not necessarily aligned)*/
 	struct ptdma_desc *qbase;
 
 	/* Aligned queue start address (per requirement) */
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..2d7550b8e03e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -440,7 +440,7 @@ static void bam_reset(struct bam_device *bdev)
 	val |= BAM_EN;
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
-	/* set descriptor threshhold, start with 4 bytes */
+	/* set descriptor threshold, start with 4 bytes */
 	writel_relaxed(DEFAULT_CNT_THRSHLD,
 			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
@@ -667,7 +667,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	for_each_sg(sgl, sg, sg_len, i)
 		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_FIFO_SIZE);
 
-	/* allocate enough room to accomodate the number of entries */
+	/* allocate enough room to accommodate the number of entries */
 	async_desc = kzalloc(struct_size(async_desc, desc, num_alloc),
 			     GFP_NOWAIT);
 
diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index e6ebd688d746..52a7c8f2498f 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1856,7 +1856,7 @@ static void gpi_issue_pending(struct dma_chan *chan)
 
 	read_lock_irqsave(&gpii->pm_lock, pm_lock_flags);
 
-	/* move all submitted discriptors to issued list */
+	/* move all submitted descriptors to issued list */
 	spin_lock_irqsave(&gchan->vc.lock, flags);
 	if (vchan_issue_pending(&gchan->vc))
 		vd = list_last_entry(&gchan->vc.desc_issued,
diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index 53f4273b657c..c1db398adc84 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -650,7 +650,7 @@ static enum dma_status adm_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	/*
 	 * residue is either the full length if it is in the issued list, or 0
 	 * if it is in progress.  We have no reliable way of determining
-	 * anything inbetween
+	 * anything in between
 	 */
 	dma_set_residue(txstate, residue);
 
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 7cc9eb2217e8..8ead0a1fd237 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -318,7 +318,7 @@ static void sh_dmae_setup_xfer(struct shdma_chan *schan,
 }
 
 /*
- * Find a slave channel configuration from the contoller list by either a slave
+ * Find a slave channel configuration from the controller list by either a slave
  * ID in the non-DT case, or by a MID/RID value in the DT case
  */
 static const struct sh_dmae_slave_config *dmae_find_slave(
diff --git a/drivers/dma/ste_dma40.h b/drivers/dma/ste_dma40.h
index c697bfe16a01..a90c786acc1f 100644
--- a/drivers/dma/ste_dma40.h
+++ b/drivers/dma/ste_dma40.h
@@ -4,7 +4,7 @@
 #define STE_DMA40_H
 
 /*
- * Maxium size for a single dma descriptor
+ * Maximum size for a single dma descriptor
  * Size is limited to 16 bits.
  * Size is in the units of addr-widths (1,2,4,8 bytes)
  * Larger transfers will be split up to multiple linked desc
diff --git a/drivers/dma/ste_dma40_ll.h b/drivers/dma/ste_dma40_ll.h
index c504e855eb02..2e30e9a94a1e 100644
--- a/drivers/dma/ste_dma40_ll.h
+++ b/drivers/dma/ste_dma40_ll.h
@@ -369,7 +369,7 @@ struct d40_phy_lli_bidir {
  * @lcsp02: Either maps to register lcsp0 if src or lcsp2 if dst.
  * @lcsp13: Either maps to register lcsp1 if src or lcsp3 if dst.
  *
- * This struct must be 8 bytes aligned since it will be accessed directy by
+ * This struct must be 8 bytes aligned since it will be accessed directly by
  * the DMA. Never add any none hw mapped registers to this struct.
  */
 
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index ac69778827f2..7d1acda2d72b 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -463,7 +463,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
 
 	/*
 	 * If interrupt is pending then do nothing as the ISR will handle
-	 * the programing for new request.
+	 * the programming for new request.
 	 */
 	if (status & TEGRA_APBDMA_STATUS_ISE_EOC) {
 		dev_err(tdc2dev(tdc),
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index fd4397adeb79..275848a9c450 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1742,7 +1742,7 @@ static int xgene_dma_probe(struct platform_device *pdev)
 	/* Initialize DMA channels software state */
 	xgene_dma_init_channels(pdma);
 
-	/* Configue DMA rings */
+	/* Configure DMA rings */
 	ret = xgene_dma_init_rings(pdma);
 	if (ret)
 		goto err_clk_enable;
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 36bd4825d389..c26ebced866c 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -149,7 +149,7 @@ struct xilinx_dpdma_chan;
  * @addr_ext: upper 16 bit of 48 bit address (next_desc and src_addr)
  * @next_desc: next descriptor 32 bit address
  * @src_addr: payload source address (1st page, 32 LSB)
- * @addr_ext_23: payload source address (3nd and 3rd pages, 16 LSBs)
+ * @addr_ext_23: payload source address (2nd and 3rd pages, 16 LSBs)
  * @addr_ext_45: payload source address (4th and 5th pages, 16 LSBs)
  * @src_addr2: payload source address (2nd page, 32 LSB)
  * @src_addr3: payload source address (3rd page, 32 LSB)
@@ -210,7 +210,7 @@ struct xilinx_dpdma_tx_desc {
  * @vchan: virtual DMA channel
  * @reg: register base address
  * @id: channel ID
- * @wait_to_stop: queue to wait for outstanding transacitons before stopping
+ * @wait_to_stop: queue to wait for outstanding transactions before stopping
  * @running: true if the channel is running
  * @first_frame: flag for the first frame of stream
  * @video_group: flag if multi-channel operation is needed for video channels
-- 
2.25.1


