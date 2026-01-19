Return-Path: <dmaengine+bounces-8371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38071D3A2F5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50CC1303BFDF
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65230356A1D;
	Mon, 19 Jan 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qzI+jUV4"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC63559DC;
	Mon, 19 Jan 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814844; cv=none; b=W0KGtznTlMZoXi5ynPIvad+T8TX1h/0cg8R8rb+eU5TjSMmDaAX7qoWlSMrgaR0jIBDUzB64+rNGua3OnpZa+PMhHmq/ckE6V+enGF179plfzJCfprLrtWLH6TeLk3l8TtGzxf8SlLBvvntOT1v+kHJcD545zF/aH6ksab72Yww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814844; c=relaxed/simple;
	bh=FnDqYCqY4eMQu1KfJO2diG09+hGAQVkPBUCJXUeIZ0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A8pTliKXcsBGELtl96Dp9tYPAWppxTrrkUtzXBtWzJshG6ZdtyukpgRfiRWEYtr/jnwUk1k4lIR7yAq2+lH6Olls78v8mvTN5RYC8yRuatjQSEHb+U00CxtnAzjfhZGp/xXB0AUKzQhmoYlDRx3XpidkrwJDH8A9UthnDLAGwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qzI+jUV4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1768814842; x=1800350842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FnDqYCqY4eMQu1KfJO2diG09+hGAQVkPBUCJXUeIZ0A=;
  b=qzI+jUV4F4r188AbBTHdpLNnjp1d8gSJoR3wif7ABt6XpEmfDpbNSJdP
   CYUxz4vHcOZpqvThGgUwjtsX1Z0Xp+R2YuM88k+MbX75KhJsrWmQ8fyA7
   a35ZK54PLMnDt1p4VsC0nwtpiDtbNNuN3H/qDKkDaCb3d8sp4yBjisL/1
   eCK0hKTrwfstcHptvJGebQpIgTWe2f0fcWOsx96GRGsQW4M5CzrfJfTbz
   6PlKYgldruDc6rncmL7lw5pX0KJ2Utd6UTeDTpD48f3BL2fWDjiwETQtl
   ox2Wqw0zwb8CpSkmjZEiObe1Aj6W2OAdKrpDmHlQSUi+YGmKbnKzgvlxJ
   w==;
X-CSE-ConnectionGUID: i0zijf1nTfiJcIl2a1rGow==
X-CSE-MsgGUID: 5Vc33klYRPeu5OUwKZF+zg==
X-IronPort-AV: E=Sophos;i="6.21,237,1763449200"; 
   d="scan'208";a="219379894"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2026 02:27:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 19 Jan 2026 02:26:44 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 19 Jan 2026 02:26:40 -0700
Message-ID: <bc019bd8-34d3-420e-8519-09700437fb01@microchip.com>
Date: Mon, 19 Jan 2026 10:26:39 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] crypto: atmel: Use dmaengine_prep_config_single()
 API
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<imx@lists.linux.dev>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <20260105-dma_prep_config-v3-9-a8480362fd42@nxp.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20260105-dma_prep_config-v3-9-a8480362fd42@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/2026 at 23:46, Frank Li wrote:
> Using new API dmaengine_prep_config_single() to simple code.
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/crypto/atmel-aes.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index 3a2684208dda9ee45d71b4bc2958be293a4fb6fe..e300672ffd7185b0f5bf356c2376681537047def 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
>          struct dma_slave_config config;
>          dma_async_tx_callback callback;
>          struct atmel_aes_dma *dma;
> -       int err;
> 
>          memset(&config, 0, sizeof(config));
>          config.src_addr_width = addr_width;
> @@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
>                  return -EINVAL;
>          }
> 
> -       err = dmaengine_slave_config(dma->chan, &config);
> -       if (err)
> -               return err;
> -
> -       desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
> -                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +       desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
> +                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
> +                                       &config);
>          if (!desc)
>                  return -ENOMEM;
> 
> 
> --
> 2.34.1
> 


