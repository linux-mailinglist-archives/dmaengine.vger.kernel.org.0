Return-Path: <dmaengine+bounces-6884-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C251BF211D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E2724F70EA
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C08264619;
	Mon, 20 Oct 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3QB9lk6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC22263F30;
	Mon, 20 Oct 2025 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973778; cv=none; b=NriEBOeTxGPJoAOou+sntYF9OM0E2p6I+GjtsqKNX3J69nqXhuu5BBr6eoWYdBarylZyA3ntkY9gdOSsa31ZAf6nhMVacvrfUhKDQPqYkgSsItDQNISSLolqb1O3heQR7iyyBRf0uNmzGswItsMUUleWitdlChs0DaigVa73sVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973778; c=relaxed/simple;
	bh=pkWCRgKje8+lMG6BeJd66Pm/J7E6gx/JTrAJgsFBx7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rgt7VVJ+sw58yx88iX3rcDdz44S2v3qXFqbJT3YpcTRIxLPS3Az1xaS3B3Kq3q5h669jn+li2WUMafJI6lS0A5Mb8Jn1aRCqsON5nxd1IKVykLH7O8Fybq8vzeqj66AJ2/5AcD+R90PrBROACcdXuerSwMuckd4CmGmgjjWVEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3QB9lk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A271BC4CEF9;
	Mon, 20 Oct 2025 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760973777;
	bh=pkWCRgKje8+lMG6BeJd66Pm/J7E6gx/JTrAJgsFBx7k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=d3QB9lk6p0NS7pcoM9t04x8GFUc9pFinspU4yAdGjmtuQtrnznIbNiSapRH7IUGdC
	 4wSO4RDhLJHA+h8zyvb/hTBZifUD5oU/9iAOf4iv+m1stMym3MB+zSiADAbD4RDw1z
	 do0hC+SSRhh9iYSuQgcwZaD1bvV3M1iljTXbVbyLfk6eJV+z6EDbwwW3IFXGbTb3dg
	 EYziadNUZwTpGwFp6B4TQBo7ShqEZzU5oAdyI39RDZFJsVytgCc9BkoiKE43zbAOBX
	 Duc1gVD0h0y/l2mZWcX/w+0Cr2kiQgpyJfYN+BoP6AA8PmpZ2yCgjBtd0IW32kR8b4
	 RZFKSrF5KQPoQ==
Message-ID: <6b9528bb-feee-4c6f-8d93-3bda1c4f7e96@kernel.org>
Date: Mon, 20 Oct 2025 10:22:55 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add iommu supports
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 "open list:CADENCE NAND DRIVER" <linux-mtd@lists.infradead.org>,
 Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
References: <cover.1760486497.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <cover.1760486497.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/14/25 19:13, Khairul Anuar Romli wrote:
> This patch series adds IOMMU support for the Agilex5 platform by:
> 
> - Updating the device tree bindings for:
>    - Cadence HP NAND controller (`cdns,hp-nfc`)
>    - Synopsys DesignWare AXI DMA controller (`snps,dw-axi-dmac`)
>    to accept the `iommus` property.
> 
> - Adding the SMMU (System Memory Management Unit) node to the Agilex5
>    device tree and wiring up the IOMMU properties to the supported
>    peripherals:
>    - NAND controller
>    - DMA controller
>    - SPI controller
> 
> The Agilex5 SoC includes an ARM SMMU v3 with dedicated Translation Buffer
> Units (TBUs) for peripherals. These allow for hardware-enforced DMA
> address translation and memory isolation using the IOMMU framework.
> 
> Enabling IOMMU support ensures proper integration of these devices in
> virtualized or secure environments, and aligns the platform with ARM’s
> architectural requirements.
> 
> ---
> Changes in v3:
> 	- Refined commit messages with detailed hardware descriptions.
> 	- Clarified which peripherals are covered in the DT changes.
> Changes in v2:
> 	- Add more description in the commit message body to clarify
> 	  device required for this changes.
> ---
> Khairul Anuar Romli (3):
>    dt-bindings: mtd: cdns,hp-nfc: Add iommu property
>    dt-bindings: dma: snps,dw-axi-dmac: Add iommu property
>    arm64: dts: socfpga: agilex5: Add SMMU nodes
> 

Applied!

Thanks,
Dinh

