Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B007563D7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jul 2023 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGQNIt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jul 2023 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjGQNIs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jul 2023 09:08:48 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44831DE;
        Mon, 17 Jul 2023 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689599326;
  x=1721135326;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Q3mm2Qg7ryGUghj23XfvWG3rKzBCiU7ABu9S+xftYUM=;
  b=AVzS57I9695p8X5gxTxlaftppG+6aq+uzoLpUKj872ssAsSyhg3D8XRq
   w+5i2jh1u+NVCI636xjKcAdGhgWtG4Ek4WWxF0Lae3XEmXS4EZn6skVmS
   U0uZ5jCV8+y5nQSaM+K/4lGocWR/6uKCTX6H3WlT1Lp5rYAl56N6IQML5
   RsxKDURo00k161S0d4UkxXRSC3tBbmKJjFE/SdUt97Zvu1cMIxObwzdpt
   fPn8f3Q+Ii1z+VXtnn46DmUU4lRzQLhFVn12E0mxoVTlbIiv9iqFZj95o
   KjsyX/mu9nWpq/c9fwEy55lecqpI8yVtVFtG38PlUZm6u3jD2mrMTfzeK
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 17 Jul 2023 15:08:41 +0200
Subject: [PATCH 2/2] dmaengine: Add dummy DMA controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230717-dummy-dmac-v1-2-24348b6fb56b@axis.com>
References: <20230717-dummy-dmac-v1-0-24348b6fb56b@axis.com>
In-Reply-To: <20230717-dummy-dmac-v1-0-24348b6fb56b@axis.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for a dummy DMA controller which performs transfers using
the CPU, which could be useful for testing the DMA engine framework or
client drivers on systems where no real DMA controller is available.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/dma/Kconfig      |  14 +++
 drivers/dma/Makefile     |   1 +
 drivers/dma/dummy-dmac.c | 258 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 644c188d6a11..68abc6be8d41 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -179,6 +179,20 @@ config DMA_SUN6I
 	help
 	  Support for the DMA engine first found in Allwinner A31 SoCs.
 
+config DUMMY_DMAC
+	tristate "Dummy DMA controller"
+	depends on DEBUG_KERNEL
+	depends on !HIGHMEM
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for a dummy DMA controller which performs transfers
+	  using the CPU, which could be useful for testing the DMA engine
+	  framework or client drivers on systems where no real DMA controller
+	  is available.
+
+	  If unsure, say N.
+
 config DW_AXI_DMAC
 	tristate "Synopsys DesignWare AXI DMA support"
 	depends on OF
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fd1ce29510..23a8a62dd390 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
 obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
 obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
+obj-$(CONFIG_DUMMY_DMAC) += dummy-dmac.o
 obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
