Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0F46ACC8
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376657AbhLFWoW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358943AbhLFWnE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:04 -0500
Message-ID: <20211206210438.913603962@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ep5zFYMr2dpuKFMI1pf/izOHx/wmIORxQk2vil3OoJI=;
        b=nfZZ3sBOutSvGHqk1sS290DDgjFJGXEhzG9mKo8h3KNUTS21yvque0kvoe6kdy44X6ihqJ
        rlecPnSuBE8kWWqzbTh8ZfS2t/6i87b9mxuCdiQdAWfWgv/FXfDMxOB4hPcENaQevz8X1t
        sfoi2d3W+glPX+uizuVT258ABJFrCCoKMbU990PZvSPJbq47uN//h7RBBdikCbG4VbXTMa
        uzPGLlJ6oqG4Ba1T/Qi10UeHj0+DdaJ0BuryMFaEruZB4DB4ufEmaO0gHVQmA6rDjulOYP
        4odcYLKYN6S0ZLHgH8AU1siZXSl2RCWz6Zdbj85yUeDpTNP4mcveuhP4LXFExg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ep5zFYMr2dpuKFMI1pf/izOHx/wmIORxQk2vil3OoJI=;
        b=zIv8vjiKX+sZKy9gbTJ2X4+XfGOmD/O04fsKImX/MjjZGQEs9MDTD7XhFu7ricmc2LeLAj
        jEryKJg6XslL1KCw==
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
Subject: [patch V2 23/36] powerpc/cell/axon_msi: Use MSI device properties
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:33 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Invoke the function with the correct number of arguments - Andy
---
 arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -199,7 +199,7 @@ static struct axon_msic *find_msi_transl
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
 	struct device_node *dn;
-	struct msi_desc *entry;
+	bool is_64bit;
 	int len;
 	const u32 *prop;
 
@@ -209,10 +209,10 @@ static int setup_msi_msg_address(struct
 		return -ENODEV;
 	}
 
-	entry = first_pci_msi_entry(dev);
+	is_64bit = msi_device_has_property(&dev->dev, MSI_PROP_64BIT);
 
 	for (; dn; dn = of_get_next_parent(dn)) {
-		if (entry->pci.msi_attrib.is_64) {
+		if (is_64bit) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;

