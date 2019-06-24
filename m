Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4782E50AC1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfFXMfr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:35:47 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:38754 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfFXMfr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:35:47 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id Ucbi2000P3XaVaC06cbiuc; Mon, 24 Jun 2019 14:35:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOCE-0003jz-Fq; Mon, 24 Jun 2019 14:35:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOCE-0005NY-En; Mon, 24 Jun 2019 14:35:42 +0200
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
Subject: [PATCH 2/2] serial: sh-sci: Terminate TX DMA during buffer flushing
Date:   Mon, 24 Jun 2019 14:35:40 +0200
Message-Id: <20190624123540.20629-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624123540.20629-1-geert+renesas@glider.be>
References: <20190624123540.20629-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While the .flush_buffer() callback clears sci_port.tx_dma_len since
commit 1cf4a7efdc71cab8 ("serial: sh-sci: Fix race condition causing
garbage during shutdown"), it does not terminate a transmit DMA
operation that may be in progress.

Fix this by terminating any pending DMA operations, and resetting the
corresponding cookie.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d4504daff99263f5..d18c680aa64b3427 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1656,11 +1656,18 @@ static void sci_free_dma(struct uart_port *port)
 
 static void sci_flush_buffer(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+
 	/*
 	 * In uart_flush_buffer(), the xmit circular buffer has just been
-	 * cleared, so we have to reset tx_dma_len accordingly.
+	 * cleared, so we have to reset tx_dma_len accordingly, and stop any
+	 * pending transfers
 	 */
-	to_sci_port(port)->tx_dma_len = 0;
+	s->tx_dma_len = 0;
+	if (s->chan_tx) {
+		dmaengine_terminate_async(s->chan_tx);
+		s->cookie_tx = -EINVAL;
+	}
 }
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
-- 
2.17.1

