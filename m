Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A633E143989
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAUJeQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:34:16 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49304 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJeP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jan 2020 04:34:15 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id sxaD2100c5USYZQ01xaDyx; Tue, 21 Jan 2020 10:34:14 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itpvI-0008IS-Qq; Tue, 21 Jan 2020 10:34:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itpuM-0007Sq-0g; Tue, 21 Jan 2020 10:33:14 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/3] dmaengine: Miscellaneous cleanups
Date:   Tue, 21 Jan 2020 10:33:08 +0100
Message-Id: <20200121093311.28639-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

	Hi Vinod,

This patch series contains a few miscellaneous cleanups for the DMA
engine code and API.

Changes compared to v1:
  - Add Acked-by,
  - Rebase on top of today's slave-dma/next.

Thanks!

Geert Uytterhoeven (3):
  dmaengine: Remove dma_device_satisfies_mask() wrapper
  dmaengine: Remove dma_request_slave_channel_compat() wrapper
  dmaengine: Move dma_get_{,any_}slave_channel() to private dmaengine.h

 drivers/dma/dmaengine.c   | 9 +++------
 drivers/dma/dmaengine.h   | 3 +++
 drivers/dma/of-dma.c      | 2 ++
 include/linux/dmaengine.h | 8 ++------
 4 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
