Return-Path: <dmaengine+bounces-4265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198FA26242
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 19:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E62B1884CDD
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E320E31B;
	Mon,  3 Feb 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch5W8Dy+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436020DD48;
	Mon,  3 Feb 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607083; cv=none; b=m4X/gDG4bGHfUiArNTKUr6NJiYlPgpXpzeHkVD/Gvze7J8MI1yJMDT+27qoc8+Izv5np6hYJC0GnzyuH4uAde1OsqubO8qmo2V5YBQucSp1aia+OuFBjwmCfvYB4nCHCWlg3rGLZKzGfy7hAkT8Om5H+icLtw+wRoVBah+gJWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607083; c=relaxed/simple;
	bh=kS52tnDcHZpqiP8fWjUc+LfmksWcnjQyHD//S3efKYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toCnt6Vu+UaSODtqPUt++W88iVPO+1BKv9qHvY/MB9PrTTeA18EU6GP2lYQXCykFGp9crbQR3hHNjGblKS7KFPWFMBbI5czdr0QLKiok/Bzo5eAFvjPc2AlMzvW7Pfn1Yy6iDbhPzG/dexPB5jrAltbel6dYwYqyg61FOHUQHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch5W8Dy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34AEC4CED2;
	Mon,  3 Feb 2025 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738607083;
	bh=kS52tnDcHZpqiP8fWjUc+LfmksWcnjQyHD//S3efKYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch5W8Dy+SLF9ojLRe9+SL81IEAdmVnDaBKiTKqGuHzdnTMptbW9i2Ac12YbILGmnl
	 BwPBdidWBGhx3jsx1Kk99OBDtbQItBZKGEOn+HngTSGzc5RMD5VQ76rEhub6HtXLsP
	 ygMLY24pZHnGPEWs989pXGDqny8th52xbxTBtCjdyoHCCOhLcRhsGa9kMzNL47IX2n
	 34uHR/JekrS5Ev7xwyfm0VJDQgH8g9BxQeHICKBwbVBI6Mx/SsGSevfvWEcvt67LZZ
	 U65p9ndoLXf/+sIIjA8BjRvoeihJrTjFFVNhEz/ELsvysh3locl7M756BBnaWwMJgw
	 lC6oQJ+gHUnhQ==
Date: Mon, 3 Feb 2025 12:24:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Durai Manickam KR <durai.manickamkr@microchip.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Andrei Simion <andrei.simion@microchip.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4] dt-bindings: dma: convert atmel-dma.txt to YAML
Message-ID: <173860707629.3348340.8749249185300226333.robh@kernel.org>
References: <20250203-test-v4-1-a9ec3eded1c7@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-test-v4-1-a9ec3eded1c7@microchip.com>


On Mon, 03 Feb 2025 11:48:09 +0530, Charan Pedumuru wrote:
> From: Durai Manickam KR <durai.manickamkr@microchip.com>
> 
> Add a description, required properties, appropriate compatibles and
> missing properties like clocks and clock-names which are not defined in
> the text binding for all the SoCs that are supported by microchip.
> Update the text binding name `atmel-dma.txt` to
> `atmel,at91sam9g45-dma.yaml` for the files which reference to
> `atmel-dma.txt`. Drop Tudor name from maintainers.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> ---
> Changes in v4:
> - Modified the description for #dma-cells property.
> - Link to v3: https://lore.kernel.org/r/20250127-test-v3-1-1b5f5b3f64fc@microchip.com
> 
> Changes in v3:
> - Renamed the text binding name `atmel-dma.txt` to
>   `atmel,at91sam9g45-dma.yaml` for the files which reference to
>   `atmel-dma.txt`.
> - Removed `oneOf` and add a blank line in properties.
> - Dropped Tudor name from maintainers.
> - Link to v2: https://lore.kernel.org/r/20250123-dma-v1-1-054f1a77e733@microchip.com
> 
> Changes in v2:
> - Renamed the yaml file to a compatible.
> - Removed `|` and description for common properties.
> - Modified the commit message.
> - Dropped the label for the node in examples.
> - Link to v1: https://lore.kernel.org/all/20240215-dmac-v1-1-8f1c6f031c98@microchip.com
> ---
>  .../bindings/dma/atmel,at91sam9g45-dma.yaml        | 68 ++++++++++++++++++++++
>  .../devicetree/bindings/dma/atmel-dma.txt          | 42 -------------
>  .../devicetree/bindings/misc/atmel-ssc.txt         |  2 +-
>  MAINTAINERS                                        |  2 +-
>  4 files changed, 70 insertions(+), 44 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


