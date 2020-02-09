Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255A1156B59
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBIQlT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44873 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBIQlT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so4364612ljj.11;
        Sun, 09 Feb 2020 08:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbxZDQJWMCGHWOArnpx4pPEVmGQqDBDsYcbt5c6buwc=;
        b=p8I8G1rhDFQq9uZWaDj5c4zk2fQ8Emc+ieqMlV28mRQeKRIfVIpWVIjO5/CA2oYfX4
         APBiVH1omBlPPt4CpEVWUoiAkl6ql+pk0zMKIJPG8LRiA2pJdz/RaWTT9mwJI3gQ/vwB
         OlnovM/KJ5YLdKYuYsjeRVn8Oix6IlErexbMGKTTPfpvhzYPIRBe8YYgQKuP+2yYddMD
         4KUKRnp+elGcEu676YRjZX7UuzbaU+PR5t9555ucJ84SwY87ugbA/Z2FXNc5w96kL5Pe
         Yp/da1MO/oJfV5+EMyX2z8eH+5Rka2W/SytM3bGj+xd/PWjA+feBA/gPJYfZUB9HKqfh
         /UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbxZDQJWMCGHWOArnpx4pPEVmGQqDBDsYcbt5c6buwc=;
        b=SwWZe2pruZsz4USCdZWJ0coVz3ehMwmi0sEYmzgHcd2bcs05PBrMO3RqcrYIqhmOFs
         nGKF8hHdoEJe9vAAygR1KGELoPo4A3JlNwb1y5Qws1OoneBUFJdSPMdN1I0hP+ToDIto
         p6OZJlnQUdHNt1gbWVnv2vDsD6gVh/Q6ZN0qS7E0A61Wsrzxy311KypyKC0p24SX6pQS
         Nei6X9f4PRBNSVBNBDjgc66NhOcIHdb+btfzufuLylg0PgaAdJ9LTxsBKQ+5IHlRiaTb
         Jic9eYqZoG7BFkJODNIDgKLhVQxpemYjDL+BIfgv0cCGQ2pTAvgzkUptAn0WsN5nCPvo
         t3bA==
X-Gm-Message-State: APjAAAX7cjqAVK6x7/UPTC7iG3wHQcwLkwffH7Bz1vn1RUgCrpUuj2Mc
        gax+SEsx8Bgq1kEr5yTqZ8Q=
X-Google-Smtp-Source: APXvYqwFlY/u4zSexkD4WaEh3fXgSTOGtb9CdtpOkiCb7WOWylgPm7/7LlOfaMz9zdRGdDD9sy0pLQ==
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr5344711ljk.207.1581266476392;
        Sun, 09 Feb 2020 08:41:16 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/19] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Sun,  9 Feb 2020 19:33:37 +0300
Message-Id: <20200209163356.6439-1-digetx@gmail.com>
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

v8: - Added RPM-put after every tegra_dma_stop(), like it was suggested by
      Jon Hunter in a review comments to v6/v7. Dropped this patch in a
      result:

        dmaengine: tegra-apb: Don't stop cyclic DMA in a case of error condition

    - Squashed all removals of duplicated pending_sg_req-list-empty checks
      into a single patch and added another removal which was suggested by
      Jon Hunter during review of v7:

        dmaengine: tegra-apb: Remove duplicated pending_sg_req checks

    - Added patch to improve error message about DMA underflow condition,
      which was suggested by Jon Hunter in a review comment to v7:

        dmaengine: tegra-apb: Improve error message about DMA underflow

    - Added another new minor cleanup-patch:

        dmaengine: tegra-apb: Remove unused function argument

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
  dmaengine: tegra-apb: Remove duplicated pending_sg_req checks
  dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS
  dmaengine: tegra-apb: Support COMPILE_TEST
  dmaengine: tegra-apb: Remove unused function argument
  dmaengine: tegra-apb: Improve error message about DMA underflow

 drivers/dma/Kconfig           |   4 +-
 drivers/dma/tegra20-apb-dma.c | 514 +++++++++++++++++-----------------
 2 files changed, 255 insertions(+), 263 deletions(-)

-- 
2.24.0

