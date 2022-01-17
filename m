Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFE48FFFA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 02:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiAQBfg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jan 2022 20:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiAQBfe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jan 2022 20:35:34 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B76C061574
        for <dmaengine@vger.kernel.org>; Sun, 16 Jan 2022 17:35:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g2so9202823pgo.9
        for <dmaengine@vger.kernel.org>; Sun, 16 Jan 2022 17:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5VfPZXhTB1Gitf1/abkH4dtjlhx6yCzyBbwzkYPtDE=;
        b=nuEGBewfX2D4CBsw5hzzXDBRybGp50VAcaPLK0Bqr/3r2gDlgyUhoDa01Y75lMtU4R
         ZsqZtEl/sbAcUqB9SJYhkfasbFUOOp6jKKaBBeKAEC4P1f6pataPMUxT76rMe6VnGxnE
         bxWI36FkiT/2N2I4+m/qFkrI3+iiAaY0rSbiG6Jp9qMbzoNCVRxeVNeGzh1iZxFnnKLa
         xXrj9gowNzNXtyIaGxcZlx0cz/zZM0r/4g5P1T8FcZDwusYWq3P64BtvYD7EvrOg7PEy
         1lMmj1YjI+E9v4/poeZIQqxDWdeoV0xpkV4rAZTGGF7PQ3wAFQkz0l4UDRJWSuMzrkb+
         hXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5VfPZXhTB1Gitf1/abkH4dtjlhx6yCzyBbwzkYPtDE=;
        b=yv4FGurMb9mQyq8+4l8C/go5gBVfkv8AlWN/8FqDBVBucT83N11jYSwVr7MlxlLx6r
         yY5y6yXOEMNQk6kRg/BYo06O595stOS4cirmqAAsfeTCip9e3JjTcm55zp8XHHKBXbFj
         r8EgmAYQEIjhY2aUEFoySsBH1s92ugAFhETexa7u2xZjycCsOfnKYJCLi0zSz03sSPOm
         npbdPKGeSKMpyyUvCLNYqM+GxwuQE8a0FkaU0/oEZEDG0DApVsxpisNOd/gPnEY3cXmm
         oAUE+Z1WxCbV8r+ZmLPJ2kkMTcrlpUdfH2wbOBxfHWHG654bqOw7sw7mYuiEOyHLZzSt
         agQw==
X-Gm-Message-State: AOAM530va+WemJ76SwPuEXiAJIRIOBXIBYSpoSOpURq/1WzzVjJw4zf1
        o3AXplQcuDsMzrNg7Q8KFCcu1Q==
X-Google-Smtp-Source: ABdhPJxLIYeShTzCQNAuiqhv+woORrPiGiFg3PY5eGHPTWu8DqZgmWT1wWUIlKvDczvdCAZbTZ+aQg==
X-Received: by 2002:a63:83c8:: with SMTP id h191mr9624306pge.499.1642383334271;
        Sun, 16 Jan 2022 17:35:34 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l1sm10008335pgn.35.2022.01.16.17.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 17:35:33 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/3] Determine the number of DMA channels by 'dma-channels' property
Date:   Mon, 17 Jan 2022 09:35:25 +0800
Message-Id: <cover.1642383007.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The PDMA driver currently assumes there are four channels by default, it
might cause the error if there is actually less than four channels.
Change that by getting number of channel dynamically from device tree.
For backwards-compatible, it uses the default value (i.e. 4) when there
is no 'dma-channels' information in dts.

This patch set contains the dts and dt-bindings change.

Changed in v4:
 - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>

Changed in v3:
 - Fix allocating wrong size
 - Return error if 'dma-channels' is larger than maximum

Changed in v2:
 - Rebase on tag v5.16
 - Use 4 as default value of dma-channels

Zong Li (3):
  riscv: dts: Add dma-channels property in dma node
  dt-bindings: Add dma-channels for pdma device node
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  7 +++++++
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  1 +
 drivers/dma/sf-pdma/sf-pdma.c                 | 20 ++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++------
 5 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.31.1

