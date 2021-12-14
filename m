Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7304747E8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 17:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhLNQYl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 11:24:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58186 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhLNQXt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Dec 2021 11:23:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BEGMmuO025468;
        Tue, 14 Dec 2021 10:22:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639498968;
        bh=j8vcNDlyu6rGGlbNXrHIPndlfNexrjOXKWOfEEIJnnk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xgTGUZkLvFa0MkQp65s/DUVAeZv9Jh6bDvETBxkkXt9kHUJh2S2ely6DWwhAEv7nE
         9sCLwo7TGhPOwJHN4Tpl9RtuWpdVoaxfjasPPolvZWeFEwB03D/XW8/nuRUiuxjvP2
         bQ7FHOHAdSfs79apWvV8d5LiB3urN2udwFKj+JSg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BEGMmM0085080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 10:22:48 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 10:22:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 10:22:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BEGMllf122522;
        Tue, 14 Dec 2021 10:22:47 -0600
Date:   Tue, 14 Dec 2021 10:22:47 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, <linux-pci@vger.kernel.org>,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <20211214162247.ocjm7ihg5oi7uiuv@slider>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator>
 <87fsqvttfv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87fsqvttfv.ffs@tglx>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10:41-20211214, Thomas Gleixner wrote:
> On Mon, Dec 13 2021 at 12:29, Nishanth Menon wrote:
> > On 23:18-20211210, Thomas Gleixner wrote:
> > Also while testing on TI K3 platforms, I noticed:
> >
> > msi_device_data_release/msi_device_destroy_sysfs in am64xx-evm / j7200
> 
> The warning complains about a device being released with MSI descriptors
> still attached to the device. This was added by:
> 
>   5b012cede0f7 ("device: Add device::msi_data pointer and struct msi_device_data")
> 
> That's not a regression caused by this commit. The warning is just
> exposing an already existing problem in the iwlwifi driver, which seems
> to do:
> 
>    probe()
>      setup_pci_msi[x]_interrupts()
>      start_drv()
>        if (try_to_load_firmware() == FAIL)
>        	   device_release_driver()
>                 ...
>                 msi_device_data_release()
>                     WARN()
> 

Agreed that the warning is fine, the null pointer exception that follows
[1] [2] it however does'nt look right and it can be trivially fixed with the
following fixup for ee90787487bc ("genirq/msi: Provide
msi_device_populate/destroy_sysfs()") below, with that the log looks
like [3] - the warn is good, the null pointer exception and resultant
crash could be avoided (not saying this is the best solution):

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ab5e83f41188..24edb870c66f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -252,11 +252,14 @@ int msi_device_populate_sysfs(struct device *dev)
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
+	const struct attribute_group **msi_irq_groups;
 	struct device_attribute *dev_attr;
 	struct attribute **msi_attrs;
 	int count = 0;
 
+	if (!dev->msi.data)
+		return;
+	msi_irq_groups = dev->msi.data->attrs;
 	dev->msi.data->attrs = NULL;
 	if (!msi_irq_groups)
 		return;

[1] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-am64xx-evm-txt-L1049
[2] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-j7200-evm-txt-L1111

[3] https://gist.github.com/nmenon/575afe7d04463026a7e420a76c2c1c5b
	https://gist.github.com/nmenon/575afe7d04463026a7e420a76c2c1c5b#file-am64xx-evm-txt-L1018
	https://gist.github.com/nmenon/575afe7d04463026a7e420a76c2c1c5b#file-j7200-evm-txt-L1053
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
