Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F312241C07C
	for <lists+dmaengine@lfdr.de>; Wed, 29 Sep 2021 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhI2ITS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Sep 2021 04:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbhI2ITS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Sep 2021 04:19:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A907C06161C;
        Wed, 29 Sep 2021 01:17:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v18so5352102edc.11;
        Wed, 29 Sep 2021 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Maeih5tUC4IGxb6TaU3ujG0BYXONHWhJwShqzfNJ/Qc=;
        b=jw9fZoA+chpP11F6nZjyofL2cshWYjCDlvMa/RMBcm2QOW3ZMlm4IXt8u5JieBeh2F
         G1bPruCwFVUDTzT/O87PwrVU0ZQDmuFlU9pkEeBZ9DJLbIsznQhYwOWQnpdDkJm+M8Ey
         QG2rse3wN0s+1Tr/OOSJRSF2ci8qcoiCU9lnGlA/2lVIJGTbmlRw2tP5R8H5oCePB+dg
         QDntV8QhQtMFlEVRFOV039dHiwzGA5+gM924Di27b0Yn0buS8a1v79eENIlAM21U9B+r
         XD6AlqRpM5tPcXFD/Tlu4FHqtUJ9ereqDUBBPkAUvUnEIAfMYnBoig+9W84eYeMlAsnA
         i2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Maeih5tUC4IGxb6TaU3ujG0BYXONHWhJwShqzfNJ/Qc=;
        b=fDyknXphHh7JhERQ3tgVLYbYqLN24ucRXXldhnL12N19F6FfQe/N1AHOKVcRzHHJXS
         NhdE6blRkiXLfyMr5OXrH48tDHNdZZ+R2UqigjvaMuQzCor8wm1Iln5ineHbYpEh9AwJ
         jX+h/FxUeuU0q1qJCJXqFhp6wS4FiwGSZN5yuz+qbxzJCiu1KJNea5EyjRl2w+8P93sT
         qQxKguYZCqVDLCfli/tnskBRxtnXI3PUHRi/Q0gbXJQRAHz8m2BU5FaNBJ84r4E03cGr
         WE/lXGsUSNAU/s+ejv0ACmHWpEmITlSJYM7G5mBzfpdzZyx4z892fswSJ8heO8pVpvRa
         KkuA==
X-Gm-Message-State: AOAM532XxtBk/gw2OCDL9HfK1KTUgH8thrhtTXGFECC0d0cnw+jwM0vR
        hnTZ9CNFWAj4VwT1Yl1czrb3wTKAkVo044maNGE=
X-Google-Smtp-Source: ABdhPJxkIRHaus0vSj1sqMRDTlOPYlqj83YMqOOdS37uynaJXcfXIM7SC1sY4OYJvKwJeM4dObc1+6FnnEb4RmRtaas=
X-Received: by 2002:a17:906:3596:: with SMTP id o22mr12002303ejb.356.1632903456194;
 Wed, 29 Sep 2021 01:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <1632800583-108571-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1632800583-108571-1-git-send-email-wangqing@vivo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Sep 2021 11:17:00 +0300
Message-ID: <CAHp75Ve3u-LkqHYHY0VBy6y4KYx_WrOL+6LgXH9fyzpFfFcZrA@mail.gmail.com>
Subject: Re: [PATCH V2] dma: dw: switch from 'pci_' to 'dma_' API
To:     Qing Wang <wangqing@vivo.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 28, 2021 at 6:44 AM Qing Wang <wangqing@vivo.com> wrote:
>
> The wrappers in include/linux/pci-dma-compat.h should go away.

> The patch has been generated with the coccinelle script below.
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)

I believe I have said to remove the noise from the commit message.

> While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
> updated to a much less verbose 'dma_set_mask_and_coherent()'.

-- 
With Best Regards,
Andy Shevchenko