diff --git a/drivers/dma/dummy-dmac.c b/drivers/dma/dummy-dmac.c
new file mode 100644
index 000000000000..a41ee20939ab
--- /dev/null
+++ b/drivers/dma/dummy-dmac.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright Axis Communications
+
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/workqueue.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "virt-dma.h"
+
+struct dummy_desc {
+	struct virt_dma_desc vdesc;
+	dma_addr_t src;
+	dma_addr_t dst;
+	size_t len;
+};
+
+struct dummy_chan {
+	struct virt_dma_chan vchan;
+	struct virt_dma_desc *ongoing;
+	struct work_struct work;
+};
+
+struct dummy_dmac {
+	struct dma_device dma;
+	struct dummy_chan channels[8];
+};
+
+static struct platform_device *dummy_dmac_pdev;
+
+static struct dummy_chan *to_dummy_chan(struct virt_dma_chan *vchan)
+{
+	return container_of(vchan, struct dummy_chan, vchan);
+}
+
+static struct dummy_desc *to_dummy_desc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct dummy_desc, vdesc);
+}
+
+static struct dma_async_tx_descriptor *
+dummy_dmac_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
+		       size_t len, unsigned long flags)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dummy_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->src = src;
+	desc->dst = dst;
+	desc->len = len;
+
+	return vchan_tx_prep(vchan, &desc->vdesc, flags);
+}
+
+static void dummy_dmac_start(struct dummy_chan *dchan)
+{
+	struct virt_dma_desc *vdesc;
+
+	vdesc = vchan_next_desc(&dchan->vchan);
+	if (!vdesc)
+		return;
+
+	list_del(&vdesc->node);
+
+	dchan->ongoing = vdesc;
+	schedule_work(&dchan->work);
+}
+
+static void dummy_dmac_issue_pending(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dummy_chan *dchan = to_dummy_chan(vchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vchan->lock, flags);
+
+	if (vchan_issue_pending(vchan) && !dchan->ongoing)
+		dummy_dmac_start(dchan);
+
+	spin_unlock_irqrestore(&vchan->lock, flags);
+}
+
+static void dummy_dmac_synchronize(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dummy_chan *dchan = to_dummy_chan(vchan);
+
+	flush_work(&dchan->work);
+	vchan_synchronize(to_virt_chan(chan));
+}
+
+static int dummy_dmac_terminate_all(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dummy_chan *dchan = to_dummy_chan(vchan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&vchan->lock, flags);
+
+	cancel_work(&dchan->work);
+
+	if (dchan->ongoing) {
+		vchan_terminate_vdesc(dchan->ongoing);
+		dchan->ongoing = NULL;
+	}
+
+	vchan_get_all_descriptors(vchan, &head);
+
+	spin_unlock_irqrestore(&vchan->lock, flags);
+
+	vchan_dma_desc_free_list(vchan, &head);
+
+	return 0;
+}
+
+static void dummy_dmac_work(struct work_struct *work)
+{
+	struct dummy_chan *dchan = container_of(work, struct dummy_chan, work);
+	struct virt_dma_chan *vchan = &dchan->vchan;
+	struct virt_dma_desc *vdesc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vchan->lock, flags);
+
+	vdesc = dchan->ongoing;
+	if (vdesc) {
+		struct dummy_desc *desc = to_dummy_desc(vdesc);
+
+		/*
+		 * No DMA translation, so the addresses are CPU physical.  We
+		 * depend on !HIGHMEM so phys_to_virt() should be safe as long
+		 * as the addresses are in RAM.
+		 */
+		memcpy(phys_to_virt(desc->dst), phys_to_virt(desc->src),
+		       desc->len);
+		vchan_cookie_complete(vdesc);
+		dchan->ongoing = NULL;
+	}
+
+	dummy_dmac_start(dchan);
+
+	spin_unlock_irqrestore(&vchan->lock, flags);
+}
+
+static void dummy_dmac_free_chan_resources(struct dma_chan *chan)
+{
+	vchan_free_chan_resources(to_virt_chan(chan));
+}
+
+static void dummy_dmac_desc_free(struct virt_dma_desc *vdesc)
+{
+	struct dummy_desc *desc = to_dummy_desc(vdesc);
+
+	kfree(desc);
+}
+
+static void dummy_dmac_release(struct dma_device *dma_dev)
+{
+	struct dummy_dmac *dummy = container_of(dma_dev, struct dummy_dmac, dma);
+
+	put_device(dma_dev->dev);
+	kfree(dummy);
+}
+
+static int dummy_dmac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dummy_dmac *dummy;
+	struct dma_device *dma;
+	int ret;
+	int i;
+
+	dummy = kzalloc(sizeof(*dummy), GFP_KERNEL);
+	if (!dummy)
+		return -ENOMEM;
+
+	dma = &dummy->dma;
+	dma->owner = THIS_MODULE;
+	dma->dev = get_device(dev);
+
+	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
+
+	dma->src_addr_widths = 0xff;
+	dma->dst_addr_widths = 0xff;
+	dma->device_prep_dma_memcpy = dummy_dmac_prep_memcpy;
+	dma->device_issue_pending = dummy_dmac_issue_pending;
+	dma->device_terminate_all = dummy_dmac_terminate_all;
+	dma->device_synchronize = dummy_dmac_synchronize;
+	dma->device_tx_status = dma_cookie_status;
+	dma->device_free_chan_resources = dummy_dmac_free_chan_resources;
+	dma->device_release = dummy_dmac_release;
+
+	INIT_LIST_HEAD(&dma->channels);
+
+	for (i = 0; i < ARRAY_SIZE(dummy->channels); i++) {
+		struct dummy_chan *chan = &dummy->channels[i];
+
+		INIT_WORK(&chan->work, dummy_dmac_work);
+
+		chan->vchan.desc_free = dummy_dmac_desc_free;
+		vchan_init(&chan->vchan, &dummy->dma);
+	}
+
+	platform_set_drvdata(pdev, dummy);
+
+	ret = dma_async_device_register(dma);
+	if (ret)
+		kfree(dummy);
+
+	return ret;
+}
+
+static void dummy_dmac_remove(struct platform_device *pdev)
+{
+	struct dummy_dmac *dummy = platform_get_drvdata(pdev);
+
+	dma_async_device_unregister(&dummy->dma);
+}
+
+static struct platform_driver dummy_dmac_driver = {
+	.probe = dummy_dmac_probe,
+	.remove_new = dummy_dmac_remove,
+	.driver = {
+		.name = "dummy-dmac",
+	},
+};
+
+static int __init dummy_dmac_init(void)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple("dummy-dmac", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	dummy_dmac_pdev = pdev;
+
+	return platform_driver_register(&dummy_dmac_driver);
+}
+module_init(dummy_dmac_init);
+
+static void dummy_dmac_exit(void)
+{
+	platform_driver_unregister(&dummy_dmac_driver);
+	platform_device_unregister(dummy_dmac_pdev);
+}
+module_exit(dummy_dmac_exit);
+
+MODULE_LICENSE("GPL");

-- 
2.34.1

