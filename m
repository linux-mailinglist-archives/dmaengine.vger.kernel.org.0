Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB01E6CBA
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407324AbgE1Uir (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407218AbgE1Uip (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 16:38:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9010CC08C5C6;
        Thu, 28 May 2020 13:38:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so143813pgn.4;
        Thu, 28 May 2020 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUmAHxoLCci70CIyQKHJVkgQVBujsUNyRL0aI0R0aqo=;
        b=I1cMDUG4Wbl6ZX/z5HWJTm2du5yh0gMU/JPmyLOA29gjDIaqZCuFlq1Akwl3x2elMt
         ocKJz6UFSs9RV8uUTGDo6qDUWd3ujnAqcC0wVQzxSf5C4KAdnYFrC2ux/mp9wHzQoU3I
         8sxF6hLFmWwdrvdGrJQR23vCVeXjvY3uf4ee+i0j7VVO7ldGgG6UHkEwvEs7NSJvucXr
         u/HX7g9A/JHwTmtNm/pizzgaEFtaHRhTXL/OSQZU6alHCgQkzALi5i6A9EqjaPivx4Ho
         YuugbZTUH2NeinzeiTFXp2XiO++0eeSonK5SMIVAiaoA3IMaWw/M6AJvPgZqSbvhlFLk
         lFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUmAHxoLCci70CIyQKHJVkgQVBujsUNyRL0aI0R0aqo=;
        b=IxfjS8uS3RD4gupLgRT3aQi0J1qxkiIQW8burB1ym+nuF6AbCWIJwtbFL5h1xsBNH+
         eU7ycey3at/NcmDQMpKsMYM9IRqMz0hdNjD2ZioW6pdWdPIA3I9jWc6o6jDHcJKOjWBS
         rt53vx1V3BJy53ODlDc/PZI5jwN/5xYVVY4OgnGjTZrceKGGDQr57eVXaUhc7qvxCcll
         M00oitiocwwMAQo3gs4HvIiLoLzLlBElYDyG0JBOa2tbxZPs2WrJkKYREhUp3yC/s0Zv
         hLGh0bJwK5Ja+mUXQQCrhqZqCXS1WaIxjKFmYc8VQDwqaXqKGvolOWD4C6BS6uWG1ec1
         A1nA==
X-Gm-Message-State: AOAM531wGp0ZtG3xBvNfUpzdu9rBHP+Pd5VibI6KiUHzhzTmvCl5wPr5
        bgzA1RdRMbH5Iu2FxCh4FvYL6UwO90DnPSm0Qfc=
X-Google-Smtp-Source: ABdhPJwe8DmfXiHurV89f6av71936kl+HM4lp/ZzAxpMRXlN2Qv/GB4+dYblIxf4soDqHWyWkLuJ27OfLk4KVGGMVXw=
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr5137217pfi.36.1590698325132;
 Thu, 28 May 2020 13:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-10-Sergey.Semin@baikalelectronics.ru>
 <20200528145224.GT1634618@smile.fi.intel.com> <20200528154022.3reghhjcd4dnsr3g@mobilestation>
In-Reply-To: <20200528154022.3reghhjcd4dnsr3g@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 May 2020 23:38:28 +0300
Message-ID: <CAHp75VcPVO6yOmyrSBfjVk5eSYhC4J0QXAfOhjRXGd4=FemezA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] dmaengine: dw: Introduce max burst length hw config
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 28, 2020 at 6:43 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Thu, May 28, 2020 at 05:52:24PM +0300, Andy Shevchenko wrote:
> > On Wed, May 27, 2020 at 01:50:20AM +0300, Serge Semin wrote:

...

> > Perhaps,
> >
> >       /* DesignWare DMA supports burst value from 0 */
> >       caps->min_burst = 0;
>
> Regarding min_burst being zero. I don't fully understand what it means.
> It means no burst or burst with minimum length or what?
> In fact DW DMA burst length starts from 1. Remember the burst-length run-time
> parameter we were arguing about? Anyway the driver makes sure that both
> 0 and 1 requested burst length are setup as burst length of 1 in the
> CTLx.SRC_MSIZE, CTLx.DST_MSIZE fields.

Yeah, I also thought about it after I sent a message. 1 sounds better.

-- 
With Best Regards,
Andy Shevchenko
