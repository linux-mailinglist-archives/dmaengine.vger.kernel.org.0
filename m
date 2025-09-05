Return-Path: <dmaengine+bounces-6392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E045B4544A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5509F3BB048
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335062D47E8;
	Fri,  5 Sep 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="fdHhu5+t"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3B2D29D1;
	Fri,  5 Sep 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067406; cv=none; b=mtpLq2R9UWY6x9Xf6Ah69c4UGe62gBvJzzMayajgK2TaPRO7FOxf02QmscuSWPEIst6oID8yoUCMXkBDZ24DiTYyrG38dq3UCSjitfHjA1MggniwFBBS/npZe2CE8EyEQKB+vkLGYJY/810E54xPMaFe911BFCCaMEtw532FMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067406; c=relaxed/simple;
	bh=VzgY2tpimVlvgm1SgvE188WWGQb1N0ivYxEYsBpx7uQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Q7iDnzcCYQDzT/7XGdDqlRlRhm/yl3KXXduPbZGW/AA/qQIEXJwbRfl2sNZr7pjd+AYOraselMmU/h2Hq4hKeHH3cr5tL0eRNKaA0O7vtsqymvorH4IaxJFNs8nCZs6mkTXo36WdxVtvIQ4Q5rWgODjAZy6xDjksUXTxVFcxpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=fdHhu5+t; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=S4Z4pi2vstaCY5LFpKxEjHRuqlRGNHBr99kO/RP0amE=; b=fdHhu5+tculIUWKwtIyzxXqTKn
	tr5L6aJmOMRaiUEnRzoIQn+5165zUajK6YOcUepLbPk1BscOZJTdye0+k8qlrCKTxiNRF3VrkwEHN
	IbIAcPw2AcIEQ0I0tdFBtjU/nyE5fj2Y6VcUW6tthn/IGAWXsyUBaWxc5aaZkscyereORb8py+sfx
	B5sJXT3IlsxWJEhOkOEnHEA2qTwA9ZLH3l1xl2rJPaFANi5hJ5p/KC48NxWEYaBFqZFL3xhtokOuJ
	TN/RjVCMQhvlbvLWyq8Jb1Ii8QYOQk4ZQixj28m11Qeolgm7Xvu7OosAeNuA5bjeq/mbJ/P/Il7bf
	CaExittA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uuT6X-000AAb-24;
	Fri, 05 Sep 2025 11:51:37 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uuT5s-0006sD-0e;
	Fri, 05 Sep 2025 11:51:37 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 09:51:36 +0000
Message-Id: <DCKRVLG0RDPF.2HIFAQSB8UF3H@folker-schwesinger.de>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix uninitialized addr_width
 when "xlnx,addrwidth" property is missing
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250905064811.1887086-1-suraj.gupta2@amd.com>
In-Reply-To: <20250905064811.1887086-1-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.0.7/27753/Thu Sep  4 10:26:09 2025)

On Fri Sep 5, 2025 at 8:48 AM CEST, Suraj Gupta wrote:
> When device tree lacks optional "xlnx,addrwidth" property, the addr_width
> variable remained uninitialized with garbage values, causing incorrect
> DMA mask configuration and subsequent probe failure. The fix ensures a
> fallback to the default 32-bit address width when this property is missin=
g.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: b72db4005fe4 ("dmaengine: vdma: Add 64 bit addressing support to t=
he driver")

Reviewed-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index fabff602065f..89a8254d9cdc 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -131,6 +131,7 @@
>  #define XILINX_MCDMA_MAX_CHANS_PER_DEVICE	0x20
>  #define XILINX_DMA_MAX_CHANS_PER_DEVICE		0x2
>  #define XILINX_CDMA_MAX_CHANS_PER_DEVICE	0x1
> +#define XILINX_DMA_DFAULT_ADDRWIDTH		0x20
> =20
>  #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
>  		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
> @@ -3159,7 +3160,7 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
>  	struct device_node *node =3D pdev->dev.of_node;
>  	struct xilinx_dma_device *xdev;
>  	struct device_node *child, *np =3D pdev->dev.of_node;
> -	u32 num_frames, addr_width, len_width;
> +	u32 num_frames, addr_width =3D XILINX_DMA_DFAULT_ADDRWIDTH, len_width;
>  	int i, err;
> =20
>  	/* Allocate and initialize the DMA engine structure */
> @@ -3235,7 +3236,9 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
> =20
>  	err =3D of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
>  	if (err < 0)
> -		dev_warn(xdev->dev, "missing xlnx,addrwidth property\n");
> +		dev_warn(xdev->dev,
> +			 "missing xlnx,addrwidth property, using default value %d\n",
> +			 XILINX_DMA_DFAULT_ADDRWIDTH);
> =20
>  	if (addr_width > 32)
>  		xdev->ext_addr =3D true;


