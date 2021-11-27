Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E453C45FA1A
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbhK0B36 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:29:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348305AbhK0B16 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:27:58 -0500
Message-ID: <20211126230524.295122054@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Oh8EM+g3S/QfSPoDjrJmTy+Z80Zsw+m+X3NUsXacOTE=;
        b=mnofpq5qHTa73EYKnX+gSUS66qA0qV9CISVRKLfy6CK+WHHapL7/SxJScP3TewGTsdaH0N
        zAvnNBw/ghsjSAPlWoxiAo332Y+PYhTukKuDEZj9V1VYhrr+P5cVirRxCX1oxdgSHHKb0H
        WjNbIuJvv3jXXH7mx4heiKx32Kw4D9PfsByyk16Elpvdu1570LvxkxGLKXRp6OjKe3TlpP
        Xe1MS5Hg5BphaQ2gVhuYOHWnihn7qsyWN1mKTT5Jwb6C+9zbFdAoXxMJC98vzYLZQNrb+l
        qFu1ZcsCjD2RhhQDyTBUL8woeasGlKhpmU6BJOCFm5U+I1V9643SxCalB7arcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Oh8EM+g3S/QfSPoDjrJmTy+Z80Zsw+m+X3NUsXacOTE=;
        b=EVRr4dtWw855mql4RX0lKIdYekacrmXSlpmN+9wTz4Ck3BslRlqjv8mdIuNN/fgD+8rRyc
        vBIv57L/ZOklsqCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 06/37] bus: fsl-mc-msi: Allocate MSI device data on first use
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:26 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate the MSI device data on first invocation of the allocation function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -253,6 +253,14 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	struct irq_domain *msi_domain;
 	int error;
 
+	msi_domain = dev_get_msi_domain(dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	error = msi_setup_device_data(dev);
+	if (error)
+		return error;
+
 	if (!list_empty(dev_to_msi_list(dev)))
 		return -EINVAL;
 
@@ -260,12 +268,6 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	if (error < 0)
 		return error;
 
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain) {
-		error = -EINVAL;
-		goto cleanup_msi_descs;
-	}
-
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback

