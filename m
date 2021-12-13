Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04002473407
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhLMSbY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 13:31:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59894 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLMSbX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 13:31:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BDITweD032784;
        Mon, 13 Dec 2021 12:29:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639420199;
        bh=CIwJXsDVc6MpWMxloZbtRdlpLw1Ztan/9G2UzPwMY0E=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aQr+rT7AbNmri1BYm4glcZYUB4D0/LtbXNn0eGzLe1Xq4LgTziMH/fZw9NMlUSxOJ
         eUvgRnz/JUOtWmI/LUlydZmqlDtGvShVqc/335BSewifnzHFovUoMb7LUYizCR9g/k
         /rYDbql0vQTQMlM2Nnxl+1kL4PPvB9mCQmf5UIQI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BDITwlR038320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Dec 2021 12:29:58 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 13
 Dec 2021 12:29:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 13 Dec 2021 12:29:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BDITwZX089938;
        Mon, 13 Dec 2021 12:29:58 -0600
Date:   Mon, 13 Dec 2021 12:29:58 -0600
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
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <20211213182958.ytj4m6gsg35u77cv@detonator>
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211210221642.869015045@linutronix.de>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23:18-20211210, Thomas Gleixner wrote:
[...]

> 
> It's also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v3-part-2

[...]

> ---
>  drivers/dma/ti/k3-udma-private.c                    |    6 
>  drivers/dma/ti/k3-udma.c                            |   14 -
>  drivers/irqchip/irq-ti-sci-inta.c                   |    2 
>  drivers/soc/ti/k3-ringacc.c                         |    6 
>  drivers/soc/ti/ti_sci_inta_msi.c                    |   22 --
>  include/linux/soc/ti/ti_sci_inta_msi.h              |    1 

Also while testing on TI K3 platforms, I noticed:

msi_device_data_release/msi_device_destroy_sysfs in am64xx-evm / j7200
[1] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-am64xx-evm-txt-L1018
[2] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-j7200-evm-txt-L1076

Which is not present in vanilla v5.16-rc4

v5.16-rc4:
https://gist.github.com/nmenon/1aee3f0a7da47d5e9dcb7336b32a70cb

msi-v3-part-2:
https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33

(.config https://gist.github.com/nmenon/ec6f95303828abf16a64022d8e3a269f)

Vs:
next-20211208:
https://gist.github.com/nmenon/f5ca3558bd5c1fbe62dc5ceb420b536e

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
