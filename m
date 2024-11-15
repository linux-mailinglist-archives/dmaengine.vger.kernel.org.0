Return-Path: <dmaengine+bounces-3739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB89CDF9A
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 14:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C48283D33
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247331BD50C;
	Fri, 15 Nov 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="j4+bHq7J"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9A190056;
	Fri, 15 Nov 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676227; cv=none; b=rD0/JwrGtzrCrd7HZSJaDNwSPbjn2/VmcWa+4yqs1BVYzXMRlJz09zk93cJuCs2MgcYwIJjPJpQfld26ta2MX4gBy/1H9gkM6s4frlaqjkzPfPOv6Mcx1fB32/WxgxwB1+B9Qj6F1vv9/wtkCS6w8OPKIUatY0yz7kuAbbBYYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676227; c=relaxed/simple;
	bh=343ybbpmX5iksSzKM9ypRjU5swcB42IuW585AnKWbe0=;
	h=Message-ID:Date:MIME-Version:Subject:CC:References:To:From:
	 In-Reply-To:Content-Type; b=IhDZgasjTKGiBUloskkL61ngPu2FBYWoSHsK4yMhfYp4eFjooMEWamUu08kGoA8Umz1rzWzoLZScI4czdUvvyDL/fXbTRD/Fy9vNGvJO+fJ/w2NFHbR6T7hWrsIh9XD+NdWKf2+F8eZr0C74AyoSv6l6gBtcTLrFUYaKd8x+ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=j4+bHq7J; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 17A1FA0796;
	Fri, 15 Nov 2024 14:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gL17cNe8aUMuYGVpdJHN
	MdCT/ltALl3FTv9dzom/v2g=; b=j4+bHq7Jo+dhNWLyZXAaJT5+Ai6ztopDA46K
	mkzikFbuuvIc6qdTZrRQbXuVCk1FvlKJc3MdFcBNm1upXpxy38ILmDztpH3XAhJV
	OdhBXl4zlnJANOedHrj2Zg6KsagE9WnyTACOZ+h0tsJWB0IRHLzZljG5fooOsTRW
	09mZOvvtiHxzWBoiHUbS+0YLHQSRNbBlE+dBSkXH9fTqXk9KeGP2eZioVGZZ71VL
	EMqYLSycdJGtS5/KvrE0Z8XUHKj1E4dsg8YBYSLGLPGSnUso8CdjseM2FqTmQ0U2
	zw0r6+7U3hgDnKvVXCFZzMee3E/KknkgoVPI9+4f36twRV/rS6mTf8Vyi8hePYkW
	AfZWOeQOpQ94I/lNgPUvArwxYecB8oZgxlNM/HS3khczmjeid1H32Ey+8KExdtRL
	8m1Bj/NS95HaPBNHHS0spB7pAH297hrqhQPoFYI62K6eEQKHRY30sfN2AX72PK4K
	Z9xJ7A02LODEwkl6K3eQ4sgdKBY1ihsgDkWUKkyE6/qNmjuBDCJgPFSh9C0L+fFP
	AvdN+vSU8H5t9bGp14aHPhw6GoaZtprZDZn3Z06IFOtPkr2NIyrg0F46BPHUHNc4
	u9AMe2XzOGxi9t3i3FREaD/x/ZQqtifxivIHt5Y8NTgdN5D/z1JIyWsxerkVrTL8
	Q/3Ish8=
Message-ID: <f1d3f71d-2e36-4ff2-9487-8494e7241c31@prolan.hu>
Date: Fri, 15 Nov 2024 14:10:14 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for DMA of F1C100s
CC: Mark Brown <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Chen-Yu
 Tsai" <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Conor Dooley <conor.dooley@microchip.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Amit Singh Tomar <amitsinght@marvell.com>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
Content-Language: en-US
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241102093140.2625230-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855617C6B

Can this be merged? The merge window is coming up, and there's still the 
other half of the series waiting on this.
Bence

On 2024. 11. 02. 10:31, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit c2ee9f594da8 ("KVM: selftests: Fix build on on non-x86 architectures")
> 
> Link: https://lore.kernel.org/all/cover.1543782328.git.mesihkilinc@gmail.com/
> 
> As requested by many, this series will now be split in 2, the DMA and the
> ALSA/ASoC codec driver. This is the DMA part of the series.
> 
> Csókás, Bence (1):
>    dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
> 
> Mesih Kilinc (4):
>    dma-engine: sun4i: Add a quirk to support different chips
>    dma-engine: sun4i: Add has_reset option to quirk
>    dma-engine: sun4i: Add support for Allwinner suniv F1C100s
>    ARM: dts: suniv: f1c100s: Add support for DMA
> 
>   .../bindings/dma/allwinner,sun4i-a10-dma.yaml |   4 +-
>   .../arm/boot/dts/allwinner/suniv-f1c100s.dtsi |  10 +
>   drivers/dma/Kconfig                           |   4 +-
>   drivers/dma/sun4i-dma.c                       | 217 +++++++++++++++---
>   4 files changed, 200 insertions(+), 35 deletions(-)
> 


