Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5D4E2A1
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUJFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 05:05:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36236 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFUJFb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 05:05:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so6180380qtl.3;
        Fri, 21 Jun 2019 02:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rkv6dR4XChzJp8kYVDvffLCfz79gLMFodiv/FkuPCHo=;
        b=ccVbStD9tyO3+C1twcHrXk0egE6qV2DMij8IdX96NNcaZcILA96aqPrYXjugNJSh5O
         ovEBYhv35cfGEV34rcWO08eor7iAKVKkrg2Er74B3jCzrTMckz/bx2YHmX1HUpwLPYfJ
         eIy2+ZBzHhMGsvIJ6qY9oyFUyLYgUixJcSiV/j8b/J8o7xMEoB1iRvXmcqb/bgH8LXNZ
         JWvvyHI5CoCKO5eI9xezyBeVxz5actzXVpUJJMED2ERdh9eLXs5sYVGxTa3kw2YnmNaP
         O2VteMpejKWwhQTRumbmYwHXDbdRpJBa0NcNHsFqYOgGOIxidGX6LaD9zrM+jKS+huku
         pBhA==
X-Gm-Message-State: APjAAAWyHirpTmzAORzvm26fB1iv9+uOJESG3oSweWXETV+seiwMFm3e
        PeXtdHUm1UqsJkHqTacBCykJ3YtCH8BA51whsaE=
X-Google-Smtp-Source: APXvYqz8oB8js3MFpU1LemL9NrKFA9/41AtXa205Aml2EuvOo6htfjU6IQxIIqjYmg1tvCkFvW13HUVFLknycA1Gfps=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr81359991qtd.18.1561107930740;
 Fri, 21 Jun 2019 02:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131733.2429469-1-arnd@arndb.de> <DM6PR12MB401006CA0446C71E36786E75DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB401006CA0446C71E36786E75DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 11:05:11 +0200
Message-ID: <CAK8P3a3TE2hu=gjyf5gVj3HufVacFSoc4WjOVpgP3bz0LBbGKQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dw-edma: fix unnecessary stack usage
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 21, 2019 at 10:21 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:

> On Mon, Jun 17, 2019 at 14:16:45, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Putting large constant data on the stack causes unnecessary overhead
> > and stack usage:
> >
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:285:6: error: stack frame size of 1376 bytes in function 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than=]
>
> I had that warning at the beginning of the development, that's why I
> divided the debugfs entries into several subfunctions. Perhaps my
> configuration has configured a bigger stack frame size than your
> configuration.

I suspect the problem is CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE,
which is a farily new configuration option that has the unintended side-effect
of sometimes preventing the compiler combining local variables from functions
inlined into the caller. Adding 'noinline_for_stack' to the sub-functions would
have also prevented this, but I think just not having the strings on the
stack is better anyway.

        Arnd
