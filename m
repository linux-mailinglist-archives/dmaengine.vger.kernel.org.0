Return-Path: <dmaengine+bounces-5861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA026B109FB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jul 2025 14:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27A9542A04
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jul 2025 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952B2D0C95;
	Thu, 24 Jul 2025 12:19:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859D2D0C8A;
	Thu, 24 Jul 2025 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359570; cv=none; b=hcRcsF9zi5+iVSLBfssTVm7KdAXyrK2kKwyFQYkryEraVB5XWdmDAvygkeagB/63JmfuYMld1mIsmsobRQra4Rb163KI18FG1vgKog5D/U+OpVDevlM24VunKhqgvMnwhQdA9r7KoBEgrKqHsSPRu/l7foQ0hkv+V5M5tzehUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359570; c=relaxed/simple;
	bh=9WMQgzf1pZnKjl9mHmZEEf14iI8HzpbMzNBECea3/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9MYnQ3X4tCec4mzaGf8zQnsTwCHkmdEuTkWEMFDy0BtJ/vXsiXL09RYX+MDV63GrCQGXjhwx2Zqh9dMLveBBTuXBGxqCfMczDLsZyFvcjEiWI7iEUfGIjRqLzDWM6vLytEKhP4hWcfdpG3Nn5SdCBm6uMPa/8++6PLn+AWltfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A885F340FB1;
	Thu, 24 Jul 2025 12:19:27 +0000 (UTC)
Date: Thu, 24 Jul 2025 20:19:16 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 6/8] riscv: dts: spacemit: Add PDMA0 node for K1 SoC
Message-ID: <20250724121916-GYA748228@gentoo>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
 <20250714-working_dma_0701_v2-v3-6-8b0f5cd71595@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-working_dma_0701_v2-v3-6-8b0f5cd71595@riscstar.com>

Hi Guodong,

On 17:39 Mon 14 Jul     , Guodong Xu wrote:
> Add PDMA0 dma-controller node under dma_bus for SpacemiT K1 SoC.
> 
> The PDMA0 node is marked as disabled by default, allowing board-specific
> device trees to enable it as needed.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v3:
> - adjust pdma0 position, ordering by device address
> - update properties according to the newly created schema binding
> v2:
> - Updated the compatible string.
> - Rebased. Part of the changes in v1 is now in this patchset:
>    - "riscv: dts: spacemit: Add DMA translation buses for K1"
>    - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn/
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..46dc002af947893cc2c234ee61e63c371cd966ca 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -660,6 +660,17 @@ dma-bus {
>  			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
>  				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
>  
> +			pdma0: dma-controller@d4000000 {
does K1 has more than one pdma controller? No? as I checked..
so, I'd suggest simply naming it as 'pdma' - which clear the confusion
that there will be more than one pdma nodes..

> +				compatible = "spacemit,k1-pdma";
> +				reg = <0x0 0xd4000000 0x0 0x4000>;
..
> +				interrupts = <72>;
for consistency in this dtsi file, I'd suggest moving "interrupts" after "clocks",
or even after "resets"? leave "clocks & resets" together..

> +				clocks = <&syscon_apmu CLK_DMA>;
> +				resets = <&syscon_apmu RESET_DMA>;
> +				dma-channels = <16>;
> +				#dma-cells= <1>;
> +				status = "disabled";
> +			};
> +
>  			uart0: serial@d4017000 {
>  				compatible = "spacemit,k1-uart",
>  					     "intel,xscale-uart";
> 
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

