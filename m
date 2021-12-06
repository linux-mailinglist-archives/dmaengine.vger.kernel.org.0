Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4046ACD0
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359726AbhLFWof (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351202AbhLFWnx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDDC061D5F;
        Mon,  6 Dec 2021 14:39:39 -0800 (PST)
Message-ID: <20211206210439.074795958@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cOZ0U3ouey82JJdJiPY/OdjPVZlxKAZBH84jVxEoqTU=;
        b=wz3TzWYBvl04aCerKYeWR58lfzMKGU0iQIuBeqOL+QMp3fzox5TmpoLeGGdAyjIdRF9we0
        u9yR0O7Qw/bXjizcycQ1gt+G/WeBK/oTI1LUwf2kX7mBg7E4BLQU+LhtJn98G1rHyhAeXN
        uZibzflizAgUufHizJH6rsQmehdTaX7twbvYr5V+KethG1Scbt8X2tNbTw+IA0tYplWXos
        ZwOGv2nZnU5zW+yHNbttX2IEcKFWRwLT0XfzLzZMFn7NfGrUzA3FstQug2ylwpcRUwc/5i
        kvFiRVvXUUkrTAhTuq9cCrdEEKtF1I+UAps11N3QhGaOgS9dJJn2kcoxCDkHWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cOZ0U3ouey82JJdJiPY/OdjPVZlxKAZBH84jVxEoqTU=;
        b=hWRF+jAuLUmdTtCJbsFelzhT8GqoJCFIgM9B0HzB2yZ+yr1G/1kR55tWj9RhnBzNSOA67w
        E7/UVXYkvpVaIZCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V2 26/36] powerpc/pseries/msi: Let core code check for
 contiguous entries
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:37 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Set the domain info flag and remove the check.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove it completely - Cedric
---
 arch/powerpc/platforms/pseries/msi.c |   33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -321,27 +321,6 @@ static int msi_quota_for_device(struct p
 	return request;
 }
 
-static int check_msix_entries(struct pci_dev *pdev)
-{
-	struct msi_desc *entry;
-	int expected;
-
-	/* There's no way for us to express to firmware that we want
-	 * a discontiguous, or non-zero based, range of MSI-X entries.
-	 * So we must reject such requests. */
-
-	expected = 0;
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->msi_index != expected) {
-			pr_debug("rtas_msi: bad MSI-X entries.\n");
-			return -EINVAL;
-		}
-		expected++;
-	}
-
-	return 0;
-}
-
 static void rtas_hack_32bit_msi_gen2(struct pci_dev *pdev)
 {
 	u32 addr_hi, addr_lo;
@@ -380,9 +359,6 @@ static int rtas_prepare_msi_irqs(struct
 	if (quota && quota < nvec)
 		return quota;
 
-	if (type == PCI_CAP_ID_MSIX && check_msix_entries(pdev))
-		return -EINVAL;
-
 	/*
 	 * Firmware currently refuse any non power of two allocation
 	 * so we round up if the quota will allow it.
@@ -530,9 +506,16 @@ static struct irq_chip pseries_pci_msi_i
 	.irq_write_msi_msg	= pseries_msi_write_msg,
 };
 
+
+/*
+ * Set MSI_FLAG_MSIX_CONTIGUOUS as there is no way to express to
+ * firmware to request a discontiguous or non-zero based range of
+ * MSI-X entries. Core code will reject such setup attempts.
+ */
 static struct msi_domain_info pseries_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
+		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MSIX_CONTIGUOUS),
 	.ops   = &pseries_pci_msi_domain_ops,
 	.chip  = &pseries_pci_msi_irq_chip,
 };

