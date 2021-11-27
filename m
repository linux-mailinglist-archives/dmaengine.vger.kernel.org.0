Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F845F93E
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbhK0B0T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35300 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbhK0BYR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:17 -0500
Message-ID: <20211126230524.540744026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gn8p+zMtjjrDzl8WaoyQn+U7cmDXCgk8UU3FdWlgcVs=;
        b=vMSQa0GYeGhY/pQ4O3tvUkTqJYLpCVkeC4y3u62zMn4FDrQJklj+STCq5BEfsBTu0s2M5V
        99+bbp9ELyYr+aMYUNTAdckGT0s4QZGAhftfFq4vaT12BSiAiglPhl/pJu5pvfNLgaBuwd
        kVox6DN0xr4zl4AtTeFqpfMGZJvbL2W6KeeYSAHPC7rcosHlgznuyHpq+qngY0fR2pBV8y
        wPD/evKPzFPBWXS5apl2H0qjp00Uw+kLC/wlv1XDYLZ/+BW6uV9TDEz8KSPr9i+jd0lgrn
        q/9a9ase9H/VIUE6ZmkDWZr6RBhaPGzfXWma37ssvD7c1Lu+tHGbdZiNuploNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gn8p+zMtjjrDzl8WaoyQn+U7cmDXCgk8UU3FdWlgcVs=;
        b=IV5GXmqv30WsdjaLssWUqwbUHWgEsyb8Y2Lk5LCM/xnsp5ZHKD4zFbZrnhqMuTkEm6CJyI
        K6bYpwodx7daw0Bg==
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
Subject: [patch 10/37] platform-msi: Let the core code handle sysfs groups
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:22 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Set the domain info flag and remove the local sysfs code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -23,7 +23,6 @@
 struct platform_msi_priv_data {
 	struct device			*dev;
 	void				*host_data;
-	const struct attribute_group    **msi_irq_groups;
 	msi_alloc_info_t		arg;
 	irq_write_msi_msg_t		write_msg;
 	int				devid;
@@ -191,6 +190,7 @@ struct irq_domain *platform_msi_create_i
 		platform_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		platform_msi_update_chip_ops(info);
+	info->flags |= MSI_FLAG_DEV_SYSFS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -279,16 +279,8 @@ int platform_msi_domain_alloc_irqs(struc
 	if (err)
 		goto out_free_desc;
 
-	priv_data->msi_irq_groups = msi_populate_sysfs(dev);
-	if (IS_ERR(priv_data->msi_irq_groups)) {
-		err = PTR_ERR(priv_data->msi_irq_groups);
-		goto out_free_irqs;
-	}
-
 	return 0;
 
-out_free_irqs:
-	msi_domain_free_irqs(dev->msi.domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -308,7 +300,6 @@ void platform_msi_domain_free_irqs(struc
 		struct msi_desc *desc;
 
 		desc = first_msi_entry(dev);
-		msi_destroy_sysfs(dev, desc->platform.msi_priv_data->msi_irq_groups);
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 

