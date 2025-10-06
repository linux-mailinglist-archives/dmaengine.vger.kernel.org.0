Return-Path: <dmaengine+bounces-6765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F1BBD912
	for <lists+dmaengine@lfdr.de>; Mon, 06 Oct 2025 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558F54EB1B8
	for <lists+dmaengine@lfdr.de>; Mon,  6 Oct 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0A21CC55;
	Mon,  6 Oct 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="UANFUV7g"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812041F582F;
	Mon,  6 Oct 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744951; cv=none; b=WmnB0wDIBcfPeHGwuGXIPl8Aq5aBc++4+QYlatk6azaldvn2s/PLlBg+GLGBpcjDuZGLUgjQqySsnOFwuK9owQu6x/tPVGdT95TxPD4f7cYk7EDvDb+XogczUcX6ZfTPMY5iMDXKs1wGpLY7Vz9q6KDHCj5kFAwnVGEbLcxB6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744951; c=relaxed/simple;
	bh=m29i96uh/xiGYdZ0vbXJuC83PCGpaWlP8r7xpff7lS4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=qa6jDiky+N2sovikLCksqbM3E0yWLLh/dO7unobWsX/JMr/mYxePuRTKrzevjPH9f3RUFgOB4VmF6IbJofffH6XQB1TJ7v6Lj1+QVVtHExr+8Vpwefrn/pXotYWT3V117FeRv6a6u2QIKjGXCxiLbwTrFB9A50TgQkTaHspmhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=UANFUV7g; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Pql4+9iK9J1XaKoIrXXTTeztSOhZE9LK27gYUKOWcpE=; b=UANFUV7g7tFGhEFjVRG2vRTT4N
	3pY0kdNdD6jylPU50cpNI0Q6ck49OVFOCZDG3vQvmhroX1M9wPej5JTdhCoa187Td4SeRJi2tulqK
	c6gczvH798FDnWwnQ1/4MkCkr5nd+A1Kh7KuCYKM5wi5lwy1k/KUlHBdTkUXg2OgZcUSz0l56zmM7
	RSBHep31kex3V9AJUv170mXqIJmpQbKqrTv/puP3k9cVMiKYjNhGn7XLzDmGNd/iaPWWoL5MzHrrm
	00hNoyPZ/XQVhEjWhXfChj9yZs5y2rbFmau8WqeBGI7ElcBUpSiFEa4QKETlKAyyNwvoImIBCqjjz
	mbwPRERA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1v5i30-000C8q-1J;
	Mon, 06 Oct 2025 12:02:26 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1v5i2z-000JYp-2I;
	Mon, 06 Oct 2025 12:02:26 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 10:02:25 +0000
Message-Id: <DDB5IRSNB09F.3HRTZZOZQ7J6@folker-schwesinger.de>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH V2 2/3] dmaengine: xilinx_dma: Enable transfer chaining
 for AXIDMA and MCDMA by removing idle restriction
X-Mailer: aerc 0.21.0-9-ga57e783008e9
References: <20251003061910.471575-1-suraj.gupta2@amd.com>
 <20251003061910.471575-3-suraj.gupta2@amd.com>
In-Reply-To: <20251003061910.471575-3-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.9/27780/Thu Oct  2 04:58:32 2025)

On Fri Oct 3, 2025 at 8:19 AM CEST, Suraj Gupta wrote:
> Remove the restrictive idle check in xilinx_dma_start_transfer() and
> xilinx_mcdma_start_transfer() that prevented new transfers from being
> queued when the channel was busy.
> Additionally, only update the CURDESC register when the channel is
> running in scatter-gather mode and active list is empty to avoid
> interfering with transfers already in progress. When the active list
> contains transfers, the hardware tail pointer extension mechanism
> handles chaining automatically.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

For the AXIDMA code paths:

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 53b82ddad007..aa6589e88c5c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct xilinx=
_dma_chan *chan)
>  	if (list_empty(&chan->pending_list))
>  		return;
> =20
> -	if (!chan->idle)
> -		return;
> -
>  	head_desc =3D list_first_entry(&chan->pending_list,
>  				     struct xilinx_dma_tx_descriptor, node);
>  	tail_desc =3D list_last_entry(&chan->pending_list,
> @@ -1567,7 +1564,7 @@ static void xilinx_dma_start_transfer(struct xilinx=
_dma_chan *chan)
>  		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  	}
> =20
> -	if (chan->has_sg)
> +	if (chan->has_sg && list_empty(&chan->active_list))
>  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>  			     head_desc->async_tx.phys);
>  	reg  &=3D ~XILINX_DMA_CR_DELAY_MAX;
> @@ -1627,9 +1624,6 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	if (chan->err)
>  		return;
> =20
> -	if (!chan->idle)
> -		return;
> -
>  	if (list_empty(&chan->pending_list))
>  		return;
> =20
> @@ -1652,8 +1646,9 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
> =20
>  	/* Program current descriptor */
> -	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> -		     head_desc->async_tx.phys);
> +	if (chan->has_sg && list_empty(&chan->active_list))
> +		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> +			     head_desc->async_tx.phys);
> =20
>  	/* Program channel enable register */
>  	reg =3D dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);


