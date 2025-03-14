Return-Path: <dmaengine+bounces-4749-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED790A61488
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FC83AB4DF
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E7200116;
	Fri, 14 Mar 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="GP3UtK10"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552C28DB3;
	Fri, 14 Mar 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965009; cv=none; b=tALIIM+K6VDOtQvZoJ1GUudTa+p8qpBds3E591UZP05TYlpTHLYRXZaAr1nOsm2aaSQWyvw5YYSo26m+06Q/UqYHo9JjbzFRhkZ92SKTK0/mECQGaiAfi0IuzND/fX/hpAnxN23BIkNIOT6lBMiTFE4OtKTyTqi1AVloX/MIK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965009; c=relaxed/simple;
	bh=gO4JcoF9W25gckTuTY35gJC7g621G2hAaoLzUGagntY=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:Mime-Version:
	 References:In-Reply-To; b=B72oRoRKayUEkh30zwH5iFlsXLf3kznJluKvXMUKS05dy5hK6eigqSQi5dWarG5XrvjgITOaTMtXB/ncu0N4LYnEdDIhhzHlDnnWp2Gngbh+9PAcFeaFP7hF9qSgrGhxJ2ollWT5ZaYDSs2D4mFJkwix7J8WBRzIimMp32Wwl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=GP3UtK10; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:
	Content-Transfer-Encoding:Mime-Version:Subject:To:From:Cc:Message-Id:Date:
	Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z+NrVsUlU9vdqAo1JusitnBgZ6CQRjkiMY5hj0uwdFA=; b=GP3UtK10MKyITz4RJZcN9BOyCK
	DO+dM/MjsPWiJ5Ix1jpvb0JtRHL+eoC5onKhliPIdvU07MoJNA3cfN8QnHzvuJMIBQEfD0TfvnxKC
	aLXOMGV/5EWfPuqyE+Fn2jVJvm9woEINjlxI67UEmaB4AfmQ9BHMcj9hxPasoBwMKE7hj4XDJnQSC
	P/eVKQlYK10o4i927ESlwfnnWQA6ArngUcKa8k4v3B/1qOSFDwEV3+dSC29ICVzNfMYZr/9CA/UCP
	Sz6vyobp0ThhVKIZqZ60ki+EV580i+zf0IrQfSzBLsZ6pG8FldbYJzUzeQjr0KnRlRqYe3nSosFLj
	k9igvZCQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tt6fl-000MxA-1e;
	Fri, 14 Mar 2025 16:10:05 +0100
Received: from [185.213.155.229] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tt6fk-0005Uj-0b;
	Fri, 14 Mar 2025 16:10:05 +0100
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 15:10:04 +0000
Message-Id: <D8G323LHQBTV.5LVSPQ3DF2NQ@folker-schwesinger.de>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Marek Vasut" <marex@denx.de>, "Radhey Shyam Pandey"
 <radhey.shyam.pandey@amd.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Thomas Gessler" <thomas.gessler@brueckmann-gmbh.de>,
 <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Set max segment size
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-33-g75c6578986f4
References: <20250314134717.703287-1-thomas.gessler@brueckmann-gmbh.de>
In-Reply-To: <20250314134717.703287-1-thomas.gessler@brueckmann-gmbh.de>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27577/Fri Mar 14 10:01:01 2025)

On Fri Mar 14, 2025 at 2:47 PM CET, Thomas Gessler wrote:
> Set the maximumg DMA segment size from the actual core configuration
> value. Without this setting, the default value of 64 KiB is reported,
> and larger sizes cannot be used for IIO DMAEngine buffers.
>
> Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 108a7287f4cd..4b4a299e3807 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -3114,6 +3114,8 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
>  		}
>  	}
> =20
> +	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
> +
>  	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
>  		xdev->has_axistream_connected =3D
>  			of_property_read_bool(node, "xlnx,axistream-connected");


