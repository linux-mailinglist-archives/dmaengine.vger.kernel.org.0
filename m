Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD42036AF
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFVM1Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVM1Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jun 2020 08:27:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9760C061794;
        Mon, 22 Jun 2020 05:27:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l188so2183821qkf.10;
        Mon, 22 Jun 2020 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRfwCdLw+lBhNQtLxGKp6oI5intMTV4VxPqzaekWRpw=;
        b=frf3ht8XWmKO5bV4tGgU699ueXhbUG1Bs/wG77NbgVGaUlfPmHu9yEGG6nkTVxk8Oq
         fSJgwEksfQDgTemix2H0rhOoECWZFyijjl8ddbUG35Q3bRzl047kT32V6EaKwVtCFF+R
         omqcsThto5ndWEYwCmTZcbJE+TTywmmleD0FV+IzyBJWuxbOhgnA8/mblUBbfkO9rlN0
         ADCjY+VxOrXexGxUOGklhvBKLZKLPqeDeqVFR5hOPx+TQysamwJmhy962hvAoq1mRxrL
         y8cp3rw8z5DteqYsV+Rbe8vNAt7s64ttaU4AhAd0Iz7eAJpsxBpHnjLZ05wi0b0p+3Pp
         zyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRfwCdLw+lBhNQtLxGKp6oI5intMTV4VxPqzaekWRpw=;
        b=DClaWo+zoqyj+EaFufd/rmbvLu5RT4Hv1+iPf3m2sjESfuQnY4aC1l0UlyH2MgX2Kg
         oMvlLWaWvvWaw1Tx8hSNPdEc444AiBUvMHyn1Imc54RlAo4Snas+bm1lKITxXQt2mTzQ
         odltMFWyiCSmSmvP20Lbv/Uo7h1CheOP4Il0uDO4w/64KmkR+gUsNEcM7BaCPYYcqXMh
         JJpdUBtMmTG/dW+SCz2nQZw/jK7WKKTTExXgly7xej/g2ib2PdVakHqYRAvmDQ53EoMT
         FICsYMDq3SQ68PZd23nJpr6qc7XeDzeqB/i+EttJOu1zVS8o2So/N2JDDlKiYhZqaKDl
         mSAw==
X-Gm-Message-State: AOAM532mmpvKHdSqGZ3LwEp/+skDOvHbn1qW9fNRjOisOldruc93RCYD
        agFshf3rMeqGn05CFH6WNJvk/t72UsmDcuoEdsU=
X-Google-Smtp-Source: ABdhPJz1IrOnYmvEw3duZtLxZgFhm2K2p/F20WQvMA4Kr/6ekSopl6eRSUieG115zwp9mto13rbCGMwLpj6EjE5J5kc=
X-Received: by 2002:a37:9942:: with SMTP id b63mr15775646qke.370.1592828843080;
 Mon, 22 Jun 2020 05:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <5614531.lOV4Wx5bFT@harkonnen> <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl> <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl> <419762761.402939.1592827272368@mailbusiness.ionos.de>
In-Reply-To: <419762761.402939.1592827272368@mailbusiness.ionos.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 22 Jun 2020 14:27:12 +0200
Message-ID: <CAFLxGvyNazbyBpySuNA6SU-8tcvqYWKHsAHuhTLsofR=VoiEwQ@mail.gmail.com>
Subject: Re: DMA Engine: Transfer From Userspace
To:     Thomas Ruf <freelancer@rufusul.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 22, 2020 at 2:02 PM Thomas Ruf <freelancer@rufusul.de> wrote:
> > more the reason not do do so, why cant a kernel driver be added for your
> > usage?
>
> by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
> now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(
>
> just let me introduce myself and the project:
> - coding in C since '91
> - coding in C++ since '98
> - a lot of stuff not relevant for this ;-)
> - working as a freelancer since Nov '19
> - implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
> - last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
> - subscribed to dmaengine on friday, saw the start of this discussion on saturday
> - talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future

How do you preserve bounds? This is the main reason why vfio requires an iommu.

> here the struct for the ioctl:
>
> typedef struct {
>   unsigned int struct_size;
>   const void *src_user_ptr;
>   void *dst_user_ptr;
>   unsigned long length;
>   unsigned int timeout_in_ms;
> } dma_sg_proxy_arg_t;

Is this on top of uio or a complete new subsystem?

-- 
Thanks,
//richard
