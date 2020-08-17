Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0D245BC2
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 06:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgHQEyX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 00:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHQEyX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 00:54:23 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C975C206FA;
        Mon, 17 Aug 2020 04:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597640062;
        bh=dhDoHPim08T8tQIOUPSLJcDdqrcHotj1Ty6KdND+evs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3ZDjpHvPf4QPepi2druAftU5PC//2v6z+wnDnBJU9eyp3MLwFmJeYK/SWFUuFL2r
         jpLrZNibJv4mG4kYUbOvL7yvp+gsoIHqDlb4BWX0bTFNmkklf7Aj6OcL6Uvc6L8o+d
         Q9VSiOwmzAqf+ZanDZnNC7f1Qx+mkLQgB5AYNwKs=
Date:   Mon, 17 Aug 2020 10:24:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dmaengine <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: pch_dma: use generic power management
Message-ID: <20200817045418.GC2639@vkoul-mobl>
References: <20200720113740.353479-1-vaibhavgupta40@gmail.com>
 <20200727085621.GL12965@vkoul-mobl>
 <CAHp75VesTCOffxiy6=HG=g2t4=js3SnTm4LcdrgAGYiNvSS65Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VesTCOffxiy6=HG=g2t4=js3SnTm4LcdrgAGYiNvSS65Q@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-07-20, 14:19, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 1:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> > On 20-07-20, 17:07, Vaibhav Gupta wrote:
> > > Drivers using legacy PM have to manage PCI states and device's PM states
> > > themselves. They also need to take care of configuration registers.
> > >
> > > With improved and powerful support of generic PM, PCI Core takes care of
> > > above mentioned, device-independent, jobs.
> > >
> > > This driver makes use of PCI helper functions like
> > > pci_save/restore_state(), pci_enable/disable_device(),
> > > and pci_set_power_state() to do required operations. In generic mode, they
> > > are no longer needed.
> > >
> > > Change function parameter in both .suspend() and .resume() to
> > > "struct device*" type. Use dev_get_drvdata() to get drv data.
> >
> > You are doing too many things in One patch. Do consider splitting them
> > up to a change per patch. for example using __maybe could be one patch,
> > removing code is suspend-resume callbacks would be other one.
> 
> Vinod, while I completely agree with you in general, in this case it
> would make more unnecessary churn and will be rather unhelpful in all
> ways: for the contributor to do this work, for the reader to collect
> all the pieces. It also will be a bisectability issue, because the
> #ifdeffery replacement (IIRC you need to move from CONFIG_PM to
> CONFIG_PM_SLEEP). I really don't see any advantages of the splitting
> here.
> 
> > > Compile-tested only.
> >
> > I would like to see some testing before we merge this
> 
> I have hardware to test (Intel Minnowboard v1) but have no time. And
> taking into account that I did similar changes for many other drivers,
> I can give my
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> and take responsibility if somebody complains in the future (I don't
> believe it will be one).
> 
> P.S. Another scenario if Vaibhav can find that board (there were
> dozens of thousands at least produced and floating on the second hand
> market) and test himself. It may be good since he touches the full lot
> of PCH (EGT20) drivers.

Applied now, thanks

-- 
~Vinod
