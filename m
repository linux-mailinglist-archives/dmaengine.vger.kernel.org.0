Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36992199E29
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgCaSix (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 14:38:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37758 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCaSiw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 Mar 2020 14:38:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so5779800lfe.4
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2020 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1iR82JLy2QBCOT69varWy2T5A5xF9bW9JJAjBNZYtw=;
        b=AgqKOg0Xlsg+qGXoQ+t9zCBNScJcIVnuGn7QUcnP5aj8K6e742Rcu/EaX9dFEgNWBB
         vLt6fu6VOygerOifBdA6nnhB4ysDtUoC0P1DJFSqfuuPpywvC25BwJBpffeJCIkJh8dG
         tLUkc/jZQ3hFDfS/dw7P10lHqjs5yx7744a4h8kR+4682zw7JntAP1hQJza4+5Ku02jb
         dNvog8Zyo5wsM5AASjRnI3cy5WnI9Gu7ncfLGtjv7HYWKTm2pQkdxBZaLHwLhXV4Ye05
         5DmXFtwrhnbuUCpWEJdx7hpJvwEYTEu/5k+jNUlVf3VrzgCLx9kpqwanVLH5BWTzIS1P
         mdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1iR82JLy2QBCOT69varWy2T5A5xF9bW9JJAjBNZYtw=;
        b=m0HtsYJ8BTYtOQ9bJHN+/XT9AZBNCRddc3LkwHnfblaUCFKRxhlOAR/nJ++nZ57HZf
         U6ZnEjXhbHXUqX6Prihb7P1eEwmG2RviwKdmFHlS/c7i5d9n1ZDpOkxAiAbiJX8Pq1Vc
         atA4iUcFoDWX3Zf4/XTPzDzpGfa9quZJ0sZ6mywl3JFY1BPUdFePkttnISJ6rXxyu3Wj
         uTshE4QfZEAZLsxfdGI7Ib2d5aGg9AT1LTOa6UZ+NLwEGHwtyipU5434kyc78BLrWEmI
         FVHDSZcFJZTFUB0rR7a+gkK0y7e2owutvbbYYAQ6F/WEFKcgN8D/hDV7O6Y+X31ijd3U
         wpnA==
X-Gm-Message-State: AGi0PuZx74a8fYtfTM3PoBN0FeFdzJJXvOYgRzREj3AoIabmvIGclVeu
        ChYqwMESRT8IgHELd7jN7perbw==
X-Google-Smtp-Source: APiQypKRx83jRA3vthxlvydh1YZb4WXvAun13NnHXa386ryuuWqw8NWW/Vu8GQtNCFg8UW/MxqPqog==
X-Received: by 2002:a19:a409:: with SMTP id q9mr12183993lfc.71.1585679928748;
        Tue, 31 Mar 2020 11:38:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b28sm10331849ljp.90.2020.03.31.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:38:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/2] amba/platform: Initialize dma_parms at the bus level
Date:   Tue, 31 Mar 2020 20:38:42 +0200
Message-Id: <20200331183844.30488-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's currently the amba/platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with this
approach allows us to avoid the initialization and to not waste memory for the
struct device_dma_parameters, as this can be decided on a case by case basis.
    
However, it has turned out that this approach is not very practical. Not only
does it lead to open coding, but also to real errors. In principle callers of
dma_set_max_seg_size() doesn't check the error code, but just assumes it
succeeds.
    
For these reasons, this series initializes the dma_parms from the amba/platform
bus at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

If it turns out that this is an acceptable solution, we probably also want the
changes for stable, but I am not sure if it applies without conflicts.

The series is based on v5.6.

Kind regards
Ulf Hansson


Ulf Hansson (2):
  driver core: platform: Initialize dma_parms for platform devices
  amba: Initialize dma_parms for amba devices

 drivers/amba/bus.c              | 1 +
 drivers/base/platform.c         | 2 ++
 include/linux/amba/bus.h        | 1 +
 include/linux/platform_device.h | 1 +
 4 files changed, 5 insertions(+)

-- 
2.20.1

