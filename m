Return-Path: <dmaengine+bounces-7559-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA8CB42CE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 23:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE414301EFA1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7702C236B;
	Wed, 10 Dec 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIXY6p8L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A926B2AD;
	Wed, 10 Dec 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407057; cv=none; b=NJL8FjP99Hm7/C4EO6EYpaAzuBl1wHQ4i4ba1PFSggF9F+G6GfApADVQBgno8d8DZjKVPA70zA2AW6ORcrE6z0sNiwj1teobPkn6mvlWrxN8F4u+1KsLrmGY7SXy+LRqY9HpII3h8ushkfAwBfcK7SVpcUM2Ir2dnTO4yFJgSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407057; c=relaxed/simple;
	bh=a2bzuFLMtFhycfladekqoVs0KC0eCxKrtmBPj8wRj2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kh9rDvHOk7Y3351SUMTY9VC2yQmMWbcD4R17pa2AE2vV2a1Q66TGLm38EHprGK3czTJlCJlgAJEE+iHuIiR9qv3g/n4NuHAZO2rBza/x4W/1ux0/M5gFFl9RX1gZcTbVr85tdeVSeb0FShMIJFrmNFvbOAnWZlGTJ0sP5a7YT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIXY6p8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3412EC4CEF1;
	Wed, 10 Dec 2025 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407057;
	bh=a2bzuFLMtFhycfladekqoVs0KC0eCxKrtmBPj8wRj2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DIXY6p8LCPnJLjTXOvDC6QVcMRuMXwOKfkk9G5nBdKrdw12H04e9XOplPEaTYQEQu
	 qN1UMXZoVsxKgTyduWwg/mc9Xz6xSe/NXPVCTOeM7MBf4Y6owfshKbx9t1FeL57Cy2
	 kR1lMy7F3jGcTZ5QGXFtt1cKPpUdFJ+F5FhFZQzN2MQFSHx0dxlPLTtsg+oK8PfHPo
	 ygIXiJGtF+R+PIaIV0xR8XFMAGjFsIbQiKUQV1u1tKlHVML6M48AdG14XCJC/+r2wk
	 h/7D+HK1dFOxpErXp4kNUumDSXqEAKCch1UQ/wQKSOCvunW9qNNdFDOHLE6Zvqj23E
	 X34k775mY3NDw==
Date: Wed, 10 Dec 2025 16:50:55 -0600
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
Subject: Re: [PATCH 2/8] PCI: endpoint: pci-epf-test: use new DMA API to
 simple code
Message-ID: <20251210225055.GA3544934@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-2-53490c5e1e2a@nxp.com>

On Mon, Dec 08, 2025 at 12:09:41PM -0500, Frank Li wrote:
> Using new API dmaengine_prep_slave_single_config() to simple code.

Capitalize and include actual interface:

  PCI: endpoint: pci-epf-test: Use dmaengine_prep_slave_single_config() to simplify code

  Use dmaengine_prep_slave_single_config() to simplify code

