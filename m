Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E211B2EE1
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfIOHAi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:00:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46275 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfIOHAh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:00:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so17469235pgv.13;
        Sun, 15 Sep 2019 00:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qTxLl5voUFSb9X26smlelj8GYPRuvUJLayWNlgtrH8I=;
        b=W6CL0NcuOOKiayvD0SZ2TQ8KNDiXRiTQoN+morrL2hU5DijtUSqNQM3zTPPdChx0j/
         c9lrCWh+xKTHyxxva/vhIr6blk0ZF4gNl8oeb4lQyJCAMSzutvtbb66WFQPn2HfYdsMk
         AeqKA36ulAIJuaFlkr0pr9FOryh9s/7wNXjtdaXl2rStcGrzQc5tWeXRmc5PSgJTryRx
         wkZr1oSCapdVN3YouuleEWUawIH6Rb3RXCMV7KRZDGbEaEtTnwsMizb827nV9Y1NCj0v
         k5QZj8DW+4x9hWs0Qn2BQo6H3+H26M6mXG+bmVw7gWsUGS4e88Ii21n0nX13wa58MBZ+
         GeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qTxLl5voUFSb9X26smlelj8GYPRuvUJLayWNlgtrH8I=;
        b=Sv3gnu8HoleEGjdmEWh+d0nBwfYdQ+xBMWRmJ2NHkRj8guqm1uivkQPALelYKTZZW/
         Q0lfwXclRNgeMUKblshQpfRQFOI1++MG6oyGUYEb4v2J2mlzrj9U973KDpxblQ+wia8K
         7SQ8bs/4Dj5pDG1SuURX9gSwBRgHM+xBXP/cVjVKTP60nhjDWGiZu15Btss4fpvDRQrw
         mpdKMNREPVCJxn+SHb4kCWtHhxJG+INvz/wvqHrXtUqA7RmEBiqZutzCQoVAKDDgzfq6
         2Oiv/UwBILI5plQr1uZMFz5tZ6CmzyAwkou387u7DRGvRUEQjdUqDGwkMAjJTbBDkqyG
         5WZw==
X-Gm-Message-State: APjAAAV/hYU7ugLQkDCo1gdVfi6oMpVjXWF0tk1XwbBrAEjeS5CoL/+Z
        ddCcx6p1+6+j0SKauEphOGs=
X-Google-Smtp-Source: APXvYqzDLofZo0Q9BogI7k5yAM89atbsKPZgSNVhbxB/0fbNPWM4aT0+glaa5BRRGORfoywzP7hEIw==
X-Received: by 2002:a63:5222:: with SMTP id g34mr16131609pgb.405.1568530836882;
        Sun, 15 Sep 2019 00:00:36 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id 197sm16699453pge.39.2019.09.15.00.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:00:35 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org, jun.nie@linaro.org,
        shawnguo@kernel.org, agross@kernel.org, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, maxime.ripard@bootlin.com, wens@csie.org,
        lars@metafoo.de, afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>
Subject: [PATCH 0/9] added helper macros to remove duplicate code from probe functions of the platform drivers
Date:   Sun, 15 Sep 2019 12:30:03 +0530
Message-Id: <20190915070003.21260-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1. For most of the platform drivers's probe include following steps

-memory allocation for driver's private structure
-getting io resources
-io remapping resources
-getting irq number
-registering irq
-setting driver's private data
-getting clock
-preparing and enabling clock

2. We have defined a set of macros to combine some or all of
the above mentioned steps. This will remove redundant/duplicate
code in drivers' probe functions of platform drivers.

devm_platform_probe_helper(pdev, priv, clk_name);
devm_platform_probe_helper_clk(pdev, priv, clk_name);
devm_platform_probe_helper_irq(pdev, priv, clk_name,
irq_hndlr, irq_flags, irq_name, irq_devid);
devm_platform_probe_helper_all(pdev, priv, clk_name,
irq_hndlr, irq_flags, irq_name, irq_devid);
devm_platform_probe_helper_all_data(pdev, priv, clk_name,
irq_hndlr, irq_flags, irq_name, irq_devid);

3. Code is made devres compatible (wherever required)
The functions: clk_get, request_irq, kzalloc, platform_get_resource
are replaced with their devm_* counterparts.

4. Few bugs are also fixed.

Satendra Singh Thakur (9):
  probe/dma : added helper macros to remove redundant/duplicate code
    from probe functions of the dma controller drivers
  probe/dma/jz4740: removed redundant code from jz4740 dma controller's 
       probe function
  probe/dma/zx: removed redundant code from zx dma controller's probe
    function
  probe/dma/qcom-bam: removed redundant code from qcom bam dma
    controller's probe function
  probe/dma/mtk-hs: removed redundant code from mediatek hs dma
    controller's probe function
  probe/dma/sun6i: removed redundant code from sun6i dma controller's
    probe function
  probe/dma/sun4i: removed redundant code from sun4i dma controller's
    probe function
  probe/dma/axi: removed redundant code from axi dma controller's probe
    function
  probe/dma/owl: removed redundant code from owl dma controller's probe
    function

 drivers/dma/dma-axi-dmac.c       |  28 ++---
 drivers/dma/dma-jz4740.c         |  33 +++---
 drivers/dma/mediatek/mtk-hsdma.c |  38 +++----
 drivers/dma/owl-dma.c            |  29 ++---
 drivers/dma/qcom/bam_dma.c       |  71 +++++-------
 drivers/dma/sun4i-dma.c          |  30 ++----
 drivers/dma/sun6i-dma.c          |  30 ++----
 drivers/dma/zx_dma.c             |  35 ++----
 include/linux/probe-helper.h     | 179 +++++++++++++++++++++++++++++++
 9 files changed, 280 insertions(+), 193 deletions(-)
 create mode 100644 include/linux/probe-helper.h

-- 
2.17.1

