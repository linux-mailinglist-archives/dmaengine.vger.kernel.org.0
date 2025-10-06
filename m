Return-Path: <dmaengine+bounces-6767-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6CBBDA39
	for <lists+dmaengine@lfdr.de>; Mon, 06 Oct 2025 12:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B10189683D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Oct 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61822172C;
	Mon,  6 Oct 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="U1YWadyo"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542292046BA;
	Mon,  6 Oct 2025 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745620; cv=none; b=qlbmNUaKFmoxSdFxopZ/MLcl6ysfXoFOlxtjnod7DANsBZQDOf7dWAccUbCP3yBVyi+9ZTcoFOyqsXAAK/Otx6xFNzgccZFhjsQlRIt/d82GRAQQy5iDR6xx3XoY+lL3p/PL4XKP2vILUwkeE61k0AOPDFlY0N6fZjiLKCkySSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745620; c=relaxed/simple;
	bh=PHbc21kaTsr/iK9wGPsPvZQ0ScdAEYoydb2YAlePOy0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=LXH+iTK1vohIYKvwOnmraHyigfZScBLL9m7r4TM/H4YdN55fK4W09wVRZFfxVDuXXUibr+7rvsfRsMcR4kBMLeCcJxOXByL9BUZgMi6wL72jSOVUbar+xJqA5yKJSgwaC1Jnv5kjL9L+3LL0l2x36BC8tQKSiTrqbYktifBhrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=U1YWadyo; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=M2+AdvJEarXyjOc4kgwr0OGK2UDYTIAIMd4EPnbaUnk=; b=U1YWadyoifm7mM0YGP+poyHkVT
	CQzuj1ezWhJjFCvgKBX1PwHo868THq65o/dt6vLLvzRFg2k6Jn6tDtGPDi9Tby22L4H0ckzeOGtsA
	i5Kd6FAj9HxgLJbEl6aRrXZuEe6eHkYk3yXKFCWhl03Ohq0frjynbbsSvf5ziD0FyDxA6wYshycOD
	AQxfENVX39WT8yQK9d4Ob2Zc9jpk3AdH8u1MU9bfO8xHMdAxNTWBJubJLwiG8mveJre2JAmn9vtZ+
	crg7vQFCJ7cKctWs5RGjOPfg3IMbL/p+DS2rer5t2erLusdoVmlpmDU6RufiywivdEr1EC66Ev8gY
	Sm0alTnQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1v5i2V-000C3T-0E;
	Mon, 06 Oct 2025 12:01:55 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1v5i2U-000EoX-1D;
	Mon, 06 Oct 2025 12:01:54 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 10:01:54 +0000
Message-Id: <DDB5IDDEOVBT.NHJF03FYW2BN@folker-schwesinger.de>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH V2 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in AXIDMA and MCDMA interrupt handlers
X-Mailer: aerc 0.21.0-9-ga57e783008e9
References: <20251003061910.471575-1-suraj.gupta2@amd.com>
 <20251003061910.471575-2-suraj.gupta2@amd.com>
In-Reply-To: <20251003061910.471575-2-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.9/27780/Thu Oct  2 04:58:32 2025)

On Fri Oct 3, 2025 at 8:19 AM CEST, Suraj Gupta wrote:
> Fix a race condition in AXIDMA and MCDMA irq handlers where the channel
> could be incorrectly marked as idle and attempt spurious transfers when
> descriptors are still being processed.
>
> The issue occurs when:
> 1. Multiple descriptors are queued and active.
> 2. An interrupt fires after completing some descriptors.
> 3. xilinx_dma_complete_descriptor() moves completed descriptors to
> done_list.
> 4. Channel is marked idle and start_transfer() is called even though
>    active_list still contains unprocessed descriptors.
> 5. This leads to premature transfer attempts and potential descriptor
>    corruption or missed completions.
>
> Only mark the channel as idle and start new transfers when the active lis=
t
> is actually empty, ensuring proper channel state management and avoiding
> spurious transfer attempts.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct =
Memory Access Engine")

For the AXIDMA code paths:

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index fabff602065f..53b82ddad007 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1857,8 +1857,10 @@ static irqreturn_t xilinx_mcdma_irq_handler(int ir=
q, void *data)
>  	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> -		chan->idle =3D true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle =3D true;
> +			chan->start_transfer(chan);
> +		}
>  		spin_unlock(&chan->lock);
>  	}
> =20
> @@ -1914,8 +1916,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,=
 void *data)
>  		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> -		chan->idle =3D true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle =3D true;
> +			chan->start_transfer(chan);
> +		}
>  		spin_unlock(&chan->lock);
>  	}
> =20


