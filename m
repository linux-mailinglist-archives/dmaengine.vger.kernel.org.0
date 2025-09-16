Return-Path: <dmaengine+bounces-6541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C074B59BA4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B11E170DAA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151534572F;
	Tue, 16 Sep 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICW2dUvB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9034165F;
	Tue, 16 Sep 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035134; cv=none; b=ng5W6ERy3vF4B0WiRbdP/jPZCAOcFLFxcOM7/vZhY5yflFWQwgoBycK5PkhtLcQv+HZrIL88Qzao3S0gP2DsyN2bFPpMZkaiC27WtmR/LDxc6UX+zIn4CWv4LIc9Sx7ODNLx+8cFqLfxlIl0Xz+W/gDKROUAPft9sB6BhEk3jC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035134; c=relaxed/simple;
	bh=elenxXnDysWjqcQd50osxc1EkZoLDOkQRvp91i47EOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pj3exPazXP9Ki/1AWAAbNo62CkAvARTaoP26p/meMv4UHYKD4/8Rh0I7a4V0HD5gCNzsV3D0BCBBhfxVjp9UPc+zukaXYeSveCJsBbUX3Y8AfYRfb86iJ7oqvDwoi8nkLuHXfl98RLgk/WygxhV6XwJtqmeqCRe21RY1oc0yEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICW2dUvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A9CC4CEF0;
	Tue, 16 Sep 2025 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758035133;
	bh=elenxXnDysWjqcQd50osxc1EkZoLDOkQRvp91i47EOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ICW2dUvBvxTtrKCR1/ov2zwENdvirdD6s6f+bqvLii9nfRsw05kVpfwiUsg5RjdIa
	 2mzEZKuw3+nkKLajdtIVsDxZIkpy9+FPsXb3ZsThH25TEUpB5ElfZXD0siHbBQHQxh
	 EXkVxvt5PDxjkHOKVGJXsXbKZ3JSvF5joPqXQzuuVst8nv906zVag+dvoEkjMoDcSP
	 me7jxi5O7ewAA3rKP9nMu8TdjB5NCZVf5HCm7sGwgYdTe9tfgZbgPmr9FpXK5CjhSw
	 4wxMRc5MZKIEJosB1Xj3LP5lJs/+ss4UnWe628waRzWZ3/8S/uPsqWndFn+PSZwxjM
	 nbF4TvbdPPUdw==
Date: Tue, 16 Sep 2025 10:05:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Devendra K Verma <devendra.verma@amd.com>, bhelgaas@google.com,
	mani@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [External] : [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB
 Endpoint Support
Message-ID: <20250916150532.GA1797586@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dbecb3-6261-4df4-a2ee-e55a398c732b@oracle.com>

On Tue, Sep 16, 2025 at 04:25:49PM +0530, ALOK TIWARI wrote:
> 
> 
> On 9/16/2025 4:13 PM, Devendra K Verma wrote:
> > +	/*
> > +	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> > +	 * of map, channel counts, etc.
> > +	 */
> > +	if (vendor != PCI_VENDOR_ID_SYNOPSYS ||
> > +	    vendor != PCI_VENDOR_ID_XILINX)
> > +		return;
> 
> if, vendor == PCI_VENDOR_ID_XILINX condition will true
> 
> should not be if (vendor != PCI_VENDOR_ID_SYNOPSYS && vendor !=
> PCI_VENDOR_ID_XILINX) ?

Good catch, I mistakenly said this part was correct, but you're right;
it's obviously broken.

The alternate structure I suggested would avoid this problem.

> > +
> > +	cap = DW_PCIE_VSEC_DMA_ID;
> > +	if (vendor == PCI_VENDOR_ID_XILINX)
> > +		cap = DW_PCIE_XILINX_MDB_VSEC_ID;
> > +
> > +	vsec = pci_find_vsec_capability(pdev, vendor, cap);
> >   	if (!vsec)
> 
> 
> Thanks,
> Alok

