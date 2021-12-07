Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC946BBD1
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 13:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhLGM5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 07:57:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhLGM5I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 07:57:08 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638881617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aNhnkzcLIHS9o6REcIVVTdi6HJHMTMekwoWhR5Os8KA=;
        b=fDdfjoBrqymOl2a+g4MXycXTFQvrRmQZeNf3rg3L6n1PiCtdWcCcmDaVpdvwx1WHZPu2/v
        fJ5y/fl9rqcMBqPDwA5dGahXUq/mN6Rr/ElGbNuccnYfY2zSKXTbzkZQodP7GLSEpFoYdh
        46+uktDwZ2vMiIgjrLAfY7tW6+YkhG+kEnyrqVcu/yhSumZnuVQZSPFDDqkewYdktBX2W1
        E5XHAvsHcg+oePKYbcgXP8R5bFs+hJf3t4yTvMtPo50NBwX80mLh/AIBUE7bofDK/aFu6H
        qtf+AY+yYI2U4AcWEXhnQ22yGPrAzddB3aN+8X6CX1qpB5O1+EGPIoTqDwRh5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638881617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aNhnkzcLIHS9o6REcIVVTdi6HJHMTMekwoWhR5Os8KA=;
        b=9LR8QBp7ApgLB6V6Z+0XA4lyUUgGXXJ03ul38aiaIn/PFJSbmKuGwWEzOcLJoDF8z5Se10
        uqB+RdhRp6Pw8iDA==
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
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V2 18/36] genirq/msi: Add msi_device_data::properties
In-Reply-To: <87ilw037km.ffs@tglx>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.634566968@linutronix.de>
 <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org> <87ilw037km.ffs@tglx>
Date:   Tue, 07 Dec 2021 13:53:36 +0100
Message-ID: <87fsr437an.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 07 2021 at 13:47, Thomas Gleixner wrote:
> On Tue, Dec 07 2021 at 10:04, C=C3=A9dric Le Goater wrote:
>>> +/**
>>> + * msi_device_set_properties - Set device specific MSI properties
>>> + * @dev:	Pointer to the device which is queried
>>> + * @prop:	Properties to set
>>> + */
>>> +void msi_device_set_properties(struct device *dev, unsigned long prop)
>>> +{
>>> +	if (WARN_ON_ONCE(!dev->msi.data))
>>> +		return ;
>>> +	dev->msi.data->properties =3D 0;
>> It would work better if the prop variable was used instead of 0.
>>
>> With that fixed,
>
> Indeed. Copy & pasta w/o brain usage ...

I've pushed out an incremental fix on top. Will be folded back.

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v2-pa=
rt-3-1

Thanks,

        tglx
