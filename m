Return-Path: <dmaengine+bounces-7860-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA77CD4E86
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 08:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB5C3025144
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DE30B506;
	Mon, 22 Dec 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ+D1kaO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2885309EEA;
	Mon, 22 Dec 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389819; cv=none; b=iD77P0Z9z4lS92abVBFD/XXyHqvGNt7cHH1ci72ZKBT1viHOsKJWWeOXLKttc1X+6KGCqRb1Udx83e2caPM/GrIXGfN30ViYYrn+is93I9EwlySigi+Ti8Bg31Pr3MR3eXilNSjuKCGjsWu9wj9b4jIp3ERiQjUvRaSXYKMwU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389819; c=relaxed/simple;
	bh=s8bMs2HaT7/SB/KIp2XWCFSkV6a48wWHJGengMvwL6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkEpdWKUy6oOWcQ491xA7tdv0YSvDMFsv2FEjUGXyVDGqFJsITvC9O6/YkCWwZpSQMDwLl0RSZtET/IfVEmIRTh6Yp226opd10RZ7KIH16McjKBQUcM+/5Xte+6PgVXUUIh93xJn7Oevi9Hy+c9xU9/s3kLMr9fXt2vMGSPzrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ+D1kaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0728C4CEF1;
	Mon, 22 Dec 2025 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766389819;
	bh=s8bMs2HaT7/SB/KIp2XWCFSkV6a48wWHJGengMvwL6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ+D1kaOkl3G+6BuPi8hfjZ6MoqupndbarVjXtyJ7qP0ux5eqAO/BfOY3ZM11790v
	 3EVTGBH/PAMN47YkaR8VHyNn5QR5OD8xTNW+kYfYRYWvCpdYFP1uFHKHymKzaEZreo
	 Sb8b3A42av+D0O6x9BEnPgpkxEyRLCHPNzIZ6lD2a1NlOPkmuUOgm6EAGnHzLzzvFw
	 t6Lt0CcB50/t0Ex9Apcz2uT72+RCpFzSTpafH5qpKDuYqQRyNGcvmg7mmaBk6eg1tP
	 dP9ojQZpgnFNbC6UzmSMaiobdFoLePsMrE+XeWDAk3SQbN763LwRS+n41wBlG+wL04
	 GM/cwHEmrJcxQ==
Date: Mon, 22 Dec 2025 08:50:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aUj4M3z87MwFSUFW@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aTaE3yB7tQ-Homju@ryzen>
 <4909f70a-2f65-4cac-96ac-5cd4371bc867@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4909f70a-2f65-4cac-96ac-5cd4371bc867@oss.qualcomm.com>

On Mon, Dec 22, 2025 at 10:40:12AM +0530, Krishna Chaitanya Chundru wrote:
> On 12/8/2025 1:27 PM, Niklas Cassel wrote:
> > On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > 
> > I guess the problem is that some EPF drivers, even if only
> > one capability can be enabled (MSI/MSI-X), call both
> > pci_epc_set_msi() and pci_epc_set_msix(), e.g.:
> > https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-test.c#L969-L987
> > 
> > To fill in the number of MSI/MSI-X irqs.
> > 
> > While other EPF drivers only call either pci_epc_set_msi() or
> > pci_epc_set_msix(), depending on the IRQ type that will actually
> > be used:
> > https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L2247-L2262
> > 
> > I think both versions is okay, just because the number of IRQs
> > is filled in for both MSI/MSI-X, AFAICT, only one of them will
> > get enabled.
> > 
> > 
> > I guess it might be hard for an EPC driver to know which capability
> > that is currently enabled, as to enable a capability is only a config
> > space write by the host side.
> As the host is the one which enables MSI/MSIX, it should be better the
> controller
> driver takes this decision and the EPF driver just sends only raise_irq.
> Because technically, host can disable MSI and enable MSIX at runtime also.
> 
> In the controller driver,  it can check which is enabled and chose b/w
> MSIX/MSI/Legacy.

I'm not sure if I'm following, but if by "the controller driver", you
mean the EPC driver, and not the host side driver, how can the EPC
driver know how many interrupts a specific EPF driver wants to use?

From the kdoc to pci_epc_set_msi(), the nr_irqs parameter is defined as:
@nr_irqs: number of MSI interrupts required by the EPF
https://github.com/torvalds/linux/blob/v6.19-rc2/drivers/pci/endpoint/pci-epc-core.c#L305


Anyway, I posted Koichiro's patch here:
https://lore.kernel.org/linux-pci/20251210071358.2267494-2-cassel@kernel.org/

See my comment:
  pci-epf-test does change between MSI and MSI-X without calling
  dw_pcie_ep_stop(), however, the msg_addr address written by the host
  will be the same address, at least when using a Linux host using a DWC
  based controller. If another host ends up using different msg_addr for
  MSI and MSI-X, then I think that we will need to modify pci-epf-test to
  call a function when changing IRQ type, such that pcie-designware-ep.c
  can tear down the MSI/MSI-X mapping.


So if we want to improve things, I think we need to modify the EPF drivers
to call a function when changing the IRQ type. The EPF driver should know
which IRQ type that is currently in use (see e.g. nvme_epf->irq_type in
drivers/nvme/target/pci-epf.c).


Additionally, I don't think that the host side should be allowed to change
the IRQ type (using e.g. setpci) when the EPF driver is in a "running state".

I think things will break badly if you e.g. try to do this on an PCIe
connected network card while the network card is in use.


Kind regards,
Niklas

