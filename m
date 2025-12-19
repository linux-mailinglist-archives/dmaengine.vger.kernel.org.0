Return-Path: <dmaengine+bounces-7835-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D70CCF6A5
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7F2306502F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07962D7D59;
	Fri, 19 Dec 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbQCkDi+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF722A4F6;
	Fri, 19 Dec 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140474; cv=none; b=DKxTSqEg4wRO9Z9n1vJZFxBB/SETKLN9zru6d/ycVBEsj8zugYYWX+uqx45eDCwNT8EnzO2DTXlV2ILsP3K1Qq6V0YEeKi7ELgKK0DO53DNUeSP7C0uplEDBh4VvbPrDcPpIzMoO9ZcxSuUpYkYrcVrHVGnhHCHVssT4nuuRS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140474; c=relaxed/simple;
	bh=SPRUl0fwxx8jiqVDCFYqIIeOa8rw0a17M2C60HwfJOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9y5ATj3IeBFQe6td14dQMtvNkdnK27H99KyHQ9+tLBBLRZVVezwJ8ZngvpTkA2KDuyKPle2z7+hN5T0c7WQXAG6Md4CZ7kCC+aAUBerLqIVS9h+dq4i3RUHz/t49X0tP7HORcm1pOnWZE1i2wcUFjOOmHayWv6T4B2mf7hRqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbQCkDi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAC7C4CEF1;
	Fri, 19 Dec 2025 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140474;
	bh=SPRUl0fwxx8jiqVDCFYqIIeOa8rw0a17M2C60HwfJOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jbQCkDi+SiwTKv020NgWvoxwzYzEONj66gaT7jH/WIt5dueq62sRmSRfSnXKy0ppP
	 wbtfJwnEOYIX+xm1UbPrmqqmZt8XYIKN47DWOjBzEu+Ki6WTVL+2KYoHfZ29Q2dD5v
	 cv6VAul5T6Jq/mIAKGQtU/MLmEyZBJFt9lPu1mNOq6mGbbu3EgFkxg5mT9AC95tab1
	 87nogYLfOfLZ/p3idrWg/DvSk515LSmGKHT7e53LnLk25R3dVzMs/J6R45XxDY7DnZ
	 eBxx7NiPTRNJiWFJf1k/UcMw2erdX3pIbb7Z6NuBc3HCIzg1fRxMHBimADkO9B2g8r
	 kT5+FXcefUX1w==
Message-ID: <bb3a60d6-8503-4990-bdf7-7e14b13bddff@kernel.org>
Date: Fri, 19 Dec 2025 19:34:30 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
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
 <20251218-dma_prep_config-v2-2-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-2-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 00:56, Frank Li wrote:
> Use dmaenigne_prep_config_single() to simplify code.
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

