Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAAA45FE6F
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349684AbhK0MRz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 07:17:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60442 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350954AbhK0MPz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 Nov 2021 07:15:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A197B817AC;
        Sat, 27 Nov 2021 12:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CACCC53FAD;
        Sat, 27 Nov 2021 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638015158;
        bh=Nsypz1pbkrnBiWqd93zUKpPoJWu4uG4aFKzWclKNc9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzMjx7oKYUBaSqI7Q8w0u1AgdSfR07MfyEkU7XIvbNq5Z99yeq3J4Ls/QMed/W4SP
         Eba1zDMeN9zfI4spkq4X+daCizQux5tAT+r3n8r6Ku+d9bimqPGycb4C4JVbp6uXIm
         qSTj78+6e5GnhJjPjP0rbDK368g5U+kzGjFnnUew=
Date:   Sat, 27 Nov 2021 13:12:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 02/37] device: Add device::msi_data pointer and struct
 msi_device_data
Message-ID: <YaIgsyae/J0XJbHQ@kroah.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.045836616@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126230524.045836616@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27, 2021 at 02:20:09AM +0100, Thomas Gleixner wrote:
> Create struct msi_device_data and add a pointer of that type to struct
> dev_msi_info, which is part of struct device. Provide an allocator function
> which can be invoked from the MSI interrupt allocation code pathes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/device.h |    5 +++++
>  include/linux/msi.h    |   12 +++++++++++-
>  kernel/irq/msi.c       |   33 +++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
