Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961F7123C14
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfLRA5R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 19:57:17 -0500
Received: from mx.socionext.com ([202.248.49.38]:11515 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfLRA5R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Dec 2019 19:57:17 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Dec 2019 09:57:15 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id DFF06603AB;
        Wed, 18 Dec 2019 09:57:15 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 18 Dec 2019 09:58:00 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 360311A0006;
        Wed, 18 Dec 2019 09:57:15 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] dmaengine: Add UniPhier XDMAC driver
Date:   Wed, 18 Dec 2019 09:56:58 +0900
Message-Id: <1576630620-1977-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for UniPhier external DMA controller (XDMAC), that is implemented
in Pro4, Pro5, PXs2, LD11, LD20 and PXs3 SoCs.

Kunihiko Hayashi (2):
  dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
  dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver

 .../devicetree/bindings/dma/uniphier-xdmac.txt     |  86 +++
 drivers/dma/Kconfig                                |  11 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/uniphier-xdmac.c                       | 620 +++++++++++++++++++++
 4 files changed, 718 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
 create mode 100644 drivers/dma/uniphier-xdmac.c

-- 
2.7.4

