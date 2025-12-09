Return-Path: <dmaengine+bounces-7541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D3CAEBD7
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 03:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190C3304DEAB
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84324A047;
	Tue,  9 Dec 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssDBAeTb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A117D2;
	Tue,  9 Dec 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765247521; cv=none; b=c+WhJSt90Tk+GWcj6Lu08PJsj2cghYwC+ZOfv8P9fb1Mn0S4KI03ZGQj12ztAcASIaVX2UhDAM7xH51AQaiUnsRKbFuJgxXq5FIHuda69FYgYDQa5xHtpYNMQ8Yhiit89NsQpoPJaw1QL+mqeb+KfWcMh+BPNmvQTQ5VRcUxzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765247521; c=relaxed/simple;
	bh=PFVA+zI/bstNK1jQzv4pqwneP+Zt6w13hC5OvKuRyxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LrcukmjBzGa5MS/Ss4eFMSmfQxGBr3A8lypY92oxof288aFE3PE1I1fAUuYKdHRbKwYzDCgdVGs+PedlE1PIHB8NIzxxV4h82GT7Em68rNroihsPz0dL0eXjqT9K+yA/tNTk0k+g4MiZ9SXjshTlJqyoIIuaHdE97Y+oHu1bv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssDBAeTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5133C4CEF1;
	Tue,  9 Dec 2025 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765247521;
	bh=PFVA+zI/bstNK1jQzv4pqwneP+Zt6w13hC5OvKuRyxA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ssDBAeTbczZcFBMVwJmnbc5qTq4e3er8CMp8YHSBZeSJNJCRRehCBlaX69b4xM6CC
	 RTGORQ7hpxfny+Pl46rv5Ho5XD7fE9sxwtE+8iGu+LpGLS5y43jXc+I1xI3yGWwBKB
	 qieu9pYrgpQvy4Rz0Hs+hjeoyyL0dwjgyMPBtG4emJgKch6f4c2LxE7cRkYqI/fQyZ
	 FXK2+X3C6JBp3QC48q5xf8EsOmpTSQQPfqjb5b4lDhvQ6qVaEk1a9RgkEiZsepnrpp
	 aqnzSnBXjs11ueplVPkabxSpSHDArAaqUTQYXkvXXETtteAKFperbM9o3uSONI7B9X
	 prSg9e6ertUPQ==
Message-ID: <e1aae851-4031-4b5c-a807-7a61ecfe6af1@kernel.org>
Date: Mon, 8 Dec 2025 20:31:58 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add dma-coherent property
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
 <vkoul@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <cover.1764717960.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/2/25 17:47, Khairul Anuar Romli wrote:
> This patch series adds dma-coherent property for the Agilex5 platform by:
> 
> - Updating the device tree bindings for:
>    - Cadence HP NAND controller (`cdns,hp-nfc`)
>    - Synopsys DesignWare AXI DMA controller (`snps,dw-axi-dmac`)
>    to accept the `dma-coherent` property.
> 
> - Adding the dma-coherent property to the Agilex5 device tree and wiring up
>    the property to the supported peripherals:
>    - NAND controller
>    - DMA controller
> 
> This dma-coherent addition aligns the Agilex5 platform with ARM’s
> architectural requirements for coherent interconnects.
> 
> ---
> Notes:
> This patch series is applied and validated on socfpga dts maintainer's
> branch
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19
> 
> This changes is validated on:
> 	- intel/socfpga_agilex5_socdk.dtb
> 	- snps,dw-axi-dmac.yaml
> 	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb
> 	- cdns,hp-nfc.yaml
> 	- cdns,hp-nfc.yaml intel/socfpga_agilex5_socdk.dtb
> 
> Changes in v2:
> 	- Rephrase git commit message to describe why the property is
> 	  needed now.
> 	- Remove redundant statement in the git commit message.
> 	- Correct the version in patch series title to v2.
> ---
> Khairul Anuar Romli (3):
>    dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent property
>    dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
>    arm64: dts: socfpga: agilex5: Add dma-coherent property
> 
>   Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
>   Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml      | 2 ++
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi              | 3 +++
>   3 files changed, 7 insertions(+)
> 

Applied!

Thanks,
Dinh


