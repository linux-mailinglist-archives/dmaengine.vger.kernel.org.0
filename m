Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83112BF29
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 21:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfL1Ure (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Dec 2019 15:47:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43638 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfL1Ure (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Dec 2019 15:47:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so29878246ljm.10;
        Sat, 28 Dec 2019 12:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nVaAP4MCfY0nef5qeRA366CqleaDa1AKgRj0nav16Q=;
        b=U0pe3eDjYWAZosIfyZGkgAA7AIHDqj9CXJQQArB/Iau5M1ZbWYhH5jLASXl+0lBQab
         2YtOxOm4O163K2S79O9hZvhdzA5qxA7FUqQoC9QKOocbUAowjHh5DPju7Eg8uGFpl+BV
         8/SUa5DLLn9xgJxLT7U/zXNboMkVrrYqeRubPp51PhPqjtYE7IUzVt9xTF+X8td/pS1D
         kJUkiiNA9CdiiE/n6/jPAL1pYqfeB7y2SEGyJu6rB5gZEKI7qXpWwQhl5pvVJi+08Cq+
         E/J6FHovTckDmXg7/EmbC2tzVqyj0vEt8Izdk72zt9XrNY3m09Pypqf5Iceu1llF61Vh
         JRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nVaAP4MCfY0nef5qeRA366CqleaDa1AKgRj0nav16Q=;
        b=JtDB8M3kxj3xdkpNXKGI7bhJSKWD/EnjPoQktbNeG9e3qSxbr0vgrbis012kXy1IER
         OtdHPuzJ0Jbx3QpHRlCfl+Nfl3vMt6UkIMDVaueNt35KZ30WJmPw19zetYwgmNrQ06yW
         gMhQXv5KSffAxuktDs7pO5Mbov9/4pl73Vk+/cEksE7VbXSpYI0HhWwG3RynJWscV9ye
         qaHxY/EItVlHOt/1LQOCBxx3E9VWMvrZ7RxOsbRsLR5h5yRAVQ6YGI/0sc0upVq86z62
         f9MNKnPypR5wrFSng9CV1WdDSE3wp3dP8qBGXAITqTXfw4uctzzqNovwE8xTdQU4DcTi
         PqPA==
X-Gm-Message-State: APjAAAXsEC9HGnLV/NCJvwLDHTPLbyp0MK8eWeZYiJVxiuNJh/bMLVjx
        pf0x3oStFWoexuCcsTWTSNw=
X-Google-Smtp-Source: APXvYqzqlrx1bUF1l2zBwl0RbJ8BQfk5EKWKRNzJi/EvRX3v5I5XLmqlNyi954GUTSZBFqUeyJPiVw==
X-Received: by 2002:a2e:9cc:: with SMTP id 195mr30540288ljj.130.1577566052293;
        Sat, 28 Dec 2019 12:47:32 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Sat, 28 Dec 2019 23:46:33 +0300
Message-Id: <20191228204640.25163-1-digetx@gmail.com>
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

Dmitry Osipenko (7):
  dmaengine: tegra-apb: Fix use-after-free
  dmaengine: tegra-apb: Implement synchronization callback
  dmaengine: tegra-apb: Prevent race conditions on channel's freeing
  dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
  dmaengine: tegra-apb: Use devm_platform_ioremap_resource
  dmaengine: tegra-apb: Use devm_request_irq
  dmaengine: tegra-apb: Fix coding style problems

 drivers/dma/tegra20-apb-dma.c | 329 +++++++++++++++++-----------------
 1 file changed, 164 insertions(+), 165 deletions(-)

-- 
2.24.0

