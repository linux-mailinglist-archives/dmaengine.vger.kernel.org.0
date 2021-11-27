Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8917345FA62
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349928AbhK0BbS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:31:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349940AbhK0B3R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:29:17 -0500
Message-ID: <20211126230525.998430251@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lIJfdgdWXqPpzoX+GA8322PEONJgAj7Dsfk3jEgUh34=;
        b=R5YlvC95EpaQPgxAhE4F+evWZhyDBgkQUIsB0wnoZ9shyLLcsPOFE5fwRSVXp3OyhZkJXn
        FUyQFq97z2DfkpJRwnqOaqVXdbXo2g72j9CnBu1iKYMe4rJKkKYKqVJjfQCuMJz0JWLf0T
        YDDxyBw7djtCBUeVSKM9knXY0898cim00oUdv19X78fW1ThGZj/7HvcTC+QuSMUQdK20aT
        ZCiTyZ5U7vtZRyk2JRoZOKJDTYTEr/PfSwXN2Ksi6uk3hIxJmD9EEYzFjy70gDXtznEwZ8
        mMuUU/ZSlI08Qyh388EOfV32NVlPMrqcnMxVWRD4kqUNHXZaJPXjBzcC+AOjQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lIJfdgdWXqPpzoX+GA8322PEONJgAj7Dsfk3jEgUh34=;
        b=vi6epW56ZkG4W5VkiDg6ULi/cByx1rm0/EDT3R7RGFvVHXPFl3HAXt3dCWwMdZK945g3gs
        C2ARNfwACu8CbnBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 35/37] bus: fsl-mc: fsl-mc-allocator: Rework MSI handling
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:12 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Storing a pointer to the MSI descriptor just to track the Linux interrupt
number is daft. Just store the interrupt number and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stuart Yoder <stuyoder@gmail.com>
---
 drivers/bus/fsl-mc/dprc-driver.c                    |    8 ++++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c               |    9 ++-------
 drivers/bus/fsl-mc/fsl-mc-msi.c                     |    6 +++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    |    4 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c    |    4 +---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c |    5 ++---
 drivers/soc/fsl/dpio/dpio-driver.c                  |    8 ++++----
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c              |    4 ++--
 include/linux/fsl/mc.h                              |    4 ++--
 9 files changed, 22 insertions(+), 30 deletions(-)

--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -400,7 +400,7 @@ static irqreturn_t dprc_irq0_handler_thr
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 	struct fsl_mc_io *mc_io = mc_dev->mc_io;
-	struct msi_desc *msi_desc = mc_dev->irqs[0]->msi_desc;
+	int irq = mc_dev->irqs[0]->virq;
 
 	dev_dbg(dev, "DPRC IRQ %d triggered on CPU %u\n",
 		irq_num, smp_processor_id());
@@ -409,7 +409,7 @@ static irqreturn_t dprc_irq0_handler_thr
 		return IRQ_HANDLED;
 
 	mutex_lock(&mc_bus->scan_mutex);
-	if (!msi_desc || msi_desc->irq != (u32)irq_num)
+	if (irq != (u32)irq_num)
 		goto out;
 
 	status = 0;
@@ -521,7 +521,7 @@ static int register_dprc_irq_handler(str
 	 * function that programs the MSI physically in the device
 	 */
 	error = devm_request_threaded_irq(&mc_dev->dev,
-					  irq->msi_desc->irq,
+					  irq->virq,
 					  dprc_irq0_handler,
 					  dprc_irq0_handler_thread,
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
@@ -771,7 +771,7 @@ static void dprc_teardown_irq(struct fsl
 
 	(void)disable_dprc_irq(mc_dev);
 
-	devm_free_irq(&mc_dev->dev, irq->msi_desc->irq, &mc_dev->dev);
+	devm_free_irq(&mc_dev->dev, irq->virq, &mc_dev->dev);
 
 	fsl_mc_free_irqs(mc_dev);
 }
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -350,7 +350,6 @@ int fsl_mc_populate_irq_pool(struct fsl_
 			     unsigned int irq_count)
 {
 	unsigned int i;
-	struct msi_desc *msi_desc;
 	struct fsl_mc_device_irq *irq_resources;
 	struct fsl_mc_device_irq *mc_dev_irq;
 	int error;
@@ -388,16 +387,12 @@ int fsl_mc_populate_irq_pool(struct fsl_
 		mc_dev_irq->resource.type = res_pool->type;
 		mc_dev_irq->resource.data = mc_dev_irq;
 		mc_dev_irq->resource.parent_pool = res_pool;
+		mc_dev_irq->virq = msi_get_virq(&mc_bus_dev->dev, i);
+		mc_dev_irq->resource.id = mc_dev_irq->virq;
 		INIT_LIST_HEAD(&mc_dev_irq->resource.node);
 		list_add_tail(&mc_dev_irq->resource.node, &res_pool->free_list);
 	}
 
-	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq = &irq_resources[msi_desc->msi_index];
-		mc_dev_irq->msi_desc = msi_desc;
-		mc_dev_irq->resource.id = msi_desc->irq;
-	}
-
 	res_pool->max_count = irq_count;
 	res_pool->free_count = irq_count;
 	mc_bus->irq_resources = irq_resources;
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -58,11 +58,11 @@ static void fsl_mc_msi_update_dom_ops(st
 }
 
 static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
-				   struct fsl_mc_device_irq *mc_dev_irq)
+				   struct fsl_mc_device_irq *mc_dev_irq,
+				   struct msi_desc *msi_desc)
 {
 	int error;
 	struct fsl_mc_device *owner_mc_dev = mc_dev_irq->mc_dev;
-	struct msi_desc *msi_desc = mc_dev_irq->msi_desc;
 	struct dprc_irq_cfg irq_cfg;
 
 	/*
@@ -129,7 +129,7 @@ static void fsl_mc_msi_write_msg(struct
 	/*
 	 * Program the MSI (paddr, value) pair in the device:
 	 */
-	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq);
+	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq, msi_desc);
 }
 
 static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4246,7 +4246,7 @@ static int dpaa2_eth_setup_irqs(struct f
 	}
 
 	irq = ls_dev->irqs[0];
