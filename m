Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D6473FAC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 10:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhLNJlM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 04:41:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40482 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLNJlL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Dec 2021 04:41:11 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639474869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QERmxLNSvvFx6vzNSYmMrsv0e2X5CmwuAGyK1bazfj4=;
        b=uVT3SzBcceVfCKVd9bfwP/mkrBbU6i6CXo8B0uqt0K0CoD5a4qXyBj1twarA7qhg9DUpCf
        OrVbNB7kcn9ckbfr0CT2aeLTQTe7pl003+0ptW2EbYL49mtlKdiGcdgbTrY3LmUvHIDRVO
        oUyYJTCLGbEKPL3lyqY4wNdexzr+WwLkloa+hbSAnazTQRKYFU/bmsDlS0IKdiZ6tW9GGx
        HiqEkWnh0eDq6pt7S9pHkclWGxZU61oDJv8S9DVEIUgIkiP6c3yxVlpBmL8rJzB+H4TNe6
        G8+D7456TbPXVtBVebfm1EMXeWbrmmtdvroOCyBCNYYLr4GmBNBW77LIxVu6Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639474869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QERmxLNSvvFx6vzNSYmMrsv0e2X5CmwuAGyK1bazfj4=;
        b=KbnnQxJjrjwD3AUzOdrDHb83i5GFD5BYZ+EuPZBYHEXZFSMZ3bN/5+CPOSNQTQ/bGXXBRZ
        h+7rXr2HbjWxd5Dw==
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
In-Reply-To: <20211213182958.ytj4m6gsg35u77cv@detonator>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator>
Date:   Tue, 14 Dec 2021 10:41:08 +0100
Message-ID: <87fsqvttfv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 13 2021 at 12:29, Nishanth Menon wrote:
> On 23:18-20211210, Thomas Gleixner wrote:
> Also while testing on TI K3 platforms, I noticed:
>
> msi_device_data_release/msi_device_destroy_sysfs in am64xx-evm / j7200

The warning complains about a device being released with MSI descriptors
still attached to the device. This was added by:

  5b012cede0f7 ("device: Add device::msi_data pointer and struct msi_device_data")

That's not a regression caused by this commit. The warning is just
exposing an already existing problem in the iwlwifi driver, which seems
to do:

   probe()
     setup_pci_msi[x]_interrupts()
     start_drv()
       if (try_to_load_firmware() == FAIL)
       	   device_release_driver()
                ...
                msi_device_data_release()
                    WARN()

Thanks,

        tglx
