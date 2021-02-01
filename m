Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1131030B2D2
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 23:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhBAWkG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 17:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBAWkD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 17:40:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5550E64E8F;
        Mon,  1 Feb 2021 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612219162;
        bh=T2g/GTyEcuYjTJ5eWuea1SGLvu0fFatPOt4eo14KckM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r6LolERSsiJR42kxMxKGo/fI/DYcNEcfAFG7i7J2f7/pjpZTFol4/5a0vauZIujwg
         EDGio/5OVjuKAstu7I6iyl6h0wLfog2m9ABVQMVWiwwrGagNE+OCLK8j4w1Dgt19jE
         A/rflOt5eptwn2dYGMFGoL9om9XhQxgmSdGxk3ykKqQ8EjvWwe36RTRB1bKKLdOajO
         hYtAQve+YKXUhc5rErqdgtIqMPIKh1EkB7q8wsU6ZA3Sry8ie5VY/5FlA2N0r6JmFh
         7SfhfFEqEwJQ7pT+KV48A0Fb35upTmjuUQP3XlvA3I1xx9aK5lTxO6nXZ5ion8vkfy
         IKawbJLZE7yPw==
Date:   Mon, 1 Feb 2021 16:39:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <20210201223920.GA46282@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4b62f333342df8e029b175079203cfe2bd095c.1608053262.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[+cc Vinod, Dan, dmaengine]

On Tue, Dec 15, 2020 at 06:30:13PM +0100, Gustavo Pimentel wrote:
> Add pci_find_vsec_capability() that crawls through the device config
> space searching in all Vendor-Specific Extended Capabilities for a
> particular capability ID.
> 
> Vendor-Specific Extended Capability (VSEC) is a PCIe capability (acts
> like a wrapper) specified by PCI-SIG that allows the vendor to create
> their own and specific capability in the device config space.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

If you fix the below, feel free to add my

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Otherwise, I can take it myself.  But that will be an ordering issue
in the merge window if you merge the rest of the series via another
tree.

> ---
>  drivers/pci/pci.c             | 29 +++++++++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  5 +++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2..235d0b2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -623,6 +623,35 @@ u64 pci_get_dsn(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_get_dsn);
>  
> +/**
> + * pci_find_vsec_capability - Find a vendor-specific extended capability
> + * @dev: PCI device to query
> + * @cap: vendor-specific capability id code

s/id/ID/

> + *
> + * Returns the address of the vendor-specific structure that matches the
> + * requested capability id code within the device's PCI configuration space

s/id/ID/

> + * or 0 if it does not find a match.
> + */
> +int pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
> +{
> +	u32 header;
> +	int vsec;

  int vsec;
  u32 header;

since that's the order they're used.

> +
> +	vsec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
> +	while (vsec) {
> +		if (pci_read_config_dword(dev, vsec + 0x4,

s/0x4/PCI_VSEC_HDR/

> +					  &header) == PCIBIOS_SUCCESSFUL &&
> +		    PCI_VSEC_CAP_ID(header) == vsec_cap_id)
> +			break;

  return vsec;

> +
> +		vsec = pci_find_next_ext_capability(dev, vsec,
> +						    PCI_EXT_CAP_ID_VNDR);
> +	}
> +
> +	return vsec;

  return 0;

> +}
> +EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
> +
>  static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
>  {
>  	int rc, ttl = PCI_FIND_CAP_TTL;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a7..effecb0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1067,6 +1067,7 @@ int pci_find_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
>  int pci_find_ext_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
> +int pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id);
>  int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
>  int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a95d55f..f5d17be 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -730,6 +730,11 @@
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
>  
> +/* Vendor-Specific Extended Capabilities */
> +#define PCI_VSEC_CAP_ID(header)		(header & 0x0000ffff)
> +#define PCI_VSEC_CAP_REV(header)	((header >> 16) & 0xf)
> +#define PCI_VSEC_CAP_LEN(header)	((header >> 20) & 0xffc)

Please put these next to the existing PCI_VSEC_HDR.

Why does PCI_VSEC_CAP_LEN mask with 0xffc instead of 0xfff?  I don't
see anything in the spec about VSEC Length having to be a multiple of
4 (PCIe r5.0, sec 7.9.5.2).

But you don't use this anyway, so I'd just drop it (and
PCI_VSEC_CAP_REV) altogether.

>  /* Advanced Error Reporting */
>  #define PCI_ERR_UNCOR_STATUS	4	/* Uncorrectable Error Status */
>  #define  PCI_ERR_UNC_UND	0x00000001	/* Undefined */
> -- 
> 2.7.4
> 
