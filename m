Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E91193D85
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2020 12:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZLCb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Mar 2020 07:02:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45234 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCZLCb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Mar 2020 07:02:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id t17so5883106ljc.12
        for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2020 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBYI2pw9sfGjCi0bzv0yJEEWCyqkyjizmfbFD6llCpw=;
        b=wTmRLYkaXfjcDQz+CdaZDxndUCSZxc+ZmhUW90ynmlTOSPwHaSPR/ClhO/nWxAf7KV
         4qbWZyni701zQEPh+GULzYXBJxAUVIBHjJXNvg5C3+il+bmdr2lje+8Fq7GiQ+0JtyfK
         eHrlGTE66PPY62wp1VinlnBxYkMI9JO103TdN/wSPU6ZndMqYfHMyxZNKAJ96zdibjd4
         d6P/2e2ei6EJUpHWQRRHplaPcdSfQB/WJgmBVQ0EF1EJNGJFGusx7B6eHWAMA+66upts
         /8YOfHxZHJrkiw4F/7IWsJMqiYVYzTsmxEJUtQZNq9RvgaoF57MbAqhJQ90NjUkol4Ii
         5+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBYI2pw9sfGjCi0bzv0yJEEWCyqkyjizmfbFD6llCpw=;
        b=Vu+Kqrv4bRtz1H7jDgLF0KDQDBht9nBc4HAN3M4BQ88K5ibRbN+G0p29aFEvBqbsk/
         VOZR/Mmkg96vn6yCu/UNgP+BlCrBvFmgnifGSdGhSv8LJrjPqaTrKkCyTPRdEFuW3aSF
         8GfevZhvi4S/8OMn84vEyRRsDGE1Rx8vsAziwa520Im/BgtRZ8hUz/pIt3nfZK/e8uOK
         IHIf6PciMjYW5jzYVY402/jQ2ypULHgiNlXJuJ7aJU0DxtQx0D+MR8OFcNcL8HyCv2l7
         nKtLT9BgjZX/NQM35NbfIBjwR7DQrRbLHmH13ax/CYg8o1TZbZLFxd7wrIF5+1g7BBCG
         lGWA==
X-Gm-Message-State: ANhLgQ0nX5jXTLRMzuu6Sh2o7vlKmxlzgMvgdySuksHdrmJi+gwF4+Qz
        hslWYlmcZAwWiX+xbEqYx0yuiqtLJctCGnE4YA0Iog==
X-Google-Smtp-Source: ADFU+vuAu4NKjgOw04+YhFG4R26tuG7+/x5c+7Ylo0beaM6wZX++zLVCej8OOV3pch4cA7VonOGw2KOeqtn4XOjj9jY=
X-Received: by 2002:a05:651c:445:: with SMTP id g5mr4725550ljg.125.1585220547769;
 Thu, 26 Mar 2020 04:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113407.26996-1-ulf.hansson@linaro.org> <20200325113407.26996-3-ulf.hansson@linaro.org>
In-Reply-To: <20200325113407.26996-3-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 12:02:16 +0100
Message-ID: <CACRpkdYVTyViFk9CWwQsfLxsNRbinJs=wEX=th6QVH-fL_YQ7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] amba: Initialize dma_parms for amba devices
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 25, 2020 at 12:34 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> It's currently the amba driver's responsibility to initialize the pointer,
> dma_parms, for its corresponding struct device. The benefit with this
> approach allows us to avoid the initialization and to not waste memory for
> the struct device_dma_parameters, as this can be decided on a case by case
> basis.
>
> However, it has turned out that this approach is not very practical. Not
> only does it lead to open coding, but also to real errors. In principle
> callers of dma_set_max_seg_size() doesn't check the error code, but just
> assumes it succeeds.
>
> For these reasons, let's do the initialization from the common amba bus at
> the device registration point. This also follows the way the PCI devices
> are being managed, see pci_device_add().
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
