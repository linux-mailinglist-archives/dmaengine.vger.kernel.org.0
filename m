Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1A410BE4
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhISOe7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhISOex (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:34:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC50C061574;
        Sun, 19 Sep 2021 07:33:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a7so720940plm.1;
        Sun, 19 Sep 2021 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARNBD52Zo2dKyfRqVziezahUhbUPFH2O5Z3M855OwXw=;
        b=IkghO2nIRjhMLXr+PtXy0Xq1ZYLxkIWAKccD+9z17jtcDBW7ejzWk0NBsfGb50zi5S
         mm6L+5Z4iTMoUSJ7WkitlW5h3n+YNlWFw1K9TDMSXWPejYaBuOiKJ8G7DrgfgbVTtFYU
         tB9bfzpgF8urUDlCW3bpc6kEmOhMTOk9AEoh7WotTHdTEoqbUCeXMSd3o+S3ji+WfMFy
         k9/EnbLN/wGA5+HJNA4bGdo2CtyvYEc/aEslk0tnlBIdXY+CTjSnWTAxQXcAhpNU7kS0
         u53aHZQ6mF5m55a2ze39wlvIqM1ecEorAODwph1DQGgp4u1bnecBHHhwST0Y3zkHXqD3
         69TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARNBD52Zo2dKyfRqVziezahUhbUPFH2O5Z3M855OwXw=;
        b=4eavg3odMlQQPbetaCwUxSgYsKadzVqxRmydWTOmaWXBS/10Hw3RXfq9EJQi7e7uQE
         eBMSEI4EyvuEzOap90kg+go8DA2PXma1XZXbk5A1rFLRaFNpDa6oD85Bgf0+3FwqL6L4
         KYOCzne8YbHs5IEel2F4frZStxFQiGlbPvbNH6statwWlJ5vdeWnyxzDnINcZVrkgLJU
         T8lKT0wXZtj99tKOwuFii02/1MCAMdGUtieNIq/Gw5mRKOujcTE3KsPzHOAuLBNHRIxd
         siwyetwMx4F4t2UXg6/FTfp5j5du1oAcQhaKE9JcyFUhAJ/OLME9qzPosoU8mHbOKAQ7
         wi0w==
X-Gm-Message-State: AOAM532B1VPrJS3SQgahZgxF5P0+zikN7hoIVZ7jcMDO+iotPb+zIN6K
        RI4Axp31Y4lLVfTenRMpcbkrSxeVhVRC2mgK
X-Google-Smtp-Source: ABdhPJzAOPPK8kL7ZzNJeLj2tMHTieVINMEk0IqIR/Sm772WMYkzasoHs1OTWsxLc1Jyd0RLdthXww==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr32723004pjb.33.1632062007848;
        Sun, 19 Sep 2021 07:33:27 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id m2sm13062149pgd.70.2021.09.19.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:33:27 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/1] dmaengine: qcom: bam_dma: Add support for metadata
Date:   Sun, 19 Sep 2021 20:03:11 +0530
Message-Id: <20210919143311.31015-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919143311.31015-1-sireeshkodali1@gmail.com>
References: <20210919143311.31015-1-sireeshkodali1@gmail.com>
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

