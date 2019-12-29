Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8130F12C2DE
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfL2O4r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:56:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42847 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2O4q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so23723041lfl.9;
        Sun, 29 Dec 2019 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COqiQMj9hoygMrJ+bG7gy6LfoV+WkHZat+iy1I4Dzik=;
        b=Flx1y2Ryu0tto50w2Hpbjg3pLS+dbHWkhHDaNcWLW7rBqPfb7hfr5/Izxcbt19sZ+M
         V7R9sGfIeh+3EmXLLaVmEO1Fx+VkV1mNyYDyB8LfpRnqIpbzNVXF8TC4lIvx3MfsYvoA
         MBj6pmC80CuCxF6Rldxgsg8UwpWAjeJNqpuxUsQhjEP2tXl1qbllXaG8xE2VxfIyUk2H
         7wRtKcW0e/MnDzpRmMOBIaRgSE07brOV7aM1EnnCKUUyR4RFQVSXpUuMYv6MbC1ltrK3
         9CapX7mec0dBKttXZPLALyjFfXqhdWMeyArrmAaoz31m1lEEZ8DJQSLD7P7OoSwzjcZe
         eUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COqiQMj9hoygMrJ+bG7gy6LfoV+WkHZat+iy1I4Dzik=;
        b=kL3zAYRPBBuODjjBV+7J+Pq1c92tF7oQU0zHq779urjMNPK2CsvNlbfP/AitQ0EDJC
         Mx8DuJKZRKCnGmLQyyeyEDmXbf7xZaCO/o06aYPiX/p0WbsAWRiwbHP10J0FwHgWGu/0
         aCoI3H51WmMiVWfZuwh47hvbOpy1Ap7cc8SYHxSedjkEB4zPEqL5btu5PKMiV1AN+q0v
         orKAmx2SgxskErZP3zn+hFKOIqvIUu0MjdxXi1gPE0+SgwJe0rQla8j340Q0ngG0kdAg
         NmDEcJJ2grojgIhY1RmCHjepJbOuo6STNKp9chTZJV5yHRyIFZGYQCed7DFMeVp/8pIh
         tvRA==
X-Gm-Message-State: APjAAAVUaRXvKNjYrOmIf9vAdp+OsqoS27Yfy5V3+bRC0VJUC3JmirTy
        OnMp6Wl5/GD3b/48ObkosDU=
X-Google-Smtp-Source: APXvYqwfD8RbbYVb4kkMc0Sq8Egu2KtWfEe7ae/chVX4gQmBs+ZmBi12I3E94nzVQIb8RgSjNYk2dg==
X-Received: by 2002:a19:7015:: with SMTP id h21mr34351852lfc.68.1577631404452;
        Sun, 29 Dec 2019 06:56:44 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Sun, 29 Dec 2019 17:55:13 +0300
Message-Id: <20191229145525.533-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This is series fixes some problems that I spotted recently, secondly the
driver's code gets a cleanup. Please review and apply, thanks in advance!

Changelog:

v2: - I took another look at the driver and spotted few more things that
      could be improved, which resulted in these new patches:

        dmaengine: tegra-apb: Remove runtime PM usage
        dmaengine: tegra-apb: Clean up suspend-resume
        dmaengine: tegra-apb: Add missing of_dma_controller_free
        dmaengine: tegra-apb: Allow to compile as a loadable kernel module
        dmaengine: tegra-apb: Remove MODULE_ALIAS

Dmitry Osipenko (12):
  dmaengine: tegra-apb: Fix use-after-free
  dmaengine: tegra-apb: Implement synchronization callback
  dmaengine: tegra-apb: Prevent race conditions on channel's freeing
  dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
  dmaengine: tegra-apb: Use devm_platform_ioremap_resource
  dmaengine: tegra-apb: Use devm_request_irq
  dmaengine: tegra-apb: Fix coding style problems
  dmaengine: tegra-apb: Remove runtime PM usage
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS

 drivers/dma/Kconfig           |   2 +-
 drivers/dma/tegra20-apb-dma.c | 478 ++++++++++++++++------------------
 2 files changed, 220 insertions(+), 260 deletions(-)

-- 
2.24.0

