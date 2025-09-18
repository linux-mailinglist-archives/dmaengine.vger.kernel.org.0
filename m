Return-Path: <dmaengine+bounces-6617-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF1B83634
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DDC54E2177
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BA2D7818;
	Thu, 18 Sep 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="EnizF+iZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B49244662;
	Thu, 18 Sep 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181610; cv=none; b=Ws1nclg8Ul49+XWXTCwq0hZC418EHn0X4z9VuzCNMtdBX/9pAtzFiS3WeljbwSmYMK+bKWgzsjpq0tREwSe0C2gbcWhm+v7TDwJXfRJuR7f5JN+kua2MCHXvufR5ioizgcDP9+vd4sr4+dyNuhvf0IiJ6ILjvjkQWTXY66Nyf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181610; c=relaxed/simple;
	bh=w5HW0BpCLTD8OrwMkFN+e0qjESMJICYUfRbSTLJROfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=kvFjRB3tvFPJH4ExQI69tuUICdOmWMgVhDEqKcbNxYHgvolaPtxCkoHdeBvqTiD4pd+tFm4O6edhutPvdmjzS8wcrgQedrY7sw4RFKwMPApTBBWR0NsQoJWedjZZdVbNG0I0hW8tq+8JQY/PH4eVh9TfeUhnNlt5Qc1sAHY4100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=EnizF+iZ; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EF2JvwMr4g7DRklqifcz4XumYYnybiwSa2gvTXwheOk=; b=EnizF+iZQgDygZvrprMPkoxH+r
	bmlHflwK0jotENxOpC+j4GT5fpjYGV7bSahnPc7omgEpiN81PdKt1mCdE6ysDdaMGN1PNSyxhdyC1
	42SyKvyCwz7S0zFtIGSBa3jnLMPg8vXTTEmP3jf94E2zb0uyXjx9WI43ym08l5pW/jrmDZDyjMSuA
	QkUPjvED9VJsMgLOh9onupKMBbfepCFySKnUPSPxhkzaHwPiiF3GzvazkmBnuTDCCCxZQl2RPNcXr
	33zsCn+Q2h+qXdgUVEgKyNA04FzCL7GZU98kg7HplvKxnux4FnODt/Ez8slySQBSU8A+/2wzhg5En
	AY8h4kdQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz97e-000CPT-1u;
	Thu, 18 Sep 2025 09:32:06 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz97d-0009pW-2N;
	Thu, 18 Sep 2025 09:32:06 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 07:32:04 +0000
Message-Id: <DCVR1UNIOUUU.2VF0ODU86VKI2@folker-schwesinger.de>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in interrupt handler
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
 <20250917133609.231316-2-suraj.gupta2@amd.com>
In-Reply-To: <20250917133609.231316-2-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.9/27765/Tue Sep 16 10:26:41 2025)

On Wed Sep 17, 2025 at 3:36 PM CEST, Suraj Gupta wrote:
> Only mark the channel as idle and start new transfers when the active lis=
t
> is actually empty, ensuring proper channel state management and avoiding
> spurious transfer attempts.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct =
Memory Access Engine")

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index a34d8f0ceed8..9f416eae33d0 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1914,8 +1914,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,=
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


