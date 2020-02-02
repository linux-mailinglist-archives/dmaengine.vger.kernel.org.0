Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09B814FFCE
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBBWbA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:31:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37055 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgBBW3x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so12611698ljg.4;
        Sun, 02 Feb 2020 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezMQKD85XJhHGrGBIOdtzVLvRLd5t7MtgsapbZEE7GU=;
        b=tGckCKAx/G4/asNFzXkqBSLWkYq8tPMK4uGK9QE7Nequzqm5BcBNJCfFyPQF8dw30+
         ldrtv1FAGUwQeKjI8OeQwZRcwBNaysugffE26xe82LzZ3xHmWuVKpUogO8y9P7osJd2/
         IEnE74TEYYDa+YvuONpfr2E3BPg7FyX+xT+azqxm1aUKr2P+95f02oyhISvJqSUU17PR
         JdvignxDsTPmnqjYo8q82HhS/Ivh5ve1mz2F1YMPUVdJGaDkxNXQ1WeDvyZGlcaL4639
         BPvS5scKvHbJM+rXrvdjZLWnRE+ggJ+l69L9SF9p1KhviSHvtY67NRoJ58usdY89Erot
         u3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezMQKD85XJhHGrGBIOdtzVLvRLd5t7MtgsapbZEE7GU=;
        b=O78UObY7VCcUNmuCXnd7gBjcRF0UeABDEPJGrkh/C301f0W1c89ZEu7kfTf2F4Yx6o
         EX/2FgWeAFBlupVs1As8OjBenJNNLiZHGlY4QbgeFYEsMoLyqp/YW/SAVeKuCg2wsWt2
         seHDmF7GgWiJnINxZf3p6kbEGjcHhCefTa+IMFgb1QtCbVk3qJOfkqjBPWnxWPSBEMtn
         UGlMXk/7RrMINYUNRR4KSpH685zXRgSZL/T7qyWTGo1zUSSFhBz8niWLQyRW9xfoZZdy
         XPiT2wy3QeJalQLQfXWy6Oa7/dp8qq9BoFWuPydT49TtAQTK4UuAZVFhR5f1qTbZVNR2
         WSOA==
X-Gm-Message-State: APjAAAV9NXotgc8k859qC7sjqJz6+7J5Vcpv9j6tmYcci5Bh5cjyPTIP
        /kkDjKXcwWpDVk2BaFX5D+4=
X-Google-Smtp-Source: APXvYqwBwm7wCsPvxT5FWRfFxhGfKX2jvCKdr9xIOdjMwJSuNgngaeTiL8h5TwEk863cWqC+UYL2hg==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr12314396ljc.39.1580682588546;
        Sun, 02 Feb 2020 14:29:48 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/19] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Mon,  3 Feb 2020 01:28:35 +0300
Message-Id: <20200202222854.18409-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This series fixes some problems that I spotted recently, secondly the
driver's code gets a cleanup. Please review and apply, thanks in advance!

Changelog:

v7: - Updated patch "Keep clock enabled only during of DMA transfer" by
      fixing RPM refcount problem of v6 that should happen if oneshot
      transfer is terminated with EOC being set. The patch was change in
      accordance to Jon's Hunter recommendation. In a result there are
      these new small additional patches:

        dmaengine: tegra-apb: Remove handling of unrealistic error condition
        dmaengine: tegra-apb: Don't stop cyclic DMA in a case of error condition

    - Updated commit's message of the "Clean up suspend-resume" patch in
      accordance to Jon's request, now saying that channel's pausing isn't
      supported by the driver.

    - Added new very minor patch to clean up tdc_start_head_req():

        dmaengine: tegra-apb: Remove pending_sg_req checking from tdc_start_head_req

v6: - Added stable tag and changed order of the patch "Prevent race
      conditions of tasklet vs free list", making it patch #2, as was
      requested by Jon Hunter in the review comment to v5.

    - Factored out the tdc->config_init cleanup into separate patch, as was
      requested by Jon Hunter in the review comment to v5:

        dmaengine: tegra-apb: Remove unneeded initialization of tdc->config_init

    - Added new very minor patch to enable compile-testing for the driver:

        dmaengine: tegra-apb: Support COMPILE_TEST

v5: - Fixed touching hardware registers after RPM-suspending in the patch
      "Keep clock enabled only during of DMA transfer", now RPM is kept
      resumed in the tegra_dma_terminate_all() while needed. Thanks to
      Jon Hunter for pointing at this problem in a review comment to v4.

    - The "Clean up runtime PM teardown" patch is replaced with the "Remove
      assumptions about unavailable runtime PM" patch because I recalled that
      now RPM is always available on all Tegra SoCs.

    - The "Clean up suspend-resume" patch got a minor improvement, now
      tasklet_kill() is invoked before checking of the busy state in
      tegra_dma_dev_suspend(), this should allow us to catch problems if DMA
      callback issues a new DMA transfer.

    - Added Jon's acks to the reviewed patches.

v4: - Addressed Jon's request to *not* remove the runtime PM usage, instead
      there is now new patch that makes RPM more practical:

        dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer

    - Added new minor patch to clean up RPM's teardown:

        dmaengine: tegra-apb: Clean up runtime PM teardown

v3: - In the review comment to v1 Michał Mirosław suggested that "Prevent
      race conditions on channel's freeing" does changes that deserve to
      be separated into two patches. I factored out and improved tasklet
      releasing into this new patch:

        dmaengine: tegra-apb: Clean up tasklet releasing

    - The "Fix use-after-free" patch got an improved commit message.

v2: - I took another look at the driver and spotted few more things that
      could be improved, which resulted in these new patches:

        dmaengine: tegra-apb: Remove runtime PM usage
        dmaengine: tegra-apb: Clean up suspend-resume
        dmaengine: tegra-apb: Add missing of_dma_controller_free
        dmaengine: tegra-apb: Allow to compile as a loadable kernel module
        dmaengine: tegra-apb: Remove MODULE_ALIAS

Dmitry Osipenko (19):
  dmaengine: tegra-apb: Fix use-after-free
  dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
  dmaengine: tegra-apb: Implement synchronization hook
  dmaengine: tegra-apb: Prevent race conditions on channel's freeing
  dmaengine: tegra-apb: Clean up tasklet releasing
  dmaengine: tegra-apb: Use devm_platform_ioremap_resource
  dmaengine: tegra-apb: Use devm_request_irq
  dmaengine: tegra-apb: Fix coding style problems
  dmaengine: tegra-apb: Remove unneeded initialization of
    tdc->config_init
  dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
  dmaengine: tegra-apb: Remove pending_sg_req checking from
    tdc_start_head_req
  dmaengine: tegra-apb: Remove handling of unrealistic error condition
  dmaengine: tegra-apb: Don't stop cyclic DMA in a case of error
    condition
  dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS
  dmaengine: tegra-apb: Support COMPILE_TEST

 drivers/dma/Kconfig           |   4 +-
 drivers/dma/tegra20-apb-dma.c | 516 +++++++++++++++++-----------------
 2 files changed, 258 insertions(+), 262 deletions(-)

-- 
2.24.0

