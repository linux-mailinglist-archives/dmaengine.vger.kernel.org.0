Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE045F95B
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhK0B0p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbhK0BYn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:43 -0500
Message-ID: <20211126230524.778704986@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ehi/wwF9q+UnZyXX27wliNOB9+x0r0rx0yUOBA3VcWA=;
        b=VTMtOkbqzmfdwZwSBeV1FD5w52HS+b6Mgrcwr6QflvuBj7vnE4RYJ5rfk7qUTp+bji6JcK
        cVF5asbiqIvHDtduDdJIVLWmIVbgaq4ZDaKaXvzsESAoYczDrJm1r9uU84ox0DXw2hgOWd
        v12BvM3GjC7FmjS2O5X26UVGzu4p++bPBOdwcy6pkI7nqcz9nxHWnLNfIWc36CYE5KfXcz
        ZHui/U+6dWfSZPfPp2tCvzujaLDyunWyL/85kPslmw2e9t7h551TfehRds9qz8pHN4Zasp
        Nl+4uuqVBbimdRkb8y6iysOMYBA7U92UU3CXWyKlYGoqa9HtUT7oEixfcn037w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ehi/wwF9q+UnZyXX27wliNOB9+x0r0rx0yUOBA3VcWA=;
        b=i6NWrHDPAtxe6JmljqOrt1HMZj0MXlU06z+oRNVp0rjhliRvqguewklbZVYvPlSgSsUf7Q
        tlJFP458IFEstdCg==
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
Subject: [patch 14/37] genirq/msi: Consolidate MSI descriptor data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:29 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

All non PCI/MSI usage variants have data structures in struct msi_desc with
only one member: xxx_index. PCI/MSI has a entry_nr member.

Add a common msi_index member to struct msi_desc so all implementations can
share it which allows further consolidation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -142,6 +142,7 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
+ * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
@@ -162,6 +163,7 @@ struct msi_desc {
 	void (*write_msi_msg)(struct msi_desc *entry, void *data);
 	void *write_msi_msg_data;
 
+	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
 		struct platform_msi_desc	platform;

