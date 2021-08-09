Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C070F3E4AC1
	for <lists+dmaengine@lfdr.de>; Mon,  9 Aug 2021 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhHIRYr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Aug 2021 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhHIRYp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Aug 2021 13:24:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7EC0613D3
        for <dmaengine@vger.kernel.org>; Mon,  9 Aug 2021 10:24:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so1000328pjb.3
        for <dmaengine@vger.kernel.org>; Mon, 09 Aug 2021 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gs4gW+l2T7TdahYIhyNWz8Fk00e6QpvAFnWvp/vF2vA=;
        b=QNtmtd7G0oPxEhy8hJVtaOkdLQO+krtUwHzCsvtMiSwcZVSd5u1HHg6a6lvtAzh80w
         fXy3HMd1mC5QF1RYh7tyQUA7PVYf6jn1wBByu7E9P5V9g5DZrKPCZ8gJHICLKq5aVVDE
         cyxwWLtUfe8RIKLek0Lhalka5sQLNDx4sQatP/s2Q2vodfiliZcg2pdATMIueV5nG6j2
         mjMcJD+3j0V2gEQRvuEakHj+7jTV+J1QUdEisXdlKkpUyf4gAtTAHvpMziwdd9NZA3Of
         ehhnNY/p1AgC+aiTzdL0spyuOA2yvPibolHN7HDIMFwz39PLq5H3YXKaCnQEnJ8KVP9G
         PTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gs4gW+l2T7TdahYIhyNWz8Fk00e6QpvAFnWvp/vF2vA=;
        b=P+wdF0YwPPUXtl5H8jfgNvFxEebzZP8hwD7b36vrLAt0OqJUCh5B9VmXAmlEojOB53
         GSN1NW4mPDJsHKUjk0lwRey/YRKrWNsJcVrVh7NP+MYacsrOJHiB6xP3KRMRJBuUt8Rl
         PPLjX5rMN17hBaLcZ0pY2WUNtqMsq+Bol/HtnqtQ/jtt5PBP7WSLFxXFFBkgTXuZWvaO
         p6UfukURpMHqnCc2THDWldMxEzqVIUzo2IpR1uL7m+HFLDKMvrg1IX+nRbKP1T++1bud
         +f0AhZDkM4Kiqd6Fe/BjURdJ+AKgVVCqA3dAnBUtnZnHqSb4rMOifk9ZqGcG/4f3RSjG
         Yrog==
X-Gm-Message-State: AOAM531JGzUMdUxHBNREx9XRKdxwc3+jP70OyYh16UKdvalzHz0xwM9u
        sb0+HQPyzmviqWzNEgJ2dDN2EUGW+49E1nxFYwu6YWMHmwc=
X-Google-Smtp-Source: ABdhPJzJjW1qer+KBwpSYbKnVzgDhHYEPIQFwib+fr54nVRkboqJXfV5BnQJRdjJTYSF3ef3ekzfAp6myZdM17yrqJM=
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id
 z63-20020a6233420000b02903b763950a93mr18937861pfz.71.1628529864149; Mon, 09
 Aug 2021 10:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
In-Reply-To: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 9 Aug 2021 10:24:13 -0700
Message-ID: <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 9, 2021 at 2:25 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.
>

Do you really need to disable compilation of the whole driver just
because an arch level helper does not exist on UML builds? Isn't there
already a check for enqcmds on x86_64 to make sure the CPU is
sufficiently feature enabled?


> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 39b5b46e880f..dc155f75926d 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -315,7 +315,7 @@ config INTEL_IDXD_PERFMON
>
>  config INTEL_IOATDMA
>         tristate "Intel I/OAT DMA support"
> -       depends on PCI && X86_64
> +       depends on PCI && X86_64 && !UML
>         select DMA_ENGINE
>         select DMA_ENGINE_RAID
>         select DCA
> --
> 2.31.1
>
