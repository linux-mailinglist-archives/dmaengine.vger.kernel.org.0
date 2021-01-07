Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92712ED687
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jan 2021 19:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbhAGSQI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jan 2021 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbhAGSQI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jan 2021 13:16:08 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B4C0612F9
        for <dmaengine@vger.kernel.org>; Thu,  7 Jan 2021 10:15:28 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id DuFS2400J4C55Sk01uFSoj; Thu, 07 Jan 2021 19:15:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-001v2j-0N; Thu, 07 Jan 2021 19:15:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZoj-008AYq-G1; Thu, 07 Jan 2021 19:15:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Date:   Thu,  7 Jan 2021 19:15:20 +0100
Message-Id: <20210107181524.1947173-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

	Hi all,

This patch series adds support for the Direct Memory Access Controller
variant in the Renesas R-Car V3U (R8A779A0) SoC, to both DT bindings and
driver.

This has been tested on the Renesas Falcon board, using external SPI
loopback (spi-loopback-test) on MSIOF1 and MSIOF2.

Thanks for your comments!

Geert Uytterhoeven (4):
  dt-bindings: renesas,rcar-dmac: Add r8a779a0 support
  dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
  dmaengine: rcar-dmac: Add helpers for clearing DMA channel status
  dmaengine: rcar-dmac: Add support for R-Car V3U

 .../bindings/dma/renesas,rcar-dmac.yaml       |  76 ++++++++-----
 drivers/dma/sh/rcar-dmac.c                    | 100 ++++++++++++------
 2 files changed, 118 insertions(+), 58 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
