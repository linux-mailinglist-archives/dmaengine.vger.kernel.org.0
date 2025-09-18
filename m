Return-Path: <dmaengine+bounces-6614-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC7BB83530
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B906486222
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776792DE715;
	Thu, 18 Sep 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="Stk/9w3l"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5B2D5C7A;
	Thu, 18 Sep 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180793; cv=none; b=skAd9KcHRw8wPU7HLN+6Hnrk/XKJ10bTJEZzUmpPYDWhAx4rRozdryQ5OazAVGRYocJ2ZA0Z16yQBgSki8v9gBC/mjO1CljLKWEGf+LJ9glOrA/98SrzvKJ7+AhRCOsrEIrUPtUgAHB9yvU8kdkCwyDI4DyCiOz0jvzTNYMUa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180793; c=relaxed/simple;
	bh=s8kO2D/phhORU28mmg3rMcQMIBds6gOEs6Y0xAx4y6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Fxrt1Jk5Qs+11fWEpzrCFfXobrQRhjpTlLuBtPFwWAlGGwOueKtEyu0hB7V3A/pVvl86Nv/L/hfQ3lCdmk02wj1rPnNTCSLGlL1oIWD+ZWw4rpOzssCx/duOTf95b6f5hKS98Oun/bzVaGjvDJLWoaAAkIZRw8Bf/8HbW0rOyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=Stk/9w3l; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=R3K1LLY6fBGRnWuhSS18/nnpPKS0286kpzOIjA3aeoY=; b=Stk/9w3lNfCX9C9Rlx5WSX0iT0
	Hb5irJfzHlCwpcb0kqGB3QtTm+TwWsbke0XqYDBBdA2aBmD4Xi4YZNn/PYLduzIq9d93HJzRfwmtO
	RHnJeOwTUWA+yQYXIjy+JdK0wEv2gS+e3Bi0NyK+C/ulh6YeGaSEimdBJy+DC3wJVX+sRwjxrucdZ
	PSn56WlS8AGRstByaIqg0oxPqeQ7rlHjMcAemtZ60OzgbjuL3aPOq1cX4Q1FoQHGyd2/9fdgxo7M0
	e+zgmgaC5v7OSm7kDjlfxj6NcRMhVUx3UFBzQkbpHQlLuZox5FxqE02tl1Qs1Cph8D32ob0Vx5luw
	wYcO+WBg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz98e-000CZU-2L;
	Thu, 18 Sep 2025 09:33:08 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz98d-000JqH-33;
	Thu, 18 Sep 2025 09:33:08 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 07:33:07 +0000
Message-Id: <DCVR2N9GKNCH.2GLNGXYTGLHOX@folker-schwesinger.de>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH 2/3] dmaengine: xilinx_dma: Enable transfer chaining by
 removing idle restriction
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
 <20250917133609.231316-3-suraj.gupta2@amd.com>
In-Reply-To: <20250917133609.231316-3-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.9/27765/Tue Sep 16 10:26:41 2025)

On Wed Sep 17, 2025 at 3:36 PM CEST, Suraj Gupta wrote:
> Remove the restrictive idle check in xilinx_dma_start_transfer() that
> prevented new transfers from being queued when the channel was busy.
> Additionally, only update the CURDESC register when the active list
> is empty to avoid interfering with transfers already in progress.
> When the active list contains transfers, the hardware tail pointer
> extension mechanism handles chaining automatically.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 9f416eae33d0..7211c394cdca 100644
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


