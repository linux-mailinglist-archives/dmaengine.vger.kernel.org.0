Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED9256882
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgH2PF4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Aug 2020 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2PFy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Aug 2020 11:05:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE95C061236;
        Sat, 29 Aug 2020 08:05:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so3314832oic.7;
        Sat, 29 Aug 2020 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GESIzfSQF/IiQj5pKJ59W/BWN56R6UAMnjLXD2xuVB4=;
        b=AGG5ffRzCA2kYkm1R9vg42GzRIb9HYRNvR2yghbUZztNX2faULR35xzkF0/Q8+11Nf
         uemArEKDOPA2/yw88M64xCY9uW7v53zNpohwjyYDDGp9H9AwENe+Ef+kcQtXJFJdkgKU
         0dIl+0kWssKjSXwaerpAJw2DXWp2mN1bQ7TRyZ+5SDCB6akg9L+2xVfRbLm1jCiyO31C
         Sbr67qr5uixtYdr73qAGku2p3YElxuXfB06JCf34RQ2tHVYO77yuJnuwbD4+eAQRENjQ
         pz3hrl1eBpGewmwu6Qn65SSFHZZmTVTFhYMWt2+QhhssCG+NqzldjhNGoR+UBJkYDOZa
         r0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=GESIzfSQF/IiQj5pKJ59W/BWN56R6UAMnjLXD2xuVB4=;
        b=lsPdBPVT9rtZ3QRMYvzqoGY+jVXH7K6TSVeHsMaHw9UKNhR0m5FfNpRLQyABXZaPnH
         OpDUMrg6bm/J1RaJUxOhOQDQYyuhq0McmzK/s59PShqW/ko15CSSWLTJDnTIlxpQJDMN
         AKRA182N42XnuTGwiPQ9jxECuIfIErmdBaW05hltBPP8MA3IE0JzV1PcHjdpxmIjH+nf
         Lstl6UhfV5nyu2vcn1hOEX4v6RKZXQuRJMuy2QM4KNQ7aESxihBbllvty0evUPQrx/4X
         5qE+fsuEA1MuoJOg48z/hO4giaQ69AuZg9RB7c+0YUKoYE4YB2hpVQ+LSX68walVDTOp
         x4pg==
X-Gm-Message-State: AOAM5333xF1T2S6w5S0CzQU4nNnYSxt3JOAyRuOaq74OE833e386mY2i
        qwUJN6Tu2tUlOuaiEFp/IeTpA5bGGG0=
X-Google-Smtp-Source: ABdhPJxb0/cqPfgx+AtFIEYXoQn7rFw9hVwhWLa/xdUqzVCRQ4RpoCuGNKpUO9nZ933mnzHCpgHPMA==
X-Received: by 2002:aca:4306:: with SMTP id q6mr2168933oia.128.1598713553709;
        Sat, 29 Aug 2020 08:05:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o11sm536368oia.6.2020.08.29.08.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Aug 2020 08:05:53 -0700 (PDT)
Date:   Sat, 29 Aug 2020 08:05:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
Message-ID: <20200829150551.GA27225@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Aug 29, 2020 at 02:45:38PM +0200, Luc Van Oostenryck wrote:
> For ppc32, the functions fsl_ioread64() & fsl_ioread64be()
> use lower_32_bits() as a fancy way to cast the pointer to u32
> in order to do non-atomic 64-bit IO.
> 
> But the pointer is already 32-bit, so simply cast the pointer to u32.
> 
> This fixes a compile error introduced by
>    ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")
> 
> Fixes: ef91bb196b0db1013ef8705367bc2d7944ef696b

checkpatch complains about this and prefers 

Fixes: ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")

Otherwise

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Zhang Wei <zw@zh-kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/dma/fsldma.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index 56f18ae99233..6f6fa7641fa2 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -205,7 +205,7 @@ struct fsldma_chan {
>  #else
>  static u64 fsl_ioread64(const u64 __iomem *addr)
>  {
> -	u32 fsl_addr = lower_32_bits(addr);
> +	u32 fsl_addr = (u32) addr;
>  	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
>  
>  	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
> @@ -219,7 +219,7 @@ static void fsl_iowrite64(u64 val, u64 __iomem *addr)
>  
>  static u64 fsl_ioread64be(const u64 __iomem *addr)
>  {
> -	u32 fsl_addr = lower_32_bits(addr);
> +	u32 fsl_addr = (u32) addr;
>  	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
>  
>  	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
> -- 
> 2.28.0
> 
