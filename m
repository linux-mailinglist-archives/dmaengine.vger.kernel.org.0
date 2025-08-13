Return-Path: <dmaengine+bounces-6006-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A73CB24449
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E9188DF84
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99E2EBDDD;
	Wed, 13 Aug 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="joLvFMKU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F22D321F;
	Wed, 13 Aug 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073631; cv=none; b=TYLv0OHNehoP1ebCzgYQOrxlxQN+tTxY2u4Bcms8hsJkSbZqC7+fu1Cu/ewvPfRj/Ncy92QDWgtESCbbaYiuE109E4v3umr/yDtFcQjcXzVRL98HrlZ1eLzvEfklsASh9wH6XipxG983Tp14OwsNqRbMRxRXkU89ddaGNuAaHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073631; c=relaxed/simple;
	bh=8grarISrrran4HsmVRztqDZfJzOAy0nLtF3rxQKJvkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnT6bUfzDpUO3QjZXHdbZlgOi25gQEeeFjtY5scIfbeWt+APjj9Zoey58odPk8cIbdKymSikh0Db1QxoPTVWsuqbLANH0fUVoA1cCUpqHNOUZeuBuVbNxAE1RX0PdxOBG5Rndx0Eyv/qt8rKKyYidgCb88Dg1Tx+gVMWR2dgtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=joLvFMKU; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755073569;
	bh=zJ0hZ2py5pjtVoXQv0PDAz0XznKZrLsvelnbnYWAbCk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=joLvFMKUIo7JVpRcyfSsH4b1zHZVCD3rV5e9ioXEuRtUaTMY+cezXEeC1Sin/7syW
	 cxD+ezMKEy0wTxj6ethL/9LIxnyHOlpvNHxR76oALadwOaf35IZ7txHIhFQ9z9LkZj
	 LyeHYrKw64pYdtYaD22UJcgEmRYRLV0WPlOLHwSE=
X-QQ-mid: zesmtpsz6t1755073566t0d2cf4d6
X-QQ-Originating-IP: ehoTC6TvF9jhdhuMPH9TGp/slVsmOkyosadz0faF+GE=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 16:26:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8202150046870958779
EX-QQ-RecipientCnt: 20
Date: Wed, 13 Aug 2025 16:26:04 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Guodong Xu <guodong@riscstar.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 0/8] dmaengine: mmp_pdma: Add SpacemiT K1 SoC support
 with 64-bit addressing
Message-ID: <268633D49B18C3E7+aJxMHPhItPq9ioto@LT-Guozexi>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MX+1SEN3H+wAVyQ2gorrg3gEUJlHKLxoVpWqDTRbemWGIGDqidTyZGFB
	tY7WabTIrDRIkcVBl3uOD+y0oDpESE3o8mTAdRcqMNKvZZde7uYwmk/8eyQFsqZ60qmrg5Z
	eoUi/dXRwB5zO1SQWPNZf6YYYiWqjWd1SJCNK3zq3Pq7xs2/FSQCRjU3+anfO0CKXPq9DQ+
	1Ex+wM4/sjaSV73skhB0oqQoA7pxL613GBX+0XnBsOwp1CB3sjOL7QdqGr6HIvgaVxZpE+9
	RJDT9cWuTRmrHS2LlYzY2ZHmCgFY79ehRvFXBy+3GQhMwTFtfM8mQTvhihhS7FX9H1mGEUL
	QQ8Nq/lyRw5qgMP7UbIWfINGHNWT7DL5Z5Ox9bn1hhDGCY9YqjIkhMvsmZzs4qTEDPH2+l2
	Y4XNSN2ZM0PAJWjUJtjlPcNZzme4L22F/Q2Gjdo1eBADKaCmw4ySsHZT7xHytNOTJEh/qHP
	vStkp5d2ouXG2t66GB+75kqkrnjA0uTSaKhse8jFosRQ91+bUJikkHxMXD6i97224XHRgPx
	rFUDHOaVsEUBfzYtGA+KcMKxWHogsWGx0CcUeF3Wkw8bAbvKXj+2e6A7AQwAZnSqucA6TYF
	3wPMOG9yXVZ67eRgd9YJfIUWv/rCXq/ytGJrRNH7yEkElo6Zl47EbAQB0VulI2IQki5JPYB
	YXTdBg1+xwkjiLbxzk3rVEm3AE/yRhDB9dX2trAB1/Xbz/7T+Kkt6gOYOIlVPTy6INMPNVP
	uZRwsfrBiIXmxDo6QXWpok2WL6xf1kyEpURCkUNj+VwF7KiTrlMBfWvBVgdo6b1on8Q3ubD
	7hS6WhjZijGglN/inrYqcPSR8gYhfKo7sDCDYPf2xmZzcDm0GJTo3T9C/XLa3lPh+0IKx7U
	wgazmlJJ7mZu7/TFHyFJRGP2HCzV1sUWmok7BZLT8FTVxUsH9U+Pu+MkZJ3C6b+94azzEKg
	Tp8kiWpQJPCMyeaRRAHS34kt4laNjuZXi2hoskTfOX7avEGmaG5mvAOlmm9NFAq8LrupacZ
	PdcAY2mfo7ZOfvpXnaLUhYi32JZXte5DbCtLNuTlnySSO+GlrvzL3b9TBNYapQn2XJxOvIF
	A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hi Guodong, thanks for your patches!

