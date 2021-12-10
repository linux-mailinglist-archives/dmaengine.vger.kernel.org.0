Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D7470D1B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbhLJWWo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbhLJWW3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731FC0617A1;
        Fri, 10 Dec 2021 14:18:52 -0800 (PST)
Message-ID: <20211210221813.493922179@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cKJHJ5pvxdQcbJzsUJMGqgFGoQj9I03QbSL7vU1xGJs=;
        b=1jYFlR/s4Fj8fK94IM8CGV2VaLN70VTxWOKgzd9JP93YsuiSkhZnYFY06GM/ck1LqQztP1
        MLFaGOIeCqYoexBgXapeoyYhkU0pOjGlXAPId/ebxaePxjkxMr+yK8v+0hb5X4+5ZG7B1H
        +va0VUPX0Xv4Yu86zDErk4wKNgJjI/W705RdoDtPXV+TGIU1/gfVAaxPimBu0jir0PtNCO
        fOlCra2fXDQuTRaSAH0ZtTlPuz+4kAZXETO59wFrYfdqVEy+3UT6OV5Rro3KejHz+49vks
        CFqN18s6k1HR1ibmPHBMCiufu6FCMC8wl1bZC8BEvjjvQ7GzWILhEocUSrICGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cKJHJ5pvxdQcbJzsUJMGqgFGoQj9I03QbSL7vU1xGJs=;
        b=CKltebaN9sJb+/12aypx+vxMoPzMz+hKX+LQCpakacpcX5G/L+sQu6V9DoCJj9DznHwv8C
        jZHW+tYr3PY7biBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V3 05/35] powerpc/cell/axon_msi: Use PCI device property
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:18:51 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
V3: Use pci_dev property - Jason
V2: Invoke the function with the correct number of arguments - Andy
---
 arch/powerpc/platforms/cell/axon_msi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -199,7 +199,6 @@ static struct axon_msic *find_msi_transl
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
 	struct device_node *dn;
-	struct msi_desc *entry;
 	int len;
 	const u32 *prop;
 
@@ -209,10 +208,8 @@ static int setup_msi_msg_address(struct
 		return -ENODEV;
 	}
 
-	entry = first_pci_msi_entry(dev);
-
 	for (; dn; dn = of_get_next_parent(dn)) {
-		if (entry->pci.msi_attrib.is_64) {
+		if (!dev->no_64bit_msi) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;

