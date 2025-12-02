Return-Path: <dmaengine+bounces-7463-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9AC9ADF0
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E7C3A52AB
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFA309EE3;
	Tue,  2 Dec 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9HSMYxa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1221770B;
	Tue,  2 Dec 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667947; cv=none; b=hBdYWk4eAu+9+NfoKrIXHkfUSOiolfg49Ud4ToQCV/b3YXOmPRR9NZ1PjQs5og+ZBiuwPOX6oJdBjc2Di+dwYCl9EAYeefMM8jaq9K3BMpVqUKRqpboSzBb0VVjbEzgwtRiHk43mwaE9/qUsXfI8Ac/goSq22BlAXGP7FJBhlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667947; c=relaxed/simple;
	bh=cH6Bwn7z9r2z9m08O1SwvgWAiLz178mtM9yKwmWkowc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg4DNRyH00vi1wwvrFBcS6OgTTJ56Ap/PiyNzcwfmZt+IWX3DZYtqPBaKSUU/aukRAjlkiP93petkPREzQ7qj9csWaaXV0y8TxEm36r87Wp343PuHKCOSCej7hRyyGIpXdHn9mkoEQGd8Zhup/l5raXg3hPaq8NP+CkKLsDhntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9HSMYxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20FAC4CEF1;
	Tue,  2 Dec 2025 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764667947;
	bh=cH6Bwn7z9r2z9m08O1SwvgWAiLz178mtM9yKwmWkowc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9HSMYxadUXzH9OEBq5dZ1GxtURPzhnNzTZ4Z/v563Gs9P1bMgN4G8bEg40xIBarx
	 is2IycG+ZYg7QEiAWwbFeCRYTJP0U7GJubQB1KF5VjH+RLOmCdK+Y6vncMeO38jXSA
	 FVyjIfehECBQxXU65Uxz/Hawqeu/cwsaTuigxoAkqp1gKZ6BrchdfoFJ6wsam7VZtR
	 yWw/KaS+EWkGG/udG3WLgBPU9j8TH70wM6KtPZNljGT3YiXUi1bOPPLMPkiNpSc/In
	 8Y7FnlGnRHfEllELPJ4r6QDeGD79/JJxuwYKHhzrh8FjE6IdgeClY8XydN0g1HtLB+
	 JsQTBU5GwBEPg==
Date: Tue, 2 Dec 2025 10:32:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@nxp.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aS6yIz94PgikWBXf@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>

Hello Koichiro,

On Tue, Dec 02, 2025 at 03:35:36PM +0900, Koichiro Den wrote:
> On Mon, Dec 01, 2025 at 03:41:38PM -0500, Frank Li wrote:
> > On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > > for the MSI target address on every interrupt and tears it down again
> > > via dw_pcie_ep_unmap_addr().
> > >
> > > On systems that heavily use the AXI bridge interface (for example when
> > > the integrated eDMA engine is active), this means the outbound iATU
> > > registers are updated while traffic is in flight. The DesignWare
> > > endpoint spec warns that updating iATU registers in this situation is
> > > not supported, and the behavior is undefined.
> > >
> > > Under high MSI and eDMA load this pattern results in occasional bogus
> > > outbound transactions and IOMMU faults such as:
> > >
> > >   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> > >
> > 
> > I agree needn't map/unmap MSI every time. But I think there should be
> > logic problem behind this. IOMMU report error means page table already
> > removed, but you still try to access it after that. You'd better find where
> > access MSI memory after dw_pcie_ep_unmap_addr().
> 
> I don't see any other callers that access the MSI region after
> dw_pcie_ep_unmap_addr(), but I might be missing something. Also, even if I
> serialize dw_pcie_ep_raise_msi_irq() invocations, the problem still
> appears.
> 
> A couple of details I forgot to describe in the commit message:
> (1). The IOMMU error is only reported on the RC side.
> (2). Sometimes there is no IOMMU error printed and the board just freezes (becomes unresponsive).
> 
> The faulting iova is 0xfe000000. The iova 0xfe000000 is the base of
> "addr_space" for R-Car S4 in EP mode:
> https://github.com/jonmason/ntb/blob/68113d260674/arch/arm64/boot/dts/renesas/r8a779f0.dtsi#L847
> 
> So it looks like the EP sometimes issue MWr at "addr_space" base (offset 0),
> the RC forwards it to its IOMMU (IPMMUHC) and that faults. My working theory
> is that when the iATU registers are updated under heavy DMA load, the DAR of
> some in-flight transfer can get corrupted to 0xfe000000. That would match one
> possible symptom of the undefined behaviour that the DW EPC spec warns about
> when changing iATU configuration under load.

For your information, in the NVMe PCI EPF driver:
https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429

We take a mutex around the dmaengine_slave_config() and dma_sync_wait() calls,
because without a mutex, we noticed that having multiple outstanding transfers,
since the dmaengine_slave_config() specifies the src/dst address, the function
call would affect other concurrent DMA transfers, leading to corruption because
of invalid src/dst addresses.

Having a mutex so that we can only have one outstanding transfer solves these
issues, but is obviously very bad for performance.


I did try to add DMA_MEMCPY support to the dw-edma driver:
https://lore.kernel.org/linux-pci/20241217160448.199310-4-cassel@kernel.org/

Since that would allow us to specify both the src and dst address in a single
dmaengine function call (so that we would no longer need a mutex).
However, because the eDMA hardware (at least for EDMA_LEGACY_UNROLL) does not
support transfers between PCI to PCI, only PCI to local DDR or local DDR to
PCI, using prep_memcpy() is wrong, as it does not take a direction:
https://lore.kernel.org/linux-pci/Z4jf2s5SaUu3wdJi@ryzen/

If we want to improve the dw-edma driver, so that an EPF driver can have
multiple outstanding transfers, I think the best way forward would be to create
a new _prep_slave_memcpy() or similar, that does take a direction, and thus
does not require dmaengine_slave_config() to be called before every
_prep_slave_memcpy() call.


Kind regards,
Niklas

