Return-Path: <dmaengine+bounces-7560-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B56BACB42E9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 23:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9740301DB9A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7D2E1C65;
	Wed, 10 Dec 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnLYbnHS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513731AC44D;
	Wed, 10 Dec 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407207; cv=none; b=CSfhtmpXY/yKRo3uDi4fCil2kBU1UUM3JHaBQk5AjXbpPYBIphHn+CbiDboskm2RSPSwLtWRU4rXKvK0/aOZxcjMQ3GljA1UaXKShybQ+Xud8LQbZgsC5hS4dcgHh0VW6duiATMS2a8Q+p0iHVgiVpthl48rZNhbTmz547xh8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407207; c=relaxed/simple;
	bh=2uTNjBtdgRM2/ASK6piQyYjDXg3OsyxobRphNNNCmm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LaHSfneU0bqAjYcB4NNE4+blOS1/3doKuw9/QcdJCpePJyAwIVzFUnH4XBRenzW4o2ri6xzyw/YOxwvroHqZDqYRQlvJlkYvAnPeKItSyUGLlSlYchH2bnX4Pr1oUlTennVtaMgdRozwQ9nNAAg4zc6bIWfNKpcLxnK+1EQRvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnLYbnHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5540C4CEF1;
	Wed, 10 Dec 2025 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407207;
	bh=2uTNjBtdgRM2/ASK6piQyYjDXg3OsyxobRphNNNCmm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hnLYbnHSg+o17LZIPAr9wi4HEVVi+KKQ3Z5BmUn8PH/y7Y3UHYbT7DzEN2DYEsQPF
	 tzlBZICrTOgdp2JO79cHYdonJi4+dC+yv9PPX4NTzH6eu9JqOKKtBAy5R3h9tgunpB
	 8PuH/Gc2TdPBzMLzBQCGv4iFsGYBqJ7M7ixbvPXJYIhgB008rosCj2KnuGe3qP2zeQ
	 hEyu9flYvHM7fFk9/wFHsUYsnT+8lbPqmc+6gLni1Zogeb/+GZ+qGRRRrseEQWcW+K
	 vviGe5IsC21Q4Vg/nVx067S3a/QDZ6q/4wDG9XrC0+YvxVMZnePuHgY39J80WxWwIx
	 5yv715g1nM33w==
Date: Wed, 10 Dec 2025 16:53:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 7/8] PCI: epf-mhi:Using new API
 dmaengine_prep_slave_single_config() to simple code.
Message-ID: <20251210225325.GA3545039@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-7-53490c5e1e2a@nxp.com>

On Mon, Dec 08, 2025 at 12:09:46PM -0500, Frank Li wrote:

Add space, include actual interface, add commit log:

  PCI: epf-mhi: Use dmaengine_prep_slave_single_config() to simplify code

  Use dmaengine_prep_slave_single_config() to simplify
  pci_epf_mhi_edma_read(), pci_epf_mhi_edma_write(), etc.

