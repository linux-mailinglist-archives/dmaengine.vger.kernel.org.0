Return-Path: <dmaengine+bounces-6766-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9FBBD927
	for <lists+dmaengine@lfdr.de>; Mon, 06 Oct 2025 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13153BA306
	for <lists+dmaengine@lfdr.de>; Mon,  6 Oct 2025 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FBC21E097;
	Mon,  6 Oct 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="f9zENp90"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3121CC44;
	Mon,  6 Oct 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744980; cv=none; b=VeYXw8muIM3LgxlLOCZDwEYuHXPtAWDDtnhQUioT89hw0xVw6ephDkC77rYftmm3OQA5w492oXFYONGQCpQyRZMmh2A/MwzbnqfUQhaPISu7DpqIWDcHx6sQiHQW2HEbWAU5LffsKnBjXLlShOoGp0I1PckPydPTocOk3G5fFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744980; c=relaxed/simple;
	bh=0FL6WtYUZb1+tgbV3+ohwvEsw7jHXmi34lNTpObH3w8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=VMNVmfUUMJpztd8bP+pFuW83ZTzl7kR/bZGJuUuUNWe8+tFnbfJuHQQmLTzrMP9+ElfE0TTcbvQv7iNLGjsKq/jntM8Knv8ekRwOqqm0/kiyciZLV+8O0gk7zSU3EDjhehmVCqhk6im6pZrKDk8U4cFst2Jg9XNzb+SY3wXiw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=f9zENp90; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:From:Cc:
	Subject:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l27ZY3jOmzA73svt5ou/Sjkka4JiXmht+5hbNg1N6UY=; b=f9zENp90moxcJayc9FFYDaxna8
	z++uVAlBT3wd3Qz8uX6WLn3d50t+iYJj09s8tVlq9FtI5q1m28uLJ1jcqsvF7GZkuMOxxygzmdp5P
	cKs3+REhnKfVr1eLOc052GNvLrNtqtL/qE/teQjtLRK8KEpzaw4tgfvbYbVNcsPRh61/QEstI4mjQ
	16pAcLdnGbCeFpbAoOYLvI3V9r7AkK9nD+YdN59D4+CzAhCWapmXzSB9D8tHob888YikW1Ax42dOV
	KiVS/Hq4GXR0I5O5b97QXZWkPBBVSipb3Y9c1Pp0+dkaZSYR82tyFaOLKQD0mbWzQmdYUpKPQ9HBX
	ckdUCZtQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1v5i3V-000CEH-04;
	Mon, 06 Oct 2025 12:02:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1v5i3U-000NRc-14;
	Mon, 06 Oct 2025 12:02:56 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 10:02:56 +0000
Message-Id: <DDB5J5V1IM0E.34WP32K550WIU@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH V2 3/3] dmaengine: xilinx_dma: Optimize control register
 write and channel start logic for AXIDMA and MCDMA in corresponding
 start_transfer()
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
X-Mailer: aerc 0.21.0-9-ga57e783008e9
References: <20251003061910.471575-1-suraj.gupta2@amd.com>
 <20251003061910.471575-4-suraj.gupta2@amd.com>
In-Reply-To: <20251003061910.471575-4-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.9/27780/Thu Oct  2 04:58:32 2025)

On Fri Oct 3, 2025 at 8:19 AM CEST, Suraj Gupta wrote:
> Optimize AXI DMA control register programming by consolidating
> coalesce count and delay configuration into a single register write.
> Previously, the coalesce count was written separately from the delay
> configuration, resulting in two register writes. Combine these into
> one write operation to reduce bus overhead.
> Additionally, avoid redundant channel starts in xilinx_dma_start_transfer=
()
> and xilinx_mcdma_start_transfer() by only calling xilinx_dma_start() when
> the channel is actually idle.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

For the AXIDMA code paths:

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index aa6589e88c5c..a050b06e3b8d 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1561,7 +1561,6 @@ static void xilinx_dma_start_transfer(struct xilinx=
_dma_chan *chan)
>  		reg &=3D ~XILINX_DMA_CR_COALESCE_MAX;
>  		reg |=3D chan->desc_pendingcount <<
>  				  XILINX_DMA_CR_COALESCE_SHIFT;
> -		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  	}
> =20
>  	if (chan->has_sg && list_empty(&chan->active_list))
> @@ -1571,7 +1570,8 @@ static void xilinx_dma_start_transfer(struct xilinx=
_dma_chan *chan)
>  	reg  |=3D chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
>  	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> =20
> -	xilinx_dma_start(chan);
> +	if (chan->idle)
> +		xilinx_dma_start(chan);
> =20
>  	if (chan->err)
>  		return;
> @@ -1660,7 +1660,8 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	reg |=3D XILINX_MCDMA_CR_RUNSTOP_MASK;
>  	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
> =20
> -	xilinx_dma_start(chan);
> +	if (chan->idle)
> +		xilinx_dma_start(chan);
> =20
>  	if (chan->err)
>  		return;


