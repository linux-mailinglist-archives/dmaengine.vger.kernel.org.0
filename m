Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFDE3AE027
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFTUOy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Jun 2021 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUOy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Jun 2021 16:14:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5302C061574
        for <dmaengine@vger.kernel.org>; Sun, 20 Jun 2021 13:12:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h4so26535988lfu.8
        for <dmaengine@vger.kernel.org>; Sun, 20 Jun 2021 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQCE+dliVmLf3P2AuQopOl7SKalAr83I8wCiqD5FuhU=;
        b=Szy3QAm2SramFPCzL8FuRDsJjSYHjWPB0EnFobXDw2C9XZZbe/QYwhumAHT0zVz49u
         GRLPKvVWquZ0ApOWaWq5bnFdxSOBDJ7CE7kfL+/f6+eavn0mPFOJBgfGJd5HYYX6G+e/
         6jtThp20XGhg0z3IF3cgKeakIetlqW4LRqGAO1Efl6O8ZvKvh+xMmem/rAloxmBx+6bQ
         An2iXpu/ZOWhBf6vGCtu9+Wds4RpGAz8xegx20oJy4mhFBTQi5akSLJZoBxVGpzmTJUB
         16kmbB5rGWWXOK0pLgH2pn9ErGbmRgAGk3ib3+GhjSpfxEnLH2AZ27MNSsxHThz0ybAf
         0OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQCE+dliVmLf3P2AuQopOl7SKalAr83I8wCiqD5FuhU=;
        b=j7U/q1AaUf98L4mXwe79L0NRF3IUJ35isGQ3i5zGsEIx8yhM9cTLXM72QEh7iCjmbw
         AiSWMa4nVuRf2uCfWgTIs7jYSRWIepow2GOJsZnOmiiAFipIszvCyZNBgogI3ywSEpQO
         8iEeVCKL8DPRGrHJZO+8JNhwk9+F1KCBcsFTkTUR6OcjkEy22HuEdxsZIcxa5F28Cpt2
         AHQwTA3Zfmwpe3wjTVHr/PcppK59ZbOjV5acsRGv460p6jqKGzzB3N099exl/FFWW6Gu
         e1XU1zvWba4fJ7fC5abZzGXhzgwyTP2wU0aFC4ZP5Auop/t1H9XOeKGpX3AM5EjRazcG
         TB5w==
X-Gm-Message-State: AOAM530ceIKLvnPj/3jFRFOp195JHY8zkiViHejRAiL28gMPdAOWcocM
        RZfZYdms3qnsVgwPZTqJ2/nNpWX2OuqLBCEvTCYVcAGISFU=
X-Google-Smtp-Source: ABdhPJzmdSIW8Y+J5yBD8slKYsSZudmwwc1RmOtUue2gOR9HjFhtBJdcGfmM5RJyjcVKDf5Mb3OkFzFzYLkg3vumpFA=
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr1867992lfo.295.1624219959093;
 Sun, 20 Jun 2021 13:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210620191103.156626-1-vz@mleia.com>
In-Reply-To: <20210620191103.156626-1-vz@mleia.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 20 Jun 2021 17:12:27 -0300
Message-ID: <CAOMZO5BVEP0Z06-v5RShB5tk7h1JxYiDNmaEomx_+NcSEgG+QQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: Remove platform data header
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vladimir,

On Sun, Jun 20, 2021 at 4:11 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> Since commit 6c5f05a6cd88 ("ARM: imx3: Remove imx3 soc_init()")
> there are no more users of struct sdma_script_start_addrs outside
> of the driver itself, thus let's move the struct declaration just
> to the driver source code and remove the header file as unused one.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Good catch:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
