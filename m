Return-Path: <dmaengine+bounces-7838-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11122CCF702
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11FE8301BE94
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11E2D97B4;
	Fri, 19 Dec 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTyqXLh+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB523314B;
	Fri, 19 Dec 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140738; cv=none; b=C6YwDeuYwx6VVQm8pNmV0rwhA9WP7vyyCK8jqQyxPaROsT+SKHKgXKoghD5pAAJiOJG5EICQxtmj1kOG8Qc1oCQyDXQylktjFOiO65klWoLRFpWK/jYRRUstAxDw9Jk1Nf0ft9cJHnDCyMhtPTSi9kuyykbdy+bHva1vvUglSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140738; c=relaxed/simple;
	bh=JojbryuXzuZwBViUbKuSYpD99u7Ev05B8Sqdbjq3JeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2MfcGGvoVepdwqVvrYyesiYdntRLVv7Jzs1rXVT5jl0H27TShF32r/3Z+wTRW7SW7EKnRJP9fYEA+dzkHS27UyHKWrOokpnwTniLBizfhXPay3KwY+Pw02UQD55bAk3+yNc4SJhWP0HYguf9xTikQcrUIWaGVxlIxZ/kx2uIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTyqXLh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A87C4CEF1;
	Fri, 19 Dec 2025 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140738;
	bh=JojbryuXzuZwBViUbKuSYpD99u7Ev05B8Sqdbjq3JeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RTyqXLh+pnMEDRL7QCn4ZVL5I48+KSFBkbfWLELWPIeGp5NlOGtMixn93HSyIUib1
	 VsXEFv6pp43x4ac+Ik1lR16wRZoTgERZyNybDBDrEdsksBKON8ZwHK+UjmvsqQ25Up
	 NicNvwtPw0uXTVVnF0tvXLWxU5N3EIikmt2XlOs9WCGgKeBy8C+XM1a4f21WmaW1HL
	 kzCa3N6gEjcuqriwV5jf2V1IrftSL6eodz2qshTNJlzsNkvBQ5/UsbP/PLEv2/8tA7
	 EOzMcZBtd8f5GjqLWa87NigJQdEnNa79jA6TIcgqP3qKIinOEECXzZvvyhNjrmtPrq
	 cgX4J/3C22GhA==
Message-ID: <8d4ae6b3-096a-4e12-8fa8-abaad2e953ad@kernel.org>
Date: Fri, 19 Dec 2025 19:38:53 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-5-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-5-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 00:56, Frank Li wrote:
> dmaengine_terminate_sync() cancels all pending requests. Calling it for
> every DMA transfer is unnecessary and counterproductive. This function is
> generally intended for cleanup paths such as module removal, device close,
> or unbind operations.
> 
> Remove the redundant calls for success path and keep it only at error path.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

