Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B070470D66
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbhLJWX1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:23:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344918AbhLJWXI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:23:08 -0500
Message-ID: <20211210221815.089008198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1PKR2Prd+1Li94AkrvejzHYXvOdiS0rHF3AWjJOJ+hY=;
        b=EXT6ZJHiL9WrQC63pWNeqEY7SfF3jIeVCos8i7xIZwHprSzmRcoSNiXrPRfeBGlX/4efFg
        GKBzvkr1hfP/TIvTDbw4CCeW2qNJNT1Mrz8mlT8JOpccmtfR+od0ZQ9AQUNq6SHiF7UA3t
        gC95XdhE8YJZ9o2I7sAZvmGtCHXLa+d9dwdc4G0asxf97pWkhPvcdF3TvGUziuRsuYw+ql
        n5cM46TBOVor1arusxIXF8fp7Wzk5TqiI9gjuel4qNwYdCdafKWtXUXZHfuM6B8FoM+RnC
        Gr+GIxVCgZ+BZGSsHPWLRtVqrhQbLaB0ZKkw3F8DrRN180qyN2lempVXeHraIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1PKR2Prd+1Li94AkrvejzHYXvOdiS0rHF3AWjJOJ+hY=;
        b=Q87ZFBVcPUXRgAfqqpqy/zVPxQ4IgjxdQfabAhW5+cvr8SXGLARh4lgGWZYcuCireCH7xW
        qehr/nAEfvi/OQDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V3 31/35] iommu/arm-smmu-v3: Use msi_get_virq()
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:31 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Let the core code fiddle with the MSI descriptor retrieval.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org

---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
 
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
-	struct msi_desc *desc;
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
 	struct device *dev = smmu->dev;
 
@@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
 		return;
 	}
 
-	for_each_msi_entry(desc, dev) {
-		switch (desc->msi_index) {
-		case EVTQ_MSI_INDEX:
-			smmu->evtq.q.irq = desc->irq;
-			break;
-		case GERROR_MSI_INDEX:
-			smmu->gerr_irq = desc->irq;
-			break;
-		case PRIQ_MSI_INDEX:
-			smmu->priq.q.irq = desc->irq;
-			break;
-		default:	/* Unknown */
-			continue;
-		}
-	}
+	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
+	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
+	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, arm_smmu_free_msis, dev);

