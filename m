Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC33E2BCD
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbhHFNpK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344083AbhHFNpK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B7F6113C;
        Fri,  6 Aug 2021 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628257494;
        bh=Gn/JIf0T5l5y6XchfhaOisk1ME/3lTklwuWGQTVoKnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zt9MxKbs2fGDBU8uwc3fj6G2dG+4iRTZzszNEFPOQ7rPEmv95HvA9b4M05mtpVUT/
         FwnbFY9xAjlnMMb6bOiuC/d63Y11fkSmUYUo+Pli5BPShKHSsxzdrqBVeSFJnpgVNE
         +GkvdS3gUNRlnOT0j38krn8AhUW9rMatJhApZZR5DFuGJqJ7asW3Ox+yzb2TOPfTNp
         0iIuWw5D1+ONkIPVnXk69F5A62bWom+APfTtGLrmtmv0X4I9PWy5d3D0yC8CUhg/LP
         5l3cPsEmGe/Sf+W981tYqVT+IgTJts6bpDhIpbTppC+whGf5mZi+Pp3uEE37301lys
         ax0X0lXHERdaA==
Date:   Fri, 6 Aug 2021 19:14:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: acpi: Check for errors from
 acpi_register_gsi() separately
Message-ID: <YQ080pMpNcXqt1ml@matsya>
References: <20210802175532.54311-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802175532.54311-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-21, 20:55, Andy Shevchenko wrote:
> While IRQ test agaist the returned variable in practice is a good enough
> there is still a room for theoretical mistake in case the vIRQ of the
> device contains the same error code that acpi_register_gsi() may return.
> Due to this, check for error code separately from matching the vIRQs.
> 
> Besides that, append documentation to tell why acpi_gsi_to_irq() can't
> be used and we call acpi_register_gsi() instead.

patch fails to apply, pls rebase

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/acpi-dma.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
> index 52768dc8ce12..5906eae26e2a 100644
> --- a/drivers/dma/acpi-dma.c
> +++ b/drivers/dma/acpi-dma.c
> @@ -75,8 +75,16 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
>  	    si->mmio_base_high != upper_32_bits(mem))
>  		return 0;
>  
> -	/* Match device by Linux vIRQ */
> +	/*
> +	 * acpi_gsi_to_irq() can't be used because some platforms do not save
> +	 * registered IRQs in the MP table. Instead we just try to register
> +	 * the GSI, which is the core part of the above mentioned function.
> +	 */
>  	ret = acpi_register_gsi(NULL, si->gsi_interrupt, si->interrupt_mode, si->interrupt_polarity);
> +	if (ret < 0)
> +		return 0;
> +
> +	/* Match device by Linux vIRQ */
>  	if (ret != irq)
>  		return 0;
>  
> -- 
> 2.30.2

-- 
~Vinod
