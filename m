Return-Path: <dmaengine+bounces-6882-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1CBF08E8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 12:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFCC1893571
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354D32F7ADD;
	Mon, 20 Oct 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5B9NWyF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2B2F7AD0;
	Mon, 20 Oct 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956393; cv=none; b=guCRONyFVyhk+k/qOFnVKs9XgLbjKfDCrtYsb+PHBM+eetnWZRQr/dAngOXBznIr/mu6dxXy2x3T8SfkUctMdAmvCpVdTB6y0w7UbuqErm2mIuXwacNnXHjHaen/feQ48HBJS0xYD3WklS4h37Xl5aQT1ly1gp0TR2WVdLDhi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956393; c=relaxed/simple;
	bh=wv0DeCgmqpuaHOPBdjyj9Ov9pUIrLxPfa9Z6o8Bnxmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYlixiv3SvsqGpDtPp+WjwxEVE9xWv50ggi+Hi7nivqUyZBFxFf+/tenuGdg4VowtRUuTyYQDJlgH4OGkcwauVI0rlieQr/3yBO9mCE/PnW82U0AA1C33x/zVXIX5R26McdKj3Crt6QQ3q12iKDUT41+kAtT1nWzf9H9NW+HCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5B9NWyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F4C4CEF9;
	Mon, 20 Oct 2025 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760956392;
	bh=wv0DeCgmqpuaHOPBdjyj9Ov9pUIrLxPfa9Z6o8Bnxmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5B9NWyFY6Sa8DO2FQY8oGwAMfl213SXg4+DY5w00Ko+pZJdQ7ccqmm5xItLYiMFU
	 kUkty54l7NF9ve0+aqhFkDTkYzQOG6DrT4yGG1c0/8AmHF+1xdP/piDuNl0e47knb+
	 RLqlq09htt9H12w2Fcbx9FCvLzFqh4F6E4/cD+zy0zo+f0WBLwgvrhADiH9tqE72PL
	 L/Fl6Me0ewj3HP+ZYJEAMP5MViExO/x6O6NVClTZdQoZeUVA+4dned4eoGQqmRVLIw
	 +mar6yzmkN37mXBQWhXC5tdRFAZD4nPOq5kgaEDXM3hBo1bYROpxjLCRUvkKWPOK46
	 Z/fkhu8667sRg==
Date: Mon, 20 Oct 2025 12:33:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, 
	"open list:CADENCE NAND DRIVER" <linux-mtd@lists.infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: cdns,hp-nfc: Add iommu property
Message-ID: <20251020-faithful-gray-nautilus-b9ca71@kuoka>
References: <cover.1760486497.git.khairul.anuar.romli@altera.com>
 <8f3ebbe7084c8330e9ea05e55b16af1544fa3dd8.1760486497.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f3ebbe7084c8330e9ea05e55b16af1544fa3dd8.1760486497.git.khairul.anuar.romli@altera.com>

On Wed, Oct 15, 2025 at 08:13:37AM +0800, Khairul Anuar Romli wrote:
> Agilex5 integrates an ARM SMMU (System Memory Management Unit) with
> Translation Buffer Units (TBUs) assigned to various peripherals,
> including the NAND controller.
> 
> The Cadence HP NAND controller ("cdns,hp-nfc") on Agilex5 is behind a
> TBU connected to the system's SMMUv3. To support this, the controller
> requires an `iommus` property in the device tree to properly configure
> address translation through the IOMMU framework.
> 
> Adding the `iommus` property to the binding schema allows the OS
> to associate the NAND controller with its corresponding SMMU stream ID.
> This enables:
> - DMA address translation between the controller and system memory
> - Memory protection for NAND operations
> - Proper functioning of the IOMMU framework in secure or virtualized
>   environments
> 
> This change documents the IOMMU integration for the NAND controller
> on platforms like Agilex5 where such hardware is present.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v3:
> 	- Refined commit messages with detailed hardware descriptions.
> 	- Remove redundant commit message and add the hardware used for
> 	  iommu.
> Changes in v2:
> 	- Updated the commit message to clarify the need for the changes
> 	  and the hardware used of this changes.
> ---
>  Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


