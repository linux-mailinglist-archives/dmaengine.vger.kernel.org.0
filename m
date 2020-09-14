Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A133268D22
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgINOKN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:10:13 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6828 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgINOKF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092605; x=1631628605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+6lC8ARyP4M+w2bf6W5qKFsmZlynHJRKkVTNVKbQ9o=;
  b=V+PeEK4gGY2/e5fPjjnbC/ex2L0JYYGg7dlJ41ek3PBeSUPxpmLza7FV
   nJ7QuOYwcewAlm5W23zLDCOCOVsxE5PjKWwEe4sVadWyZi0hCzWmTCqPc
   8w0RblhclHuSbmd9ElOyShhv0/Wogn3KQZXLfKZmCp9nlUTsJ61+LyFVv
   LlMSYbt7iFwZXKtWdHp36mbOtHBcswWUEaXBIuHjMbIbIqygUfeGr9RGH
   1ilK7m57cuKzAOwcyA8vejNxljykeZNzpcPXFLIWnzC1BJRQ6PK7eQuCX
   wfy8FSto8jOkxrS2K+Cr28wq7yheEYQDdObzzI232G7aUf+RBw/KW+1Uv
   g==;
IronPort-SDR: ASYTBgDYQUudn+rtV449UYNYZ46d7K3OWrcKa2iV8EEnK+sw049wodL/Z1M7O2Td3r5qAnkF7v
 Rd/4yZfevT/Xd92jW8k+hvM0WgCmR7vl9zs8cIuUnWvOViTd3ISKlFzhHvS8JqmzUZS3NUNx5x
 d6/F8spMF4lEcpqZjUDGvt19/Z6NQ7ToXZOzdnQSBS0gLfkWAFGJjHUgIM5cr1i8N9cSHiFF+W
 XPd7BsmECdG0JaEnQdHzKUxZH01SZEmRxf3RJ2afNDoaGMwnR+LVjZ2zRSQqgtIxzXXH422L06
 L5A=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="88993898"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:01 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:09:57 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 0/7] dmaengine: add support for sama7g5 based at_xdmac
Date:   Mon, 14 Sep 2020 17:09:49 +0300
Message-ID: <20200914140956.221432-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for sama7g5-based at_xdmac.

In sama7g5, the XDMAC is present in a slightly modified form. This series
tries to adapt the existing driver to the differences.
According to the compatible string, we select one of two possible
layouts, which hold the differences in registermap and supported features.

Thanks!

Eugen Hristev (7):
  dmaengine: at_xdmac: separate register defines into header file
  MAINTAINERS: add dma/at_xdmac_regs.h to XDMAC driver entry
  dt-bindings: dmaengine: at_xdmac: add compatible with
    microchip,sama7g5
  dmaengine: at_xdmac: adapt perid for mem2mem operations
  dmaengine: at_xdmac: add support for sama7g5 based at_xdmac
  dt-bindings: dmaengine: at_xdmac: add optional microchip,m2m property
  dmaengine: at_xdmac: add AXI priority support and recommended settings

 .../devicetree/bindings/dma/atmel-xdma.txt    |   9 +-
 MAINTAINERS                                   |   1 +
 drivers/dma/at_xdmac.c                        | 273 +++++++-----------
 drivers/dma/at_xdmac_regs.h                   | 161 +++++++++++
 4 files changed, 281 insertions(+), 163 deletions(-)
 create mode 100644 drivers/dma/at_xdmac_regs.h

-- 
2.25.1

