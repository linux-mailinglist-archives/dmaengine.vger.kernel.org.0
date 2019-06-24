Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63D950ABF
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfFXMfr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:35:47 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:51578 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbfFXMfq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:35:46 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Ucbi2000A3XaVaC01cbi88; Mon, 24 Jun 2019 14:35:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOCE-0003jv-FB; Mon, 24 Jun 2019 14:35:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOCE-0005NU-Ci; Mon, 24 Jun 2019 14:35:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Date:   Mon, 24 Jun 2019 14:35:38 +0200
Message-Id: <20190624123540.20629-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

	Hi Greg, Jiri,

This patch series attempts to fix the issues Eugeniu Rosca reported
seeing, where .flush_buffer() interfered with transmit DMA operation[*].

There's a third patch "dmaengine: rcar-dmac: Reject zero-length slave
DMA requests", which is related to the issue, but further independent,
hence submitted separately.

Eugeniu: does this fix the issues you were seeing?

Thanks for your comments!

[*] '[PATCH 2/6] Revert "arm64: dts: renesas: r8a7796: Enable DMA for SCIF2"'
(https://lore.kernel.org/lkml/20190504004258.23574-3-erosca@de.adit-jv.com/).

Geert Uytterhoeven (2):
  serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
  serial: sh-sci: Terminate TX DMA during buffer flushing

 drivers/tty/serial/sh-sci.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
