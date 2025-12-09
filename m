Return-Path: <dmaengine+bounces-7542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873FCAF0D3
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 07:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A53301D5A6
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 06:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510E266B6B;
	Tue,  9 Dec 2025 06:38:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B528223DFB;
	Tue,  9 Dec 2025 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765262300; cv=none; b=qFKN2fuPViDr9QPUe8oqb+SfGe2X5OTNr4GIM2cc2zFCT34StLKX244jxFCRwUUjp8+6v9XddfLpnecgTbJ8h67sGicaEa/acnqCAOzR48Hb6yWYwPSbz9HcooE7GybUn3I6l+m7H1TAJBl5eke6EMAJqzC0T8euM77oleOWsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765262300; c=relaxed/simple;
	bh=xzM56ImHaGqlS44dVuPIX6ZJ/sTggxw7Eb2KfxoA8rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSiWRGWmNbucT3jxgyWX03QaAJzS6Bf5UAh04QwgA+9VPTnjIwcvHcf0Q3gTXPt2bv+f9nE6Iz/zu3vGHqIiDEHOm20PUOmKHbihg47WLmojhF2wiw8pP1ZWZ9zIQOrpvx074u0ouu/UJzEIG7IlETo92lA8U5aX01uwnuMKO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1062568AFE; Tue,  9 Dec 2025 07:38:09 +0100 (CET)
Date: Tue, 9 Dec 2025 07:38:09 +0100
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
Subject: Re: [PATCH 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <20251209063809.GA27728@lst.de>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com> <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 08, 2025 at 12:09:40PM -0500, Frank Li wrote:
> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose and
> requires additional locking to ensure both steps complete atomically.
> 
> Add a new API and callback device_prep_slave_sg_config that combines
> configuration and preparation into a single operation. If the configuration
> argument is passed as NULL, fall back to the existing implementation.

Maybe this would be a good time to start retiring the "slave" naming
and come up with shorter names as a win-win situation?


