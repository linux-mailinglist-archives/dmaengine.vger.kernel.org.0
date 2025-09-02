Return-Path: <dmaengine+bounces-6325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F6B3FB34
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CC21B237AB
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AED2ED865;
	Tue,  2 Sep 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8ruingw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBB2EAB81;
	Tue,  2 Sep 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806608; cv=none; b=pbrbj+OJaUUymDC4nf6dSUcub9xK8s6f240p7Why5sUkkxKh+XvCTVN0QMtBx3YnVEkudSCLSKpxxMjmuNT8qD8zR1y6cxDLIVO09ipVBsufqreeY2iuVEpbvct6fhe6/X/IAfTcWKZ6+Ob7M1UWVRF5xV8FiAIjEPXZwk8WaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806608; c=relaxed/simple;
	bh=qbKcoCnyI7prTmn2e4S8kHQTAUMV3OUtBdKQxOT3nYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i1vflsYQQ1IQHJCRTkOVBATlbfCmmgnhiE/u/VoJ69dYhKh4w5wL56SJurCy+ozKiBYts/ber62cMYJ2yW7VYnBtyHZ/eFMnBRtkC3fwAnqo8PzdCWvSRBd0w5kXPIN1Wx1/u0fjZT7Wygn1nmA7JFxeXPvXQO/2zh+wThrhUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8ruingw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BF3C4CEED;
	Tue,  2 Sep 2025 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806607;
	bh=qbKcoCnyI7prTmn2e4S8kHQTAUMV3OUtBdKQxOT3nYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k8ruingwTTYBUbt3by1J5OOjSTZhVyaU4tHBF1Gae/gFogtsNgm7byLyGgEC0Cf3+
	 YFEk2g1u5b1Dq8k9IDTnIqxFfK5CCIjI/VrzYo1fecM1TBbIzymPyFhXA0SEU89zLm
	 /8GUNmG4+Nb49r54jESMtZOVpEd51ohtY7QOymGGw8lCV1cg7gvV9msFEWIewr5v1A
	 B6tuadsViNb8LilGhWGieHQZxpGQbmXCeBwsCoZCu0xrI6GuQdNPMABZwguJ9FpJlT
	 J5Gq+NoaS0ySwrx7Gz7VIyBrwhPtbY1pjEhGl8TsAXw3zKRHcBgKKVNCiJ4stXYU9L
	 Itdw4kkU2+hIA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz, 
 Guodong Xu <guodong@riscstar.com>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
Subject: Re: (subset) [PATCH v5 0/8] dmaengine: mmp_pdma: Add SpacemiT K1
 SoC support with 64-bit addressing
Message-Id: <175680660058.246694.5045747556533020350.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:20:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 22 Aug 2025 11:06:26 +0800, Guodong Xu wrote:
> This patchset adds support for SpacemiT K1 PDMA controller to the existing
> mmp_pdma driver. The K1 PDMA controller is compatible with Marvell MMP PDMA
> but extends it with 64-bit addressing capabilities through LPAE (Long
> Physical Address Extension) bit and higher 32-bit address registers (DDADRH,
> DSADRH and DTADRH).
> 
> In v5, two smatch warnings reported by kernel test bot and Dan Carpenter were
> fixed.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
      commit: 39ce725e621b256188550492b4b53fb02bfc872e
[2/8] dmaengine: mmp_pdma: Add clock support
      commit: e73a9a13c99c5a55abfdb8c273651509be1eb5bb
[3/8] dmaengine: mmp_pdma: Add reset controller support
      commit: fc72462bc6107b8babda05cad5bf8f7daf8bec20
[4/8] dmaengine: mmp_pdma: Add operations structure for controller abstraction
      commit: 35e40bf761fcb24b1355d6a8d48b5b10683fe1a3
[5/8] dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing
      commit: 5cfe585d8624f7482505183dd0e4c534b061e822

Best regards,
-- 
~Vinod



