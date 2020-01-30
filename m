Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0620314D5A8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA3ElN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39255 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA3ElN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so2568441wme.4;
        Wed, 29 Jan 2020 20:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mcUDkOWGULuQ9Y+ECUahZ1YIpKQNag00Dt8JWWpACM=;
        b=Ndm1zex43ionJqExd895NA0rg9xCR3DFq4OnA8F2bqEDDyHuQiBKZohbJ7cmvgrAK6
         0KC7oJFDHhoB3cOAbIQVnEWono5ZvbJXa+obV5iZlDtMxyzz/k0PetT3MMoMa7O9Y04y
         k1wYJbdhUvR6VK9HFiLvdnc/6IZ183Y3WmIgcjGubEGP6FYbc/2dsPNAgxmmodLqkLgO
         gSsRteP4MqBRH3J1LKBLKhEGCV8iWz9b1lHmNY/fxalCTsUoJUtpUh4Y64SntXgCdMTB
         gc3iyVBsQYd66GUcBHLrlbYebOaenLSQrQl+IVK9OcWO/sJygh1UIPdBF/lqjlePArDi
         SE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mcUDkOWGULuQ9Y+ECUahZ1YIpKQNag00Dt8JWWpACM=;
        b=eRX+6dqzGoE0+pbDPHcVJUqkKcjacuRUN3pyGMdGZzGRZR+JZ5OfhGbrwYIclrJXbt
         1UeFI3N8DvBXKUfwXwdoCX7M74sna8xPTtnjqnoIRWzO6+GVZ65rJOUJYs4IEwoLRzgg
         y1Otnv1LJF8opAM80nE/m4osncdQi2pYiAVEmfYsosGmP8IQMIAPxWmtPtKhaPyJe4wt
         AerK3ZWh0HOHJJVxX1oK5FI6zbQ3t3DQgT5X4mR2abCjTYsL2AZqsgiIH/f0nTXznh1C
         fDmLWe6/mI0ikUuMfAaSTbHcJPWW317JykvIyhmo/HcKSyi7jQynuzCK5dkY7a4rowsI
         xo+Q==
X-Gm-Message-State: APjAAAUQcZubryeOyCfHz1iEbht+9rA4sD5vNAJl+tW5wxQhMdkTu4gq
        di9pC/yEEgai/Bc6fiCtoGL83bZq
X-Google-Smtp-Source: APXvYqxxTtqKAh91lqHfKF312r09wQYaitmQ83jqmWSXFb/t82I0pfDch/r5p/bFC2pxgYI6Sdym4A==
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr2728889wmm.132.1580359270871;
        Wed, 29 Jan 2020 20:41:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/16] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Thu, 30 Jan 2020 07:37:48 +0300
Message-Id: <20200130043804.32243-1-digetx@gmail.com>
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


Dmitry Osipenko (16):
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
  dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS
  dmaengine: tegra-apb: Support COMPILE_TEST

 drivers/dma/Kconfig           |   4 +-
 drivers/dma/tegra20-apb-dma.c | 507 +++++++++++++++++-----------------
 2 files changed, 261 insertions(+), 250 deletions(-)

-- 
2.24.0

