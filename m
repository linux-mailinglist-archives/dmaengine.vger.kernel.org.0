Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694044E27D
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFUJBX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 05:01:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40784 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJBW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 05:01:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so6150365qtn.7;
        Fri, 21 Jun 2019 02:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HzRDcacmGtqmGfE244Fy6uOAK8PIsDaZn0yNCgG68w=;
        b=WC4ldDEqh98+jAK2BHEm6qqEMG9dtnaGvDu3ntwspsgB00CmgLUBlCt7EDfZd2KOMy
         ap8r+bTKn2gTmbE5DVHCYrIIZCAkxSvZz8wcj28ckx/Xj35J0u8KcqSmAPnCMnjX+EH4
         6eDgOJZJ58IpRi8JKwcXX81iA1ZvLQKPmoqZBYo697zFqkHZmSOvi2yISRyz0f5iZDfT
         ts1wzluzC77gTqvHrNNY80yLsaW+11DwID26tNFBOEcrFOFe1Rbu4udL/dxmgoCrAG56
         1Uhv96QUXp15dlQG+7w78hS3LnSucMLMVznZSFKExvKF8mVxsO4G3XOIq/btiADuX6+Q
         DfIg==
X-Gm-Message-State: APjAAAUj8xhDtmMArrAMdIJKN82uVEBzoyfuVhhy3qo0RYPVDG0VWgM3
        YdWty6fteiMjYnl3s/S/QtJvvsRZdLqCi6VAIb8=
X-Google-Smtp-Source: APXvYqz2Q7BuEoztoQTk2y/k79111s2N2dTh7un3E/p/9yKUTVgU6nYSZUxZoOhohB0/YOF1w6kvgu0HzqpoPMsRoUY=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr81342975qtd.18.1561107681874;
 Fri, 21 Jun 2019 02:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131918.2518727-1-arnd@arndb.de> <DM6PR12MB401058325016417472CD5717DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB401058325016417472CD5717DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 11:01:01 +0200
Message-ID: <CAK8P3a1qhj_YYTo8aKgbdufjMFXfa3WNdqY6m=222fFxOcQaZg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dw-edma: fix __iomem type confusion
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

On Fri, Jun 21, 2019 at 10:53 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:

> >
> >  static struct dentry                         *base_dir;
> >  static struct dw_edma                                *dw;
> > -static struct dw_edma_v0_regs                        *regs;
> > +static struct dw_edma_v0_regs                        __iomem *regs;
>
> Shouldn't the __iomem be next to dw_edma_v0_regs instead of the variable
> name? I saw other drivers putting the __iomem next to the variable type,
> therefore I assume it's the typical coding style.

Yes, that seems more common indeed. Do you want to fix up
both patches yourself when you apply them or should I send a new version?

         Arnd
