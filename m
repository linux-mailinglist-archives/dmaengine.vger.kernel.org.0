Return-Path: <dmaengine+bounces-7024-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6952C16165
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 18:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0C5423070
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12338347BD4;
	Tue, 28 Oct 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3aAavwg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAD2848B4;
	Tue, 28 Oct 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671307; cv=none; b=XNKQGk1jiycmo4RGQZ4euCyJ9K5Zv5YoxwZb6+ecLlSwzz8kSyyc4bpAch75yTb9cTvhMZzXcPZhUB2TMMBx6pyE8JZ+6MqjtNG4BOxRFej0XyQZsoH67mWeNHb9xdBp0KvvzVVG/Zq+ysI3uDvbvQgzP9EQfFpEqcLlBtAVGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671307; c=relaxed/simple;
	bh=9eUztxr0c5bs9J7IDIf5az3dpnFzy5BKhJ7flVcVeA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gAOpV1tyKQ2g8fYxWG/2ttiNil1sMkOGHUoYqpQHznKejggbNPJg6DxJ+1J2pzN2wfk1mi1bXvkqQOlOIpDtG09sgqjZF1HGmXy5Ur5X1M7VLpRo3Mh4yJJNF0m4FQWFmsFe/o3zLYE6oN/j0utVPNS8iwvRZtzzBvCnYFJ2itc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3aAavwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416F7C4CEE7;
	Tue, 28 Oct 2025 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671306;
	bh=9eUztxr0c5bs9J7IDIf5az3dpnFzy5BKhJ7flVcVeA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G3aAavwgwh9gFQLPVh9gLVrbNzRS7vPP3F+iQSp8h7oFGi/a7/yqzJfeel5KMYXsZ
	 KpuDQ0bMz3eRPrsH5hF8bxUgyVuWDZNiuBNnncLYHSskrhU59hpxcbMAs+U/ORnhX4
	 cFViZ0VLpddZJri4lwfTgaoaq4GFjJGin85kOhI0KI7y7XOJdonF9+NA3m+S/rmAR2
	 epCaae+HjNGigmqsb/lLq2jpIbwTzqpg6XVZFmtN6cCesFNPM5hi66tA7KMBQTlYmr
	 iYkt5jKvntMutcqKZt55xBvRKamuIEdVWHAWSULx5ePb6CUpiIn24DYPseHSvXgE53
	 v8MIH7c1UBflA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 7E3F25F863;
	Wed, 29 Oct 2025 01:08:23 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027125655.793277-1-wens@kernel.org>
References: <20251027125655.793277-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 00/10] allwinner: a523: Enable I2S and
 SPDIF TX
Message-Id: <176167130349.1161173.2622009044232312995.b4-ty@kernel.org>
Date: Wed, 29 Oct 2025 01:08:23 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 27 Oct 2025 20:56:41 +0800, Chen-Yu Tsai wrote:
> This is v2 of my Allwinner A523 family I2S and SPDIF enablement series.
> 
> Changes since v1:
> - Collected tags
> - Dropped clk patches that were merged
> - Added patch for SPDIF pinmux settings that was missing in v1
> - Dropped bogus change to DAI name in SPDIF driver
> - Dropped clk rate message in SPDIF driver
> - Switched my email to kernel.org one
> 
> [...]

Applied to sunxi/dt-for-6.19 in local tree, thanks!

[01/10] dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatibles for A523
        commit: 697fbb43aba6dae48cbe5e1fa0d3023a0b12ab73
[05/10] arm64: dts: allwinner: a523: Add DMA controller device nodes
        commit: 55d43ef77712e3b7fd4c3db5715be1f405afe31e
[06/10] arm64: dts: allwinner: a523: Add device node for SPDIF block
        commit: e51b773798ea1dece229b44854256ec38d35cc41
[07/10] arm64: dts: allwinner: a523: Add device nodes for I2S controllers
        commit: 1fe1e9b67166e304e8c3e46bdd1104519d6d1bd7
[08/10] arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
        commit: a9050236f81c43fc2eaa2e13098c7fb53c3aba34
[09/10] arm64: dts: allwinner: a523: Add SPDIF TX pin on PB and PI pins
        commit: ae0d3f1e6dd2c6404db2fbd7556b93eddd6c87b8

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