-	err = devm_request_threaded_irq(&ls_dev->dev, irq->msi_desc->irq,
+	err = devm_request_threaded_irq(&ls_dev->dev, irq->virq,
 					NULL, dpni_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(&ls_dev->dev), &ls_dev->dev);
@@ -4273,7 +4273,7 @@ static int dpaa2_eth_setup_irqs(struct f
 	return 0;
 
 free_irq:
-	devm_free_irq(&ls_dev->dev, irq->msi_desc->irq, &ls_dev->dev);
+	devm_free_irq(&ls_dev->dev, irq->virq, &ls_dev->dev);
 free_mc_irq:
 	fsl_mc_free_irqs(ls_dev);
 
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -129,7 +129,6 @@ static irqreturn_t dpaa2_ptp_irq_handler
 static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 {
 	struct device *dev = &mc_dev->dev;
-	struct fsl_mc_device_irq *irq;
 	struct ptp_qoriq *ptp_qoriq;
 	struct device_node *node;
 	void __iomem *base;
@@ -177,8 +176,7 @@ static int dpaa2_ptp_probe(struct fsl_mc
 		goto err_unmap;
 	}
 
-	irq = mc_dev->irqs[0];
-	ptp_qoriq->irq = irq->msi_desc->irq;
+	ptp_qoriq->irq = mc_dev->irqs[0]->virq;
 
 	err = request_threaded_irq(ptp_qoriq->irq, NULL,
 				   dpaa2_ptp_irq_handler_thread,
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1553,8 +1553,7 @@ static int dpaa2_switch_setup_irqs(struc
 
 	irq = sw_dev->irqs[DPSW_IRQ_INDEX_IF];
 
-	err = devm_request_threaded_irq(dev, irq->msi_desc->irq,
-					NULL,
+	err = devm_request_threaded_irq(dev, irq->virq, NULL,
 					dpaa2_switch_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(dev), dev);
@@ -1580,7 +1579,7 @@ static int dpaa2_switch_setup_irqs(struc
 	return 0;
 
 free_devm_irq:
-	devm_free_irq(dev, irq->msi_desc->irq, dev);
+	devm_free_irq(dev, irq->virq, dev);
 free_irq:
 	fsl_mc_free_irqs(sw_dev);
 	return err;
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -88,7 +88,7 @@ static void unregister_dpio_irq_handlers
 	irq = dpio_dev->irqs[0];
 
 	/* clear the affinity hint */
-	irq_set_affinity_hint(irq->msi_desc->irq, NULL);
+	irq_set_affinity_hint(irq->virq, NULL);
 }
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
@@ -98,7 +98,7 @@ static int register_dpio_irq_handlers(st
 
 	irq = dpio_dev->irqs[0];
 	error = devm_request_irq(&dpio_dev->dev,
-				 irq->msi_desc->irq,
+				 irq->virq,
 				 dpio_irq_handler,
 				 0,
 				 dev_name(&dpio_dev->dev),
@@ -111,10 +111,10 @@ static int register_dpio_irq_handlers(st
 	}
 
 	/* set the affinity hint */
-	if (irq_set_affinity_hint(irq->msi_desc->irq, cpumask_of(cpu)))
+	if (irq_set_affinity_hint(irq->virq, cpumask_of(cpu)))
 		dev_err(&dpio_dev->dev,
 			"irq_set_affinity failed irq %d cpu %d\n",
-			irq->msi_desc->irq, cpu);
+			irq->virq, cpu);
 
 	return 0;
 }
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -67,7 +67,7 @@ static int vfio_set_trigger(struct vfio_
 	int hwirq;
 	int ret;
 
-	hwirq = vdev->mc_dev->irqs[index]->msi_desc->irq;
+	hwirq = vdev->mc_dev->irqs[index]->virq;
 	if (irq->trigger) {
 		free_irq(hwirq, irq);
 		kfree(irq->name);
@@ -137,7 +137,7 @@ static int vfio_fsl_mc_set_irq_trigger(s
 		return vfio_set_trigger(vdev, index, fd);
 	}
 
-	hwirq = vdev->mc_dev->irqs[index]->msi_desc->irq;
+	hwirq = vdev->mc_dev->irqs[index]->virq;
 
 	irq = &vdev->mc_irqs[index];
 
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -91,13 +91,13 @@ struct fsl_mc_resource {
 
 /**
  * struct fsl_mc_device_irq - MC object device message-based interrupt
- * @msi_desc: pointer to MSI descriptor allocated by fsl_mc_msi_alloc_descs()
+ * @virq: Linux virtual interrupt number
  * @mc_dev: MC object device that owns this interrupt
  * @dev_irq_index: device-relative IRQ index
  * @resource: MC generic resource associated with the interrupt
  */
 struct fsl_mc_device_irq {
-	struct msi_desc *msi_desc;
+	unsigned int virq;
 	struct fsl_mc_device *mc_dev;
 	u8 dev_irq_index;
 	struct fsl_mc_resource resource;

