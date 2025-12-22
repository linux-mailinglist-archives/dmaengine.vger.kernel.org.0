Return-Path: <dmaengine+bounces-7864-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD9CD589F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C412302EF4B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F0337680;
	Mon, 22 Dec 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lptE8bgT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A4336EFE;
	Mon, 22 Dec 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398885; cv=none; b=tpVsq5jEmkiG4eRObSOeHcHFt/+XfTcjZITXj0x1ZqVufeAJ5Lku6RrLDwT+6feEMU4Dur5vg4JoTKwY5f9mVNLX4zgb7oecrmGokqXnBFI+GxO9HajWpB4yXaK0Ut7jf6PwgL6BqbuM90rHdaDj88hLmkf3qk0ZGZZiDbomM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398885; c=relaxed/simple;
	bh=ur3+ntnWaxFP7G2fO4rVI/mtWr0Ceux11S/HrxXPHyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohIiM446BF6OulxM7pRlPkUXSikPKiw7Yd0LiPGRSLlUqIjGh7q6rHD3+81g+CrzhRZO3RCuT8Fn0/0OnO88FeTTFM7GzHhbneLnFkYWfjgTFdw00nGi5NpZP1yv8aBWLHsq2nbEuZzVAQeEvANXCkXsSCf7PoaKzhISG7yG/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lptE8bgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B22C4CEF1;
	Mon, 22 Dec 2025 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766398884;
	bh=ur3+ntnWaxFP7G2fO4rVI/mtWr0Ceux11S/HrxXPHyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lptE8bgTwFEpwlUv5EpAcYdPSRw1p64QACv0Fy2z1FXeJejK3oo8kKBToGcKyE5Sb
	 w7z9Os/KKbIzCwZiX6cKPPxAT5qHZIrdKG7p9jKn9pCOYZkXSXBvywpwIUptlSp+UN
	 G+xuEY0lnHohIKHb/4/2l85k1xgAY1tB02xuL4UdoBIzVTupgcZbunxs0cjuWoiNYI
	 tkZX121GToykUSkfaKtK/km9h8hgzK0ZdrGZubIrcHQFZR+Oonro9KWwVVurncoS75
	 49YdVzbQsj8eiLE+qfnrwTInzHcOQnIuQ0bhAJ4nyuXiOvnVMr5ebIrEZLaZWS8Gef
	 H+0NL9IbCGqaA==
Date: Mon, 22 Dec 2025 15:51:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>, 
	ntb@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us, 
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, jbrunet@baylibre.com, 
	fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <ym3evivt3co5ic7p5co624me3hmvoa53it22a6ddcu7dacl3wk@le233yriaip5>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aTaE3yB7tQ-Homju@ryzen>
 <4909f70a-2f65-4cac-96ac-5cd4371bc867@oss.qualcomm.com>
 <aUj4M3z87MwFSUFW@ryzen>
 <a7b94f8f-8773-43b0-b481-29828aba9abd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7b94f8f-8773-43b0-b481-29828aba9abd@oss.qualcomm.com>

