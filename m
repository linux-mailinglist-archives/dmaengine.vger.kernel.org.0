Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EFE10077D
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 15:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKROgr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 09:36:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42910 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfKROgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 09:36:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so9902485plt.9
        for <dmaengine@vger.kernel.org>; Mon, 18 Nov 2019 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uaGtjQjkiXQCGGVyN/yvfM6hHUAMfrH/0aSuT3FKPok=;
        b=dXr2HiDHC+WF7WTSzcXRorBdBEEEgGeM1BgutFITl9KcciFzaGe1qDCYMYwb84+f41
         03kMnArtj/j5dOV+EsvJnXimx88ca6TOO+QRUIkZRfOQlxvI5a2UEKatswHBJ3GeCLr7
         8EWherCy1ydgUv617d/4Ug6AQgyuVxapZ3LygvUlJPDfqKJms5udKg89pFfN0s0wKuoK
         /4kFS36KX/dcNP44P4QDJQYRFPMfHq8eUlqr5QWLo2Rjy/b7KSrlH2cp5iW4VK92GJEu
         RA1W18d7EUWFLhpL58Lew3y3zCchT1+KQMhEDMLFKN1B99zxQSIdzKmzHlp741dtC41t
         zwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uaGtjQjkiXQCGGVyN/yvfM6hHUAMfrH/0aSuT3FKPok=;
        b=qUAN57Gc9M+jd2DG3nnPOUSwGwnWhtxz+XT6ekFWBAfWQRYt761LAx5TWshK3+bUTK
         fCJQiLVPhLeDAX5CNjtPulSO4YtScpcx9r99016+4qSNLCuVTQQhru/0h3jb2vko7usw
         +xgnNT6hknv2MX5LqdVaocJLBNmXlDCq/t3UEfBiT9amAua1l8qnrT0s+nMsMv7+PXPM
         7fV/hUEaxK9KM+pGUVIGaQ+zd4Ho5ye8U4KYntIxrysMmwVbNMbx4ENtGk3V8gpjOuyB
         7UvLOoiBPABu7+hHS02ZnyX4a2bd0lzm3IYpYyei4LZfJzAf34q2LvdWXaqJCwCz5CSl
         dWCw==
X-Gm-Message-State: APjAAAUQk8ihYhn4I8yV/QAV7m4dSH1rXTjUmVXXPy7s6aCZwlA77YEB
        Chc45kMmBrX8Lzk1kAzQdmCeOQ==
X-Google-Smtp-Source: APXvYqxZ54D+VZ1BRTP9UpgguFCizP4ZBPpYz1OoT7BDsD1dW5wa3A5/4dEWw3lEyHmvu/gNNUOCMA==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr39718491pjo.68.1574087806084;
        Mon, 18 Nov 2019 06:36:46 -0800 (PST)
Received: from localhost.localdomain (1-169-21-101.dynamic-ip.hinet.net. [1.169.21.101])
        by smtp.gmail.com with ESMTPSA id x10sm21910996pfn.36.2019.11.18.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:36:45 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: sf-pdma: replace /** with /* for non-function comment
Date:   Mon, 18 Nov 2019 22:35:52 +0800
Message-Id: <20191118143554.16129-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are several comments starting from "/**" but not for function
comment purpose. It causes kernel-doc parsing wrong string. Replace
"/**" with "/*" to fix them.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 2 +-
 drivers/dma/sf-pdma/sf-pdma.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 16fe00553496..e8b9770dcfba 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 55816c9e0249..aab65a0bdfcc 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *

base-commit: a7e335deed174a37fc6f84f69caaeff8a08f8ff8
-- 
2.17.1

