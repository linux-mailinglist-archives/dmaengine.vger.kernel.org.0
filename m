Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D164D45F96B
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbhK0B0y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346990AbhK0BYx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:53 -0500
Message-ID: <20211126230524.956623715@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E+zTAHs9Nymatzr+Yqyb5m4mctEau3gQEfp24M+P+yQ=;
        b=dNn3bIFVZIqnrwOPPKTgnM88lyYtiLqDmvkR5lSNVSeeEjjGt6gbGFuGbfknuaG+R38FNx
        Nx8jtTKn6Vvp7raIlHGVZy+J3IKkQAtKn3BjVW0xMPzVgwpAo/0g7A4AhyZ8AfYvVRT6mo
        3ngjH31IDVKIlI1Tq5fZPCNQ+l40Y7Sm9CEygyO30SvWEl1ULXHyTwQzpRTLXTF8QG1A2T
        XwDOt3kUK5MD5unBT+hUGkXHSXKW0w3+iYUQRjYdmwyFmJNIhpINkW4p0KGj6RhNANcm5/
        DmITJvsOJdnWOhLRI+bU6381SWHfBHZoZyqXNRRZ4x2SP1PzFyLGuKnTUYkxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E+zTAHs9Nymatzr+Yqyb5m4mctEau3gQEfp24M+P+yQ=;
        b=dgiaaASOxmK0tHaedOkd2xal+SVgOLvU5d9RNIBv3ZPi+Bw//6TY3s5FTKlFw7PWIxn7OS
        XohhinYHgn3UGLDw==
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
Subject: [patch 17/37] soc: ti: ti_sci_inta_msi: Use msi_desc::msi_index
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:34 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-ti-sci-inta.c |    2 +-
 drivers/soc/ti/ti_sci_inta_msi.c  |    6 +++---
 include/linux/msi.h               |   16 ++--------------
 3 files changed, 6 insertions(+), 18 deletions(-)

--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -595,7 +595,7 @@ static void ti_sci_inta_msi_set_desc(msi
 	struct platform_device *pdev = to_platform_device(desc->dev);
 
 	arg->desc = desc;
-	arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
+	arg->hwirq = TO_HWIRQ(pdev->id, desc->msi_index);
 }
 
 static struct msi_domain_ops ti_sci_inta_msi_ops = {
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -84,7 +84,7 @@ static int ti_sci_inta_msi_alloc_descs(s
 				return -ENOMEM;
 			}
 
-			msi_desc->inta.dev_index = res->desc[set].start + i;
+			msi_desc->msi_index = res->desc[set].start + i;
 			INIT_LIST_HEAD(&msi_desc->list);
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
@@ -96,7 +96,7 @@ static int ti_sci_inta_msi_alloc_descs(s
 				return -ENOMEM;
 			}
 
-			msi_desc->inta.dev_index = res->desc[set].start_sec + i;
+			msi_desc->msi_index = res->desc[set].start_sec + i;
 			INIT_LIST_HEAD(&msi_desc->list);
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
@@ -154,7 +154,7 @@ unsigned int ti_sci_inta_msi_get_virq(st
 	struct msi_desc *desc;
 
 	for_each_msi_entry(desc, dev)
-		if (desc->inta.dev_index == dev_index)
+		if (desc->msi_index == dev_index)
 			return desc->irq;
 
 	return -ENODEV;
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -106,14 +106,6 @@ struct pci_msi_desc {
 };
 
 /**
- * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
- * @dev_index: TISCI device index
- */
-struct ti_sci_inta_msi_desc {
-	u16	dev_index;
-};
-
-/**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
  * @irq:	The base interrupt number
@@ -127,8 +119,7 @@ struct ti_sci_inta_msi_desc {
  * @write_msi_msg_data:	Data parameter for the callback.
  *
  * @msi_index:	Index of the msi descriptor
- * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
+ * @pci:	PCI speficic msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -146,10 +137,7 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	u16				msi_index;
-	union {
-		struct pci_msi_desc		pci;
-		struct ti_sci_inta_msi_desc	inta;
-	};
+	struct pci_msi_desc		pci;
 };
 
 /**

