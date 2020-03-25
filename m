Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E58192730
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2020 12:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgCYLea (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Mar 2020 07:34:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39213 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCYLea (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Mar 2020 07:34:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so1460070lfk.6
        for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2020 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPegYuSfHcA3EBvl8rBN548IrIHva7Siiqx3+i9i/fk=;
        b=aXIfbdqkfrWHNMJxk7rgpfQnHosJstUgv+nPJg8nxRo+9pKouM26WAI5jitlKG5zYm
         dZx7N6OfzJ8B8lp5AR5Z/nKynJm5BIZo5mfsjpnAouFOVrITTq+MpsKOdTK1TnVZGr6J
         ZXD2xs25UMtjG5Seqi4Yh5xID9TbudX70og/9CFMxinK3V+PWmxJYgvnCCYaBfOylFDU
         sGLI80eAP38UiXXmS6eBcqtzZVijLUoii6AuDKzHfZGoxLxCvXIxIjGTYuwjdAwTyjxy
         RcJsKyFXDpgd4yPdbiI4DwWjQrdAE5T9nhViX9NpC7LDGEGvjepXCx2QLRJr9XWlR41n
         bh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPegYuSfHcA3EBvl8rBN548IrIHva7Siiqx3+i9i/fk=;
        b=M1PigFLQrz8C/sdvQGWuyf++wh4518KXIOp+HyPLBTFc1brqhBsiXj0WNK8oLqseGN
         /4QHRh92h7J49gcWqgNLcq+C6QmZseJXzK+wwB67hQfuY7kJ7eUensUkKfH+ewTQGArc
         AJthVuu8AFw5zqAE1nxv78xZCmawEj7+Iq4nn52YH5nmS8J5PlCC+Siutl7kTSxu1fnY
         rv/S5gCDJi7mcCjq4cCtKQy/3/ZEICm7FvSwnKwA4EGjTrXazDyejh6h9YuziVAOSk4B
         9EiM4wY+6lnU1kNwaFnCclNvbllQ6mYvgye8F6WRjixbnqRvFxmYBPaR8ym7IF6/O+Wf
         oVBQ==
X-Gm-Message-State: ANhLgQ2PupzafX57Nxa/UqVbgpQj4UXYnbed3/kklU5foJIAQPn5P34B
        uf+LcAj7Ubat6otfR3lcpzCqlQ==
X-Google-Smtp-Source: ADFU+vuRSm6/etAQz80VrEgGUDZc5VTTv9FpBEJTzRn3gDVEDfDCfTlInPIezeIUpXLoXiDhoHUYOw==
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr2098414lfa.0.1585136068643;
        Wed, 25 Mar 2020 04:34:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v22sm3920009ljc.79.2020.03.25.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:34:28 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] driver core: platform: Initialize dma_parms for platform devices
Date:   Wed, 25 Mar 2020 12:34:06 +0100
Message-Id: <20200325113407.26996-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325113407.26996-1-ulf.hansson@linaro.org>
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's currently the platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with
this approach allows us to avoid the initialization and to not waste memory
for the struct device_dma_parameters, as this can be decided on a case by
case basis.

However, it has turned out that this approach is not very practical.  Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common platform bus
at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/platform.c         | 1 +
 include/linux/platform_device.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b5ce7b085795..46abbfb52655 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -512,6 +512,7 @@ int platform_device_add(struct platform_device *pdev)
 		pdev->dev.parent = &platform_bus;
 
 	pdev->dev.bus = &platform_bus_type;
+	pdev->dev.dma_parms = &pdev->dma_parms;
 
 	switch (pdev->id) {
 	default:
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 041bfa412aa0..81900b3cbe37 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	bool		id_auto;
 	struct device	dev;
 	u64		platform_dma_mask;
+	struct device_dma_parameters dma_parms;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.20.1

