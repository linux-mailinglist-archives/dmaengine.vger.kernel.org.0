Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7782FD1AB
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jan 2021 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhATNT6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 08:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389341AbhATNTo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Jan 2021 08:19:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8907E2245C;
        Wed, 20 Jan 2021 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148743;
        bh=bQTnBKkU+gtgpMEYbCsMyfCEEsZ5pC/JUmFF+aOaAgY=;
        h=From:To:Cc:Subject:Date:From;
        b=bL4n5mSWjKoQM7CIk3iH07O5rrNJOC8sw6fa2RpIxZX6ZFe/L3IJW2gJ1ukzOk54E
         UvgFQLXgQDiltfSBc9NCjMvIuID30+6kcHtyJGQcefan0UO4H8NVro/1/6wsxq6kHk
         R2EfpE12RsdDieGHLjwlhxw9BoXzoOStqXAp5YbczS6SzQOAiALqreDeLpcuU2yNJt
         svvYkkv9d9OFaRNl+v45vS+DNuJl1fWe/xzZI2ZKeao/0+Y3XzUT5dXcwrvIbP24w1
         TbT5Q4cycDX0h8UJidZuCXfFlpmsudMw5VQpHNTj3SS89Khv9OQz3fFphJyfWw+Cat
         zPh1TUbSkJ8mA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] dmaengine: remove obsolete drivers
Date:   Wed, 20 Jan 2021 14:18:56 +0100
Message-Id: <20210120131859.2056308-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few Arm platforms are getting removed in v5.12, this removes
the corresponding dmaengine drivers.

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/

Arnd Bergmann (3):
  dmaengine: remove sirfsoc driver
  dmaengine: remove zte zx driver
  dmaengine: remove coh901318 driver

 .../devicetree/bindings/dma/sirfsoc-dma.txt   |   44 -
 .../devicetree/bindings/dma/ste-coh901318.txt |   32 -
 .../devicetree/bindings/dma/zxdma.txt         |   38 -
 drivers/dma/Kconfig                           |   23 -
 drivers/dma/Makefile                          |    3 -
 drivers/dma/coh901318.c                       | 2808 -----------------
 drivers/dma/coh901318.h                       |  141 -
 drivers/dma/coh901318_lli.c                   |  313 --
 drivers/dma/sirf-dma.c                        | 1170 -------
 drivers/dma/zx_dma.c                          |  941 ------
 include/linux/platform_data/dma-coh901318.h   |   72 -
 include/linux/sirfsoc_dma.h                   |    7 -
 12 files changed, 5592 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/ste-coh901318.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/zxdma.txt
 delete mode 100644 drivers/dma/coh901318.c
 delete mode 100644 drivers/dma/coh901318.h
 delete mode 100644 drivers/dma/coh901318_lli.c
 delete mode 100644 drivers/dma/sirf-dma.c
 delete mode 100644 drivers/dma/zx_dma.c
 delete mode 100644 include/linux/platform_data/dma-coh901318.h
 delete mode 100644 include/linux/sirfsoc_dma.h

-- 
2.29.2

