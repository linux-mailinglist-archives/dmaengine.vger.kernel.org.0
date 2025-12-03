Return-Path: <dmaengine+bounces-7482-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4EC9EAEC
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A501347495
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0142E92A6;
	Wed,  3 Dec 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+GO0mwH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF02E8E0B;
	Wed,  3 Dec 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757163; cv=none; b=qefQNdvJESZ4xFIH4sc9OHziZlw+7LQzsMWKA4vkCryWHi4J9+HvueQNH+eLoggJ8wA5p73NpbEKvoREs4x+sQOi+oUN8yUXs5LFFiDdhl3cGKKM1m8AQ+4ZDUmm210gM7stOrcHp7nDI3LO1R5JHgwIeaqGvftAVH9z0dQTSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757163; c=relaxed/simple;
	bh=VgK/tY9UAl4jvmdC5xmVgHL50lqPTwZfBYeqWY3zmyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUyQZAwnluitJozo4HbzUHZXBucASwX33cKcrZc4xaQhz1pFmwTs+gDc+D6g4XxzXVH384fjZMLHTELXTcKUwNNGD507nbOzYlaX+EAahqdrLGaKwZJqOwis2pRsRf1//0sIEO6Xdxf4f/9PliJFEt5x/wRxMcBCyUFe5L5qElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+GO0mwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BC0C4CEFB;
	Wed,  3 Dec 2025 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764757161;
	bh=VgK/tY9UAl4jvmdC5xmVgHL50lqPTwZfBYeqWY3zmyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+GO0mwHh06rAgXiQY4ZHdZdhTUGkTsBOCn/gyKe4qlgz58oUt1I50NB4pmvQUD7j
	 rCLeNGLxXBJEsDSg5iNOdh8c2ibw5AxauOPKkxel+h2jGYWlQeYQaBFPa85a5QdnLt
	 UHx4TGUNTQN5VB7KNcT0+SGdZjLtDkKA427Suj9zsG1bwpzlxhffiH+PhEIUu/VH/6
	 9nnw+tR3nwjBAtMxlAEaeBqCi4DEJWx+5UlA5h5UQNlgWrh/abFNtVV+/yZLMrMFD+
	 xtgCtwjjBHUhBZVIPRJh+oBI2s9yWLaQjVOJWD39LaczAHNbOsOb1AhawG0MsqTVhQ
	 05M70PIr+whvQ==
Date: Wed, 3 Dec 2025 11:19:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>, mani@kernel.org
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aTAOoWRYMk1qZG0B@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS6H_6gBEQjmQUG0@ryzen>
 <mb2tkza65fj77i3cjs7t2lrcrxnlesn7aibf46zq3c3fahjp7i@2hcziakdeo5s>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb2tkza65fj77i3cjs7t2lrcrxnlesn7aibf46zq3c3fahjp7i@2hcziakdeo5s>

On Wed, Dec 03, 2025 at 05:30:52PM +0900, Koichiro Den wrote:
> On Tue, Dec 02, 2025 at 07:32:31AM +0100, Niklas Cassel wrote:
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
> > 
> > Please reference a specific section in the EP databook, and the specific
> > EP databook version that you are using.
> 
> Ok, the section I was referring to in the commit message is:
> 
> DW EPC databook 5.40a - 3.10.6.1 iATU Outbound Programming Overview
> "Caution: Dynamic iATU Programming with AXI Bridge Module You must not update
> the iATU registers while operations are in progress on the AXI bridge slave
> interface."

Please add this text to the commit message when sending a proper patch.

Nit: I think it is "DW EP databook" and not "DW EPC databook".


However, if what you are suggesting is true, that would have an implication
for all PCI EPF drivers.

E.g. the MHI EPF driver:
https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-mhi.c#L394-L395
https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-mhi.c#L323-L324

uses either the eDMA (without calling pci_epc_map_addr()) or MMIO
(which does call pci_epc_map_addr(), which will update the iATU registers),
depending on the I/O size.

And I assume that the MHI bus can have multiple outgoing reads/writes
at the same time.

If what you are suggesting is true, AFAICT, any EPF driver that could have
multiple outgoing transactions occuring at the same time, can not be allowed
to have calls to pci_epc_map_addr().

Which would mean that, even if we change dw_pcie_ep_raise_msix_irq() and
dw_pcie_ep_raise_msi_irq() to not call map_addr() after
dw_pcie_ep_init_registers(), we could never have an EPF driver that mixes
MMIO and DMA. (Or even has multiple outgoing MMIO transactions, as that
requires updating iATU registers.)


Kind regards,
Niklas

