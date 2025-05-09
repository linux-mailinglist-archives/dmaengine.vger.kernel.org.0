Return-Path: <dmaengine+bounces-5122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA5FAB0971
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 07:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8214B3B16F4
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 05:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9824266569;
	Fri,  9 May 2025 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="OLcejcwO"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D523F429;
	Fri,  9 May 2025 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746767498; cv=none; b=cAxI7dbgixs/PAYX6ONO1jqrBvESYfNOzanXP6N1t6E3IvFz01P59r5u2dvp9pfMHRoFPTMi5ehJi/qh4lrtOo8l8k4u79Ae1OmzaZee2v2yRiWhUjOOUie2cXD+U6iHRdyIwTWrSD1cOVtjZ8fnS08q0AIr74kNouER5dyKPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746767498; c=relaxed/simple;
	bh=QXhS/C6KhLftQrV0gxYpGmieyLMHJFg5hC4iI6H+pbE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=dfygH3BV7upT6W5UyL5Seic2tGlM7M/UCM84/qr6aYSNxUXJ4Nv9QeA1ez3B7+grXgyRGP+XJGyLrEkTkvWwAvyXngBjvTU0Kk29YeVu/CtUHtYTSiftU58K61I62z7y+GtQ2ISp9jGvYd8o2TqNxDO/lQ8WOI0aLVTimb07tgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=OLcejcwO; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:From:Cc:
	Subject:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GdBEsgjaYAHtmN5VFRdLlmlYJA177/Rj1RK0UPmSt4Y=; b=OLcejcwOZnCrKB8JNabEUvO+O/
	kglaxXVzJVvQkvxDIhm/gk6Txh8HjJ0pGth6dqK4JLAl8VbnWS6Y4qanAlv+WJqoMTCstEEZzRs4d
	EFIG500ZEBD53ELrMvG5y9atipiO+gqHJ9bBzf/5c0nq3Bz90sKIUMXHZThCLbuXTGQM9Lyp3FRXW
	E/Lt9/CPfI+q3eIywmZooO/XTXHDpSj05l/BQXoSMTc63QlmmSJSQnojZ5/5r7/TlKQiFMLWOjJ13
	1ljkesG2lLN3BWteghn1wCGdcTSKMjRl+bPX6UQ+Y9xvi03Vm9czbjSyHAqPjYpPy4SDdo2KC4j7/
	2QiS2kYQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uDG0y-0008tp-2e;
	Fri, 09 May 2025 07:11:17 +0200
Received: from [170.62.100.137] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uDG0y-0007zr-1G;
	Fri, 09 May 2025 07:11:16 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 May 2025 05:11:14 +0000
Message-Id: <D9RDE3X5FIWG.BUFCOXYYAW1U@folker-schwesinger.de>
To: "Thomas Gessler" <thomas.gessler@brueckmann-gmbh.de>,
 <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: xilinx_dma: Set dma_device directions
Cc: <linux-kernel@vger.kernel.org>, "Vinod Koul" <vkoul@kernel.org>, "Michal
 Simek" <michal.simek@amd.com>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Radhey Shyam Pandey"
 <radhey.shyam.pandey@amd.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Marek Vasut" <marex@denx.de>,
 <linux-arm-kernel@lists.infradead.org>, "Suraj Gupta"
 <Suraj.Gupta2@amd.com>, "Harini Katakam" <harini.katakam@amd.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
X-Mailer: aerc 0.20.1-74-g1b72b76797b9
References: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
In-Reply-To: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27631/Thu May  8 10:35:15 2025)

On Wed May 7, 2025 at 8:21 PM CEST, Thomas Gessler wrote:
> Coalesce the direction bits from the enabled TX and/or RX channels into
> the directions bit mask of dma_device. Without this mask set,
> dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
> from being used with an IIO DMAEngine buffer.
>
> Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
> Changes in v2:
>   - Change to Suraj's simpler version as per Radhey's request
>
>  drivers/dma/xilinx/xilinx_dma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 3ad44afd0e74..8f26b6eff3f3 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2909,6 +2909,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_=
device *xdev,
>  		return -EINVAL;
>  	}
> =20
> +	xdev->common.directions |=3D chan->direction;
> +
>  	/* Request the interrupt */
>  	chan->irq =3D of_irq_get(node, chan->tdest);
>  	if (chan->irq < 0)


