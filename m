Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE145F911
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbhK0B0H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbhK0BYG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:06 -0500
Message-ID: <20211126230524.236729743@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MsQMrlpTATaTMzIfF99P8uE12mWb1u9o9W8ziR/qOrU=;
        b=v+0MDRnHIZmUYh9muIDezvCL+GrBrMKFHLXhnXDbx/aIi2Wrrx2btpQc2pbAq708vAOooJ
        ObadXZFbvQQRZhMeKea1bFWMBR++d2Kee/VhqKH4WHWiniGjoIj/ZOXWd4n8EoZVQ82t2C
        nko5LxZWgMMymJUvjSUGyQm0rfeRyd5sFUXOKIVxxVcL0iLy3n3tVNdEZtgRf1hC78nAr2
        bk9apjv2EpkYiMxr4EuHqAXH2Mf4K0ob8IkVlrkTIbQ+lNr0Z/0RN+LJkfsjRRlVaQBn7P
        Qr3lelca0UZiVpBnbQsaRtzf/2roo+7eVAdf5rYtyNBt7Xe9zdOlWr5n2eHbow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MsQMrlpTATaTMzIfF99P8uE12mWb1u9o9W8ziR/qOrU=;
        b=xNoV+WZ/LZHW9aCCjR5qeNdZLfCaDUJ0rJxOsmXMnhAv7pGi4kmklBVoXkagTGMlO0Ex2g
        B8JBNqCfSLc9oTCw==
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
Subject: [patch 05/37] platform-msi: Allocate MSI device data on first use
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:14 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate the MSI device data on first invocation of the allocation function
for platform MSI private data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

