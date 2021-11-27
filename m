Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0516645F93B
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbhK0B0T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbhK0BYI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:08 -0500
Message-ID: <20211126230524.355599952@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=eU/+MzcFFw4K2a/jF7MWe8bjN6ge/wr+X0hgqu8YCCQ=;
        b=37q0V1cbSuIIBymAUrmV6vNbD0AG9OhMRNskcj82I53q40Eo+MPVhg9OV3PPrI+vgf4Qae
        00OY4DmpKexitvBVgwNQhbp9/fozZeZ+4BpSQZSm/65H82KVpqc+wm5XstEezuZy3aX7Ia
        ezIJIq/W39ScORxoxOeztywmxVN04GEwt0DIYoLqyVUSBJx2pMS2puOtcT6b+M9lKl02wW
        DDfqSCxmFBAl4spcZCo8BfS4fDaYnwnjJijv85HCTJ7v6gKzZLqwmYAU/qlu+OqhGxTzf0
        ZrvZK5+NDO4xKKNbv8zZCSZ1r3cmU5PM767ECfySrY/+l7AM6FBdJZCNhWJbHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=eU/+MzcFFw4K2a/jF7MWe8bjN6ge/wr+X0hgqu8YCCQ=;
        b=rYicKTlUm2Sg+aAsLf2zZH11aPVNUVCcQpbGPeExh9jfY/pxFsA9qZS4IfVsfuUORtN6WK
        JmeK4LXSsAc/2cDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 07/37] soc: ti: ti_sci_inta_msi: Allocate MSI device data on first use
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:17 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate the MSI device data on first invocation of the allocation function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

