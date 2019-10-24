Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6C9E3042
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 13:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438928AbfJXLXH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 07:23:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436501AbfJXLXH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Oct 2019 07:23:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so14951796pfo.10;
        Thu, 24 Oct 2019 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ls0W+64w3PGvyuiP9luWgbDevluvHPGKPEVNOAGncE=;
        b=MY59WQDKl4p83dfWdP9QAIjPqrfox2Yv+fYcDPhdml+5AzHRS9Qnq2b91AGO52p9DS
         Ej8X3Oxd7J3dLDU0mAEpR52DNngLwLCMRducvFQ4Vr4XqFM5zvBYVkh6yXde1z565w2c
         RjsPtDlcAXuI4EnGstitG/cNLmZ/xWTDgxswdVTaYBFuz2TwDQNfjGaTzcxFUa4rW+Ww
         yfdhXOq7OpBVNPgsInckEGqvCWjsmKY4O/XKsuy2AjbMkCRx4FbeZy1gcHO2cc50IP1z
         4Otlf04WX8fUoYuvXMqK58m8nisWeTsSEcactdcmkrXYG+LoPvGkZEzdEiHJtQGBbj8q
         7ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ls0W+64w3PGvyuiP9luWgbDevluvHPGKPEVNOAGncE=;
        b=PLssQN6To2NHHqdOhmFa0ZvYJqsKgDJMXs97dEo5UV9Q16EbON208DJjHETpSNOQAB
         VjBdqeevnpSITotvevp0guG8Yac+HJUyssecNLU/dvLkGm7AnVFfWQywvVHc5ZSOLFOd
         ev/PT5PduxqjcByDrN2R17GwTeXOgPJfMiGwZUh+t7qwD+jxOXy/IEFl5UEwfKenGQzy
         8QIJgez387rRKY4iwL3bx+fDT2Bm1EFmOBEDSS8XCFXwgabYdDzutZHS6tsqOGfW+KAo
         lB+ren/3lisDoGpOpjo4VzEe9ejuX6QtosymZ/0jIqHch3APyK9OiQR/PZgm00EJJW0o
         u1Zg==
X-Gm-Message-State: APjAAAUq+KlkMv6XEDIjeco0spqcBJol4aHAJRzO69ReNsRlBP183PuX
        OdW8rBlKAH7Zqz8MKPK3blnS46ptm3p1vYwKI9dJvCGOrhw=
X-Google-Smtp-Source: APXvYqwTOXYKFz4zL+nTklqXxFVSq0ni8Z2/5Q9mcA3tN9XvSXhZOL//KmM33TZrq+Zt0lSMZYmOPl62zpUg+bInOeY=
X-Received: by 2002:a65:5bca:: with SMTP id o10mr15618588pgr.74.1571916185802;
 Thu, 24 Oct 2019 04:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191023153138.23442-1-tony@atomide.com> <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com> <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
 <20191023191859.GQ5610@atomide.com> <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
 <20191023201829.GR5610@atomide.com> <4bcd75d8-b7c5-5006-d80f-c5bda0cdf011@ti.com>
In-Reply-To: <4bcd75d8-b7c5-5006-d80f-c5bda0cdf011@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Oct 2019 14:22:54 +0300
Message-ID: <CAHp75VfOHjzO=ar+G7ieJo49=Nt8kFwUnA__B7vX8+Gh4JZqzg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 24, 2019 at 11:51 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 23/10/2019 23.18, Tony Lindgren wrote:

> And the USB cable connect/disconnect is handled in interrupt -> you need
> to call pm_runtime_get_sync(dmadev) from interrupt context and need to
> mark the dmadev to pm_runtime_irq_safe()

Side note: and please don't spread the pm_runtime_irq_safe() hack more...
I think Tony is quite aware of this.

-- 
With Best Regards,
Andy Shevchenko
