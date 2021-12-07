Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1B46C692
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhLGVWe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 16:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhLGVWe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 16:22:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FAC061574;
        Tue,  7 Dec 2021 13:19:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638911940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fejqz/bIS5UVVez3Xtjq2jInYaufJY/nLKnDbenyBtw=;
        b=VC5Rvg7jiq8Ikfw+JFC2if6V+C51JARVBdC0uW9vUW0CHLXLMJTCVCws2bKyhUrgzzbYBD
        TspgTWIoCN3z1mpSmBTfGbx4XIbh9GbNDRxSmFXBfJwIBX3j0sw+jnfm/oYCbc43OrEUpM
        SS9tX2diiZM5lYRGla6ljcr7iPYUAT/RJ9qMdqhJZgpVF0sfTve/39i5qs1L2SbKmA26Kk
        RuYaS8IxyMjfJtp5yErMcFm+uepejATF2VudC9wKWykGQzcm11Soqa0vOKrqlwq9Qy2ES/
        hIUI+MznVV8wAM/ESPIdQN7tFRoLJxRc700tRc0QEredDULx8y3xvMEgR1lqVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638911940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fejqz/bIS5UVVez3Xtjq2jInYaufJY/nLKnDbenyBtw=;
        b=tpxYQz931aJ9NXdPSYYAooQnjmQcVTU6ncg1A9XfE7ZYmworf/GnMN1rkeaSCd4LIsHO3E
        LsosR2mIUwj5rrDw==
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [patch V2 29/36] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <e32237f3-0ff2-cf80-cd99-0b4813d1ed21@kaod.org>
References: <20211206210307.625116253@linutronix.de>
 <20211206210439.235197701@linutronix.de>
 <e32237f3-0ff2-cf80-cd99-0b4813d1ed21@kaod.org>
Date:   Tue, 07 Dec 2021 22:19:00 +0100
Message-ID: <87zgpc15bv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cedric,

On Tue, Dec 07 2021 at 18:42, C=C3=A9dric Le Goater wrote:
>
> This is breaking nvme on pseries but it's probably one of the previous
> patches. I haven't figured out what's wrong yet. Here is the oops FYI.

Hrm.

> [   32.494562] WARNING: CPU: 26 PID: 658 at kernel/irq/chip.c:210 irq_sta=
rtup+0x1c0/0x1e0

This complains about a manual enable_irq() on a managed interrupt.

> [   32.494575] Modules linked in: ibmvscsi ibmveth scsi_transport_srp bnx=
2x ipr libata xhci_pci xhci_hcd nvme xts vmx_crypto nvme_core mdio t10_pi l=
ibcrc32c dm_mirror dm_region_hash dm_log dm_mod
> [   32.494601] CPU: 26 PID: 658 Comm: kworker/26:1H Not tainted 5.16.0-rc=
4-clg+ #54
> [   32.494607] Workqueue: kblockd blk_mq_timeout_work
> [   32.494681] NIP [c000000000206f00] irq_startup+0x1c0/0x1e0
> [   32.494686] LR [c000000000206df0] irq_startup+0xb0/0x1e0
> [   32.494690] Call Trace:
> [   32.494692] [c0000018050f38b0] [c000000000206df0] irq_startup+0xb0/0x1=
e0 (unreliable)
> [   32.494699] [c0000018050f38f0] [c00000000020155c] __enable_irq+0x9c/0x=
b0
> [   32.494705] [c0000018050f3950] [c0000000002015d0] enable_irq+0x60/0xc0
> [   32.494710] [c0000018050f39d0] [c008000014a54ae8] nvme_poll_irqdisable=
+0x80/0xc0 [nvme]
> [   32.494719] [c0000018050f3a00] [c008000014a55824] nvme_timeout+0x18c/0=
x420 [nvme]
> [   32.494726] [c0000018050f3ae0] [c00000000076e1b8] blk_mq_check_expired=
+0xa8/0x130
> [   32.494732] [c0000018050f3b10] [c0000000007793e8] bt_iter+0xd8/0x120
> [   32.494737] [c0000018050f3b60] [c00000000077a34c] blk_mq_queue_tag_bus=
y_iter+0x25c/0x3f0
> [   32.494742] [c0000018050f3c20] [c00000000076ffa4] blk_mq_timeout_work+=
0x84/0x1a0
> [   32.494747] [c0000018050f3c70] [c000000000182a78] process_one_work+0x2=
a8/0x5a0

Confused. I diffed against v1, but could not spot anything except that
properties issue which you found too.

Thanks,

        tglx

