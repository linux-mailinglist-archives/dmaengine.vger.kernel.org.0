Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C59410BF6
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhISOoW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhISOoV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:44:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B4C061574;
        Sun, 19 Sep 2021 07:42:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s16so5561605pfk.0;
        Sun, 19 Sep 2021 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARNBD52Zo2dKyfRqVziezahUhbUPFH2O5Z3M855OwXw=;
        b=e7MgWHDY4Anh2CPoe30qpSB8Ne7ptPorY78r7vH90WZTc6j5rTg5bk3dOuIOoFNXqh
         8G++2DPezrIy8ljee1vvsSRhzkEOglDnUPLOwzak+Wf6XHaxX7k2rwz04o4hGLsyi3i9
         z13suuy7//MHi6DTBWqCVCbVKOIF7FPJ/ddMUWpBGwTinL/wzm2Q0Erl6otauL5kclGS
         2P2/x3pJ31lhaaek5gMUFgA18R9sRO420o8IiUcFqWBJ8LhIWy/E4Dsx8XkEgAxwTQJh
         oeDrZnwfYs+aj54ggTjcVEQB0pvVXwFac5w8zs3Oeo85GDaIRdbgcerG3CYkbhO44F5g
         ID9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARNBD52Zo2dKyfRqVziezahUhbUPFH2O5Z3M855OwXw=;
        b=sDUHqsjtAlyAZr1vixG8c/NzR9LAosCeTgCRLpBMaYi9P5aRJ7H0YJGvDIYXquOSUb
         rReNiImHZFfLK5n+/wMn6awgZJMvwkJRw9zyu/1DeWqVdtjInzmbM0N4tJMII8jQC0Jp
         LyToBsUrqZX6ntKC9KGVzNQWAoYYgy0z86Jd5R+MGaCeVKNS7ATDdSQu4s9Hhw80uKOz
         d8FQc2Bj8x4p8/qY1xR2KK/1pIMk0A+vZNYwqkQbX3Ua0yrnzD50Fxqaw7JLr8TudMx+
         l60BlF1lyesr2+5wvhWVyZKAtJ7KfxI1Jm4iIAr2ELsUsZMWiK/IwFEyy7AlVfWl89ej
         u2Ow==
X-Gm-Message-State: AOAM532p8Y1gtFuPmeYjwMwY3aadJn/w8Pw8UbmIEJ+Lje5UoT0Ah4c2
        CPnwcuRyZfgAq9tlzs+cuo+y7NBpjNRvjOLn
X-Google-Smtp-Source: ABdhPJy5j3ETLNhad063ol2jCH3J8kWQUnDiycZcCJs7PjSnIaDDG6upISD1mlQ5ILpV7Q+OSRHeBg==
X-Received: by 2002:a63:774e:: with SMTP id s75mr5996779pgc.73.1632062575855;
        Sun, 19 Sep 2021 07:42:55 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id v4sm11716151pff.11.2021.09.19.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:42:55 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/1] dmaengine: qcom: bam_dma: Add support for metadata
Date:   Sun, 19 Sep 2021 20:12:41 +0530
Message-Id: <20210919144242.31776-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919144242.31776-1-sireeshkodali1@gmail.com>
References: <20210919144242.31776-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some devices (like the IPA block) do not send the size of the DMA
transaction in band. Instead, the IPA driver needs to get the size of
the DMA transaction from the size of the BAM driver. This commit adds
support for attaching a pointer using the dmaengine API, to which it
will write the size of the DMA transaction.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index cebec638a994..911c0f2e88a2 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -71,6 +71,11 @@ struct bam_async_desc {
 
 	struct bam_desc_hw *curr_desc;
 
+	/* first descriptor position in fifo */
+	size_t fifo_index;
+	void *metadata;
+	size_t meta_len;
+
 	/* list node for the desc in the bam_chan list of descriptors */
 	struct list_head desc_node;
 	enum dma_transfer_direction dir;
@@ -593,6 +598,65 @@ static int bam_slave_config(struct dma_chan *chan,
 	return 0;
 }
 
+/**
+ * bam_update_metadata - update metadata buffer
+ * @async_desc: BAM async descriptior
+ * @fifo: BAM FIFO to read metadata from
+ *
+ * Updates metadata buffer (transfer size) based on values
+ * read from FIFO descriptors
+ */
+
+static void bam_update_metadata(struct bam_async_desc *async_desc,
+				struct bam_desc_hw *fifo)
+{
+	unsigned int len = 0, i;
+
+	if (!async_desc->metadata)
+		return;
+
+	for (i = 0; i < async_desc->xfer_len; ++i) {
+		unsigned int pos = (i + async_desc->fifo_index) % MAX_DESCRIPTORS;
+
+		len += fifo[pos].size;
+	}
+
+	switch (async_desc->meta_len)  {
+	case 4:
+		*((u32 *)async_desc->metadata) = len;
+		break;
+	case 8:
+		*((u64 *)async_desc->metadata) = len;
+		break;
+	}
+}
+
+/**
+ * bam_attach_metadata - attach metadata buffer to the async descriptor
+ * @desc: async descriptor
+ * @data: buffer pointer
+ * @len: length of passed buffer
+ */
+static int bam_attach_metadata(struct dma_async_tx_descriptor *desc, void *data,
+			       size_t len)
+{
+	struct bam_async_desc *async_desc;
+
+	if (!data || !(len == 2 || len == 4 || len == 8))
+		return -EINVAL;
+
+	async_desc = container_of(desc, struct bam_async_desc, vd.tx);
+
+	async_desc->metadata = data;
+	async_desc->meta_len = len;
+
+	return 0;
+}
+
+static struct dma_descriptor_metadata_ops metadata_ops = {
+	.attach = bam_attach_metadata,
+};
+
 /**
  * bam_prep_slave_sg - Prep slave sg transaction
  *
@@ -672,6 +736,8 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		} while (remainder > 0);
 	}
 
+	async_desc->vd.tx.metadata_ops = &metadata_ops;
+
 	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
 }
 
@@ -839,6 +905,11 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 			 * it gets restarted by the tasklet
 			 */
 			if (!async_desc->num_desc) {
+				struct bam_desc_hw *fifo = PTR_ALIGN(bchan->fifo_virt,
+						sizeof(struct bam_desc_hw));
+
+				bam_update_metadata(async_desc, fifo);
+
 				vchan_cookie_complete(&async_desc->vd);
 			} else {
 				list_add(&async_desc->vd.node,
@@ -1053,6 +1124,8 @@ static void bam_start_dma(struct bam_chan *bchan)
 			       sizeof(struct bam_desc_hw));
 		}
 
+		async_desc->fifo_index = bchan->tail;
+
 		bchan->tail += async_desc->xfer_len;
 		bchan->tail %= MAX_DESCRIPTORS;
 		list_add_tail(&async_desc->desc_node, &bchan->desc_list);
@@ -1331,6 +1404,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	bdev->common.src_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	bdev->common.dst_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
 	bdev->common.device_alloc_chan_resources = bam_alloc_chan;
 	bdev->common.device_free_chan_resources = bam_free_chan;
 	bdev->common.device_prep_slave_sg = bam_prep_slave_sg;
-- 
2.33.0

