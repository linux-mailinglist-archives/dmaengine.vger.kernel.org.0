Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F202471466
	for <lists+dmaengine@lfdr.de>; Sat, 11 Dec 2021 16:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhLKPWC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Dec 2021 10:22:02 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLKPWC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Dec 2021 10:22:02 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MGzDv-1mjk843Q7n-00E5a9; Sat, 11 Dec 2021 16:21:59 +0100
Received: by mail-wr1-f48.google.com with SMTP id u17so19745471wrt.3;
        Sat, 11 Dec 2021 07:21:59 -0800 (PST)
X-Gm-Message-State: AOAM5319a7871nV7zsV0a5cBDe4XXC6UUgeRhWe9fEraMQ9XPiJYMA7v
        3SCFEW9Mg+76rTXmTw7LT3zDfThvbdPLo7rWoj8=
X-Google-Smtp-Source: ABdhPJw71fHmkJDBQfwdVvTsQemVVjs0TdIXte5O3MuH5722pvreNXPnvtVfyYQ4NEpRi0VtDUcmnQ9Z/Qh6+K4QE8c=
X-Received: by 2002:a5d:530e:: with SMTP id e14mr21123035wrv.12.1639236119426;
 Sat, 11 Dec 2021 07:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de> <20211210221813.493922179@linutronix.de>
In-Reply-To: <20211210221813.493922179@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Dec 2021 16:21:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3U2DSm_DWS+iDkzH14hNMwyOQ77iS=W4HoAyHPh6pqUw@mail.gmail.com>
Message-ID: <CAK8P3a3U2DSm_DWS+iDkzH14hNMwyOQ77iS=W4HoAyHPh6pqUw@mail.gmail.com>
Subject: Re: [patch V3 05/35] powerpc/cell/axon_msi: Use PCI device property
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Cedric Le Goater <clg@kaod.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dL1bxa9iZITAgc3bsHGM2Af3jWeNCf9/dAR0/IBJ7Tybc34XAPl
 SrPJyALTNcn/07+ugQtPp6MWtAgzaMEYKp/2o+Zxv7LCPV3lFlQPdvUfhDmfA75KHaCbCi+
 M08B55K3uDyfdS76WkrPRHG2h3Fx0O4fC3ZVhxC6+WSR3iKLyDXOxc1iF+eqVIdsJTUMAw0
 F+xFl2I37z1iNGfKmONIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Mp2aU4myrA=:pZ0MRBWKPnpXZkhthY/2oe
 Q+k2gTGCXktPZ8BkzJJIMnD7TG5GbIRjGNWBHlI3vnFw6pLiZvfzEE6q5q1XFiqOJnOsTG+Dd
 w9Z6KWd47eH4ZNuapwERaDx7MMeV6tRmG5lK3YF1sqUf6J9qJDPxhulygiQeXGHj95+C/ILyU
 EbjxdxU/D81MhiyJxlGnuwTjqPeI4Lc9H8k0lS/vvxf2TVON8ek8HvHRyKyX4ZKBvLI2SRRlI
 AG6+DT3rk8Sf7Ke04Lz4C5+vBZtaeYx8aQg3wlv64WPKqr5SHMUi9zIBSWxmJ8r9q3maGZLRu
 FAOhDaKk1c2pUhbIweYgDi11Js39x6+Db9DIw42P7dFRDSbw/03C/ZnqE5YHEr9cGSpjdtXaY
 DSWUFNCxo4X+Zz2JnwnI3g/pzC+/6TBz3BxesCWSOuDSrCaWfweFYYCrXs5ufw3VFXfvW7JGR
 LG5/vfwlQ0I71ewyGY3J21qKoCFQ+5pTDDAM494DhEw358tUBucg6uq+wQ82K18ItdHD3e02V
 AjMzFT9o0LxeLQaCGIawFZBGKz+mQqpGVpdD26ZxWD4Srf4YJ9Y757CtQiMkIHjd1Yp2w47fo
 uvkkKoogjWSt9BxUvKG2rmTrnhsT1IasrDAQbJ2XQEPTBfDNWB8JAXOFDoVDP10HLJe+gaLEG
 /PqL9bv4aFoKoIWn1IWMCR6SPVrCvsbO3YcJuKqXABX9MnOItRntDJ7/GO8Hrmt+8eci5b+Qv
 FOxgdeitH/vGW/SFJY7lj8Wqis0PWQHOU56l7uVI75Esx3Ma05oT1+sg8JhqhHZ9n1iepJFP7
 PlGVzc51uNLM1rFYKyNvUfzgD2Umjc+l+hs7pKOp8xIuhxM1YI=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 10, 2021 at 11:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> instead of fiddling with MSI descriptors.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
