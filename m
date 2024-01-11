Return-Path: <dmaengine+bounces-725-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A782ADF5
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 12:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260FA1F22E35
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6946156E5;
	Thu, 11 Jan 2024 11:52:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361E156D4;
	Thu, 11 Jan 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rNtbD-0005Y5-00; Thu, 11 Jan 2024 12:51:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 4DE01C0135; Thu, 11 Jan 2024 12:51:25 +0100 (CET)
Date: Thu, 11 Jan 2024 12:51:25 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: vkoul@kernel.org, jiaheng.fan@nxp.com, peng.ma@nxp.com,
	wen.he_1@nxp.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MIPS: Alchemy: Fix an out-of-bound access in
 db1200_dev_setup()
Message-ID: <ZZ/WPZ4e9QIqkXaC@alpha.franken.de>
References: <ed2a1d5f41c5e83ae82fe6a16cfd40c78eeb8093.1704910022.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2a1d5f41c5e83ae82fe6a16cfd40c78eeb8093.1704910022.git.christophe.jaillet@wanadoo.fr>

On Wed, Jan 10, 2024 at 07:07:36PM +0100, Christophe JAILLET wrote:
> When calling spi_register_board_info(), we should pass the number of
> elements in 'db1200_spi_devs', not 'db1200_i2c_devs'.
> 
> Fixes: 63323ec54a7e ("MIPS: Alchemy: Extended DB1200 board support.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  arch/mips/alchemy/devboards/db1200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index f521874ebb07..67f067706af2 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -847,7 +847,7 @@ int __init db1200_dev_setup(void)
>  	i2c_register_board_info(0, db1200_i2c_devs,
>  				ARRAY_SIZE(db1200_i2c_devs));
>  	spi_register_board_info(db1200_spi_devs,
> -				ARRAY_SIZE(db1200_i2c_devs));
> +				ARRAY_SIZE(db1200_spi_devs));
>  
>  	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C	 ON=SPI)
>  	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

