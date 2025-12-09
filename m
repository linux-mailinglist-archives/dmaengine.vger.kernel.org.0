Return-Path: <dmaengine+bounces-7546-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CBCAF425
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F553017EC9
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D813A258;
	Tue,  9 Dec 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX+AmI4A"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69323B8D64;
	Tue,  9 Dec 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268165; cv=none; b=mYIf1TM2c2yHBMB2a63T+Bm0u7qpSecGDXPcsEN1W7FhTMF6wTOSItMMIVn0PnHAUc2qzqR7HSBOBGSx7QcfdtyrdB9qsXKrbhbQI6wMBFqx3W/Tepge4rcbgNftEPEH4X74+gymPKYs40IzppZaWAGXTgK0upXMhSjYC9bmFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268165; c=relaxed/simple;
	bh=XnHT+V9QtuZ5gcDpy0Vw8acht1bOsv0SGcdX4i9Cq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFgoUr2tYIfdpbopthJWnE9iGtOexCvvu53ucBpqJKJygBduY3Updg/tc/hkzHqLJItvD7BMzBL1453mUI6SwmJ+whLzo+fEvgyiyALEh1OsXyrgGHkNM1HijTpeAMwdhboYmFCU5Nn1LmYovS07lZNISiGS5pLFTl5ix/p9q/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX+AmI4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0483CC4CEF5;
	Tue,  9 Dec 2025 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765268165;
	bh=XnHT+V9QtuZ5gcDpy0Vw8acht1bOsv0SGcdX4i9Cq0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uX+AmI4AUAC7sbo9DvaOkzDFyV5xtnfpbiMbvuycbGLIPCl4mGIzyHd2IQ40zX6R1
	 c45i/n/6obdZnLsegO4P9K1HkeiYX7FjBsUU+tEG0z4C4TV0GBaEJ9myAjmbxGfbuQ
	 tCqcjbOlhbLdROvhfhUEsqDe6/8V7NpJXflQ/aTuZ3TCJpS8OItylZ1TkEpRqmmpn/
	 AAlrIyb8vhF32ioqff6YZWq6KpoL6Dd7D9BSPUlL0Shu9IS8NxqCTT9pOwIYMQGubL
	 kd9WRlzgp5dX6rhc/uoVjDxOY3WvcdUFfoAV0Q8NzP6pXLd4zaq29mPCl1vOu8ZxFL
	 OrnMjmxLSc0dQ==
Date: Tue, 9 Dec 2025 09:15:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com, mani@kernel.org, kwilczynski@kernel.org,
	kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aTfavdjoc2ob2j2g@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aTaE3yB7tQ-Homju@ryzen>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTaE3yB7tQ-Homju@ryzen>

On Mon, Dec 08, 2025 at 08:57:19AM +0100, Niklas Cassel wrote:
> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
>
> I don't like that this patch modifies dw_pcie_ep_raise_msi_irq() but does
> not modify dw_pcie_ep_raise_msix_irq()
>
> both functions call dw_pcie_ep_map_addr() before doing the writel(),
> so I think they should be treated the same.

Btw, when using nvmet-pci-epf:
drivers/nvme/target/pci-epf.c

With queue depth == 32, I get:
[  106.585811] arm-smmu-v3 fc900000.iommu: event 0x10 received:
[  106.586349] arm-smmu-v3 fc900000.iommu:      0x0000010000000010
[  106.586846] arm-smmu-v3 fc900000.iommu:      0x0000020000000000
[  106.587341] arm-smmu-v3 fc900000.iommu:      0x000000090000f040
[  106.587841] arm-smmu-v3 fc900000.iommu:      0x0000000000000000
[  106.588335] arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
[  106.589383] arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0

(If I only run with queue depth == 1, I cannot trigger this IOMMU error.)


So, I really think that this patch is important, as it solves a real
problem also for the nvmet-pci-epf driver.


With this patch applied, I cannot trigger the IOMMU error,
so I really think that you should send this a a stand alone patch.


I still think that we need to modify dw_pcie_ep_raise_msix_irq() in a similar
way.


Perhaps instead of:


	if (!ep->msi_iatu_mapped) {
		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
					  ep->msi_mem_phys, msg_addr,
					  map_size);
		if (ret)
			return ret;

		ep->msi_iatu_mapped = true;
		ep->msi_msg_addr = msg_addr;
		ep->msi_map_size = map_size;
	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
				ep->msi_map_size != map_size)) {
		/*
		 * The host changed the MSI target address or the required
		 * mapping size. Reprogramming the iATU at runtime is unsafe
		 * on this controller, so bail out instead of trying to update
		 * the existing region.
		 */
		return -EINVAL;
	}

	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);



We could modify both dw_pcie_ep_raise_msix_irq and dw_pcie_ep_raise_msi_irq
to do something like:



	if (!ep->msi_iatu_mapped) {
		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
					  ep->msi_mem_phys, msg_addr,
					  map_size);
		if (ret)
			return ret;

		ep->msi_iatu_mapped = true;
		ep->msi_msg_addr = msg_addr;
		ep->msi_map_size = map_size;
	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
				ep->msi_map_size != map_size)) {
		/*
		 * Host driver might have changed from MSI to MSI-X
		 * or the other way around.
		 */
		 dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
		 ret = dw_pcie_ep_map_addr(epc, func_no, 0,
		 			   ep->msi_mem_phys, msg_addr,
					   map_size);
		if (ret)
			return ret;
	}

	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);



I think that should work without needing to introuce any
.start_engine() / .stop_engine() APIs.



Kind regards,
Niklas

