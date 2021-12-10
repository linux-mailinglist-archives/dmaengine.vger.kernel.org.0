Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E26470D7C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbhLJWW4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbhLJWWh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:37 -0500
Message-ID: <20211210221813.805529729@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AIipdYHJdw47YEIR3ibDM4/EuKIZd0bBkHdL069vGOQ=;
        b=j1D2L9Q78IUwnll6n5rxMGVu2mITgI1fie6htejXwkZkBu5vKvBCoSC0hybtM8CIndzeKy
        8FxbvyCsSWDO1Je5QzsKaI/JE7U3VHAG33NrckGM8Jh90EVfjx9LVyCBsKiWw/5ODWbyNU
        kojl0x/4/PVaVVmvviwmUOctKhNCi3chDZvokC+2bV6jT+/MGWHy2QTxSbgq5bJLTS0oc3
        WunwiNoKKzPpL872PSd/7Fh8pFZgVkBASgKwd3jLaDi5pE0MyQTn5hNy8f1JZB6aEnheiK
        IXKzSIcv8qTnf/i+HWAfLXKhChF87Qp+8borfTOdx+L3rIKkbAniU7i2NTkEuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AIipdYHJdw47YEIR3ibDM4/EuKIZd0bBkHdL069vGOQ=;
        b=iR9CZQZxt9DwiDQaI1OMnpL3qc51lhNFwI0XGQkIVGuIAxEp7I6QmDjeueiB5NSx48DEzo
        NTxgjLao7vpldkAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [patch V3 10/35] platform-msi: Allocate MSI device data on first use
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:18:58 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allocate the MSI device data on first invocation of the allocation function
for platform MSI private data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/base/platform-msi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -204,6 +204,8 @@ platform_msi_alloc_priv_data(struct devi
 			     irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
+	int err;
+
 	/*
 	 * Limit the number of interrupts to 2048 per device. Should we
 	 * need to bump this up, DEV_ID_SHIFT should be adjusted
@@ -218,6 +220,10 @@ platform_msi_alloc_priv_data(struct devi
 		return ERR_PTR(-EINVAL);
 	}
 
+	err = msi_setup_device_data(dev);
+	if (err)
+		return ERR_PTR(err);
+
 	/* Already had a helping of MSI? Greed... */
 	if (!list_empty(dev_to_msi_list(dev)))
 		return ERR_PTR(-EBUSY);
@@ -229,7 +235,7 @@ platform_msi_alloc_priv_data(struct devi
 	datap->devid = ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
-		int err = datap->devid;
+		err = datap->devid;
 		kfree(datap);
 		return ERR_PTR(err);
 	}