I have tested it using i2s and dma-tetst.

Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

                - Troy

On Mon, Jul 14, 2025 at 05:39:27PM +0800, Guodong Xu wrote:
> This patchset adds support for SpacemiT K1 PDMA controller to the existing
> mmp_pdma driver. The K1 PDMA controller is compatible with Marvell MMP PDMA
> but extends it with 64-bit addressing capabilities through LPAE (Long
> Physical Address Extension) bit and higher 32-bit address registers (DDADRH,
> DSADRH and DTADRH).
> 
> In v3, the major change is creating a separate yaml binding schema for
> SpacemiT K1 PDMA, per Krzysztof's suggestion. By doing this, the binding
> schema got simplified a lot. Deprecated property (ie. #dma-channels) and
> unused values for backward compatibility (#dma-cells const 2) can be
> removed.
> 
> Other changes involve placing pdma0 node in k1.dtsi and in board specific
> dts files with proper ordering.
> 
> The patchset has been tested on BananaPi F3 board.
> 
> This patchset is based on SpacemiT linux (for-next) [1] with Patch 8
> depending on:
> - riscv: defconfig: run savedefconfig to reorder it
>     It has been merged into riscv/linux.git (for-next)
>     Link: https://git.kernel.org/riscv/c/d958097bdf88
> 
> [1] https://github.com/spacemit-com/linux.git (for-next)
> 
> All of these patches are available here:
> https://github.com/docularxu/linux/tree/working_dma_0714_v3
> 
> Changes in v3:
> - Created separated yaml binding for Spacemit K1 PDMA controller
> - Updated pdma0 node properties according to the new yaml binding
> - Put pdma0 node in k1.dtsi according to its device address
> - Put pdma0 node in board dts files according to alphabetic order
> 
> Link to v2:
> https://lore.kernel.org/r/20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com
> 
> Changes in v2:
> - Tag the series as "damengine".
> - Used more specific compatible string "spacemit,k1-pdma"
> - Enhanced DT bindings with conditional constraints:
>    - clocks/resets properties only required for SpacemiT K1
>    - #dma-cells set to 2 for marvell,pdma-1.0 and spacemit,k1-pdma
>    - #dma-cells set to 1 for other variants
> - Split mmp_pdma driver changes per maintainer feedback:
>    - First patch (4/8) adds ops abstraction layer and 32-bit support
>    - Second patch (5/8) adds K1-specific 64-bit support
> - Merged Kconfig changes into the dmaengine: mmp_pdma driver patch (5/8)
> - Enabled pdma0 on both BPI-F3 and Milk-V Jupiter
> 
> Link to v1:
> https://lore.kernel.org/all/20250611125723.181711-1-guodong@riscstar.com/
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> Guodong Xu (8):
>       dt-bindings: dma: Add SpacemiT K1 PDMA controller
>       dmaengine: mmp_pdma: Add optional clock support
>       dmaengine: mmp_pdma: Add optional reset controller support
>       dmaengine: mmp_pdma: Add operations structure for controller abstraction
>       dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing
>       riscv: dts: spacemit: Add PDMA0 node for K1 SoC
>       riscv: dts: spacemit: Enable PDMA0 on Banana Pi F3 and Milkv Jupiter
>       riscv: defconfig: Enable MMP_PDMA support for SpacemiT K1 SoC
> 
>  .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  68 +++++
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   4 +
>  arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   4 +
>  arch/riscv/boot/dts/spacemit/k1.dtsi               |  11 +
>  arch/riscv/configs/defconfig                       |   1 +
>  drivers/dma/Kconfig                                |   2 +-
>  drivers/dma/mmp_pdma.c                             | 281 ++++++++++++++++++---
>  7 files changed, 339 insertions(+), 32 deletions(-)
> ---
> base-commit: 6be7a5a768aafcb07d177bd2ae36ab84e4e0acde
> change-id: 20250701-working_dma_0701_v2-7d2cf506aad7
> prerequisite-change-id: 20250611-01-riscv-defconfig-7f90f73d283d:v1
> prerequisite-patch-id: 53bda77e089023a09152a7d5403e1a738355c5d3
> 
> Best regards,
> -- 
> Guodong Xu <guodong@riscstar.com>
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

