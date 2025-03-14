Return-Path: <dmaengine+bounces-4748-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B45A61485
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C823AB581
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673A201032;
	Fri, 14 Mar 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="MjgqkO1U"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283B200116;
	Fri, 14 Mar 2025 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964968; cv=none; b=PV8fFfhqflZp49Nb2tpbcsZH3vtCj+QRwb9hMnh9z9E+Tsx3lcZt3DekDcnvqtckoVGWAVvFFbP/RZBayKXwpmEpXCPA0b1Dq05rb+XJ23a2ii7ZhdqGEhMhHSaQby9vumWUiQVeJ8fr91uBwchRpfa6rkfK1dMjBPP9lSZY6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964968; c=relaxed/simple;
	bh=kla4UXAFG27RFQR092D02kAR6qn49qhwz6sHc9GvvQ8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=lVHSqwnRwwry71mmd7RM8gOz5ot4uXYs28f8MgDJExpikcgMTsVXlPy579ZT69Ae9uBtGcy5A5jm+XMGV1uJcZGgkrN4jm5Nbn2UXnk93rYzAHo1gce3gVLIIqt5uKZZ/2Ppprdjk7OLJbMsP2QLNOzNdo+Zgv8Lbd1/GYCOeeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=MjgqkO1U; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:
	Content-Transfer-Encoding:Mime-Version:To:From:Cc:Subject:Message-Id:Date:
	Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TDGHe5H9DDTsiL/3ihAwqrP4qS9aTGO3ohjYTzmIf94=; b=MjgqkO1UHN37C5wdfNLcTeDKFh
	F4uhfb/1LWyBNpNtuF7lk1D2cTSB+zaldu5zhS5tsdgZ7h1ghQTUTeqUv8NG3KcGjnLqRj+JWHKeH
	FWqD8pBWMKLsTNOwa2AXdwhXEqky8tsmv/5NCCrnNq1tQWBz+rTq1WkyQii0lOEnE5P5eMm+srzBr
	si6UEHvgsjAtmYQ3/J8L4mNh1SmkVsUhQpQztAFBNd9e/oe4rtpKBaTH0myfdgHbKN9GuiNyCR+DG
	SrPsuNnTanh+j8D//n6bCPBCINHeaIbaYDqU8HqIp6wJthZhzkxcwta5TZTXGcFAyCisTwdRLN6AZ
	02Pu5FhA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tt6ey-000Mpp-1C;
	Fri, 14 Mar 2025 16:09:16 +0100
Received: from [185.213.155.229] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tt6ex-0001HJ-0C;
	Fri, 14 Mar 2025 16:09:15 +0100
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 15:09:15 +0000
Message-Id: <D8G31H1FDKXJ.3C3P6GDB2JBW@folker-schwesinger.de>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Cc: "Vinod Koul" <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Marek Vasut" <marex@denx.de>, "Radhey Shyam Pandey"
 <radhey.shyam.pandey@amd.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Thomas Gessler" <thomas.gessler@brueckmann-gmbh.de>,
 <dmaengine@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-33-g75c6578986f4
References: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
In-Reply-To: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27577/Fri Mar 14 10:01:01 2025)

On Fri Mar 14, 2025 at 2:48 PM CET, Thomas Gessler wrote:
> Coalesce the direction bits from the enabled TX and/or RX channels into
> the directions bit mask of dma_device. Without this mask set,
> dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
> from being used with an IIO DMAEngine buffer.
>
> Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 108a7287f4cd..641aaf0c0f1c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -3205,6 +3205,10 @@ static int xilinx_dma_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> +	for (i =3D 0; i < xdev->dma_config->max_channels; i++)
> +		if (xdev->chan[i])
> +			xdev->common.directions |=3D xdev->chan[i]->direction;
> +
>  	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) {
>  		for (i =3D 0; i < xdev->dma_config->max_channels; i++)
>  			if (xdev->chan[i])


