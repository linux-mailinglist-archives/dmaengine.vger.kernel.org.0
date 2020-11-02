Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2F2A264B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Nov 2020 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgKBIl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Nov 2020 03:41:29 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38415 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIl2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Nov 2020 03:41:28 -0500
Received: by mail-wr1-f47.google.com with SMTP id n18so13515447wrs.5;
        Mon, 02 Nov 2020 00:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LE6jfeBaedNtUOiZilvHvmLOozgEEEYdnPDcbbq+vus=;
        b=my/WtJycsWZ9yj1SIHdsdh1NQZ813UEVAITpjlOVN6D15ldRlpigzUqfsBAbd7c2Gx
         O/2Dc5GlWY8q7yQi8lwiZQ94fM+NiXWDf+xH4g+5xZ7m4wOAzpR7toYedk7THcUyrEGg
         TXeyMGhzbtKSjJkFEse8RJBKJFD91aDMHkd5nsDimtnuNBG3nqAoeGJr50JztBimxQHz
         8A8ouMAhxclU3g1Me+Hrp8loDG0CgnI61s4HEGI4fd1ubsqdkVVvZqkHJPIyy6mJsgj8
         l5GC8cJZ6+ljgubXhWQV5FGMk1PxWOX7XGUZPNnWJMwGsvLGwwZH+mI9y5wMSMQqz6Z0
         nlDg==
X-Gm-Message-State: AOAM532Eqh9Nf9wF3LOge+vwd/+13JtcGUOmsuSsNmoVG7Xapl2Zfz+3
        lnm8q99rM3LEdCq7VOOXBrANwHzn+A26ZQ==
X-Google-Smtp-Source: ABdhPJxEntbrtRvffSWB2E3xhXP8aL9tfpqwwm0A3s92KIa06PgNflQihgMrxmliDhgFc5ONdad7cg==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr18215180wrt.51.1604306485033;
        Mon, 02 Nov 2020 00:41:25 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n8sm1907613wmc.11.2020.11.02.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:41:23 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:41:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: dmaengine: pl330 rare NULL pointer dereference in pl330_tasklet
Message-ID: <20201102084122.GA7331@kozik-lap>
References: <CGME20201031190133eucas1p2a90b3a7a1e39f4e778e288bb11a3ff9d@eucas1p2.samsung.com>
 <20201031190124.GA486187@kozik-lap>
 <a4bbe5e8-dd3d-d66f-a9fe-012bf7910943@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4bbe5e8-dd3d-d66f-a9fe-012bf7910943@samsung.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 02, 2020 at 08:38:14AM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 31.10.2020 20:01, Krzysztof Kozlowski wrote:
> > I hit quite rare issue with pl330 DMA driver, difficult to reproduce
> > (actually failed to do so):
> >
> > Happened during early reboot
> >
> > [  OK  ] Stopped target Graphical Interface.
> > [  OK  ] Stopped target Multi-User System.
> > [  OK  ] Stopped target RPC Port Mapper.
> >           Stopping OpenSSH Daemonti[   75.447904] 8<--- cut here ---
> > [   75.449506] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> > ...
> > [   75.690850] [<c0902f70>] (pl330_tasklet) from [<c034d460>] (tasklet_action_common+0x88/0x1f4)
> > [   75.699340] [<c034d460>] (tasklet_action_common) from [<c03013f8>] (__do_softirq+0x108/0x428)
> > [   75.707850] [<c03013f8>] (__do_softirq) from [<c034dadc>] (run_ksoftirqd+0x2c/0x4c)
> > [   75.715486] [<c034dadc>] (run_ksoftirqd) from [<c036fbfc>] (smpboot_thread_fn+0x13c/0x24c)
> > [   75.723693] [<c036fbfc>] (smpboot_thread_fn) from [<c036c18c>] (kthread+0x13c/0x16c)
> > [   75.731390] [<c036c18c>] (kthread) from [<c03001a8>] (ret_from_fork+0x14/0x2c)
> >
> > Full log:
> > https://protect2.fireeye.com/v1/url?k=7445a1ab-2bde98a7-74442ae4-000babff3563-a368d542db0c5500&q=1&e=62e4887b-e224-48e5-80a2-71163caeeec8&u=https%3A%2F%2Fkrzk.eu%2F%23%2Fbuilders%2F20%2Fbuilds%2F954%2Fsteps%2F22%2Flogs%2Fserial0
> >
> > 1. Arch ARM Linux
> > 2. multi_v7_defconfig
> > 3. Odroid HC1, ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
> > 4. systemd, boot up with static IP set in kernel command line
> > 5. No swap
> > 6. Kernel, DTB and initramfs are downloaded with TFTP
> > 7. NFS root (NFS client) mounted from a NFSv4 server
> >
> > Since I was not able to reproduce it, obviously I did not run bisect. If
> > anyone has ideas, please share.
> 
> Well, I've also observed it a few times. IMHO it is related to the 
> broken UART (in DMA mode) shutdown procedure. Usually it can be easily 
> observed by flushing some random parts of the previously transmitted 
> data to the UART console during the system shutdown. This also depends 
> on the board and used system (especially the presence of systemd, which 
> plays with UART differently than the old sysv init). IMHO there is a 
> kind of use-after-free issue there, so the above pl330 stacktrace can be 
> also observed depending on the timing and system load. This issue is 
> there from the beginning of the DMA support. I have it on my todo list, 
> but it had too low priority to take a look into it. I only briefly 
> checked the related code a few years ago and noticed that the UART 
> shutdown is not really synchronized with DMA. However that time I didn't 
> find any simple fix, so I gave up.

Thanks for the explanation.

Best regards,
Krzysztof

