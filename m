Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7613A4114E3
	for <lists+dmaengine@lfdr.de>; Mon, 20 Sep 2021 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhITMwh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Sep 2021 08:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233587AbhITMwh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Sep 2021 08:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F65E610A8;
        Mon, 20 Sep 2021 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632142270;
        bh=4WoXR2w/h9re32MIQ0x+GJKbqB4GhEs6CMM54BSGfSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LNSxxG4vjfOT5jWs0Azwe5jxmYBWyLg3WgYpAFCdNepx7w2EnOHuAuQUuhKvs8HLs
         Nfk3wkE6tswZtAzK713jWu+LkH1iH5jlRjvcPzskBxe1+DeVuqc/z0DmCBha73hb7P
         xg8HFEr58wYhNiiYCcJiv0FEDE7S+POoytMwoWlSHmxjyAiV+xVk33tb2sNJLldPPY
         uPeC5MW3gPbE8J8qvSFhIPqBjE19yWlr5PmlQIgbXxtbVM7VuVXvQ1JmX2nRoDgOmJ
         P3Ij/hTet6Gc4DNdyvkhiUm/6rolYgijAZwGjmbUNxwFW9D5RuSFKc7T/PM/PqHOgO
         4TJp6jQGAmhHQ==
Received: by mail-wr1-f44.google.com with SMTP id q11so29359873wrr.9;
        Mon, 20 Sep 2021 05:51:10 -0700 (PDT)
X-Gm-Message-State: AOAM530NBAjU8yu07A/JGQ3REZf4A6nJ26x4nU3qxjgkU5C5bJDuXN4G
        +ci7oaEvw0FBAPxubyWDy/8FsA5wkHPlzbgmT18=
X-Google-Smtp-Source: ABdhPJzFtZLgwcroeT9Z0tz/FjbRi+f8dH2LRv8hahyF9SoTtIHIO8zGevWiY6lKXq4ydmHTOt/2gr9MwU4SIvH0gdk=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr28119752wrs.71.1632142268846;
 Mon, 20 Sep 2021 05:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210920122017.205975-1-arnd@kernel.org> <YUiCy7A9cXTDGx6s@pendragon.ideasonboard.com>
In-Reply-To: <YUiCy7A9cXTDGx6s@pendragon.ideasonboard.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 20 Sep 2021 14:50:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1fcmCWsOuqF8qy4ko9MC8nCd4gyt2K6Rk5K-Zs7yCbJA@mail.gmail.com>
Message-ID: <CAK8P3a1fcmCWsOuqF8qy4ko9MC8nCd4gyt2K6Rk5K-Zs7yCbJA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: remove debugfs #ifdef
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jianqiang Chen <jianqiang.chen@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 20, 2021 at 2:47 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> It's only a few bytes of data in struct dma_device, but a bit more in
> .text here. Is the simplification really required in this driver ?

The intention was to not change the resulting object code in this driver,
and I still don't see where it would grow after dead-code-elimination removes
all the unused static functions. What am I missing?

        Arnd
