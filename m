Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B834346AC5A
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357827AbhLFWmi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:42:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358008AbhLFWmg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:42:36 -0500
Message-ID: <20211206210437.984321429@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wtPMGV5PTpz1yqWy70m2nhuRZOAE9ffD5q8PvX2HIIo=;
        b=FWpnEY9/Zjn8PcmvL5gy8OQMtSAgOf2w5Kf3cMg51UELgoNnReATs8yuuH/ZN3gPg+8scB
        cwvQH9VUFWLlCbLQ6PInp2mwIO9QT0iNFBgnt5onIeLiEqkEFBOgdZAz+8cwUWuNKnQJXa
        N5TO8eSKXeP/bhU8bRF6BIcanMCqXhld7Ah/J7ZPfieGVDvzYhRUv9Y1Au4prmsH1nGOaI
        L67Zrex05IDgdCfyf+Te40MDuirDyGTTT8f7/Pbz9AoruyGC+5CDL6LOU9GL2V+Ucf1Vn1
        W+uptRcO9Dq4pewx8SE1u8QdnFhSbUhLofZvB1Y6DUEEB3qtSVgzRPmv/dHMaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wtPMGV5PTpz1yqWy70m2nhuRZOAE9ffD5q8PvX2HIIo=;
        b=3iJ1sRdxnOfhMeFz/of0Hh7n9fP3JPzTifzOUTZle2NbTuTSk9CyV+KPnDIDd6tDt73mL5
        s3SenUGZDykxIpDw==
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
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V2 06/36] soc: ti: ti_sci_inta_msi: Allocate MSI device data
 on first use
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:05 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate the MSI device data on first invocation of the allocation function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/soc/ti/ti_sci_inta_msi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -120,6 +120,10 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 	if (pdev->id < 0)
 		return -ENODEV;
 
+	ret = msi_setup_device_data(dev);
+	if (ret)
+		return ret;
+
 	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
 	if (nvec <= 0)
 		return nvec;

