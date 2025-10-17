Return-Path: <dmaengine+bounces-6875-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048EBE7E38
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9249F543BCC
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138B770FE;
	Fri, 17 Oct 2025 09:47:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA662D663E
	for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694477; cv=none; b=hTaP+w4zZWDRIhsMBquwG03rmS77+Vgpy9NTpuuwDkkaDiE1VuBlP6gAyXIl/Jb9jqXQvVIaFqDGT2BTfMeggCWRkfSRKSsn3oV4/HTcmG6ZJFd+h2f7gHfNDqoEtZCI38guf/i9j/Q01533uN1lEsY3NhaQK7eAAg3vbnbehY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694477; c=relaxed/simple;
	bh=IMHtirtYD8ubB7ZLiMwBPLrpMJH5hqnDQ5dn5NPj7vY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qsARdVrrNw92643T5SZFZS/3WOy2QDE8IFBXA+qK1f4VPvzJnO+lQL/8B/awR5bzzzZy+BQo3hiv1XpsqJkJmnsVT45SSTayNSQ1YFHINH/FOBjaIndSr595Tybrwb4O8TNaRqR/KRI26UGPyaJSbcIoIvvphXOFatuhTpkQkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v9h3v-0007Ts-Lz; Fri, 17 Oct 2025 11:47:51 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v9h3u-0042NW-31;
	Fri, 17 Oct 2025 11:47:50 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v9h3u-000000003i0-3dx5;
	Fri, 17 Oct 2025 11:47:50 +0200
Message-ID: <9f7514c69d11a0377283fe52fa6e7558b75c7ad3.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] dmaengine: dw-axi-dmac: add reset control support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Artem Shimko <a.shimko.dev@gmail.com>, Eugeniy Paltsev
	 <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 11:47:50 +0200
In-Reply-To: <20251016154627.175796-3-a.shimko.dev@gmail.com>
References: <20251016154627.175796-1-a.shimko.dev@gmail.com>
	 <20251016154627.175796-3-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On Do, 2025-10-16 at 18:46 +0300, Artem Shimko wrote:
> Add proper reset control handling to the AXI DMA driver to ensure
> reliable initialization and power management. The driver now manages
> resets during probe, remove, and system suspend/resume operations.
>=20
> The implementation stores reset control in the chip structure and adds
> reset assert/deassert calls at the appropriate points: resets are
> deasserted during probe after clock acquisition, asserted during remove
> and error cleanup, and properly managed during suspend/resume cycles.
> Additionally, proper error handling is implemented for reset control
> operations to ensure robust behavior.
>=20
> This ensures the controller is properly reset during power transitions
> and prevents potential issues with incomplete initialization.
>=20
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 42 ++++++++++++-------
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>  2 files changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> index 8b7cf3baf5d3..ac23e1a5e218 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1321,6 +1321,8 @@ static int axi_dma_suspend(struct device *dev)
>  	axi_dma_irq_disable(chip);
>  	axi_dma_disable(chip);
> =20
> +	reset_control_assert(chip->resets);
> +
>  	clk_disable_unprepare(chip->core_clk);
>  	clk_disable_unprepare(chip->cfgr_clk);
> =20
> @@ -1340,6 +1342,8 @@ static int axi_dma_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	reset_control_deassert(chip->resets);
> +

Missing error handling, or at least inconsistent with the deassert
turing dw_probe().

regards
Philipp

