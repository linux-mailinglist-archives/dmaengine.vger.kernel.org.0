Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE160EF73
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 07:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ0FUy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 01:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiJ0FUv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 01:20:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CA153E09;
        Wed, 26 Oct 2022 22:20:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e4so448611pfl.2;
        Wed, 26 Oct 2022 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=356wsUtfDj9Of8EBeD21kcVauGg1lCBRFlRX+/DNRBM=;
        b=ahouZy8C+S7spZ0vVK6XNt6vbx+n3vPFmNXZfu+SJ/8ckoT29WDQy2cb/1fc4VipLC
         tSSOTjUsTWLkodKJb4Z2qd7v8Ps8cZGMGmxoAUJ72Gpzv7VF6vmgFzpMTVArkiLLRQc6
         El2Slf8ioPqohUhwPVnpheZTTST1rcHcyrgWz/xyeucSQM8NJUK71lCn9EkiqheYWOoO
         1QH9RQ06/D+I6Mx0AQVb9HOXBzcj5caq2eY5BdF1baPkFPqfkI9Ui865U3OvTm0Y3zRq
         kni9cPbi404/a5w2cjJC0yK5HApEnH0OxwpQ3U2lfE8vPCYrggJ0mti+N2IbP6o9vLq4
         B5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=356wsUtfDj9Of8EBeD21kcVauGg1lCBRFlRX+/DNRBM=;
        b=OYEnAuh/UJgQJF6qcu3mra0PVLQF6N9YbTfhNujIy6w1qJIlHwRp0UETjh3uuMXBBC
         ADtDsdB61SKk4TiG8OMHhpqFkah93jzc8neXCY9LAV1sEGfETX3hqu5AbkMfmHC3BiTa
         +FhuqrT2aAxoFnV+MsWaCMy78cDhF4U6Y1aElBsnWnwnI31fM2br2ga2Hb8QjYWQ4qzZ
         KUci51iGyIM8Pzh6O3cA2a0R/LA/tVRatSiRTentwr7r+aTibBfRINHVPM0tlJfOHMt2
         xJiG6VZLCJyOH0zNCaWENGIfhwM94sz35pKKk8BLSwn4xKj2m6239r0s30bv3RMH2D4p
         JozQ==
X-Gm-Message-State: ACrzQf0uoCDOD+41EMbQfWoyKo+9TwtQI+Qz6NNhv3HazVb38LzxBGYn
        OUuyN4SruOIks6vDTl4wm3Q=
X-Google-Smtp-Source: AMsMyM47Lz9/iaBrP9YC1HpfaUARkHVrv8BEscxyCyP9xxb5YsX4tfSNmlV3cvOnn6qUxiu1288o5A==
X-Received: by 2002:aa7:9292:0:b0:56b:c4d3:a723 with SMTP id j18-20020aa79292000000b0056bc4d3a723mr20246911pfa.57.1666848049752;
        Wed, 26 Oct 2022 22:20:49 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:dcaa:bb0:9908:b137:b0b4])
        by smtp.googlemail.com with ESMTPSA id u9-20020a17090341c900b00186afd756edsm218874ple.283.2022.10.26.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:20:49 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     andersson@kernel.org, agross@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     dmaengine@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v2 1/1] dmaengine: qcom: bam_dma: Add support for metadata
Date:   Thu, 27 Oct 2022 10:50:07 +0530
Message-Id: <20221027052007.47403-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027052007.47403-1-sireeshkodali1@gmail.com>
References: <20221027052007.47403-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add client metadata support for receiving information about transfers.
Only type of metadata implemented is amount of transferred bytes. This
can be used to know how much data is actually received if information
transferred doesn't contain header with size or is aggregated.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/dma/qcom/bam_dma.c       | 57 ++++++++++++++++++++++++++++++++
 include/linux/dma/qcom_bam_dma.h |  8 +++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 3135a3e4a167..264a9a2e199f 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/qcom_bam_dma.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -70,6 +71,7 @@ struct bam_async_desc {
 	u16 flags;
 
 	struct bam_desc_hw *curr_desc;
+	struct bam_dma_metadata *metadata;
 
 	/* list node for the desc in the bam_chan list of descriptors */
 	struct list_head desc_node;
@@ -418,6 +420,52 @@ static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 		r.ee_mult * bdev->ee;
 }
 
+/**
+ * bam_update_metadata - update metadata buffer
+ * @bchan: BAM channel to read metadata from
+ * @async_desc: BAM async descriptior
+ *
+ * Updates metadata buffer (transfer size) based on values
+ * read from FIFO descriptors at bchan->head
+ */
+
+static inline void bam_update_metadata(struct bam_chan *bchan,
+				       struct bam_async_desc *async_desc)
+{
+	unsigned int i, e, len = 0;
+	struct bam_desc_hw *fifo;
+
+	if (!async_desc->metadata)
+		return;
+
+	fifo = PTR_ALIGN(bchan->fifo_virt, sizeof(struct bam_desc_hw));
+	for (i = bchan->head, e = i + async_desc->xfer_len; i < e; i++)
+		len += fifo[i % MAX_DESCRIPTORS].size;
+
+	async_desc->metadata->xfer_len_bytes += len;
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
+	if (!data || len != sizeof(struct bam_dma_metadata))
+		return -EINVAL;
+
+	async_desc = container_of(desc, struct bam_async_desc, vd.tx);
+	async_desc->metadata = data;
+	async_desc->metadata->xfer_len_bytes = 0;
+
+	return 0;
+}
+
 /**
  * bam_reset() - reset and initialize BAM registers
  * @bdev: bam device
@@ -456,6 +504,10 @@ static void bam_reset(struct bam_device *bdev)
 	writel_relaxed(BAM_IRQ_MSK, bam_addr(bdev, 0, BAM_IRQ_SRCS_MSK_EE));
 }
 
+static struct dma_descriptor_metadata_ops metadata_ops = {
+	.attach = bam_attach_metadata,
+};
+
 /**
  * bam_reset_channel - Reset individual BAM DMA channel
  * @bchan: bam channel
@@ -714,6 +766,8 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		} while (remainder > 0);
 	}
 
+	async_desc->vd.tx.metadata_ops = &metadata_ops;
+
 	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
 }
 
@@ -867,6 +921,8 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 			if (avail < async_desc->xfer_len)
 				break;
 
+			bam_update_metadata(bchan, async_desc);
+
 			/* manage FIFO */
 			bchan->head += async_desc->xfer_len;
 			bchan->head %= MAX_DESCRIPTORS;
@@ -1347,6 +1403,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	bdev->common.src_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	bdev->common.dst_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
 	bdev->common.device_alloc_chan_resources = bam_alloc_chan;
 	bdev->common.device_free_chan_resources = bam_free_chan;
 	bdev->common.device_prep_slave_sg = bam_prep_slave_sg;
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..8168b0573f45 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -8,6 +8,14 @@
 
 #include <asm/byteorder.h>
 
+/*
+ * This data type is used as client metadata buffer in bam driver.
+ */
+struct bam_dma_metadata {
+	/* Actual number of bytes transferred by hardware */
+	size_t xfer_len_bytes;
+};
+
 /*
  * This data type corresponds to the native Command Element
  * supported by BAM DMA Engine.
-- 
2.38.1

