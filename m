Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022C5147463
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgAWXKq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:10:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgAWXKp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so5249513wrq.0;
        Thu, 23 Jan 2020 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4auLfeTWYpfRnRGmALkFYqcKSPLJ0m/g2ODa3jrK1c=;
        b=EGal7W4OAs1ShOUeFk8DBOF/grFbVGnHDqKtZt6ZKvoeae2FHLK346srFokFr8Z856
         Ud9eLuOY5qggOmoXGH8Q94pIrY36Kn7ZVzrI/Z1JqsXPAQISwuZDRevKgJINRcBq/OiL
         LnSfkgcK872L+evBH8dMdO42/WjPU9z0IF8BZysUCHP0vjr4Huugp8qMLcYzfVST3+Co
         CNtbKiVBbTjSIIQFUI54BTxevfmyZNQ1ebq6sMP/yjmE4o5XlVU7Nj+mTQO/363CR7CL
         UYPgdK94BqMLuWvOLS0PLUp90LGgES+1XTVBuyEo4P9g28GZEVnDUe3SmyHl4+/j6eRC
         RmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4auLfeTWYpfRnRGmALkFYqcKSPLJ0m/g2ODa3jrK1c=;
        b=Fun1lxI/o94/bOQgy8wOYsJQwPQ2uM0MF04fXShLzh4vy85ttKPK63YsJHKQoxhcy7
         boW4kgkNtZxgE8SeWW4HoUzoktVonpQM3PbIwSYrcqXLGJsUgpiIH2C1GM7r/fN+ZmB8
         RTl2eTiD1fT8B5vAv0GftUDiMWehY1W3SuvZm2ZzuHB9Tg9PX04U8httX8dFlnYt+0rP
         EWsRr31l9W4ME75x14XlMowzkrHuocf4jRC3ofW2bibjC5gMaUrbBFrQ1w9AcfYnL6dB
         s+bBe1OEKD/L7hVBm4yWOOfsyn+2sX+SLkyMVWZJfSTuWsWMP6XPvuN3uRVwTzPp8B0N
         Bjdg==
X-Gm-Message-State: APjAAAWdSN9sRwOr175kKZMn0yFWrMinvSrYlwtICAV8wnX/6JA4nGWA
        /YjFURX/2lkuaOmGpq1S410=
X-Google-Smtp-Source: APXvYqzpix3/UoO0zYYUskqcPQbRVEYyW2mrxMcV8vZWmWwc5qbmGd7vTFIsErg56ocucvRROmcNVg==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr473570wru.112.1579821043400;
        Thu, 23 Jan 2020 15:10:43 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/14] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Fri, 24 Jan 2020 02:03:11 +0300
Message-Id: <20200123230325.3037-1-digetx@gmail.com>
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

Dmitry Osipenko (14):
  dmaengine: tegra-apb: Fix use-after-free
  dmaengine: tegra-apb: Implement synchronization hook
  dmaengine: tegra-apb: Prevent race conditions on channel's freeing
  dmaengine: tegra-apb: Clean up tasklet releasing
  dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
  dmaengine: tegra-apb: Use devm_platform_ioremap_resource
  dmaengine: tegra-apb: Use devm_request_irq
  dmaengine: tegra-apb: Fix coding style problems
  dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
  dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS

 drivers/dma/Kconfig           |   2 +-
 drivers/dma/tegra20-apb-dma.c | 507 +++++++++++++++++-----------------
 2 files changed, 260 insertions(+), 249 deletions(-)

-- 
2.24.0

