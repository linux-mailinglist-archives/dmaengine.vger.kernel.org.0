Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0E47677C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 02:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhLPBqc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 20:46:32 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45046 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLPBqc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 20:46:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BG1jRfh031919;
        Wed, 15 Dec 2021 19:45:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639619127;
        bh=x5y0W7NcQu8KFCCs6SOY3R1ieqDIaIpGqjfY0/mf1aE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=J5phN9h68zO6NinAKtCP/hmHaPgLgmqEGVPSbOywTVyespzsahOYEMGicemzLRq2Y
         21pPWpguPw6fDybn84tKdvQctjmv68Dr1n2Jr/sg63dZkF5qXYf/uErtLqrDj5vXPI
         1ZEaLuHXnc4osJDl09QfWl3URXAzeFJSZ4FNP8zc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BG1jRfp012888
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 19:45:27 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 19:45:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 19:45:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BG1jRLZ081996;
        Wed, 15 Dec 2021 19:45:27 -0600
Date:   Wed, 15 Dec 2021 19:45:27 -0600
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
Message-ID: <20211216014527.5d3sqs2klrqjmm2k@lunacy>
References: <20211213182958.ytj4m6gsg35u77cv@detonator>
 <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider>
 <87wnk7rvnz.ffs@tglx>
 <87tufbrudl.ffs@tglx>
 <87mtl3rli1.ffs@tglx>
 <20211214205626.lrnddha6bd6d6es5@possibly>
 <87h7basx36.ffs@tglx>
 <87zgp1rge4.ffs@tglx>
 <87wnk5rfkt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wnk5rfkt.ffs@tglx>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Thomas,

On 17:35-20211215, Thomas Gleixner wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4.2-part-3

As you helped offline, summarizing the details on part3 of the series:

I was seeing failure[1] of NFS(DMA) on all TI K3 platforms:

[    1.013258] ti-bcdma 485c0100.dma-controller: Number of rings: 68
[    1.019963] ti-bcdma 485c0100.dma-controller: Failed to allocate IRQs -28
[    1.026938] ti-bcdma 485c0100.dma-controller: Failed to allocate MSI interrupts

Rationale as you explained:
"
-28 is ENOSPC, which is returned when the interrupt allocation in the
 MSI domain fails. Fix below.
"

Which turned out to be the fixup[2] you suggested and I confirm that
fixes the problem for me.

With the fixup in place:

Tested-by: Nishanth Menon <nm@ti.com>

for part 3 of the series as well.

Thanks once again for your help. Hope we can roll in the fixes for
part3.

[1] https://gist.github.com/nmenon/5971ab27aa626c022e276cc946e4b6c3
[2]
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -68,6 +68,7 @@ static int ti_sci_inta_msi_alloc_descs(s
 	int set, i, count = 0;
 
 	memset(&msi_desc, 0, sizeof(msi_desc));
+	msi_desc.nvec_used = 1;
 
 	for (set = 0; set < res->sets; set++) {
 		for (i = 0; i < res->desc[set].num; i++, count++) {
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
