Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61121FFFDF
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 08:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRH63 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 02:58:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfKRH63 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Nov 2019 02:58:29 -0500
Received: from localhost (unknown [122.167.117.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614B820692;
        Mon, 18 Nov 2019 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574063909;
        bh=2inFxxvwRMGZpWan2xQ1yUu6g4OjzeAlqm+cS029Jkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIUOEw9VUPEfCmkeckbz0iSW3JnqhEPwU61x17w/0G6rFiTZPx2+fC8ouwz+klFaS
         KJEjiSCXf2K+K93SijTnH4ocZ5Lk7Qurup7ZYlavjL8jQJILJ2yahZw4vEp6YVDx3C
         aA5dJzjJ3CvUtlySWB8/ozLBoAHyHK87Fnzco4nk=
Date:   Mon, 18 Nov 2019 13:28:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sf-pdma: fix kernel-doc W=1 warning
Message-ID: <20191118075821.GA82508@vkoul-mobl>
References: <20191115031013.30448-1-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115031013.30448-1-green.wan@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-11-19, 11:10, Green Wan wrote:
> Fix kernel-doc W=1 warning. There are several comments starting from "/**"
> but not for function comment purpose. Remove them to fix the warning.
> Another definition in front of function causes warning. Move definition
> to header file.

We do not do these kind of titles for a patch, a patch should have
subject which describes the changes and we do not mix multiple changes
into a patch , so..
> 
> kernel-doc warning:
> 
> drivers/dma/sf-pdma/sf-pdma.c:28: warning: Function parameter or member
> 	'addr' not described in 'readq'

'describe redq parameter' can be good subject and a patch

> drivers/dma/sf-pdma/sf-pdma.c:438: warning: Function parameter or member
> 	'ch' not described in 'SF_PDMA_REG_BASE'
> drivers/dma/sf-pdma/sf-pdma.c:438: warning: Excess function parameter
> 	'pdma' description in 'SF_PDMA_REG_BASE'

'remove pdma description' can be second patch and subject

> 
> Changes:
>  - Replace string '/**' with '/*' not for comment purpose
>  - Move definition, "SF_PDMA_REG_BASE", fomr sf-pdma.c to sf-pdma.h
> 
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 3 +--
>  drivers/dma/sf-pdma/sf-pdma.h | 4 +++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 16fe00553496..465256fe8b1f 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * SiFive FU540 Platform DMA driver
>   * Copyright (C) 2019 SiFive
>   *
> @@ -435,7 +435,6 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
>   *
>   * Return: none
>   */
> -#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
>  static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>  {
>  	int i;
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 55816c9e0249..0c20167b097d 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/**
> +/*
>   * SiFive FU540 Platform DMA driver
>   * Copyright (C) 2019 SiFive
>   *
> @@ -57,6 +57,8 @@
>  /* Error Recovery */
>  #define MAX_RETRY					1
>  
> +#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
> +
>  struct pdma_regs {
>  	/* read-write regs */
>  	void __iomem *ctrl;		/* 4 bytes */
> 
> base-commit: a7e335deed174a37fc6f84f69caaeff8a08f8ff8
> -- 
> 2.17.1

-- 
~Vinod
