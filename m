Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727E76FB56
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGVIcA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 04:32:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46788 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfGVIb7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 04:31:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so37605359qtn.13;
        Mon, 22 Jul 2019 01:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP0nbmsifYCzd3jNOn99GVAeFmpNunbIC0Kq27beutY=;
        b=qVGx5L0T069oIZxymtCc4y8q+X2ok5sT/W9e4+u7KgL7knQ3FRlYNcHG+/Tgv4sWqs
         LJU1uStSwUoWiOY+PTGQRYDPgxtHvJo8CDBom8jK05WD8NAFLISY8eJvWkNrA/8b/JhU
         r99NNQLeOQy8qayG6/9YdKF5YL0N/6JOpEFDnsNHreRYxKJuW2v+ImOyW/YShMCfaCz1
         W4VrTw9BceQn+nLSv7UswAG2nH79eWN0u4/AMHAAux5CR1lmp8oLBhx3U9m+pDFV+M+Q
         8/mFKHF/3X1+h5PJbQLlldEV4d3inC1J4KSP6rTcz0NzrCSVimcoFYdaX8x8X6KKNWmI
         iB0w==
X-Gm-Message-State: APjAAAV7T8weJCW2/lpCazisp+G5hB7KIMg+tYyUMWL7BkE8MgxpMHOU
        P8gPK67pyFxj3srYvniT16hmmMWFhwWDyEUzJTk=
X-Google-Smtp-Source: APXvYqwY6NELHyjo5eYsa2GKjeVYDwJoABufs2FhlniZMp1qxhCMv3/4XbgcYi75VOd2ow9DACzkH64S8Ak0YGx1hLg=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr47240030qtn.304.1563784318805;
 Mon, 22 Jul 2019 01:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190722081705.2084961-1-arnd@arndb.de>
In-Reply-To: <20190722081705.2084961-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 10:31:42 +0200
Message-ID: <CAK8P3a39YBEueSGo-DpVOH3nE88T7DyarcoT29XZ13onCRP1Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make omap_dma_filter_fn private
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 22, 2019 at 10:17 AM Arnd Bergmann <arnd@arndb.de> wrote:
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - * OMAP DMA Engine support
> - *


I noticed this causes a trivial merge conflict (the file change but still
needs to get removed), let me know if you need me to resend the patch.

      Arnd
