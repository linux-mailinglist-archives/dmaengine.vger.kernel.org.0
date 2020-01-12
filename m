Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0E13875C
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgALRbb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37045 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALRbb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:31 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so5161737lfc.4;
        Sun, 12 Jan 2020 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HL3afQ+2XxQB+ynh5iqFR45GHfhJh9TiDp615Gudnb4=;
        b=KhECHmAVbC3Fprb9kCDCVjlCGhTNHOkSopDW0RZV93mxWB7MBdQq5hPuBfKrkI4GeT
         kM5kjdpBUnyk2Qjio0B9lty7PwCXl11BdriCtvhJ4cOxbZ89T61UvM6zli8THNekLJLF
         eIIkKyhDJqwewxySl3Vf9X93FhVrhjsO9h04QzGDfvpITIxN5mbZ5rG8BrDSyL3NjML4
         iNxu3yAy3jv5W5B5828OdTLV86KIZ5ANZqgtHmuxkdgKrNLoYqcZQFgafH+V04XE3Hrq
         BHDkYZJo38QSX7BYKBDL7J3qFNiz/yzppLRVLpOQRJPK+7eIBob7F1Byy112TNS8hvD5
         X+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HL3afQ+2XxQB+ynh5iqFR45GHfhJh9TiDp615Gudnb4=;
        b=iohWnhCTLwDKB/S53sb5/MmmKWftLVFpeIHBTmLJ1Y+k5CfjMdLqZgNXx8aVcKI/hf
         tyq24mUpJduF9ltIe0DNJs17zTDVVGfRcTt+TwlpNIHjlWDRtnN/PhNls4L35u7IBXLS
         1qY35EeuE6Z6d2ulBNPof5HxPFXyo0VYTpBKbkw7fn/xdbjwHBNDCXzZHBnaHpi1OXpk
         3o2/meymOdMBK759FSRQcE/AYFHxDlGeZTgWGxU284VWwS+y6BItxqk+ERt8kyI8ofmo
         FlhWCwWuL2TKfOlYiHENDO6AvLvDbaWsDTjSAMb7dGxZLyTGdjxRVz3+oFGN/R7wlJEX
         21AQ==
X-Gm-Message-State: APjAAAUu5IkS93+H3nxxasFFZx83iXePst6EDiqFo8hGHqNLqWX92AbT
        YP/PcZgM4p0/0EGJPImrlqA=
X-Google-Smtp-Source: APXvYqx4g4hUx2cpDSpbPJ7XN261mpPtdubTxU9fvGwI1/9jdskROiJOMxQHgDvu7mPjWXPQu2Y4Ng==
X-Received: by 2002:ac2:555c:: with SMTP id l28mr7526643lfk.52.1578850288898;
        Sun, 12 Jan 2020 09:31:28 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/14] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Sun, 12 Jan 2020 20:29:52 +0300
Message-Id: <20200112173006.29863-1-digetx@gmail.com>
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
  dmaengine: tegra-apb: Implement synchronization callback
  dmaengine: tegra-apb: Prevent race conditions on channel's freeing
  dmaengine: tegra-apb: Clean up tasklet releasing
  dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
  dmaengine: tegra-apb: Use devm_platform_ioremap_resource
  dmaengine: tegra-apb: Use devm_request_irq
  dmaengine: tegra-apb: Fix coding style problems
  dmaengine: tegra-apb: Clean up runtime PM teardown
  dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS

 drivers/dma/Kconfig           |   2 +-
 drivers/dma/tegra20-apb-dma.c | 509 +++++++++++++++++-----------------
 2 files changed, 263 insertions(+), 248 deletions(-)

-- 
2.24.0

