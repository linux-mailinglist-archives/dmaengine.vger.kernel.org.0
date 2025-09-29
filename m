Return-Path: <dmaengine+bounces-6728-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28560BA9CD3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 17:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FF516E405
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B430BF67;
	Mon, 29 Sep 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LieiEkf/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692130BBAC;
	Mon, 29 Sep 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159740; cv=none; b=XG9OgbpSAuSYauSqeaYBSIT/q1QmNlcHg0vaOfuh4l/tEuRAm7fl8ewsoo51RuXbDgM28NpipQM2bZ3WWZpg3zwosKbBLX+AJP5ZYG1FaEHHKB+l4fxXMEXSi7bHSC7FKAw0qaZjpagIHfD6a0oTvtQpwQlAFkbWbqv2TIH186I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159740; c=relaxed/simple;
	bh=zz+GUmVsy2vB+3ANMPWPbJpVcNFY2jQbjEDvoTACVOw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ECbCZ7z50cPXil69p3ZOv5n6Q479IOxOeawfq5j6nkAoPx0QWXLWPCBDcgxUd/0q9kKPlk6ft45p+/3r2NbTPnyIsWEDXPXOH/VVm9FhKDVHbg9Fv25EzEC3jrm2qlJXxs2pWP1gxQGTi2PwOeGMwz96nzMm/DtnaWg6Yhvo7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LieiEkf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D72C116B1;
	Mon, 29 Sep 2025 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759159739;
	bh=zz+GUmVsy2vB+3ANMPWPbJpVcNFY2jQbjEDvoTACVOw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LieiEkf/My5IzhSHvnx4xacBLRykPFVF30XNtrgPaxvt2XruntfGF75FreaDo5sBd
	 7xIR+u+UDMeWUdKANsMbUYIezK3qC+eBLGFYhBfbwlCZp/dWe7mpLGu1lF2BWlcHIk
	 A8SYBu5x4+tJ2dvEy1iXzJO04Slrd60iufQ0d5V7EBMv6kxh/iPMaOxV/+77aJZzuC
	 d61H5tM8BVpft6iJid+miAYFAIBLgkso9EXESl+Cv0Z6HtLz35zjtQ7vjNe/9Yl4ix
	 4pKSEvUXKrIQLuwqjrlKISh9VE34TmD2amQ3kMZBmQ/MdXd6yUGUQSxnUFTxjndsRh
	 dvSafSW63W2JA==
Date: Mon, 29 Sep 2025 10:28:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>, 
 linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, 
 Thierry Reding <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>
To: "Sheetal ." <sheetal@nvidia.com>
In-Reply-To: <20250929105930.1767294-1-sheetal@nvidia.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
Message-Id: <175915953199.54406.1457670691076635405.robh@kernel.org>
Subject: Re: [PATCH V2 0/4] Add tegra264 audio device tree support


On Mon, 29 Sep 2025 16:29:26 +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
> 
> Add device tree support for tegra264 audio subsystem including:
> - Binding update for
>   - 64-channel ADMA controller
>   - 32 RX/TX ADMAIF channels
>   - tegra264-agic binding for arm,gic
> - Add device tree nodes for
>   - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
>     DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
>   - HDA controller
>   - sound
> 
> Note:
>  The change is dependent on https://patchwork.ozlabs.org/project/linux-tegra/patch/20250818135241.3407180-1-thierry.reding@gmail.com/
> 
> ...
> Changes in V2:
>  - Update the allOf condition in Patch 2/4.
> 
> sheetal (4):
>   dt-bindings: dma: Update ADMA bindings for tegra264
>   dt-bindings: sound: Update ADMAIF bindings for tegra264
>   dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic
>   arm64: tegra: Add tegra264 audio support
> 
>  .../bindings/dma/nvidia,tegra210-adma.yaml    |   15 +-
>  .../interrupt-controller/arm,gic.yaml         |    1 +
>  .../sound/nvidia,tegra210-admaif.yaml         |  106 +-
>  .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
>  5 files changed, 3377 insertions(+), 41 deletions(-)
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1-57-g635ae6f0a3ad (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250929105930.1767294-1-sheetal@nvidia.com:

In file included from arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi:3,
                 from arch/arm64/boot/dts/nvidia/tegra264-p3834-0008.dtsi:3,
                 from arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dts:5:
arch/arm64/boot/dts/nvidia/tegra264.dtsi:8:10: fatal error: dt-bindings/power/nvidia,tegra264-powergate.h: No such file or directory
    8 | #include <dt-bindings/power/nvidia,tegra264-powergate.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/nvidia] Error 2
make[2]: Target 'arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1480: nvidia/tegra264-p3971-0089+p3834-0008.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'nvidia/tegra210-p2371-2180.dtb' not remade because of errors.
make: Target 'nvidia/tegra210-p3450-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra234-p3737-0000+p3701-0008.dtb' not remade because of errors.
make: Target 'nvidia/tegra234-p3740-0002+p3701-0008.dtb' not remade because of errors.
make: Target 'nvidia/tegra234-p3737-0000+p3701-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra186-p2771-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra210-p2371-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra194-p3509-0000+p3668-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra234-p3768-0000+p3767-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra234-sim-vdk.dtb' not remade because of errors.
make: Target 'nvidia/tegra186-p3509-0000+p3636-0001.dtb' not remade because of errors.
make: Target 'nvidia/tegra194-p2972-0000.dtb' not remade because of errors.
make: Target 'nvidia/tegra210-smaug.dtb' not remade because of errors.
make: Target 'nvidia/tegra194-p3509-0000+p3668-0001.dtb' not remade because of errors.
make: Target 'nvidia/tegra234-p3768-0000+p3767-0005.dtb' not remade because of errors.
make: Target 'nvidia/tegra210-p2571.dtb' not remade because of errors.
make: Target 'nvidia/tegra264-p3971-0089+p3834-0008.dtb' not remade because of errors.
make: Target 'nvidia/tegra132-norrin.dtb' not remade because of errors.
make: Target 'nvidia/tegra210-p2894-0050-a08.dtb' not remade because of errors.






