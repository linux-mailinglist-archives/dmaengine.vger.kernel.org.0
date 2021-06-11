Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3EF3A4007
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 12:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKKUr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFKKUr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 06:20:47 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2EC0613A2
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 03:18:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2411:a261:8fe2:b47f])
        by baptiste.telenet-ops.be with bizsmtp
        id FmJl2500K25eH3q01mJl6A; Fri, 11 Jun 2021 12:18:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFQ-00Fd29-VD; Fri, 11 Jun 2021 12:18:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFQ-00CaZT-H1; Fri, 11 Jun 2021 12:18:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] Remove shdma DT support
Date:   Fri, 11 Jun 2021 12:18:38 +0200
Message-Id: <cover.1623405675.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

	Hi all,

Documentation/devicetree/bindings/dma/renesas,shdma.txt is one of the
few^W57% of the DT bindings that haven't been converted to json-schema
yet.  These bindings were originally intended to cover all SH/R-Mobile
SoCs, but the DMA multiplexer node and one DMA controller instance were
only ever added to one .dtsi file, for R-Mobile APE6.  Still, DMA
support for R-Mobile APE6 was never completed to the point that it would
actually work, cfr. commit a19788612f51b787 ("dmaengine: sh: Remove
R-Mobile APE6 support").  Later, the mux idea was dropped when
implementing support for DMA on (very similar) R-Car Gen2, cfr.
renesas,rcar-dmac.yaml.

Hence this series removes the Renesas SHDMA Device Tree bindings, the
SHDMA DMA multiplexer driver, and the corresponding description in the
R-Mobile APE6 DTS.

I plan to queue [PATCH 3/3] in renesas-devel for v5.15.

Thanks for your comments!

Geert Uytterhoeven (3):
  dt-bindings: dmaengine: Remove SHDMA Device Tree bindings
  dmaengine: sh: Remove unused shdma-of driver
  ARM: dts: r8a73a4: Remove non-functional DMA support

 .../devicetree/bindings/dma/renesas,shdma.txt | 84 -------------------
 arch/arm/boot/dts/r8a73a4.dtsi                | 44 ----------
 drivers/dma/sh/Makefile                       |  2 +-
 drivers/dma/sh/shdma-of.c                     | 76 -----------------
 4 files changed, 1 insertion(+), 205 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,shdma.txt
 delete mode 100644 drivers/dma/sh/shdma-of.c

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
