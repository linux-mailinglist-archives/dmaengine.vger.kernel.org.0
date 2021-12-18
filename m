Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDA479D72
	for <lists+dmaengine@lfdr.de>; Sat, 18 Dec 2021 22:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhLRVmV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Dec 2021 16:42:21 -0500
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110]:50663 "EHLO
        1.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLRVmV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Dec 2021 16:42:21 -0500
X-Greylist: delayed 2401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Dec 2021 16:42:21 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.121])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 3A38A20143;
        Sat, 18 Dec 2021 20:25:43 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 18 Dec
 2021 21:25:41 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-97G0022d2cf51f-56be-41f7-b9ac-2c271cc1d1bb,
                    B1F2FCB93787BB0875C07E604CDE73E7ADF677F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.11.79.163
Message-ID: <ee5db32f-c21e-287f-2a19-94c1ba6e8217@kaod.org>
Date:   Sat, 18 Dec 2021 21:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
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
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de> <Yb0PaCyo/6z3XOlf@archlinux-ax161>
 <87v8zm9pmd.ffs@tglx>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <87v8zm9pmd.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2aa807ab-02a3-4ad6-8447-d206fc92c88e
X-Ovh-Tracer-Id: 4883872323797683005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrleekgddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehokhgrhigrsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/18/21 11:25, Thomas Gleixner wrote:
> On Fri, Dec 17 2021 at 15:30, Nathan Chancellor wrote:
>> On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
>> I just bisected a boot failure on my AMD test desktop to this patch as
>> commit f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()") in
>> -next. It looks like there is a problem with the NVMe drive after this
>> change according to the logs. Given that the hard drive is not getting
>> mounted for journald to write logs to, I am not really sure how to get
>> them from the machine so I have at least taken a picture of what I see
>> on my screen; open to ideas on that front!
> 
> Bah. Fix below.

That's a fix for the issue I was seeing on pseries with NVMe.

Tested-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> Thanks,
> 
>          tglx
> ---
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 71802410e2ab..9b4910befeda 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1100,7 +1100,7 @@ EXPORT_SYMBOL(pci_irq_vector);
>    */
>   const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>   {
> -	int irq = pci_irq_vector(dev, nr);
> +	int idx, irq = pci_irq_vector(dev, nr);
>   	struct msi_desc *desc;
>   
>   	if (WARN_ON_ONCE(irq <= 0))
> @@ -1113,7 +1113,10 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>   
>   	if (WARN_ON_ONCE(!desc->affinity))
>   		return NULL;
> -	return &desc->affinity[nr].mask;
> +
> +	/* MSI has a mask array in the descriptor. */
> +	idx = dev->msi_enabled ? nr : 0;
> +	return &desc->affinity[idx].mask;
>   }
>   EXPORT_SYMBOL(pci_irq_get_affinity);
>   
> 

