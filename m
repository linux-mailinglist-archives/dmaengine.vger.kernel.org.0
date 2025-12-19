Return-Path: <dmaengine+bounces-7836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B026ECCF6BA
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6225930E3956
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46EF2EBB84;
	Fri, 19 Dec 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQe/v+sR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A572E229F;
	Fri, 19 Dec 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140527; cv=none; b=TqCT2aBm1nWpakie4CmLHdZhB1lXFZXQ1IEjECIIKzy6htymXQH47pj/wdeUZvy2gGwK5IWEhrZp4oJLlFlgayyogafKWc5E582ZIi5UDqNIIeWfi0hceGnhgTlPItEb94EeEzAfC5xUre+lzWAFu7u77dawceF/xuPYVArq9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140527; c=relaxed/simple;
	bh=42xsPFIBt7s6uJmGcvjTi6dEM713cKqiD0X2WgnoWSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgwsqWnE8LHoKaZIchSF18ffS/xRPswVLYyO7tqW3O6MSREX6Va9BDbSwpQcuY849clegopWmYXwZuviCtuJ8bvQH/dQyGvcKCpYnuoJhMNJ/0iZI5rBChq+lTkN879586R+VmX4DAjKMgdxNhDaVaZ5hOLAtPcHnp0GxjjcM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQe/v+sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBB9C4CEF1;
	Fri, 19 Dec 2025 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140527;
	bh=42xsPFIBt7s6uJmGcvjTi6dEM713cKqiD0X2WgnoWSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iQe/v+sRIsVtiWEaDXcR0GAO8tWvy6YrF1JcUtjLroBXKbQsoQPU/WCnvDBoHZDdW
	 QBBDHo4ycl7vrOsym9hKeSK1/b5kWZYMDXzZJGlyn0+NA+0TJYpe3nrKikMtuH1LEf
	 Sf8nresz9hWF8dv0+wdtI5SmSMyZJZck8It3Q7OSm1SUcY7Vp3xJvIreNEWiLc1fuE
	 moU3Rz2gqS70gfaZF1Ry3pi3qHv3irZNH07CLqixX7AKla+PZS0qjeLwGxCpcE8rJG
	 D5JBTpAw937t3JorQBFiSwTfqNLsxLjItDldlV4mXGMgUi/sG2dPQBp9Hngma8es15
	 P29peXidh5bVw==
Message-ID: <69a9daf3-0439-4b6c-bc12-1b0ea7f01fba@kernel.org>
Date: Fri, 19 Dec 2025 19:35:22 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
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
 <20251218-dma_prep_config-v2-3-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-3-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 00:56, Frank Li wrote:
> Use the new .device_prep_config_sg() callback to combine configuration and
> descriptor preparation.
> 
> No functional changes.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

