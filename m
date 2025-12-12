Return-Path: <dmaengine+bounces-7582-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB72CB7C8F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 04:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87C0B3007743
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF622BE02D;
	Fri, 12 Dec 2025 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5rLjdeF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E29296BD8;
	Fri, 12 Dec 2025 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510692; cv=none; b=IGfy7Xj1djm/p0PsGkOByJTb7ZuesQF3TtOQJYgXnleue8/fyOYS5ylMesyHLp3Jt950gPtxg71vpY42gjpN8QrHF7mz7uQ9m+wNsSzy9Uam7HOmF/vbENKGg0AKEHnLNyEjCHC6VgR0D1voEWjAkSQ99epf8uDZBlZatOS1R1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510692; c=relaxed/simple;
	bh=9D6zWgM275kFJjmUhT1myHE47fJbV2AAsrgk9IFLcP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMK//QXEcrt6YikUQsRk8v9TB/cG0mq4240o7q8Ib0q1qPxjtc/KEf92TeDBt8hHT2MjcJMixTJ0bsuMLwjCrB7S+OjUqNEajvYfY025VwVOTsMK9XLkMFSaKYLeVqAaei/zL8IkLMS7SFKJvew+4vb4QmN/z/TlYTx81TrYqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5rLjdeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605DDC4CEF1;
	Fri, 12 Dec 2025 03:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765510692;
	bh=9D6zWgM275kFJjmUhT1myHE47fJbV2AAsrgk9IFLcP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5rLjdeFyK1iCqTiMKDj1mu2MMFuoThjqZFKqga4z2vySOzox++N2fQ92HkLV20P/
	 LIN6OECNEB2yU3KW3BKaMNvtnEF/3x0sDgx/n1DecKOl7CnNosKPEDzUBqKAw6WJQW
	 4/mzuXt9JooDYzZvlvbbTpZnqPezjaGwZipWZVnqNKPFxSQs2Db+IoAHuSlPxBJA6K
	 3abDhx8Cs9Y9StIPHlzWBNrjTh3jHQIWiZDaw796kTIcwZJhkzFuwa0KaRxpltzUJY
	 rlZCg/NoOAiTITMqC0FJVS4y2KIjW07LhiB6Wn9/ifLaKU3AwSf54pWRUMQTrXSXIQ
	 bFciVULY5HbGA==
Date: Fri, 12 Dec 2025 12:38:02 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <qyrjma57yonkgy4ouopzssyrktcrosjs2v6hnawjkddzwcfm5e@bm5q2isynhet>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251129160405.2568284-20-den@valinux.co.jp>

On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> for the MSI target address on every interrupt and tears it down again
> via dw_pcie_ep_unmap_addr().
> 
> On systems that heavily use the AXI bridge interface (for example when
> the integrated eDMA engine is active), this means the outbound iATU
> registers are updated while traffic is in flight. The DesignWare
> endpoint spec warns that updating iATU registers in this situation is
> not supported, and the behavior is undefined.
> 

When claiming spec violation, you should quote the spec reference such as the
spec version, section, and actual wording snippet.

> Under high MSI and eDMA load this pattern results in occasional bogus
> outbound transactions and IOMMU faults such as:
> 
>   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> 
> followed by the system becoming unresponsive. This is the actual output
> observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
> 
> There is no need to reprogram the iATU region used for MSI on every
> interrupt. The host-provided MSI address is stable while MSI is enabled,
> and the endpoint driver already dedicates a scratch buffer for MSI
> generation.
> 
> Cache the aligned MSI address and map size, program the outbound iATU
> once, and keep the window enabled. Subsequent interrupts only perform a
> write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> the hot path and fixing the lockups seen under load.
> 

iATU windows are very limited (just 8 in some cases), so I don't like allocating
fixed windows for MSIs.

> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 3780a9bd6f79..ef8ded34d9ab 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -778,6 +778,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> +	/*
> +	 * Tear down the dedicated outbound window used for MSI
> +	 * generation. This avoids leaking an iATU window across
> +	 * endpoint stop/start cycles.
> +	 */
> +	if (ep->msi_iatu_mapped) {
> +		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = false;
> +	}
> +
>  	dw_pcie_stop_link(pci);
>  }
>  
> @@ -881,14 +891,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>  
>  	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  map_size);
> -	if (ret)
> -		return ret;
>  
> -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> +	/*
> +	 * Program the outbound iATU once and keep it enabled.
> +	 *
> +	 * The spec warns that updating iATU registers while there are
> +	 * operations in flight on the AXI bridge interface is not
> +	 * supported, so we avoid reprogramming the region on every MSI,
> +	 * specifically unmapping immediately after writel().
> +	 */
> +	if (!ep->msi_iatu_mapped) {
> +		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> +					  ep->msi_mem_phys, msg_addr,
> +					  map_size);
> +		if (ret)
> +			return ret;
>  
> -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = true;
> +		ep->msi_msg_addr = msg_addr;
> +		ep->msi_map_size = map_size;
> +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> +				ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI target address or the required
> +		 * mapping size. Reprogramming the iATU at runtime is unsafe
> +		 * on this controller, so bail out instead of trying to update
> +		 * the existing region.
> +		 */

I'd perfer having some sort of locking to program the iATU registers during
runtime instead of bailing out.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

