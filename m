Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E634748BD
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 18:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhLNRDx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 12:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbhLNRDw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Dec 2021 12:03:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62854C061574;
        Tue, 14 Dec 2021 09:03:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639501430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXDy+gEt+jM/GLA+wNxlJEuBnWYy8r3p2Ru1kkxGm4Q=;
        b=4P9YNy0ES7591XCDm5PSWup8bN4QZP7lauZPNqzguglGF810Qx6tlHC+ni+cCTXT//bRrL
        8sy8xtbBW2WNueS1zjqp8h8A0yb4naQSxUV7RBh2hqT1tsFq6begUYU0evqtkPzN01b278
        fd9gHbaeywBmVDCmDPd2qQ/zpjMiaB9wQAqsRoE0OI6pkTd0Mdkr8wct9zyvWczqltcPfP
        gVFurKQstARHhwA4cqkMjQuwW0a240akK7UOWCq2KqJXtL/Zk07hDvbDB6Geb3dHg82+ku
        rQEa7JysFMGTutJcrfi+Bj+sn5C4cesBd4+iCf7oAFV+qmPbWW589QvaRwSxBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639501430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXDy+gEt+jM/GLA+wNxlJEuBnWYy8r3p2Ru1kkxGm4Q=;
        b=NEaZQwUVupGSoHFBC83jQ5nykyNdZrjtpZRBFsQka5WyTgqzd9VoqFy4Lrz/ewIMzZW0fK
        mYumgixv6qanTNBQ==
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
In-Reply-To: <87wnk7rvnz.ffs@tglx>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider> <87wnk7rvnz.ffs@tglx>
Date:   Tue, 14 Dec 2021 18:03:50 +0100
Message-ID: <87tufbrudl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 14 2021 at 17:36, Thomas Gleixner wrote:
> On Tue, Dec 14 2021 at 10:22, Nishanth Menon wrote:
>> On 10:41-20211214, Thomas Gleixner wrote:
> [   13.478122] Call trace:
> [   13.509042]  msi_device_destroy_sysfs+0x18/0x88
> [   13.509058]  msi_domain_free_irqs+0x34/0x58
> [   13.509064]  pci_msi_teardown_msi_irqs+0x30/0x3c
> [   13.509072]  free_msi_irqs+0x78/0xd4
> [   13.509077]  pci_disable_msix+0x138/0x164
> [   13.529930]  pcim_release+0x70/0x238
> [   13.529942]  devres_release_all+0x9c/0xfc
> [   13.529951]  device_release_driver_internal+0x1a0/0x244
> [   13.542725]  device_release_driver+0x18/0x24
> [   13.542741]  iwl_req_fw_callback+0x1a28/0x1ddc [iwlwifi]
> [   13.552308]  request_firmware_work_func+0x50/0x9c
> [   13.552320]  process_one_work+0x194/0x25c
>
> That's not a driver problem, that's an ordering issue vs. the devres
> muck. Let me go back to the drawing board. Sigh...

Which is pretty obvious why:

   pcim_enable_device()
        devres_alloc(pcim_release...);
        ...
        pci_irq_alloc()
          msi_setup_device_data()
             devres_alloc(msi_device_data_release, ...)

and once the device is released:

    msi_device_data_release()
    ...
    pcim_release()
       pci_disable_msi[x]()

Groan....
