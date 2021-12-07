Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74EA46C1FB
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhLGRp5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 12:45:57 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173]:45959 "EHLO
        smtpout4.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234757AbhLGRp5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 12:45:57 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.17])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4DC6CD06F169;
        Tue,  7 Dec 2021 18:42:25 +0100 (CET)
Received: from kaod.org (37.59.142.102) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 18:42:23 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-102R0045e25c049-ab10-4875-94b1-6aac2f02c5c1,
                    EDCC1E77E28A65BD51DFCD2B92BF934EEA10E5FB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.201.172.254
Message-ID: <e32237f3-0ff2-cf80-cd99-0b4813d1ed21@kaod.org>
Date:   Tue, 7 Dec 2021 18:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch V2 29/36] PCI/MSI: Simplify pci_irq_get_affinity()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, <linux-pci@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <iommu@lists.linux-foundation.org>, <dmaengine@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
References: <20211206210307.625116253@linutronix.de>
 <20211206210439.235197701@linutronix.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20211206210439.235197701@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 9a201c60-92f7-40d1-8e65-204b0cf1b1c0
X-Ovh-Tracer-Id: 11313323742435773410
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephffhleegueektdetffdvffeuieeugfekkeelheelteeftdfgtefffeehueegleehnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepohhkrgihrgeskhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thomas,

On 12/6/21 23:39, Thomas Gleixner wrote:
> Replace open coded MSI descriptor chasing and use the proper accessor
> functions instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/pci/msi/msi.c |   26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1056,26 +1056,20 @@ EXPORT_SYMBOL(pci_irq_vector);
>    */
>   const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>   {
> -	if (dev->msix_enabled) {
> -		struct msi_desc *entry;
> +	int irq = pci_irq_vector(dev, nr);
> +	struct msi_desc *desc;
>   
> -		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->msi_index == nr)
> -				return &entry->affinity->mask;
> -		}
> -		WARN_ON_ONCE(1);
> +	if (WARN_ON_ONCE(irq <= 0))
>   		return NULL;
> -	} else if (dev->msi_enabled) {
> -		struct msi_desc *entry = first_pci_msi_entry(dev);
>   
> -		if (WARN_ON_ONCE(!entry || !entry->affinity ||
> -				 nr >= entry->nvec_used))
> -			return NULL;
> -
> -		return &entry->affinity[nr].mask;
> -	} else {
> +	desc = irq_get_msi_desc(irq);
> +	/* Non-MSI does not have the information handy */
> +	if (!desc)
>   		return cpu_possible_mask;
> -	}
> +
> +	if (WARN_ON_ONCE(!desc->affinity))
> +		return NULL;
> +	return &desc->affinity[nr].mask;
>   }
>   EXPORT_SYMBOL(pci_irq_get_affinity);

This is breaking nvme on pseries but it's probably one of the previous
patches. I haven't figured out what's wrong yet. Here is the oops FYI.

Thanks,

C.

[   32.494536] ------------[ cut here ]------------
[   32.494562] WARNING: CPU: 26 PID: 658 at kernel/irq/chip.c:210 irq_startup+0x1c0/0x1e0
[   32.494575] Modules linked in: ibmvscsi ibmveth scsi_transport_srp bnx2x ipr libata xhci_pci xhci_hcd nvme xts vmx_crypto nvme_core mdio t10_pi libcrc32c dm_mirror dm_region_hash dm_log dm_mod
[   32.494601] CPU: 26 PID: 658 Comm: kworker/26:1H Not tainted 5.16.0-rc4-clg+ #54
[   32.494607] Workqueue: kblockd blk_mq_timeout_work
[   32.494615] NIP:  c000000000206f00 LR: c000000000206df0 CTR: c000000000201570
[   32.494619] REGS: c0000018050f3610 TRAP: 0700   Not tainted  (5.16.0-rc4-clg+)
[   32.494624] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44002288  XER: 00000000
[   32.494636] CFAR: c000000000206e0c IRQMASK: 1
[   32.494636] GPR00: c000000000206df0 c0000018050f38b0 c000000001ca2900 0000000000000800
[   32.494636] GPR04: c000000001ce21b8 0000000000000800 0000000000000800 0000000000000000
[   32.494636] GPR08: 0000000000000000 0000000000000200 0000000000000000 fffffffffffffffd
[   32.494636] GPR12: 0000000000000000 c000001fff7c5880 c00000000018f488 c00000012faaba40
[   32.494636] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
[   32.494636] GPR20: 0000000000000000 c0000018050f3c40 c00000000076e110 c00000013ac23678
[   32.494636] GPR24: 000000000000007f 0000000000000100 0000000000000001 c000001805b08000
[   32.494636] GPR28: c000000139b8cc18 0000000000000001 0000000000000001 c000000139b8cc00
[   32.494681] NIP [c000000000206f00] irq_startup+0x1c0/0x1e0
[   32.494686] LR [c000000000206df0] irq_startup+0xb0/0x1e0
[   32.494690] Call Trace:
[   32.494692] [c0000018050f38b0] [c000000000206df0] irq_startup+0xb0/0x1e0 (unreliable)
[   32.494699] [c0000018050f38f0] [c00000000020155c] __enable_irq+0x9c/0xb0
[   32.494705] [c0000018050f3950] [c0000000002015d0] enable_irq+0x60/0xc0
[   32.494710] [c0000018050f39d0] [c008000014a54ae8] nvme_poll_irqdisable+0x80/0xc0 [nvme]
[   32.494719] [c0000018050f3a00] [c008000014a55824] nvme_timeout+0x18c/0x420 [nvme]
[   32.494726] [c0000018050f3ae0] [c00000000076e1b8] blk_mq_check_expired+0xa8/0x130
[   32.494732] [c0000018050f3b10] [c0000000007793e8] bt_iter+0xd8/0x120
[   32.494737] [c0000018050f3b60] [c00000000077a34c] blk_mq_queue_tag_busy_iter+0x25c/0x3f0
[   32.494742] [c0000018050f3c20] [c00000000076ffa4] blk_mq_timeout_work+0x84/0x1a0
[   32.494747] [c0000018050f3c70] [c000000000182a78] process_one_work+0x2a8/0x5a0
[   32.494754] [c0000018050f3d10] [c000000000183468] worker_thread+0xa8/0x610
[   32.494759] [c0000018050f3da0] [c00000000018f634] kthread+0x1b4/0x1c0
[   32.494764] [c0000018050f3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
[   32.494769] Instruction dump:
[   32.494773] 60000000 0b030000 38a00000 7f84e378 7fc3f378 4bff9a55 60000000 7fe3fb78
[   32.494781] 4bfffd79 eb810020 7c7e1b78 4bfffe94 <0fe00000> 60000000 60000000 60420000
[   32.494788] ---[ end trace 2a27b87f2b3e7a1f ]---
[   32.494798] nvme nvme0: I/O 192 QID 128 timeout, aborting
[   32.584562] nvme nvme0: Abort status: 0x0
[   62.574526] nvme nvme0: I/O 200 QID 128 timeout, aborting
[   62.574587]  nvme0n1: p1

