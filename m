Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB247BDB4
	for <lists+dmaengine@lfdr.de>; Tue, 21 Dec 2021 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhLUJtq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Dec 2021 04:49:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:14489 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhLUJte (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Dec 2021 04:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1640079992;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=42mCLPP+/26IgMgMu1NSuqVuS12TTqkjJCf4VQaLAzE=;
    b=P+MuxOGkejIvVYs8B0FfYf07ourOmlhnk8fDrXS+O2Z29FGhYbSpBElj2G61A1V19i
    6op+sEgjbbWIDfFKhjwhriy25OJ1DfPX2WTgIw+u+wZNN8pO9SwH8oupUjQQRSRkGWX9
    GDCjJl/boX2ZZfihy0LLuLwY4yqt7YVyD7che9m+kSfOnOIu+jxgOT+sIKgMEtzcHV6m
    OZmbAac7bXHYsrZpBZTbxxWCeo+wf4Bu47pJJVmlrWDWWrhmYsxpka/vgSWqxWrJeMWB
    DoJL6gQcVt0QkX0bi6qnDcXDxXPwLh11DGzHEEqAJyM7E6LXAt5+IkWL2yk1KxegYHUI
    4JWA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7B6PNk="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.35.3 AUTH)
    with ESMTPSA id N01f39xBL9kWyGE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 21 Dec 2021 10:46:32 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:46:32 +0100 (CET)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Message-ID: <1313974359.541738.1640079992364@webmail.strato.com>
In-Reply-To: <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
 <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev33
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 12/21/2021 6:27 AM Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> wrote:
> 
>  
> Add support for R-Car S4-8. We can reuse R-Car V3U code so that
> renames variable names as "gen4".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 5c7716fd6bc5..e409c89edca1 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -2009,7 +2009,7 @@ static const struct rcar_dmac_of_data rcar_dmac_data = {
>  	.chan_offset_stride	= 0x80,
>  };
>  
> -static const struct rcar_dmac_of_data rcar_v3u_dmac_data = {
> +static const struct rcar_dmac_of_data rcar_gen4_dmac_data = {
>  	.chan_offset_base	= 0x0,
>  	.chan_offset_stride	= 0x1000,
>  };
> @@ -2018,9 +2018,12 @@ static const struct of_device_id rcar_dmac_of_ids[] = {
>  	{
>  		.compatible = "renesas,rcar-dmac",
>  		.data = &rcar_dmac_data,
> +	}, {
> +		.compatible = "renesas,rcar-gen4-dmac",
> +		.data = &rcar_gen4_dmac_data,
>  	}, {
>  		.compatible = "renesas,dmac-r8a779a0",
> -		.data = &rcar_v3u_dmac_data,
> +		.data = &rcar_gen4_dmac_data,
>  	},
>  	{ /* Sentinel */ }
>  };
> -- 
> 2.25.1

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
