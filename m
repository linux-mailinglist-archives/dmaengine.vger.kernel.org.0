Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F996D4C82
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjDCPuT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjDCPuJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 11:50:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B663AB1;
        Mon,  3 Apr 2023 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680536891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBi7PX/7n3UhrKXex6m7UfXrnlhGP3WO/OYjpM7zL0o=;
        b=QW2FI1x44F8Zk1JtxUeC1uKCao8FhfoJddmDLG200LbZ6MiogX5rGWrXhlIhSP9w7IWGeT
        h8wDfNhQW7P/fOr2orBwPD215WIhvGp6p/oT1Qp5GAZTQwTcneLKHtu3nlaIWA8TuvfaZN
        /g+CFxG9a3QwUlJqgjTZMaXVDkI185M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 02/11] dmaengine: dma-axi-dmac: Implement device_prep_slave_dma_array
Date:   Mon,  3 Apr 2023 17:47:51 +0200
Message-Id: <20230403154800.215924-3-paul@crapouillou.net>
In-Reply-To: <20230403154800.215924-1-paul@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add implementation of the .device_prep_slave_dma_array() callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v3: New patch
---
 drivers/dma/dma-axi-dmac.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a812b9b00e6b..61a796aca631 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -536,6 +536,46 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	return sg;
 }
 
+static struct dma_async_tx_descriptor *
+axi_dmac_prep_slave_dma_array(struct dma_chan *c, dma_addr_t *addrs,
+			      size_t *lengths, size_t nb,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags)
+{
+	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
+	struct axi_dmac_desc *desc;
+	unsigned int num_sgs = 0;
+	struct axi_dmac_sg *dsg;
+	size_t i;
+
+	if (direction != chan->direction)
+		return NULL;
+
+	for (i = 0; i < nb; i++)
+		num_sgs += DIV_ROUND_UP(lengths[i], chan->max_length);
+
+	desc = axi_dmac_alloc_desc(num_sgs);
+	if (!desc)
+		return NULL;
+
+	dsg = desc->sg;
+
+	for (i = 0; i < nb; i++) {
+		if (!axi_dmac_check_addr(chan, addrs[i]) ||
+		    !axi_dmac_check_len(chan, lengths[i])) {
+			kfree(desc);
+			return NULL;
+		}
+
+		dsg = axi_dmac_fill_linear_sg(chan, direction, addrs[i], 1,
+					      lengths[i], dsg);
+	}
+
+	desc->cyclic = false;
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
 static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	struct dma_chan *c, struct scatterlist *sgl,
 	unsigned int sg_len, enum dma_transfer_direction direction,
@@ -958,6 +998,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_tx_status = dma_cookie_status;
 	dma_dev->device_issue_pending = axi_dmac_issue_pending;
 	dma_dev->device_prep_slave_sg = axi_dmac_prep_slave_sg;
+	dma_dev->device_prep_slave_dma_array = axi_dmac_prep_slave_dma_array;
 	dma_dev->device_prep_dma_cyclic = axi_dmac_prep_dma_cyclic;
 	dma_dev->device_prep_interleaved_dma = axi_dmac_prep_interleaved;
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
-- 
2.39.2

