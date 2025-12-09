Return-Path: <dmaengine+bounces-7543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDFCAF0D9
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 07:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4A7301B80B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6026E17F;
	Tue,  9 Dec 2025 06:39:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E27266B6B;
	Tue,  9 Dec 2025 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765262341; cv=none; b=ka9Fd/uHYRHptrcHjJylllrnpq9KTQDbNex/wiVsRSn3zCCHXyI/F8G/i9CYd1mW3CZU6e+MO5gJM6qHtXi6DuDaPysvUfunwJzPnMJttFQ27xbdBIS2O4epNIs2RqpYleGTqI6+06hn3p+bvVbYNrJIDjpEcFf1KX17PcSW2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765262341; c=relaxed/simple;
	bh=B9RSKhfm6Al4b3wh3fYU2Ycm1AXnKH0+iYj3pAhZ7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSe2F99cgeqGUI74E2HhiTqs3F+RLn1OLfTAGKBwE90fqssSmnxEsdOAiVlPtKMpk+1TcKPc/qONXSsczfWOMUi2AqqiLu6GzVpLIsPfaM/LqqFCJ/6NskslYEH1vOI8PcJ4CNih1SN7gdMYkcFKe+NTlA0+udiTjV/wZJHCNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54A7C68AFE; Tue,  9 Dec 2025 07:38:56 +0100 (CET)
Date: Tue, 9 Dec 2025 07:38:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <20251209063855.GB27728@lst.de>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com> <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
> +						  sconf.direction,
> +						  DMA_CTRL_ACK,
> +						  &sconf);


If you stick to tab-indents this becomes a lot more readable:

	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
			sconf.direction, DMA_CTRL_ACK, &sconf);

