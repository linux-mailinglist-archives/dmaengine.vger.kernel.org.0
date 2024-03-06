Return-Path: <dmaengine+bounces-1276-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D84D873334
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7422DB28D8B
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0A5F853;
	Wed,  6 Mar 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JfdHE1uB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A145F551;
	Wed,  6 Mar 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718905; cv=none; b=tNySFHK79jd5nCjV878pKqKUzrfdWb07QZuPoffYHKDJizL2sWdhvkDu9btsVGC217f8Nmh1rG3Sc+MLrEuRYARRJla2klMT4wMg1+sAAxib/C0xDalGBIg1Pe3YptFVaO3WfpWocLdXD9byJ+pCpXsQ1Cvf86bAoaWJcdrDUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718905; c=relaxed/simple;
	bh=2ftyihPbAmkS6J+gl1Y1Ht/NezQ4YW814oVTc/B6SUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BphvVXwMc4Djj0OgYWUQCngULqqhdIC0ebK9yYR8qcTf/uWv6EdgxIiZJxejzODywGoXUubhg6lzQIstuotfh4tzse4z5wF3C4HaABrPEL0pmby+vmL6Z/+fRDzNApWcmazkGP4IC1rJhVhr6N35qetFV3MHiDB4vpEaK722TGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JfdHE1uB; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709718901; x=1741254901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xRQdIjIh2u/H09dIqzgYCCAQtjiG9q90vID+o94vTbg=;
  b=JfdHE1uB9povPjO1clJtyUrTW6fHGIunSfAeP+bTHSgFeVgEuAJlJanh
   Cpv300HFpl4YRzew+fy5x0WsQDYg+84hX3zSu1NottenXQV04o5e3SwMS
   ct/vyVvNS7iRmvQdd5Vc8v+hqvWcldhwiMKnt8DTarqhPKNqBvTquVc7e
   PSb35xxkB2fmjkkT+kbGnZS3rRTTB5awTaxe+bmdm3y6TdSBNURQEms9o
   bpmEwkcOvQ1WeOkXWl6mOKgY+dBOocc5lCdi81qmyFulDX2g/lB3APb8G
   vgGBEFO4rit7lsfxb1YaFwWGqwnZRLKBNL9Ouadosawdm8xqRkFV9oP6I
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,207,1705359600"; 
   d="scan'208";a="35759910"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Mar 2024 10:54:58 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 018A9280071;
	Wed,  6 Mar 2024 10:54:58 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, Nicolin Chen <b42378@freescale.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/4] dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)
Date: Wed, 06 Mar 2024 10:55:00 +0100
Message-ID: <3280558.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240303-sdma_upstream-v1-1-869cd0165b09@nxp.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com> <20240303-sdma_upstream-v1-1-869cd0165b09@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Frank,

thanks for the patch.

