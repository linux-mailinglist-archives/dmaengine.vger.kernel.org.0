Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF30304473
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbhAZGBV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 01:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbhAYO3L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jan 2021 09:29:11 -0500
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [IPv6:2a02:1800:110:4::f00:d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585A9C061794
        for <dmaengine@vger.kernel.org>; Mon, 25 Jan 2021 06:27:21 -0800 (PST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4DPXG703S1zMsJqG
        for <dmaengine@vger.kernel.org>; Mon, 25 Jan 2021 15:25:35 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id M2QZ240084C55Sk012QZ6k; Mon, 25 Jan 2021 15:24:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l42nA-000eiT-MP; Mon, 25 Jan 2021 15:24:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l42nA-004P50-4V; Mon, 25 Jan 2021 15:24:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Date:   Mon, 25 Jan 2021 15:24:27 +0100
Message-Id: <20210125142431.1049668-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

	Hi Vinod,

This patch series adds support for the Direct Memory Access Controller
variant in the Renesas R-Car V3U (R8A779A0) SoC, to both DT bindings and
driver.

Changes compared to v1:
  - Add Reviewed-by,
  - Put the full loop control of for_each_rcar_dmac_chan() on a single
    line, to improve readability,
  - Use two separate named regions instead of array,
  - Drop rcar_dmac_of_data.chan_reg_block, check for
    !rcar_dmac_of_data.chan_offset_base instead,
  - Precalculate chan_base in rcar_dmac_probe().

This has been tested on the Renesas Falcon board, using external SPI
loopback (spi-loopback-test) on MSIOF1 and MSIOF2.

Thanks!

Geert Uytterhoeven (4):
  dt-bindings: renesas,rcar-dmac: Add r8a779a0 support
  dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
  dmaengine: rcar-dmac: Add helpers for clearing DMA channel status
  dmaengine: rcar-dmac: Add support for R-Car V3U

 .../bindings/dma/renesas,rcar-dmac.yaml       |  76 ++++++++-----
 drivers/dma/sh/rcar-dmac.c                    | 105 +++++++++++++-----
 2 files changed, 123 insertions(+), 58 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
