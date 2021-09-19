Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E7410BFB
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhISOpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhISOpW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:45:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C0C061574;
        Sun, 19 Sep 2021 07:43:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a7so731177plm.1;
        Sun, 19 Sep 2021 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgPLHXXunCR3IzS/aaq9u3EBGY9bXZbNkS1EmeAMmh0=;
        b=KiriABwjLeDoe6zxuxLHC2Sx7VC4PiH30cNQ7gr+0L3GS4gmwZIHtLwLQd44pWO83T
         EFT3Dc2d7DLiWu7oqFJIqnrAPIyKFgArbghP+wMQnDDsqlnuYGeKuD2g7a9RXu8WKPsS
         d7qQG2YBq5BRh5uIdcGVKy4XNA1lYF1rVfXenWg7VBKjnKle8tie8vAxqSExu7OIqwoD
         N39P+eIhzuOpSh1sfoUS5odUqGLX8NnLSINOs+uxYayU4Ge5iKeUoiFssxSAP+IbosrD
         gjnyvQow832Y+cVcn57uXK/m3sCqniS5WWdliZQ53EJtUsANzo5OKzjYgyDGuFUXYOXx
         Ed1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgPLHXXunCR3IzS/aaq9u3EBGY9bXZbNkS1EmeAMmh0=;
        b=Vx4+vGNFoSZd6gwxwXIDZUhm1k6IrLy3qajg5U57y7QznHmhy47Ss0fv6vQxs9YdM+
         EBCOffDMA4f1CbnJRSP4FVjEWVZQw0NE1ybed1iSDERDToLdRRghz+fL9vBSUSkGUlAF
         UssirPSUZN8dKofy4NkODs90LtGTPnCg061bXOM0hG4GE3e6KMsPv8+iEVDZsBRgi2S0
         kY4Q3JqUok8Cz8DefCwqiGJYqYw+bo52YquIrwegn1/hsjZ/wEEAOA7yJk5NemJhoXhx
         LnxRrmUE1QeMctH4XabE4SkfoE3fTRQ+adI9ZvZaf7NHS1v9zGo6oCzl+H5DkkBRw6pe
         VtXg==
X-Gm-Message-State: AOAM531JvletTS55EuKf8hNDzxhOJ0uO0q6cTgP4z3oeDgyipGqZKcay
        8xj7F1YtVxW4KErvL9mP+/If/kakgClRFQ==
X-Google-Smtp-Source: ABdhPJy8wAKk3vfnNfUGf6OGG0Dks/Aq2Y2tvtbLsF2qNj3CEc/n9extXaDZ3lEbrs1TtFJrZXR/ZQ==
X-Received: by 2002:a17:90b:4a8a:: with SMTP id lp10mr24047358pjb.216.1632062637080;
        Sun, 19 Sep 2021 07:43:57 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id c9sm16270427pjg.2.2021.09.19.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:43:56 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [RFC PATCH 0/3] DMAengine: Add support for Immediate commands
Date:   Sun, 19 Sep 2021 20:13:18 +0530
Message-Id: <20210919144322.31977-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The IPA v2.x block, found on some older Qualcomm SoCs, uses BAM DMA to
send and receive packets from the AP. It also uses BAM to receive
commands from the AP (and possibly the modem). These commands are
encoded as "Immediate Commands". They vary from regular BAM DMA
commands, although I'm not sure as to exactly how they vary. Adding
support for immediate commands is trivial, but requires also adding
Immediate Commands to the dmaengine API, which is what this patch does.

Sireesh Kodali (3):
  doc: dmaengine: client-api: Add immediate commands in the DMA client
    API
  dmaengine: Add support for immediate commands in the client API
  dmaengine: qcom: bam_dma: Add support for immediate commands

 Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
 drivers/dma/qcom/bam_dma.c                      |  3 +++
 include/linux/dmaengine.h                       |  4 ++++
 3 files changed, 17 insertions(+)

-- 
2.33.0

