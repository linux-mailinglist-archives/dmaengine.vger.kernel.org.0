Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB22A1A31
	for <lists+dmaengine@lfdr.de>; Sat, 31 Oct 2020 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgJaTBa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 31 Oct 2020 15:01:30 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44374 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgJaTBa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 31 Oct 2020 15:01:30 -0400
Received: by mail-wr1-f46.google.com with SMTP id b3so4092138wrx.11;
        Sat, 31 Oct 2020 12:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=fo1vLw7uqzM0/HVmudKwwfC5LAehVsjoosFf5UWA8y0=;
        b=uAzRAJdvrzSFruVaBlWcp+QtmdOAo4cIHTy2W6P6A1PJTkgkizaIzzNYKnKg8+wbo7
         Omchg07xbP/KJzAtjBmN0Kg9lLSYON0WUeqUjGBbc02Vs4im631BJlkN8IEENCKrXQzU
         hJjH/nQimpOade3cg7wSfJQaoMxc16vImF42xcI+2hrQ5Brgw2lh0uT1PG14IHnNOAET
         A0YTkd2YVVIma8D4pxTi0fXVggIMgUXZ/p5RUNE/GfFLrembKykis+gJI9tdTI7+OeJm
         X/KWWJFACSECoSkznafUF8oikmUyDSnwOD5ens7yVa+wDQh2y/fuDwSCcmUuCIsaL7za
         tCsA==
X-Gm-Message-State: AOAM531Ypw7Xo2F+qTnvZjAk0sIuQ4xV5he17IsiZ9XbtKcUGOES1/YI
        VsJSyHZV9wwq2IxZeidJaAp4hgqzvccs+w==
X-Google-Smtp-Source: ABdhPJxAoD+lJVSovF6LGZWjGAOGZSs5Ew9Xk7ScBo+AW4SrynsiHyTcb0Qsb6SAn5qAndIgOwcexg==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr10785093wrr.300.1604170887339;
        Sat, 31 Oct 2020 12:01:27 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e7sm15597705wrm.6.2020.10.31.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 12:01:26 -0700 (PDT)
Date:   Sat, 31 Oct 2020 20:01:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: dmaengine: pl330 rare NULL pointer dereference in pl330_tasklet
Message-ID: <20201031190124.GA486187@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

I hit quite rare issue with pl330 DMA driver, difficult to reproduce
(actually failed to do so):

Happened during early reboot

[  OK  ] Stopped target Graphical Interface.
[  OK  ] Stopped target Multi-User System.
[  OK  ] Stopped target RPC Port Mapper.
         Stopping OpenSSH Daemonti[   75.447904] 8<--- cut here ---
[   75.449506] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
...
[   75.690850] [<c0902f70>] (pl330_tasklet) from [<c034d460>] (tasklet_action_common+0x88/0x1f4)
[   75.699340] [<c034d460>] (tasklet_action_common) from [<c03013f8>] (__do_softirq+0x108/0x428)
[   75.707850] [<c03013f8>] (__do_softirq) from [<c034dadc>] (run_ksoftirqd+0x2c/0x4c)
[   75.715486] [<c034dadc>] (run_ksoftirqd) from [<c036fbfc>] (smpboot_thread_fn+0x13c/0x24c)
[   75.723693] [<c036fbfc>] (smpboot_thread_fn) from [<c036c18c>] (kthread+0x13c/0x16c)
[   75.731390] [<c036c18c>] (kthread) from [<c03001a8>] (ret_from_fork+0x14/0x2c)

Full log:
https://krzk.eu/#/builders/20/builds/954/steps/22/logs/serial0

1. Arch ARM Linux
2. multi_v7_defconfig
3. Odroid HC1, ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
4. systemd, boot up with static IP set in kernel command line
5. No swap
6. Kernel, DTB and initramfs are downloaded with TFTP
7. NFS root (NFS client) mounted from a NFSv4 server

Since I was not able to reproduce it, obviously I did not run bisect. If
anyone has ideas, please share.

Best regards,
Krzysztof

