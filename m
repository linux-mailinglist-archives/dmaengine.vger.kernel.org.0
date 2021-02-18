Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6B31F016
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhBRTkZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhBRT2N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Feb 2021 14:28:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB90164DF0;
        Thu, 18 Feb 2021 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613676452;
        bh=XfVjVZpWYLTAsNl6mOoxLz46fumb9V2SXnTYEAUS40Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sVKez0e4ne1EbQ5M8GLkhuHBoD6+l+5DRo9A8zB/gcW1IlrLH5iyEgvIHhIIl9huB
         ExOx92OO8HSsasfnwOEEEDzNMjjOolPnP1657MjkPyP5HSN+qEhbz8mFyjX/rM+A1k
         UH8Ja/Srp15x3YE08Z2eIOtJgyd67POMHDxTzpypyq6RVVXANFbVJ5ZCX8JtbF65jD
         5m0UKc7XaXHVYHJ6QFWAgwP5vPh0CwASyx95Ly5QzLfl4uYCrTStN6qC/2uJHGruhQ
         sQ+bPFsZA96pZP8I+Hzlyv2CO7yZ9lJsDgeg2jeIgdsgF15tlv23yUmIFa2cvYEG3/
         WzfnwSuXQj9rw==
Date:   Thu, 18 Feb 2021 13:27:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v7 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <20210218192730.GA996712@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89506834fb11c6fa0bd5d515c0dd55b13ac6958.1613674948.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Feb 18, 2021 at 08:03:58PM +0100, Gustavo Pimentel wrote:
> Add pci_find_vsec_capability() to locate a Vendor-Specific Extended
> Capability with the specified VSEC ID.
> 
> The Vendor-Specific Extended Capability (VSEC) allows one or more
> proprietary capabilities defined by the vendor which aren't standard
> or shared between vendors.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Beautiful, thanks!

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc2..aef217c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -693,6 +693,36 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
>  EXPORT_SYMBOL_GPL(pci_find_ht_capability);
>  
>  /**
> + * pci_find_vsec_capability - Find a vendor-specific extended capability
> + * @dev: PCI device to query
> + * @vendor: Vendor ID for which capability is defined
> + * @cap: Vendor-specific capability ID
> + *
> + * If @dev has Vendor ID @vendor, search for a VSEC capability with
> + * VSEC ID @cap. If found, return the capability offset in
> + * config space; otherwise return 0.
> + */
> +u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	if (vendor != dev->vendor)
> +		return 0;
> +
> +	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> +						     PCI_EXT_CAP_ID_VNDR))) {
> +		if (pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
> +					  &header) == PCIBIOS_SUCCESSFUL &&
> +		    PCI_VNDR_HEADER_ID(header) == cap)
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
> index b32126d..814f814 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1077,6 +1077,7 @@ u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
>  u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
>  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
> +u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);

If you do any updates for other reasons, slide this up one more line
so we have:

  u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
  u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);

  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);

I don't know why pci_find_next_bus() got stuck with the capability
things.  It doesn't have anything to do with finding capabilities.  It
goes more with pci_get_device(), etc.

But don't roll the series just for that.

>  u64 pci_get_dsn(struct pci_dev *dev);
>  
> -- 
> 2.7.4
> 
