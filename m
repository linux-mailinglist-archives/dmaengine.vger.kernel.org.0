Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99245F968
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbhK0B0x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbhK0BYv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:51 -0500
Message-ID: <20211126230524.897737278@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bB22Fj84OnFrRIG/bs67IiQdK7QkbC0Kd4+++76cDFQ=;
        b=dnyi6ZGO5rvUA2htl5juh5Q0my/6XQ4KZE0zQIoraFHvn5942Q98AvWmlactqt7BB9KHfX
        Sk/HHpNEqzO7fHqwqGmCI1Y4T42TM2DciedPwCnVobY8BwhOlVhpqp1WwyFzt17NaZ1v8K
        C2CI2q7A0L1Ri4/rRS2Yr+Z0u9QWUlewg7P9KfraUYNPRsBtc9gvDMpBokDzpaxU3PJg89
        NeIUt1Z8bFTe0VWXLo4dMOt7od7lI7yG//10uohdINn4dl3Fbz719otFbCzhXcAkUVTNvN
        1xeyMMcHfxL2bZlxsX8P3zeEowT/7MR3VVeaajYZ+tNjMG9SnluHwkTcZATNsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bB22Fj84OnFrRIG/bs67IiQdK7QkbC0Kd4+++76cDFQ=;
        b=arnwtnXDSvpjG4t/Su03L3GWt+QLXvNHlG9AI/6oGMQu6t/37MW+YaEkYtrOWKzumSdZvi
        GxNFZXOrvRlXzmDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 16/37] bus: fsl-mc-msi: Use msi_desc::msi_index
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:32 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c |    2 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c       |    6 +++---
 include/linux/msi.h                   |   10 ----------
 3 files changed, 4 insertions(+), 14 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -393,7 +393,7 @@ int fsl_mc_populate_irq_pool(struct fsl_
 	}
 
 	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq = &irq_resources[msi_desc->fsl_mc.msi_index];
+		mc_dev_irq = &irq_resources[msi_desc->msi_index];
 		mc_dev_irq->msi_desc = msi_desc;
 		mc_dev_irq->resource.id = msi_desc->irq;
 	}
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -29,7 +29,7 @@ static irq_hw_number_t fsl_mc_domain_cal
 	 * Make the base hwirq value for ICID*10000 so it is readable
 	 * as a decimal value in /proc/interrupts.
 	 */
-	return (irq_hw_number_t)(desc->fsl_mc.msi_index + (dev->icid * 10000));
+	return (irq_hw_number_t)(desc->msi_index + (dev->icid * 10000));
 }
 
 static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
@@ -122,7 +122,7 @@ static void fsl_mc_msi_write_msg(struct
 	struct fsl_mc_device *mc_bus_dev = to_fsl_mc_device(msi_desc->dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_device_irq *mc_dev_irq =
-		&mc_bus->irq_resources[msi_desc->fsl_mc.msi_index];
+		&mc_bus->irq_resources[msi_desc->msi_index];
 
 	msi_desc->msg = *msg;
 
@@ -235,7 +235,7 @@ static int fsl_mc_msi_alloc_descs(struct
 			goto cleanup_msi_descs;
 		}
 
-		msi_desc->fsl_mc.msi_index = i;
+		msi_desc->msi_index = i;
 		INIT_LIST_HEAD(&msi_desc->list);
 		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 	}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -106,14 +106,6 @@ struct pci_msi_desc {
 };
 
 /**
- * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor
- */
-struct fsl_mc_msi_desc {
-	u16				msi_index;
-};
-
-/**
  * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
  * @dev_index: TISCI device index
  */
@@ -136,7 +128,6 @@ struct ti_sci_inta_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
 struct msi_desc {
@@ -157,7 +148,6 @@ struct msi_desc {
 	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
-		struct fsl_mc_msi_desc		fsl_mc;
 		struct ti_sci_inta_msi_desc	inta;
 	};
 };

