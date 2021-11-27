Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D745FB85
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhK0ByA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbhK0Bv5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:51:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0629C07E5E7;
        Fri, 26 Nov 2021 17:25:43 -0800 (PST)
Message-ID: <20211126230525.315266344@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mgACjNybAkVsWjwjzkFX6HgLmpYiDt2Y2zyU/5gje7g=;
        b=KOcx3nq0WyifD+pKyhXaQuQZxy8oNJ6TEM8KnJUeZOnhbOmr+Z6Kla2uLscM+ZHi+RxDlw
        JaxZ8cYn7jOSFxvM7b573wYgfgL7uvjy8ueUQ34e9Q53Wy6WrHdjSKvaDSa7dByNsa8pun
        K+nO6dznYtYlF6sQZUR485cEwqPZOzDl7r59/rB18RBWEnnEeV0T5R2Ephfhy3cJzNp3dL
        4cCqqL2h+fkEQi0oKd2jx9nN2pF6LwAgFu4wHk7mdwFyi9zRPkAdjp27PlxUHAGrQCx9s8
        YINFMfNaB6GTnh21IpugaACCfoJcUiU3yMK5oUfFo6hF0zcTmm5s4c3GEOVZ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mgACjNybAkVsWjwjzkFX6HgLmpYiDt2Y2zyU/5gje7g=;
        b=EGxaCwEPBh08Xoq7pWIfjP7M0ZAGZOJm0n8Or0SD+Oin8/oTIrpCUJMNJfNyRd9EPccb5o
        05bkh4ioEjRNtcCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 23/37] genirq/msi: Use device MSI properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:54 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
 kernel/irq/msi.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -114,21 +114,8 @@ int msi_setup_device_data(struct device
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct msi_desc *entry;
-	bool is_msix = false;
-	unsigned long irq;
-	int retval;
-
-	retval = kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry = irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	if (dev_is_pci(dev))
-		is_msix = entry->pci.msi_attrib.is_msix;
+	/* MSI vs. MSIX is per device not per interrupt */
+	bool is_msix = msi_device_has_property(dev, MSI_PROP_PCI_MSIX);
 
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }

