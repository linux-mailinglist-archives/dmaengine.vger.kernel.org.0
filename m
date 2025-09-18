Return-Path: <dmaengine+bounces-6616-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB18B8355D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D931C26C79
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCACB2EA493;
	Thu, 18 Sep 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="NU0u7pVj"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8902E41E;
	Thu, 18 Sep 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181021; cv=none; b=J7vYVMLsf0s0k9kBI8Jz41vnRUlNx58kmgGe1d7rdz00j9DbV+MGoDIUd+r6e8xu7z4k2gQdKVcPOzz0JoSqX1DTMfEFizKM0EC9feuKvXlRVh07Rs+Sx6LI40VsEo4GYCEwe1Vcqi0YHfv4BLXUKbSxF3JVMMAD16/DYTBt0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181021; c=relaxed/simple;
	bh=w5HW0BpCLTD8OrwMkFN+e0qjESMJICYUfRbSTLJROfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=ksReHx8u84q0TKrKYuCide6MUGMad+2vMX43gE/Cbj5DX2G5yxFSfHBtSEpo/fHbWU3nPyt6fDNUdgIDF6Mevg+Ncg2INu8fLITwrzLUnGkXnODpisRxl7UkvBMJCPsHyUl2ATb9UrROfNA/wJPR6cMtJqL1b0PKH5F+mU/dMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=NU0u7pVj; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EF2JvwMr4g7DRklqifcz4XumYYnybiwSa2gvTXwheOk=; b=NU0u7pVj07uFgNnYUttHqC2iLY
	l4Z8cQobu1E9+hD2ES9xr30AAkAIIglxfNfvtCKbClB1u3KA+gHH/tgn+RKKTLX3fFnnOUG4QvXNX
	NkV/emb0upMEJZYkYYVgDGgnqvSH0A3BTN50wg+KQ4FUO2dnM7kcxnUqbg0XS6eFM8Hg7aTzertJQ
	iinODO0UOcpYjqGeERhLz0Y5lAoplCOMHh9vOU5KTQMl8FqkDgkkdDs72w6rQN3+xtBK80OrbDXDm
	YiVBQY3IaUV5pGw5VhYJiYyTEn/oeNWYR2m1qKS1KFMBvy3dssDkrof9hfRjj+RJXU2mFdqKvN6/H
	t2n5xyoA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz9CM-000DN7-0F;
	Thu, 18 Sep 2025 09:36:58 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uz9CL-0006j2-0t;
	Thu, 18 Sep 2025 09:36:57 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 07:36:56 +0000
Message-Id: <DCVR5KLTP8SD.1K7YIKXC08TWX@folker-schwesinger.de>
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


