Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BED192733
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2020 12:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCYLec (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Mar 2020 07:34:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47082 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYLec (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Mar 2020 07:34:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id q5so1437008lfb.13
        for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2020 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7KffvUQLvEtuKLuleQeJ202vBQLqQy9HV1Fxk0tNOM=;
        b=HDfdSaRDnAglhBGm1Inpp4+PGlm69FgGVABJzD28TMp6tqeNsKiHMI777YCormOPzd
         uObNsIFHV1Npk5ziYCXZ0cQLBNe4T8aZZKrc3tZBoKsfGViR+Ix/mqOLR4JsgIMcm9t1
         vFdk3jktgqFH4Z/+GU/IydPzWVGMjeoANomk1rbXDkBKfC1ZsDPJLBW8K0DcZwll9C24
         tp+m/Jzg8CN8lYauf5ETMIUTJ1rrRQ1tXDrgUnt6dLpzH8GpssHm3HOsSizAit60PbjS
         Q/2MXBDO8MYvbDm058vsshlEfxsxUgbcDLCNaTtOnWlyOVawtVI6kXoNhDLMsh67bsk+
         papQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7KffvUQLvEtuKLuleQeJ202vBQLqQy9HV1Fxk0tNOM=;
        b=GYDry9wa7WJR3po+kxTf/5ojmUa/P3OMSKfoKopgnAXg2Ie7C4y8EzElpVsQbVmLLr
         YDa0JysK8h1P38qO3LvMEL6Oja0jA2HU/gKqg2WD4bOSLSzFN2HHW3JAdcrMptwSIZfs
         trziy29OVEU31RJnXIFPcOxU+EpfNtx1wTyccIXbyyvUTWexQUvuHh7cDZeOZwPqlVDI
         GvNoYbi9qgTA8PgZ7RHH3BcZZP+KXBJ/gvF9q6yuaF1Wss53WQlO55kobJNv97Hk4UVH
         IdbBzn37BAlaoc+BqVrtg2dKEXdNJcG2KQ8Q3imUvCrZy1zJgZjVTE5kblRee///WeHH
         E3MA==
X-Gm-Message-State: ANhLgQ0JLOMYHIoHWyCSBChGIyt5OwoA9zTM0RmBWmHwC8NgWUUaHm9Z
        5smsTimeUCSXVE0apjZrpC1OIQ==
X-Google-Smtp-Source: ADFU+vtF9WPanLG3a1vSHxs2lc6VyzDOkLrVTfTbQpdbdnZ4basqRFJVF+b7L4EKM0fI2K8g88uVuw==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr1933177lfi.172.1585136070290;
        Wed, 25 Mar 2020 04:34:30 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v22sm3920009ljc.79.2020.03.25.04.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:34:29 -0700 (PDT)
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
Subject: [PATCH 2/2] amba: Initialize dma_parms for amba devices
Date:   Wed, 25 Mar 2020 12:34:07 +0100
Message-Id: <20200325113407.26996-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325113407.26996-1-ulf.hansson@linaro.org>
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's currently the amba driver's responsibility to initialize the pointer,
dma_parms, for its corresponding struct device. The benefit with this
approach allows us to avoid the initialization and to not waste memory for
the struct device_dma_parameters, as this can be decided on a case by case
basis.

However, it has turned out that this approach is not very practical. Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common amba bus at
the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c       | 2 ++
 include/linux/amba/bus.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index fe1523664816..5e61783ce92d 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -374,6 +374,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	WARN_ON(dev->irq[0] == (unsigned int)-1);
 	WARN_ON(dev->irq[1] == (unsigned int)-1);
 
+	dev->dev.dma_parms = &dev->dma_parms;
+
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 26f0ecf401ea..0bbfd647f5c6 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -65,6 +65,7 @@ struct amba_device {
 	struct device		dev;
 	struct resource		res;
 	struct clk		*pclk;
+	struct device_dma_parameters dma_parms;
 	unsigned int		periphid;
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
-- 
2.20.1

