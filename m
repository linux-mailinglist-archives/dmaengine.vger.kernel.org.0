Return-Path: <dmaengine+bounces-6615-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6481B83542
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FC54A4C5F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB42E8DF3;
	Thu, 18 Sep 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="IegsR67w"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E72DAFA3;
	Thu, 18 Sep 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180849; cv=none; b=izAs6C+l6TfytpXt6Kt9SWb48PPty1qF6MaCd2cBBjZjvuhvQoN7C+Eeet2nkiPknlZddwq1CILY5IDuPq6KcQSEfiKCZmMtMT9ajZySKRnxQ464OZfbcNaXzXOezI+N6ZmiFsOP9gmE6NIqioftIoUIZ7eyDqWU7aWGpNSjAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180849; c=relaxed/simple;
	bh=LR/A2myjErcrF+TvmHD4Vp56qH5epTgq+Ts++mYNmn0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Ib0aiUnGpf/nx+NX9jvjCJWzIED8i56jOF3dl1biK45v3MpZkK/yVoh7dVNO+hw0IxbLRt4VwPCXlQ+tjf4Ki8MCQDmxRcs1nZx9CROujqIkx1HynRKVoutD4rdrZFpeiBrUNAX/ZvjAYenNuVOnPZ7cd/Id2qUOHACdZgsPG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=IegsR67w; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YTiiARvjYDiBVt7M/XCY8cwwyM5K4Ezubm3vBRd2AEY=; b=IegsR67wiIdFsX7vitr1JXNWdC
	VF+EHnF3AQ/2W5TIaqQ3RTDUHhXbEP/D4m6RHSoa4RZhd9WIvxx1AewIf8AvfqeruuG9uDGS7XIFL
	OUSaCosYU6pNCEhaghyv8W5TMPTZSphcP/Z/Iqc5oVaBJzQ+cf4tnexT6rK0tGqqJPc160awgcuGS
	I2L9oWHmh9vAyMm41gjmmpJS3gL9lwR74QI7pDHXF+pnHeDWMblGFlBQvzFTmJ3v3jowcdm+eBk+N
	LM07aW4aYtHEMEcRtLkDnYN28+ACjvVO8KcDYP5IEzqwwX4w1yM9CymriuPgTUvHcuM6qupTMLd2Q
	fkY1Jt7w==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz99Z-000Cqq-1M;
	Thu, 18 Sep 2025 09:34:05 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz99Y-000378-21;
	Thu, 18 Sep 2025 09:34:05 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 07:34:03 +0000
Message-Id: <DCVR3DC53STM.3H636S2IWLLG9@folker-schwesinger.de>
Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Optimize control register
 write and channel start logic in xilinx_dma_start_transfer
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
 <20250917133609.231316-4-suraj.gupta2@amd.com>
In-Reply-To: <20250917133609.231316-4-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.9/27765/Tue Sep 16 10:26:41 2025)

On Wed Sep 17, 2025 at 3:36 PM CEST, Suraj Gupta wrote:
> Optimize AXI DMA control register programming by consolidating
> coalesce count and delay configuration into a single register write.
> Previously, the coalesce count was written separately from the delay
> configuration, resulting in two register writes. Combine these into
> one write operation to reduce bus overhead.
> Additionally, avoid redundant channel starts by only calling
> xilinx_dma_start() when the channel is actually idle.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 7211c394cdca..6e9bf4732ded 100644
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