On Mon, Dec 22, 2025 at 01:44:02PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/22/2025 1:20 PM, Niklas Cassel wrote:
> > On Mon, Dec 22, 2025 at 10:40:12AM +0530, Krishna Chaitanya Chundru wrote:
> > > On 12/8/2025 1:27 PM, Niklas Cassel wrote:
> > > > On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > > > 
> > > > I guess the problem is that some EPF drivers, even if only
> > > > one capability can be enabled (MSI/MSI-X), call both
> > > > pci_epc_set_msi() and pci_epc_set_msix(), e.g.:
> > > > https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-test.c#L969-L987
> > > > 
> > > > To fill in the number of MSI/MSI-X irqs.
> > > > 
> > > > While other EPF drivers only call either pci_epc_set_msi() or
> > > > pci_epc_set_msix(), depending on the IRQ type that will actually
> > > > be used:
> > > > https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L2247-L2262
> > > > 
> > > > I think both versions is okay, just because the number of IRQs
> > > > is filled in for both MSI/MSI-X, AFAICT, only one of them will
> > > > get enabled.
> > > > 
> > > > 
> > > > I guess it might be hard for an EPC driver to know which capability
> > > > that is currently enabled, as to enable a capability is only a config
> > > > space write by the host side.
> > > As the host is the one which enables MSI/MSIX, it should be better the
> > > controller
> > > driver takes this decision and the EPF driver just sends only raise_irq.
> > > Because technically, host can disable MSI and enable MSIX at runtime also.
> > > 
> > > In the controller driver,  it can check which is enabled and chose b/w
> > > MSIX/MSI/Legacy.
> > I'm not sure if I'm following, but if by "the controller driver", you
> > mean the EPC driver, and not the host side driver, how can the EPC
> > driver know how many interrupts a specific EPF driver wants to use?
> I meant the dwc drivers here.
> Set msi & set msix still need to called from the EPF driver only to tell how
> many
> interrupts they want to configure etc.

Please leave a newline before and after your reply to make it readable in text
based clients, which some of the poor folks like me still use.

> > 
> >  From the kdoc to pci_epc_set_msi(), the nr_irqs parameter is defined as:
> > @nr_irqs: number of MSI interrupts required by the EPF
> > https://github.com/torvalds/linux/blob/v6.19-rc2/drivers/pci/endpoint/pci-epc-core.c#L305
> > 
> > 
> > Anyway, I posted Koichiro's patch here:
> > https://lore.kernel.org/linux-pci/20251210071358.2267494-2-cassel@kernel.org/
> I will comment on that patch.
> > 
> > See my comment:
> >    pci-epf-test does change between MSI and MSI-X without calling
> >    dw_pcie_ep_stop(), however, the msg_addr address written by the host
> >    will be the same address, at least when using a Linux host using a DWC
> >    based controller. If another host ends up using different msg_addr for
> >    MSI and MSI-X, then I think that we will need to modify pci-epf-test to
> >    call a function when changing IRQ type, such that pcie-designware-ep.c
> >    can tear down the MSI/MSI-X mapping.
> Maybe for arm based systems we are getting same address but for x86 based
> systems
> it is not guarantee that you will get same address.
> > So if we want to improve things, I think we need to modify the EPF drivers
> > to call a function when changing the IRQ type. The EPF driver should know
> > which IRQ type that is currently in use (see e.g. nvme_epf->irq_type in
> > drivers/nvme/target/pci-epf.c).
> My suggestion is let EPF driver call raise_irq with the vector number then
> the dwc driver
> can raise IRQ based on which IRQ host enables it.
> > Additionally, I don't think that the host side should be allowed to change
> > the IRQ type (using e.g. setpci) when the EPF driver is in a "running state".
> In the host driver itelf they can choose to change it by using
> pci_alloc_irq_vectors
> <https://elixir.bootlin.com/linux/v6.18.2/C/ident/pci_alloc_irq_vectors>,
> Currently it is not present but in future someone can change it, as spec
> didn't say you
> can't update it.

The spec has some wording on it (though not very clear) in r6.0, sec 6.1.4

"System software initializes the message address and message data (from here on
referred to as the “vector”) during device configuration, allocating one or more
vectors to each MSI-capable Function."

This *sounds* like the MSI/MSI-X initialization should happen during device
configuration.

> > I think things will break badly if you e.g. try to do this on an PCIe
> > connected network card while the network card is in use.
> I agree on this.
> 
> I just want to highlight there is possibility of this in future, if someone
> comes up with a
> clean logic.
> 

I don't know if this is even possible. For example, I don't think a host is
allowed to reattach a device which was using MSI to a VM which only uses MSI-X
during live device migration in virtualization world. I bet the device might not
perform as expected if that happens.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

