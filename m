Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41445F9CB
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbhK0B2T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347868AbhK0B0H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:07 -0500
Message-ID: <20211126230525.432148049@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R5e0O3/cPtKTz28swaAQpwxXJzIJ0KDZCypBX7NJJUs=;
        b=1n7oWPvlZf1xqG6Sw+LVHR6RbnhIdn409ZgeaAT3nQ/uTiEZJj8qbhGRo2Hp13JC71Sw14
        B6R7uoa2QCejc2UUGcypq/q7tYpI6GAZazBi1svWlXijtjO8MDV9by/U//aLSEXrMBhmEo
        1XHTnjiajvaAlTv3SSj52TxIywHy5rK0mPsVWCDObhAI8WzzYsjmKssz9Uf7QXmav9wkhd
        UpxZqVvs/0/Jwj7FYcWOU9N14DVD4Bp06tmK85PYK80Li1jzm1ftGL3RZXmqjlkoU+NuEN
        HcfU+b866/pCAgBCvtxw/YKfDOv70fzufvhPSc6g7RsL3S6nKzJPZfVJF4tR1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R5e0O3/cPtKTz28swaAQpwxXJzIJ0KDZCypBX7NJJUs=;
        b=de/BHQTomYdNMV5p6IjuUEGKCvLrIts4BHniXnUr81HjSGHocBuvhsDv6/YQyr/xEO1owH
        t/ukPevbzOfZelBw==
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
Subject: [patch 25/37] powerpc/pseries/msi: Use MSI device properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:46 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -447,9 +447,9 @@ static int rtas_prepare_msi_irqs(struct
 static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev,
 				   int nvec, msi_alloc_info_t *arg)
 {
+	bool is_msix = msi_device_has_property(dev, MSI_PROP_PCI_MSIX);
+	int type = is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-	int type = desc->pci.msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }

