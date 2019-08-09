Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62F48836B
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2019 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHIToJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Aug 2019 15:44:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIToI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Aug 2019 15:44:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so18526886otk.13
        for <dmaengine@vger.kernel.org>; Fri, 09 Aug 2019 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwTeQv0nkF8ZzkbuQwNoI5oM1jAqjP+SUKLHmshqgU4=;
        b=rVihWVM562FWHeevrHmURj44PEleWt0ASN0AHKY6Hov5uYsCDz6oAGJ08b5H+EjqCD
         hrjmBpOMNbBTXqmeCjkz46TBjIJrLkXjEjT+pVCiYGb3t70pJZ2s6SOhfMQAgipiQcfh
         voXpiKFXiOl4fpATrz2qU7P+Vg3vo2ah//XnRDQOufMi7c8/E93rAoGgLk+1pT8eIesw
         585O3KBYW/5zl+F/ep6RKtKY1WSoGGTwUAiTU/eKHm+FE0rZel3W99kgCKtIDv2+gsT6
         wOOIjgW/HCzR2ZqBx4Wu4gcauVBAzX3ll5QJUQsdIRWzbWiBDlsl1aGpBEBpZSKJ+Urg
         5L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwTeQv0nkF8ZzkbuQwNoI5oM1jAqjP+SUKLHmshqgU4=;
        b=Z0Zxr0NKTkIwmwArZHO3NJoAG2QVbY0jpW/kTXPvWS0PEUB7+VdaV7XoQswDqugFJE
         BYIITIyA1ooLz59b8aKNBHZU3fJEJB9rD6WWzIxpB7L9CHN65c5Gy4dsbmSr7RvhjwZ0
         LLjXFlhHoOpfzjeXRM5VIT4NsKpqbtWY05IhEKfPGA6icW5kfdhXSS6+CMzv5Bm1Bdpn
         QkMGGuzr9fUIlZO+YJF0HAr5CHO6W9TTFQeg51gSHjZ6x426rBvkBf/33il6X/7utGVo
         g7/X3P2C8SVFreZ3pkJwPbAwv02BOp5AIorLDZuWw8KHWsDRwzA+ipNl/1yCTJQr8laH
         OhLA==
X-Gm-Message-State: APjAAAXeVmlOjdasj4i3j3mLb/e0MfRVuTJgeiaBhyQK3JBVTHMGmL6U
        NftjoD7acHPXBF0J3HUoNM93zpa12Z+wGdx2g+v3Ug==
X-Google-Smtp-Source: APXvYqwmGWxKnhH0pu0CdmdtkY9MWiQA2sqa6Y0AXYzLsTz11/rPRS6N91uTv6hH5s8O/RR8/YTXeJBAlToJ8WjZMUg=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr7522848oig.105.1565379847824;
 Fri, 09 Aug 2019 12:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com> <20190809183658.GA13294@shell.armlinux.org.uk>
In-Reply-To: <20190809183658.GA13294@shell.armlinux.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 9 Aug 2019 12:43:56 -0700
Message-ID: <CAPcyv4juKU5TLU+3=xAw0Hq=6EeLSxKA4C9kR1YqEV8XuH7e2Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 9, 2019 at 11:37 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Aug 09, 2019 at 11:34:12AM -0700, Dan Williams wrote:
> > [ add Martin (if cyrius.com address is still valid) ]
> >
> > On Fri, Aug 9, 2019 at 9:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > There are three families of IOP machines we support in Linux: iop32x
> > > (which includes EP80219), iop33x and iop13xx (aka IOP34x aka WP8134x).
> > >
> > > All products we support in the kernel are based on the first of these,
> > > iop32x, the other families only ever supported the Intel reference
> > > boards but no actual machine anyone could ever buy.
> > >
> > > While one could clearly make them all three work in a single kernel
> > > with some work, this takes the easy way out, removing the later two
> > > platforms entirely, under the assumption that there are no remaining
> > > users.
> > >
> > > Earlier versions of OpenWRT and Debian both had support for iop32x
> > > but not the others, and they both dropped iop32x as well in their 2015
> > > releases.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > I'm just guessing that iop32x is still needed, and the other two are
> > > not. If anyone disagrees with that assessment, let me know so we
> > > can come up with an alternative approach.
> >
> > I'm not sure who would scream if iop32x support went away as well, but
> > I have not followed this space in years hence copying Martin.
> >
> > In any event:
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> Those of us who have and still run Thecus N2100's, for example?

Nice! Good to hear.
