Return-Path: <dmaengine+bounces-8212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AACD12A98
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 14:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9477F3010D69
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A9357732;
	Mon, 12 Jan 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXpL3ocf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F435770E;
	Mon, 12 Jan 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222899; cv=none; b=XjMf3zzwUAoaEq8JhDDQ0alMmbjxwcyl4LInXYi5/OBScnvGIKx/OIGRMvWn3e4cduHd0jtsljq+TCbW/CQAaIsBEpmfQDBYf8LHuStz2HYb3px49Uwz81E5kDyFN8HRcrKIXKoyv6yWsTSMwE07qTo5ME9VTVe8vuyhrRvLM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222899; c=relaxed/simple;
	bh=WLtpL3iiLHc+bo5wxz2Ay2u3w3qNsN2rTz0oFg1Enb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhC1x4UgYV5IkyeuWv4P19mf6jWl5aqr3qfDF9dqqBsmwr6XB/AHth30A4t+Q0i54u6mnbJDuGiPQa4yezjsWT4cODAS+2mRuyL0ObktO75fZZEA4YF97NHuCirMNY4n+5jhSgRN8LD3GI1fEX6zxE8z0Mrc44UIQLA5reAdZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXpL3ocf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2987C19422;
	Mon, 12 Jan 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222899;
	bh=WLtpL3iiLHc+bo5wxz2Ay2u3w3qNsN2rTz0oFg1Enb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXpL3ocfh373K5bNXWgVfNocnwtPg11QneBpqIT66SgmmZ/6+awvuRRAs6hTWn3Iq
	 bcl9sVDzTDUlH58n7OTWA7Ow5zH/zTAidmSunr1zSCV7wYLQ6IuEpHb1q50qGePdf/
	 PAhA4LZm8r4xFIuS2KE+Ngg9rjsPTcO2qGiQXm+GwTe17ykNXaZGF5UZzQJLYgf+xD
	 BPDMm+HMpYRLY0M9QmCK6sJM+ACJnMQ0KQyXmq2N5t91Gcbl0TWXezGTixppahR1vh
	 vJ5SiF+P4EuQP4AruPe8Gy2Byg9B6EUPJJ2EtOAoKb4j4WrHjKfzutdV+iRJD1El6U
	 X3sv697FjFtzg==
Date: Mon, 12 Jan 2026 14:01:32 +0100
From: Niklas Cassel <cassel@kernel.org>
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
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aWTwrOOXX3AR8Ght@ryzen>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>

Frank,

Thanks a lot for your work on this series!

On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
>  Documentation/driver-api/dmaengine/client.rst |   9 ++
>  drivers/crypto/atmel-aes.c                    |  10 +--
>  drivers/dma/dmaengine.c                       |   3 +
>  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
>  drivers/nvme/target/pci-epf.c                 |  21 ++---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
>  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
>  8 files changed, 177 insertions(+), 84 deletions(-)

Is the plan to merge this series via the dmaengine tree?

If so, we might need an Ack from Mani on the pci-epf-mhi.c and
pci-epf-test.c patch.

Likewise we might need an Ack from Keith/Christoph on the
drivers/nvme/target/pci-epf.c patches.


Kind regards,
Niklas

