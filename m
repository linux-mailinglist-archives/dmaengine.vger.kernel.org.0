Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF630E08E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBCRJt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 12:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhBCRJp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:09:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83844C061573;
        Wed,  3 Feb 2021 09:09:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l18so52956pji.3;
        Wed, 03 Feb 2021 09:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xk2EwKQ1eHpmkOxJJbFec7Fsbi451sNnu9yFO3pOpow=;
        b=o6FkmBZZ55VlbVJtzpjqacQSCpePFCRO4MUyRhKyGBWHN4gN/+yiC63+b4UY4oeBmC
         jbLycpyLm8RRrv1SfzhIypcbuzNEmxjnGs6w9CblYztV7roGW/0Ax5tevK1oShkqB8ti
         uEmXP0+HUzIePali5/RjP+vHcoDDqaCSfQQTaODxZeES6wGQFRB8J4vlG3oSODpm2/hC
         7jWRbJGFLRcnCxaM5VsXVvSog+7ohfLPVIwdem7rG+n6Ip/ThbQ6EutxhhGb7kx8fnEq
         QXqcPOnp2hPNzuW81yYaRkZpLjR/sTKyLKkDaVhPSrG/kCaLXIPWzcRk+ceu9kIzkZXE
         PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xk2EwKQ1eHpmkOxJJbFec7Fsbi451sNnu9yFO3pOpow=;
        b=f5Lv/YA3Ux99bcwR1bS3vVsPbMAMygu9ZUnhvIirGL2twvzCBQduoICsck3OvUnAdq
         YArRwbGV90lIRYeRmmKtXWbKlyWEa7xS0Lx1e4QALo971aEjOEa8E/2XXLwZfBa4w9FK
         vbFjOEAWjH62lfiyjHL3V0dK9ntPB5uMWV0qfULcJufqHQGphD3NyZwriIvi7ejXRNgv
         qYcHjFgrrTdUZnzi/2ueRMEbvxYXRh6AtTGSl5/8l+jG2o7b/olkB6mdfldhWkCctswT
         JXPHGn2Jgi2xtyW4Bcdwx1lwKUDvsuM0cVV/pT9KF6IdV/xcJlRY8gM9GzdPVZQlUXTK
         3OBg==
X-Gm-Message-State: AOAM531FZTahUpeGyNV8y5IJsAFHtPwdHa6Xa3l13r1EjkVQh5bMJLbi
        KmP8aX01T0eLFZwXxi+3WACyyL+S41N/nFClGA7Ygnqz2KBqlA==
X-Google-Smtp-Source: ABdhPJyhhLCFZs45Lh41E648LIXAWVDNk6suG6+t6Bdb9WCk87cQQsQbiQrSd0JW0BqjxJLstc1Q5gDdnpN6tb/J2mw=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr4061074pja.228.1612372145098;
 Wed, 03 Feb 2021 09:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20210203155100.15034-1-cezary.rojewski@intel.com> <CAHp75VeuL0d48JBBQrb=twQvtwh4E_oB8Aszy+GtszhNWKqAmg@mail.gmail.com>
In-Reply-To: <CAHp75VeuL0d48JBBQrb=twQvtwh4E_oB8Aszy+GtszhNWKqAmg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Feb 2021 19:08:49 +0200
Message-ID: <CAHp75Vc-By8mNzBoMqVSNac_yjX3J_Tv24pSxAw1FEFHTAwFLA@mail.gmail.com>
Subject: Re: [PATCH] Revert "dmaengine: dw: Enable runtime PM"
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        viresh kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 3, 2021 at 7:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 5:53 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
> >
> > This reverts commit 842067940a3e3fc008a60fee388e000219b32632.
> > For some solutions e.g. sound/soc/intel/catpt, DW DMA is part of a
> > compound device (in that very example, domains: ADSP, SSP0, SSP1, DMA0
> > and DMA1 are part of a single entity) rather than being a standalone
> > one. Driver for said device may enlist DMA to transfer data during
> > suspend or resume sequences.
> >
> > Manipulating RPM explicitly in dw's DMA request and release channel
> > functions causes suspend() to also invoke resume() for the exact same
> > device. Similar situation occurs for resume() sequence. Effectively
> > renders device dysfunctional after first suspend() attempt. Revert the
> > change to address the problem.
>
> I kinda had the mixed feelings about this, thanks for the report.

Side note: the better solution in general seems to have a specific
power domain for the ASoC multi-function devices (if ever you move to
use auxiliary bus, it may be done easier I think).

-- 
With Best Regards,
Andy Shevchenko
