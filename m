Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE51A47483F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 17:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhLNQgE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhLNQgD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Dec 2021 11:36:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB05C061574;
        Tue, 14 Dec 2021 08:36:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639499761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHkEiVG0BVT8V/9kbAcBq/GVsYt3jqgvF40FkGyKrlo=;
        b=x+UREoz0tV0ByegvETONzIcJg/btHkYAeUTOB9Cwk6fF4WS4tcdqSKPZhosLY9Kw8fzkL2
        iAO8dxlrohDcjOfDmK3UIx35hhe0gnfY1J6UUVxyO061FZZ9igOXoMxu0oZsfFw4GbgpYB
        Q5rK3Ehp3GsvY/ZWFqOBDe34LxDsXDQAfeXwgAzwLGuRTF6/6fajjiB+l4faY58KyXYRd9
        TRvQUMx4KhjpOhAQjyD53NZ44/KDHNZzen3o5CWSSmMuXJs7tSK49MGIkP5L/9Tw/0p3r8
        ob+7BJIhXKuW4vpCWZYdUoDVrJaJ+Ar127CVhFKQjgeiplPgqNc0w3IVyPx/sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639499761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHkEiVG0BVT8V/9kbAcBq/GVsYt3jqgvF40FkGyKrlo=;
        b=JRPDqiMesD5qMuzHSYGkN8LOEMskH9IhyPnRCqMbSThsy+YATwXU6QDtFhGJhGuZcxfILm
        UyvW8q3ctT/IqHDg==
To:     Nishanth Menon <nm@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Tero Kristo <kristo@kernel.org>,
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
        Sinan Kaya <okaya@kernel.org>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211214162247.ocjm7ihg5oi7uiuv@slider>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider>
Date:   Tue, 14 Dec 2021 17:36:00 +0100
Message-ID: <87wnk7rvnz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 14 2021 at 10:22, Nishanth Menon wrote:
> On 10:41-20211214, Thomas Gleixner wrote:
> Agreed that the warning is fine, the null pointer exception that follows
> [1] [2] it however does'nt look right and it can be trivially fixed with the
> following fixup for ee90787487bc ("genirq/msi: Provide
> msi_device_populate/destroy_sysfs()") below, with that the log looks
> like [3] - the warn is good, the null pointer exception and resultant
> crash could be avoided (not saying this is the best solution):

Aaargh.

[   13.478122] Call trace:
[   13.509042]  msi_device_destroy_sysfs+0x18/0x88
[   13.509058]  msi_domain_free_irqs+0x34/0x58
[   13.509064]  pci_msi_teardown_msi_irqs+0x30/0x3c
[   13.509072]  free_msi_irqs+0x78/0xd4
[   13.509077]  pci_disable_msix+0x138/0x164
[   13.529930]  pcim_release+0x70/0x238
[   13.529942]  devres_release_all+0x9c/0xfc
[   13.529951]  device_release_driver_internal+0x1a0/0x244
[   13.542725]  device_release_driver+0x18/0x24
[   13.542741]  iwl_req_fw_callback+0x1a28/0x1ddc [iwlwifi]
[   13.552308]  request_firmware_work_func+0x50/0x9c
[   13.552320]  process_one_work+0x194/0x25c

That's not a driver problem, that's an ordering issue vs. the devres
muck. Let me go back to the drawing board. Sigh...

Thanks,

        tglx

