Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12C430C927
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 19:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhBBSLq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 13:11:46 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:37207 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbhBBSJn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 13:09:43 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4738F2800B3CC;
        Tue,  2 Feb 2021 19:08:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3D6A71DEBA; Tue,  2 Feb 2021 19:08:55 +0100 (CET)
Date:   Tue, 2 Feb 2021 19:08:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <20210202180855.GA3571@wunner.de>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
 <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 02, 2021 at 01:40:18PM +0100, Gustavo Pimentel wrote:
>  /**
> + * pci_find_vsec_capability - Find a vendor-specific extended capability
> + * @dev: PCI device to query
> + * @cap: vendor-specific capability ID code
> + *
> + * Returns the address of the vendor-specific structure that matches the
> + * requested capability ID code within the device's PCI configuration space
> + * or 0 if it does not find a match.
> + */
> +u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
> +{

As the name implies, the capability is "vendor-specific", so it is perfectly
possible that two vendors use the same VSEC ID for different things.

To make sure you're looking for the right capability, you need to pass
a u16 vendor into this function and bail out if dev->vendor is different.


> +	u16 vsec;
> +	u32 header;
> +
> +	vsec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
> +	while (vsec) {
> +		if (pci_read_config_dword(dev, vsec + PCI_VSEC_HDR,
> +					  &header) == PCIBIOS_SUCCESSFUL &&
> +		    PCI_VSEC_CAP_ID(header) == vsec_cap_id)
> +			return vsec;
> +
> +		vsec = pci_find_next_ext_capability(dev, vsec,
> +						    PCI_EXT_CAP_ID_VNDR);
> +	}

FWIW, a more succinct implementation would be:

	while ((vsec = pci_find_next_ext_capability(...))) { ... }

See set_pcie_thunderbolt() in drivers/pci/probe.c for an example.
Please consider refactoring that function to use your new helper.

Thanks,

Lukas
