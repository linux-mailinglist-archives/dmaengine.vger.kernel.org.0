Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83A60658
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 15:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfGENJF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 09:09:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37079 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfGENJF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jul 2019 09:09:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so7113211oih.4;
        Fri, 05 Jul 2019 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5aBgcZX8BM3lrWnJ+kbRYl9+W/2MtbDb5XJ+5mk5o8=;
        b=OewWw3WvArDnn1VafRBRT/VICgzg+jvhtqmojq9/wwo3ca8p+TO1E8ZN1+nqfZm8Uk
         ZhpWVDdTGaUg/Kh7P2lMU/RYpp7fWr+06UWvtqlFvSVqV2yrRz3db6T9LjBsCMspOlML
         ExkH05cgGPqmJgT+y+cfPnN+c6RUNjd3nadMvlxw2/FVgy9eul0ceJFFfIeaorbgIms5
         8Q3R1m+ZYMLGKFeB+UNpihZdVhZwG87drcgunyYcJJme7mP1wrJt+jtJ2jbNDAQ64lB/
         pDxrJrjczVzWvKHm51jlkU63C0Lu9n+R5i0GWcc2eaYQufKYJZgnd7527zOMVa/Ttq2M
         vsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5aBgcZX8BM3lrWnJ+kbRYl9+W/2MtbDb5XJ+5mk5o8=;
        b=SLC5iw92Bdd0IyumJ+qe97A/s0N6Q1ZhBWexpPUFGUxIGmtfIvup/Nl+e8slLVTj2O
         AQOiHgjZtjhxpH9HdkERjAHdRiU8or7bFTsjLXNK8s2YlQJDDuW2f4i8tFBRIQYL5sp3
         AhJ8nMGXY3a1oRPlmDtkWigE8Osspjf1FrcKAgLPoY0musKkqfO+ZewfasxyqLQCMgP5
         vXftQGFIKMrLo8plC0vLB5v/wXhdMSKKHur2kVivENSZ03VwZd75FKQlqz8TXIsTnLVG
         +jlOEUnXsnJ89vfies/pDr8zi6MtOEaVkxd/lbLntBjEpnZNRmvz/to95mI1MyJRBV6A
         wfSw==
X-Gm-Message-State: APjAAAWtfQCxzaZtHavnZ00wtYaRL4/rIH+2fcc4FygZJwx166EmhvjH
        QaFDgp74OPySamCFWmJxm2/JscXY57J+NUvDmgezgw==
X-Google-Smtp-Source: APXvYqxui889Mq8R7ntAdj+DPEOHSrvmC2KImz0tEUKn6wObFBF7Gej1LLd0cbAtmODQa/QDNY+TjhCj1VCsMQusUEI=
X-Received: by 2002:aca:bb08:: with SMTP id l8mr1835062oif.92.1562332143968;
 Fri, 05 Jul 2019 06:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com> <20190705124646.GD2911@vkoul-mobl>
In-Reply-To: <20190705124646.GD2911@vkoul-mobl>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 5 Jul 2019 09:08:53 -0400
Message-ID: <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error path
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Jul 5, 2019 at 8:50 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> there is an else here too!
>

You are of course right, I was looking at the wrong if.

Apologies for the confusion, I did try to look at what you
changed, but your git repo listed in MAINTAINERS appears
unresponsive for me?

Thanks, Sven
