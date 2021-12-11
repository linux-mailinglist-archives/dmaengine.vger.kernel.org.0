Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5BF471469
	for <lists+dmaengine@lfdr.de>; Sat, 11 Dec 2021 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhLKPWc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Dec 2021 10:22:32 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:38413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLKPWc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Dec 2021 10:22:32 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M72Xn-1mtcYk1n1b-008Xki; Sat, 11 Dec 2021 16:22:29 +0100
Received: by mail-wm1-f54.google.com with SMTP id o29so8944073wms.2;
        Sat, 11 Dec 2021 07:22:29 -0800 (PST)
X-Gm-Message-State: AOAM533W7k3Pu/gXWMLTD9w6lg1OBblu6vtzvwpwmLg1xPYuh1JAQ/By
        w/aIemzSnT71x+7OAOFIAlTWiaZcX7V2qGcrBuY=
X-Google-Smtp-Source: ABdhPJyOlfLidEd9162beuC5UM1yFpg2300rafM4JRbY2mJjNOXxVFZo/cAEJoaFFS655TaSoVWjWn5yGpFZ9WnPivI=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr25037494wmn.98.1639236149109;
 Sat, 11 Dec 2021 07:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de> <20211210221813.617178827@linutronix.de>
In-Reply-To: <20211210221813.617178827@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Dec 2021 16:22:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0SPopq871z7hbeTZbgnpO=cnEz-4Pmi1Ko3SHFTpU-mg@mail.gmail.com>
Message-ID: <CAK8P3a0SPopq871z7hbeTZbgnpO=cnEz-4Pmi1Ko3SHFTpU-mg@mail.gmail.com>
Subject: Re: [patch V3 07/35] device: Move MSI related data into a struct
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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
X-Provags-ID: V03:K1:fUuJQ2AsISLUdi+AG+Qbc4Q/W0QBp701PEQ0GvDiNGD+ja6gQ04
 29oOMIKzSBzeO5CJyDi6vtHD7rzgvP3O/4nDSP2hojBv+w4Jtd6k5AEGzP6eCc8Hvcokfi1
 3rz5r7EfSlA/mJrtfdjPP9EQQ/onvOByVZgQmDMIGXs7WmGrgm8o5i2PyJ8ChnByj/7vU1V
 H6+1hSnzPKSgKv/A9kjQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XjWPy7XxXaI=:WySdY1SWZ0MrEwczbp/5sl
 FPm297apjpRBmUxqayBXwzyIJBUsHQJiEfwS8L/zV+bhwUwtRfl/3Pc+NSznN00YMnXLmJDbG
 oxaaY8tR+Ps2z56Gws4yhiIx9Lf07etJnmXJOFfpqEDgevfzKNI7JrbDWQIN+EVwpV38IIT/4
 cfwyCOkC2auhWTHw9WwkeRDKaj9wzpj7sGwf5nD0lnkBbxOYeZrZ360Slz+8wwPacxiolvTvD
 mVp66pjJ8eC/AbPXVLGkNIfcA9hTLa3QYHDFQM/j2ut4HprU4dlYBTiQsfZcFb76JV50n4tTD
 8LIeURJZzRyeUe/fOYxl5zndTzWA0B5h7Xs8upnmug7osIBSCfiTKhK9r2Sti1dF5G1bhXPGo
 XsaolC3GlQZggUXZHNSo7EXQ2kyi+lwPdC9tltyuen+2yaZIlhNB9NpwYSUQlwBVFO8AC38uF
 EgmW06H1zjEIXj+s7A3iwNbhb8LKFi7SlEAs1KL2KQIELkkwHD7TNJvR0l08l6+piIZ/yJfjh
 KLR3BP+BtYdNwsKALw9LwjcD0BNLrDyVU7PubBgTScGI4ac/YKKaf+jjRNeIkX84Tv+2/+q+g
 CQPX3VhxUlm28aqgWZXM1NHfdVag0nnaXaMXaIYXm8Qkh6xyULR+G+p6QayxSGadjvgTk/F/6
 EA5PdRtefLPs2kg4C2kp3Gf9qqavNeT+i9QYRNU4EY+CNE6TjMh8Z/9SMjkyg3nSDtWUMm8qP
 LhmBDo31qaVt9tAZdTDf1+MKTeTZsiw7d5y/4nnMR/GLS7+RwdHK77sZ/T/WBCQQuAvLy9s/N
 9l/vsaOUuYp0yr114g910GNvar/Hc+QqHNDuBTm9PZnvpfLoIm3ajTLWKh63QvL26raeIuDQY
 Jl/HcGDdTU52xDgfC20FrPZkPcUqd++ZPWBFGPr/BOFdVggh34yhesEKjhj2ml/okB47VEA1J
 6sMcd/CaaqA==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 10, 2021 at 11:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The only unconditional part of MSI data in struct device is the irqdomain
> pointer. Everything else can be allocated on demand. Create a data
> structure and move the irqdomain pointer into it. The other MSI specific
> parts are going to be removed from struct device in later steps.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
