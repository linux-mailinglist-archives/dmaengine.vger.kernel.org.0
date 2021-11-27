Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA245F9B6
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347690AbhK0B16 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:27:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhK0BZ4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:25:56 -0500
Message-ID: <20211126230525.374699615@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=G+kQoqkWvFJXcdz5PQCdFWimR12BfigYgz7Zbwfcs54=;
        b=a4IGUqXtXIwTCipeEaCK18NENo8ejWLO0RAVBMzwJd4vheCxJFL1u083PEtxGKZjYTpDXa
        kjIkdlz/Me+vDfIXTizASuoqgVKXXbjp05y7oakiEmGuw3/2un0MFaI1Y0b7EaSGzUdgiF
        gyN5B1u3cRhGUOObj98rlrrocAGjSCu2+NVv9Janv+epcZt2H6wEpPqA4frbcE+evuyirU
        EE16hmnNL546crv5bPO8fWnp45/znozW8kxsYEPVlOgYrU3wYQUl54HJALseiDrLgPlMQi
        nkl0LlcAjYLUfacIM3Xz5ufccSxVwgm9akbsqevUgaybsKVHfGP8te/8BvBw2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=G+kQoqkWvFJXcdz5PQCdFWimR12BfigYgz7Zbwfcs54=;
        b=lf9IuXXC/5triKpko28bR3F8ly/WAaUvo4XZUDmmDQUjFfB2wrlfPNfYASVPyKqWnEncGk
        /nZZx/GnJyyEWNBA==
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
Subject: [patch 24/37] powerpc/cell/axon_msi: Use MSI device properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:45 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
+	is_64bit = msi_device_has_property(MSI_PROP_64BIT);
 
 	for (; dn; dn = of_get_next_parent(dn)) {
-		if (entry->pci.msi_attrib.is_64) {
+		if (is_64bit) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;

