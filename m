Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE3472046
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhLMFOz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhLMFOz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:14:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85FFC06173F;
        Sun, 12 Dec 2021 21:14:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0064DCE0DC7;
        Mon, 13 Dec 2021 05:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E36C00446;
        Mon, 13 Dec 2021 05:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639372491;
        bh=zuuGW5+kS2UVDTK9JZgN0rVsKZ9vO7N+ikVVGGhcFus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGfflIEVbOYzZ4L0+ZwdoUg9quAO5nOi9/UXP3Xmr9G9FMvVyrwT7jr3JP9IGaiFL
         iDr3OkfoB6b8rQrplP3MBZ21trYA1fHZJ/P6K9OgJk7ys8npF3ZR421z8PmAzyK7at
         mVJOPb6bRTPOptJL+XKRuXrxiPG2olj+FZeiYHjN4ZRoI7C3Src7FeNuQiJmp+bUMG
         xPtHLVBnuBhLRIQdqXBDutn2NvWHHNDEQKnckdYO0OUOOTJAyaAkyCOddpx7Tk6abA
         UbXFRd62tmtswrOO2et02MquRCBkv8NhukN03R6Wud8Ms+/tbnOLTtPGic26cUTGyv
         Al/o3XGCyfNBQ==
Date:   Mon, 13 Dec 2021 10:44:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@kernel.org>, dmaengine@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [patch V3 35/35] dmaengine: qcom_hidma: Cleanup MSI handling
Message-ID: <YbbWx1LhPEtF/9pp@matsya>
References: <20211210221642.869015045@linutronix.de>
 <20211210221815.329792721@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210221815.329792721@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-12-21, 23:19, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There is no reason to walk the MSI descriptors to retrieve the interrupt
> number for a device. Use msi_get_virq() instead.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
