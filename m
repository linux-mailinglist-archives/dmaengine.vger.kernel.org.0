Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07A246093A
	for <lists+dmaengine@lfdr.de>; Sun, 28 Nov 2021 20:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhK1TOg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Nov 2021 14:14:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhK1TMg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Nov 2021 14:12:36 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638126558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjZcRIM8mi5Lga3dE0YMFAAVgRUsLCHnKUD78SK4AQQ=;
        b=RXQ9TCzzfl4WPtWcEJoRHxY0CML6p5j+vVn642rlvX4FXeGOQlTdOUHJA7TT/zMvTcjhsJ
        z2rlcikR4dPUEfkkZEyKLgBw5JNje7IukbrP5rH+IE6poqMYiao1Ca4Jv76m34iRN55Ugp
        9P197uGT9ReR6cEJgyZzR2bL1i5B2LiF3G8u3m1MGyv/K7P7ZcAj693GrLpygGCZMR0zi0
        0KJ7ALQY8WY49eWHTHuU3ao5WzbumtDwaMd5vjrhuQEmq6z0WkfUTzt9rSRrTjaYjKnNAh
        cfKsUGOras+oIgI8Eal2B4zXTACelM12H/MpiLBy/YwAKS60vXfzAPoKFbwzqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638126558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjZcRIM8mi5Lga3dE0YMFAAVgRUsLCHnKUD78SK4AQQ=;
        b=bp81l/mvh3aNr1oJURqDKy63fAKoxH05F3XfT4StsiB+7OI2VuNNOHrlu3G2D0TFLaaxGV
        tRyuRxEuQqfHuuBA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
In-Reply-To: <20211128001406.GT4670@nvidia.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.045836616@linutronix.de>
 <20211128001406.GT4670@nvidia.com>
Date:   Sun, 28 Nov 2021 20:09:18 +0100
Message-ID: <87czmkf675.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27 2021 at 20:14, Jason Gunthorpe wrote:
> On Sat, Nov 27, 2021 at 02:20:09AM +0100, Thomas Gleixner wrote:
>
>> +/**
>> + * msi_setup_device_data - Setup MSI device data
>> + * @dev:	Device for which MSI device data should be set up
>> + *
>> + * Return: 0 on success, appropriate error code otherwise
>> + *
>> + * This can be called more than once for @dev. If the MSI device data is
>> + * already allocated the call succeeds. The allocated memory is
>> + * automatically released when the device is destroyed.
>
> I would say 'by devres when the driver is removed' rather than device
> is destroyed - to me the latter implies it would happen at device_del
> or perhaps during release..

Ah. Indeed it's when the driver unbinds because that's what disables MSI.

>> +int msi_setup_device_data(struct device *dev)
>> +{
>> +	struct msi_device_data *md;
>> +
>> +	if (dev->msi.data)
>> +		return 0;
>> +
>> +	md = devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
>> +	if (!md)
>> +		return -ENOMEM;
>> +
>> +	raw_spin_lock_init(&md->lock);
>
> I also couldn't guess why this needed to be raw?

That lock is to replace the raw spinlock we have in struct device right
now, which is protecting low level register access and that's called
from within irq_desc::lock held regions with interrupts disabled. I had
to stick something into the data structure because allocating 0 bytes is
invalid. But yes, I should have mentioned it in the changelog.

Thanks,

        tglx


