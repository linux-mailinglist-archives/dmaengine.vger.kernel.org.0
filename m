Return-Path: <dmaengine+bounces-3414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D6C9AB9B0
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43C7B21998
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 22:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C01CDFA4;
	Tue, 22 Oct 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="BoaNCIs5"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271511CCEE9;
	Tue, 22 Oct 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637543; cv=none; b=r9MisWzM217L04JgWxpe9fBn6OScQDOMxTyLv7pqRYrccIbmMtEMWYcdD/37tldC4bCsT0hR4B2lCdCNuDezKQ+HIxByLQP9ogE9phtcBjC7rDfSI4ljFhfzFilzKibVsvK0zFppNMj5y25HHHK8Sb+vICVg+iraOejTzG++Nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637543; c=relaxed/simple;
	bh=VQrpKREvli+uQgQBCCF3h70saTVIC9tipcVecmoLowE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YdPKh8B8oFrUE2eC5dljoaft+vQFsDbkVUYRN9ZdUML8EM2yMkB8kPgW1U+UugVQn5x6PM70/Kh8zVtbQJKrg/8MV1nAhCiwSQTr2/uOlv4Xgz9XKNnQfIbFoyym/tkb0bqIGSpKBsqR3AKNXZKTuJ61MD8n+TxpMPGJktWiQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=BoaNCIs5; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 29A1FA041A;
	Wed, 23 Oct 2024 00:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=o+6vI2iAgKwV5VmRn04r
	SP3ACb8gAm2vQTCmx1chAik=; b=BoaNCIs57WLzSNjaN7xZCnp7eLPFowP0lhHI
	gpCRAKZXPRuckip+Zd4PAOqzwHsmqjtG4H2fFD2qav4fmhRq7dVSyH5dDCSk4/8x
	aJ9kIcbDy3znhJMP6pMZFId4VXiN0rpfruigA1QFFacwvzgZ5bpRXPPU9cxEAhrB
	erbkMLR+41QoxlXhJymEReKtienr8fO1WZHxq9Fg3oYnTuSbrsuqKIkOPHB6eRaR
	wr04IJ5gI8R0wXXT4d+fyzeKPk05uDwnoXl3rF6GAwhKExRrnb85gAcmq1kfU2ct
	LxLrDauM3hvmYzxvux3g3rwVBNd5YG2muq8dyI2pJYnaWgPl15tiIDpRomvI1AMd
	9b7N3fqxU03kaQfaMVzzedeRCf7fNgpOP2UQkIiA2NjVE/nJJ4GPDOkkOysMV+ch
	jLe1YHJrLYSKNFL21LMPB8vr9aU5RHIVVLjAmT6d7BNHgH9i+oecT/05ceATdC2N
	HWWlTrNeFbQh4L/IqKWB64zzTu3okcNkMVCBfAjUBufsyfhb8h6I/Trj3Ph0LdW+
	h7X7nbo6RDyTFON0mb5gv7ALxMDWPsW76ZEQGO9AHJosIQLpOitrFyUAHh6VNmfU
	wZHMSUGzr7sCoeRPsLIyEr7jDXrqVlPqO4jGmXTOlaizEli8yOaPnYiocONuQR7e
	ZWnI2YI=
Message-ID: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
Date: Wed, 23 Oct 2024 00:52:06 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] Add support for DMA and audio codec of F1C100s
To: Mesih Kilinc <mesihkilinc@gmail.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-sunxi@googlegroups.com>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677163

Hi,
I was trying to get audio on the F1C200s, but so far had no luck, and I 
came across this series.

On 2018. 12. 02. 22:23, Mesih Kilinc wrote:
> This is RFC patchset for Allwinner suniv F1C100s to support DMA and
> audio codec.
> 
> Allwinner F1C100s has a audio codec that has necessary digital and
> analog parts. It has r-l headphone output and microphone, line, r-l
> FM inputs. ADC can capture any inputs and also output channels via mux.
> Any input channels or DAC samples can feed output channels.
> 
> Add support for this audio codec.
> 
> F1C100s utilizes DMA channels to send and receive ADC-DAC samples. So
> DMA support needed. Patch 1~5 adds support for DMA. Suniv F1C100s has
> very similar DMA to sun4i. But there is some dissimilarities also.
> Suniv features a DMA reset bit in clock  control unit. It has smaller
> number of DMA channels. Several registers has different addresses.
> It's max burst size is 4 instead of 8. Also DMA endpoint numbers are
> different.
> 
> Patch 6 adds DMA max burst option to sun4i-codec.
> 
> Patch 7~8 Add support for suniv F1C100s audio codec.
> 
> Patch 9 adds audio codec to suniv-f1c100s.dtsi
> 
> Patch 10 adds audio codec support to Lichee Pi Nano board.
>   
> Thanks!
> 
> Mesih Kilinc (10):
>    dma-engine: sun4i: Add a quirk to support different chips
>    dma-engine: sun4i: Add has_reset option to quirk
>    dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
>    dma-engine: sun4i: Add support for Allwinner suniv F1C100s
>    ARM: dts: suniv: f1c100s: Add support for DMA
>    ASoC: sun4i-codec: Add DMA Max Burst field
>    dt-bindigs: sound: Add Allwinner suniv F1C100s Audio Codec
>    ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
>    ARM: dts: suniv: f1c100s: Add support for Audio Codec
>    ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
> 
>   .../devicetree/bindings/dma/sun4i-dma.txt          |   4 +-
>   .../devicetree/bindings/sound/sun4i-codec.txt      |   5 +
>   arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |   8 +
>   arch/arm/boot/dts/suniv-f1c100s.dtsi               |  25 ++
>   drivers/dma/Kconfig                                |   4 +-
>   drivers/dma/sun4i-dma.c                            | 221 ++++++++++--
>   sound/soc/sunxi/sun4i-codec.c                      | 371 ++++++++++++++++++++-
>   7 files changed, 601 insertions(+), 37 deletions(-)

What's the status of this series? I see that it was not merged, despite 
getting a few ACKs and only a few minor comments. Ripard's comments make 
me believe that the sun4i DMA driver should be able to handle the suniv 
family with minimal adjustments, have those not been added? Or is it 
that the DMA support is ready but the ALSA/ASoC support is missing?

Bence


