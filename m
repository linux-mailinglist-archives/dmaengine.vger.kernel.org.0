Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157546BB9D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 13:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhLGMvK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 07:51:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbhLGMvJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 07:51:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638881258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfvMhKPhb1o//czxJpD8hEyO6OfjVQhOJc2oIhKZDZw=;
        b=1QK7A5Quf6kWCtw53J7LvMSn21VoC3/a3rTC4N/K9KOL4NOIZguih61ltj5o2xfGP8fosF
        BeQwVchpb12p0y5ddl73SUOzMBu6gIMOsGkxFdl5DJrfmj1Eim1xbeRkUgaFost/P/l1rc
        R2cgY1UjJCMU1gjgvFUxFmbrR1966LIsSNzq5oGXncv5V0Y5vYAuEeLPzjweMxQI48uHLx
        MdMtGCM3OlYqjQpPgR4EUu0q413CYfgQ72I0nJ6osdk/lVoifAMucYRoeBo63dPfAw6clb
        UTcRGoe1SrHcnbJssHPqCjL3MC2C5BTHwEW6fNyn25OsD54B/nKqidN8WpkUhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638881258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfvMhKPhb1o//czxJpD8hEyO6OfjVQhOJc2oIhKZDZw=;
        b=iWRt10cM8F7Z6E8RZ9a3abFTVEBRiybM6wE8GDhsSLisml9tvmBdzmeYXcqagp5wZeqokg
        ZkJiPjEuHtHx+wCA==
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
In-Reply-To: <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.634566968@linutronix.de>
 <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org>
Date:   Tue, 07 Dec 2021 13:47:37 +0100
Message-ID: <87ilw037km.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 07 2021 at 10:04, C=C3=A9dric Le Goater wrote:
>> +/**
>> + * msi_device_set_properties - Set device specific MSI properties
>> + * @dev:	Pointer to the device which is queried
>> + * @prop:	Properties to set
>> + */
>> +void msi_device_set_properties(struct device *dev, unsigned long prop)
>> +{
>> +	if (WARN_ON_ONCE(!dev->msi.data))
>> +		return ;
>> +	dev->msi.data->properties =3D 0;
> It would work better if the prop variable was used instead of 0.
>
> With that fixed,

Indeed. Copy & pasta w/o brain usage ...
