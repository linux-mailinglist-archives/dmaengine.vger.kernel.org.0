Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8E2349C6
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgGaQ5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 12:57:09 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33136 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGaQ5J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 12:57:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4E59A8030808;
        Fri, 31 Jul 2020 16:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cETLo8b0IAHn; Fri, 31 Jul 2020 19:57:03 +0300 (MSK)
Date:   Fri, 31 Jul 2020 19:57:03 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dmaengine: dw: Activate FIFO-mode for memory
 peripherals only
Message-ID: <20200731165703.ktnl7ctv647j6mzl@mobilestation>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-3-Sergey.Semin@baikalelectronics.ru>
 <20200730162428.GU3703480@smile.fi.intel.com>
 <20200730163154.qqrlas4zrybvocno@mobilestation>
 <20200730164703.GY3703480@smile.fi.intel.com>
 <20200730171358.7yxnqavmszahlzfr@mobilestation>
 <20200731165254.GG12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200731165254.GG12965@vkoul-mobl>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 31, 2020 at 10:22:54PM +0530, Vinod Koul wrote:
> On 30-07-20, 20:13, Serge Semin wrote:
> > On Thu, Jul 30, 2020 at 07:47:03PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 30, 2020 at 07:31:54PM +0300, Serge Semin wrote:
> > > > On Thu, Jul 30, 2020 at 07:24:28PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Jul 30, 2020 at 06:45:42PM +0300, Serge Semin wrote:
> > > 
> > > ...
> > > 
> > > > > > Thanks to the commit ???????????? ("dmaengine: dw: Initialize channel
> > > 
> > > ...
> > > 
> > > > > > Note the DMA-engine repository git.infradead.org/users/vkoul/slave-dma.git
> > > > > > isn't accessible. So I couldn't find out the Andy' commit hash to use it in
> > > > > > the log.
> 
> Yeah I moved tree to k.org after disk issue with infradead, change patch
> was on dmaengine ML
> 
> > > > > It's dmaengine.git on git.kernel.org.
> > > > 
> > > > Ah, thanks! I've just found out that the repo address has been changed. But I've
> > > > also scanned the "next" branch of the repo:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> > > > 
> > > > Your commit isn't there. Am I missing something?
> > > 
> > 
> > > It's a fix. It went to upstream branch (don't remember its name by heart in
> > > Vinod's repo).
> 
> Yes it is Linus's tree now and in dmaengine you can find in fixes branch
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=fixes&id=99ba8b9b0d9780e9937eb1d488d120e9e5c2533d

Thanks for pointing out to the commit. I'll add the hash to the patch log and
resend the series shortly.

-Sergey

> 
> > 
> > Right. Found it. Thanks.
> > 
> > -Sergey
> > 
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > > 
> 
> -- 
> ~Vinod