Am Montag, 4. M=E4rz 2024, 05:32:53 CET schrieb Frank Li:
> From: Nicolin Chen <b42378@freescale.com>
>=20
> Allocate memory from SoC internal SRAM to reduce DDR access and keep DDR =
in
> lower power state (such as self-referesh) longer.
>=20
> Check iram_pool before sdma_init() so that ccb/context could be allocated
> from iram because DDR maybe in self-referesh in lower power audio case
> while sdma still running.
>=20
> Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 53 +++++++++++++++++++++++++++++++++++++-------=
=2D-----
>  1 file changed, 40 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 9b42f5e96b1e0..9a6d8f1e9ff63 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -24,6 +24,7 @@
>  #include <linux/semaphore.h>
>  #include <linux/spinlock.h>
>  #include <linux/device.h>
> +#include <linux/genalloc.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/firmware.h>
>  #include <linux/slab.h>
> @@ -516,6 +517,7 @@ struct sdma_engine {
>  	void __iomem			*regs;
>  	struct sdma_context_data	*context;
>  	dma_addr_t			context_phys;
> +	dma_addr_t			ccb_phys;
>  	struct dma_device		dma_device;
>  	struct clk			*clk_ipg;
>  	struct clk			*clk_ahb;
> @@ -531,6 +533,7 @@ struct sdma_engine {
>  	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
>  	bool				clk_ratio;
>  	bool                            fw_loaded;
> +	struct gen_pool			*iram_pool;
>  };
> =20
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -1358,8 +1361,14 @@ static int sdma_request_channel0(struct sdma_engin=
e *sdma)
>  {
>  	int ret =3D -EBUSY;
> =20
> -	sdma->bd0 =3D dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
> -				       GFP_NOWAIT);
> +	if (sdma->iram_pool)
> +		sdma->bd0 =3D gen_pool_dma_alloc(sdma->iram_pool,
> +					sizeof(struct sdma_buffer_descriptor),
> +					&sdma->bd0_phys);
> +	else
> +		sdma->bd0 =3D dma_alloc_coherent(sdma->dev,
> +					sizeof(struct sdma_buffer_descriptor),
> +					&sdma->bd0_phys, GFP_NOWAIT);
>  	if (!sdma->bd0) {
>  		ret =3D -ENOMEM;
>  		goto out;
> @@ -1379,10 +1388,14 @@ static int sdma_request_channel0(struct sdma_engi=
ne *sdma)
>  static int sdma_alloc_bd(struct sdma_desc *desc)
>  {
>  	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
> +	struct sdma_engine *sdma =3D desc->sdmac->sdma;
>  	int ret =3D 0;
> =20
> -	desc->bd =3D dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
> -				      &desc->bd_phys, GFP_NOWAIT);
> +	if (sdma->iram_pool)
> +		desc->bd =3D gen_pool_dma_alloc(sdma->iram_pool, bd_size, &desc->bd_ph=
ys);
> +	else
> +		desc->bd =3D dma_alloc_coherent(sdma->dev, bd_size, &desc->bd_phys, GF=
P_NOWAIT);
> +
>  	if (!desc->bd) {
>  		ret =3D -ENOMEM;
>  		goto out;
> @@ -1394,9 +1407,12 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
>  static void sdma_free_bd(struct sdma_desc *desc)
>  {
>  	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
> +	struct sdma_engine *sdma =3D desc->sdmac->sdma;
> =20
> -	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
> -			  desc->bd_phys);
> +	if (sdma->iram_pool)
> +		gen_pool_free(sdma->iram_pool, (unsigned long)desc->bd, bd_size);
> +	else
> +		dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd, desc->bd_=
phys);
>  }
> =20
>  static void sdma_desc_free(struct virt_dma_desc *vd)
> @@ -2066,8 +2082,8 @@ static int sdma_get_firmware(struct sdma_engine *sd=
ma,
> =20
>  static int sdma_init(struct sdma_engine *sdma)
>  {
> +	int ccbsize;
>  	int i, ret;
> -	dma_addr_t ccb_phys;

What is the motivation to put ccb_phys to struct sdma_engine? AFAICS
this is only used in sdma_init. Also the following patches of this series
are not using the struct member.

Best regards,
Alexander

> =20
>  	ret =3D clk_enable(sdma->clk_ipg);
>  	if (ret)
> @@ -2083,10 +2099,15 @@ static int sdma_init(struct sdma_engine *sdma)
>  	/* Be sure SDMA has not started yet */
>  	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
> =20
> -	sdma->channel_control =3D dma_alloc_coherent(sdma->dev,
> -			MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control) +
> -			sizeof(struct sdma_context_data),
> -			&ccb_phys, GFP_KERNEL);
> +	ccbsize =3D MAX_DMA_CHANNELS * (sizeof(struct sdma_channel_control)
> +		  + sizeof(struct sdma_context_data));
> +
> +	if (sdma->iram_pool)
> +		sdma->channel_control =3D gen_pool_dma_alloc(sdma->iram_pool,
> +							   ccbsize, &sdma->ccb_phys);
> +	else
> +		sdma->channel_control =3D dma_alloc_coherent(sdma->dev, ccbsize, &sdma=
=2D>ccb_phys,
> +							   GFP_KERNEL);
> =20
>  	if (!sdma->channel_control) {
>  		ret =3D -ENOMEM;
> @@ -2095,7 +2116,7 @@ static int sdma_init(struct sdma_engine *sdma)
> =20
>  	sdma->context =3D (void *)sdma->channel_control +
>  		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
> -	sdma->context_phys =3D ccb_phys +
> +	sdma->context_phys =3D sdma->ccb_phys +
>  		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
> =20
>  	/* disable all channels */
> @@ -2121,7 +2142,7 @@ static int sdma_init(struct sdma_engine *sdma)
>  	else
>  		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> =20
> -	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
> +	writel_relaxed(sdma->ccb_phys, sdma->regs + SDMA_H_C0PTR);
> =20
>  	/* Initializes channel's priorities */
>  	sdma_set_channel_priority(&sdma->channel[0], 7);
> @@ -2272,6 +2293,12 @@ static int sdma_probe(struct platform_device *pdev)
>  			vchan_init(&sdmac->vc, &sdma->dma_device);
>  	}
> =20
> +	if (np) {
> +		sdma->iram_pool =3D of_gen_pool_get(np, "iram", 0);
> +		if (sdma->iram_pool)
> +			dev_info(&pdev->dev, "alloc bd from iram.\n");
> +	}
> +
>  	ret =3D sdma_init(sdma);
>  	if (ret)
>  		goto err_init;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



