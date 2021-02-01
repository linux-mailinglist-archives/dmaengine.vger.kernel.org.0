Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9E30B392
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 00:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBAXaM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 18:30:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:27047 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhBAXaK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 18:30:10 -0500
IronPort-SDR: SnG8cqesWA9e3q9UloBuHkmtFjnx8C9JVY8u4U1l21RzKxQWaLOyEbG68yjhUNZBUEyg/38zmE
 5V+u5NH7MVTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168448755"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="168448755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:29:27 -0800
IronPort-SDR: qBytakmKEKpI8nAMNhTPVTVxKjgzS2PA+dA+qXmn5yuRiF90xlGYJ2qdQ2NT/JpWZFmoNTrTGr
 m7uAP+cCvkEw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412944429"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:29:26 -0800
Date:   Mon, 1 Feb 2021 15:29:24 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <20210201232924.kklgi7u37iyrm2lq@intel.com>
References: <cc4b62f333342df8e029b175079203cfe2bd095c.1608053262.git.gustavo.pimentel@synopsys.com>
 <20210201223920.GA46282@bjorn-Precision-5520>
 <CAPcyv4ia_0Sn8paGi7y7JGNXQrbCoFhT7st2VOD=L_LKNEMOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ia_0Sn8paGi7y7JGNXQrbCoFhT7st2VOD=L_LKNEMOEg@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-02-01 15:24:45, Dan Williams wrote:
> [ add Ben ]
> 
> On Mon, Feb 1, 2021 at 2:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Vinod, Dan, dmaengine]
> >
> > On Tue, Dec 15, 2020 at 06:30:13PM +0100, Gustavo Pimentel wrote:
> > > Add pci_find_vsec_capability() that crawls through the device config
> > > space searching in all Vendor-Specific Extended Capabilities for a
> > > particular capability ID.
> > >
> > > Vendor-Specific Extended Capability (VSEC) is a PCIe capability (acts
> > > like a wrapper) specified by PCI-SIG that allows the vendor to create
> > > their own and specific capability in the device config space.
> > >
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >
> > If you fix the below, feel free to add my
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Otherwise, I can take it myself.  But that will be an ordering issue
> > in the merge window if you merge the rest of the series via another
> > tree.
> 
> I wonder if this warrants and if you'd be willing to stand up a stable
> branch for just this commit for concerned parties to integrate,
> because CXL development should adopt it as well.
> 

Yeah, can we add DVSEC too please?

> >
> > > ---
> > >  drivers/pci/pci.c             | 29 +++++++++++++++++++++++++++++
> > >  include/linux/pci.h           |  1 +
> > >  include/uapi/linux/pci_regs.h |  5 +++++
> > >  3 files changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 6d4d5a2..235d0b2 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -623,6 +623,35 @@ u64 pci_get_dsn(struct pci_dev *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_get_dsn);
> > >
> > > +/**
> > > + * pci_find_vsec_capability - Find a vendor-specific extended capability
> > > + * @dev: PCI device to query
> > > + * @cap: vendor-specific capability id code
> >
> > s/id/ID/
> >
> > > + *
> > > + * Returns the address of the vendor-specific structure that matches the
> > > + * requested capability id code within the device's PCI configuration space
> >
> > s/id/ID/
> >
> > > + * or 0 if it does not find a match.
> > > + */
> > > +int pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
> > > +{
> > > +     u32 header;
> > > +     int vsec;
> >
> >   int vsec;
> >   u32 header;
> >
> > since that's the order they're used.
> >
> > > +
> > > +     vsec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
> > > +     while (vsec) {
> > > +             if (pci_read_config_dword(dev, vsec + 0x4,
> >
> > s/0x4/PCI_VSEC_HDR/
> >
> > > +                                       &header) == PCIBIOS_SUCCESSFUL &&
> > > +                 PCI_VSEC_CAP_ID(header) == vsec_cap_id)
> > > +                     break;
> >
> >   return vsec;
> >
> > > +
> > > +             vsec = pci_find_next_ext_capability(dev, vsec,
> > > +                                                 PCI_EXT_CAP_ID_VNDR);
> > > +     }
> > > +
> > > +     return vsec;
> >
> >   return 0;
> >
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
> > > +
> > >  static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
> > >  {
> > >       int rc, ttl = PCI_FIND_CAP_TTL;
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 22207a7..effecb0 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1067,6 +1067,7 @@ int pci_find_capability(struct pci_dev *dev, int cap);
> > >  int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
> > >  int pci_find_ext_capability(struct pci_dev *dev, int cap);
> > >  int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
> > > +int pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id);
> > >  int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
> > >  int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
> > >  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index a95d55f..f5d17be 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -730,6 +730,11 @@
> > >  #define PCI_EXT_CAP_DSN_SIZEOF       12
> > >  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> > >
> > > +/* Vendor-Specific Extended Capabilities */
> > > +#define PCI_VSEC_CAP_ID(header)              (header & 0x0000ffff)
> > > +#define PCI_VSEC_CAP_REV(header)     ((header >> 16) & 0xf)
> > > +#define PCI_VSEC_CAP_LEN(header)     ((header >> 20) & 0xffc)
> >
> > Please put these next to the existing PCI_VSEC_HDR.
> >
> > Why does PCI_VSEC_CAP_LEN mask with 0xffc instead of 0xfff?  I don't
> > see anything in the spec about VSEC Length having to be a multiple of
> > 4 (PCIe r5.0, sec 7.9.5.2).
> >
> > But you don't use this anyway, so I'd just drop it (and
> > PCI_VSEC_CAP_REV) altogether.
> >
> > >  /* Advanced Error Reporting */
> > >  #define PCI_ERR_UNCOR_STATUS 4       /* Uncorrectable Error Status */
> > >  #define  PCI_ERR_UNC_UND     0x00000001      /* Undefined */
> > > --
> > > 2.7.4
> > >
