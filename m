Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15D31E210
	for <lists+dmaengine@lfdr.de>; Wed, 17 Feb 2021 23:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhBQW2X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Feb 2021 17:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232435AbhBQW2W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Feb 2021 17:28:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5299864D92;
        Wed, 17 Feb 2021 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613600860;
        bh=smvavd1obBK51N21MHwIXd6pKhAqK6e/rwjswr9lv70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tz624YXqZLkVd7D5rlAjSwoSEtHXrdpXUgiKk9YPeVbJM5O9d1gRwqEi5v+R7nuRD
         1iV4ufAIsG4sFRyU0xidcK2kmOA1PKw1q8TD/zjXpoREHibC4MwS/FxdvVaRH8Ij2M
         2/bjsVn3trGHUboq9H7mXRwbouVuYB3fxymojV30dpdRT9Y8lmo9AZKcu8CiIkgMsp
         Zp9zFGHoA7alfdDqc6rw7rWrLrPABKofHlQ4rfd+jSN7Gt5RtJYPey0mmHD3rC30lY
         +ZXd9snxUEiiS+HcfNQ0ykC3ylNclV+dWt1aYPRK7eH9aAGGM82EM2ivj3VzI4rUnR
         Hfe58ci4wZsNQ==
Date:   Wed, 17 Feb 2021 16:27:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <20210217222738.GA915397@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145b54b2a6feabcfa913ec8c44c9dee92deedf11.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[+cc Krzysztof, since he commented on a previous version]
[+cc Lukas, who previously proposed exactly what I suggest below,
sorry for repeating.  I think Lukas was right to propose passing in
the vendor ID because it makes it easier to read the caller.]

When you post new versions of a series, please cc people who commented
on previous versions.

On Fri, Feb 12, 2021 at 06:37:39PM +0100, Gustavo Pimentel wrote:
> Adds another helper to ones that already exist called
> pci_find_vsec_capability. This helper crawls through the device PCI
> config space searching for a specific ID on the Vendor-Specific Extended
> Capabilities section.

  Add pci_find_vsec_capability() to locate a Vendor-Specific Extended
  Capability with the specified VSEC ID.
> 
> The Vendor-Specific Extended Capability (VSEC) is a special PCI
> capability (acts like container) defined by PCI-SIG that allows the one
> or more proprietary capabilities defined by the vendor which aren't
> standard or shared between the manufactures.

s/is a special ... by PCI-SIG that//
s/allows the one/allows one/
s/the manufactures/manufacturers/ (or maybe "vendors" to match previous use)

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/pci.c             | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  2 ++
>  include/uapi/linux/pci_regs.h |  6 ++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc2..628aa9f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -693,6 +693,40 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
>  EXPORT_SYMBOL_GPL(pci_find_ht_capability);
>  
>  /**
> + * pci_find_vsec_capability - Find a vendor-specific extended capability
> + * @dev: PCI device to query
> + * @cap: vendor-specific capability ID code
> + *
> + * Typically this function will be called by the PCI driver, which passes
> + * through argument the 'struct pci_dev *' already pointing for the device
> + * config space that is associated with the vendor and device ID which will
> + * know which ID to search and what to do with it, however, there might be
> + * cases that this function could be called outside of this scope and
> + * therefore is the caller responsibility to check the vendor and/or
> + * device ID first.

This is important because it's a bit subtle.  IIUC, each vendor
(identified by Vendor ID at 0x00 in config space) can define its own
VSEC IDs, so it can define up to 2^16 == 64K VSEC structures.

Of course there's not room for that many in config space; but the
point is that the vendor chooses its own VSEC IDs and doesn't need to
coordinate with anybody.

So a VSEC ID 0x0006 in a Synopsys device (Vendor ID 0x16c3) has
nothing to do with a VSEC ID 0x0006 in an Intel device (Vendor ID
0x8086), and it's up to the caller to make sure it's using the correct
one.

I wonder if it would help avoid mistakes if we made the interface look
like this:

  u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int vsec_cap_id)
  {
    if (vendor != dev->vendor)
      return 0;

    while ((vsec = ...))
      ...
  }

so calls would look like this:

  vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_SYNOPSYS, DW_PCIE_VSEC_DMA_ID);

which would make it more obvious that DW_PCIE_VSEC_DMA_ID is only
valid in a Synopsys device.

The function comment could be something like this:

  pci_find_vsec_capability - Find a vendor-specific extended capability
  @dev: PCI device to query
  @vendor: Vendor ID for which capability is defined
  @vsec_cap_id: Vendor-specific capability ID

  If @dev has Vendor ID @vendor, search for a VSEC capability with
  VSEC ID @vsec_cap_id.  If found, return the capability offset in
  config space; otherwise return 0.

Or maybe it's even more subtle than I thought, and I'm missing
something :)

> + * Returns the address of the vendor-specific structure that matches the
> + * requested capability ID code within the device's PCI configuration space
> + * or 0 if it does not find a match.
> + */
> +u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> +						     PCI_EXT_CAP_ID_VNDR))) {
> +		if (pci_read_config_dword(dev, vsec + PCI_VSEC_HDR,
> +					  &header) == PCIBIOS_SUCCESSFUL &&
> +		    PCI_VSEC_CAP_ID(header) == vsec_cap_id)
> +			return vsec;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
> +
> +/**
>   * pci_find_parent_resource - return resource region of parent bus of given
>   *			      region
>   * @dev: PCI device structure contains resources to be searched
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b32126d..da6ab6a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1080,6 +1080,8 @@ struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>  
>  u64 pci_get_dsn(struct pci_dev *dev);
>  
> +u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id);

Can you put this declaration up with the other "find_capability"
declarations just a few lines up?

>  struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
>  			       struct pci_dev *from);
>  struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8..deae275 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -983,6 +983,12 @@
>  #define PCI_VSEC_HDR		4	/* extended cap - vendor-specific */
>  #define  PCI_VSEC_HDR_LEN_SHIFT	20	/* shift for length field */
>  
> +/* Vendor-Specific Extended Capabilities */
> +#define PCI_VSEC_HEADER		4	/* Vendor-Specific Header */
> +#define  PCI_VSEC_CAP_ID(x)	((x) & 0xffff)
> +#define  PCI_VSEC_CAP_REV(x)	(((x) >> 16) & 0xf)
> +#define  PCI_VSEC_CAP_LEN(x)	(((x) >> 20) & 0xfff)

The VSEC #defines are a mess.  We have already have some duplication
and inconsistent names.  But I think what you need is already there:

  /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
  #define PCI_VNDR_HEADER         4       /* Vendor-Specific Header */
  #define  PCI_VNDR_HEADER_ID(x)  ((x) & 0xffff)
  #define  PCI_VNDR_HEADER_REV(x) (((x) >> 16) & 0xf)
  #define  PCI_VNDR_HEADER_LEN(x) (((x) >> 20) & 0xfff)

>  /* SATA capability */
>  #define PCI_SATA_REGS		4	/* SATA REGs specifier */
>  #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
> -- 
> 2.7.4
> 
