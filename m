Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30F79CE7
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfG2Xiq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 19:38:46 -0400
Received: from gateway36.websitewelcome.com ([50.116.125.2]:48370 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727533AbfG2Xiq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jul 2019 19:38:46 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 19:38:46 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 9AB05400C88C5
        for <dmaengine@vger.kernel.org>; Mon, 29 Jul 2019 17:16:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sEVDh1w7w2qH7sEVDh4IBR; Mon, 29 Jul 2019 17:52:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RGM1QOf7Ifka8Lzj21bKpD9jnLg3f9Vd1ITqzxm/VOU=; b=gV9r2PvwJ6rxIRIgwFC2X2SCdZ
        g7/+BkFcoDz0V9uUOGllyxNtsuluzDThOjYowlhrij65SbkzuX75rigaZDRftzgUiV0o1DPAYUTGb
        oZrWQybdnVtt/4v1P7Rusa2Q1rTb/30pyx4ExZe2xPRlFQfh/Y/2E8OKwJ448mqa7mUmWwvnwFoLk
        N5zW03DPfInXg5UpRiUBT5MpkOyVO3BLu5XNZ3fi7uz5wu8vIArdm+DT4elWgYkmikAC/wbkQTP8V
        a8cEFs8pUOoQmOwXYBaP2ZQsuJWBuIdHKwgY3BlCb8Ix150TlM+sOJanfZFuzXIQNbiBWAQIpRLcT
        wumxlobw==;
Received: from [187.192.11.120] (port=60908 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsEVB-002HF4-S4; Mon, 29 Jul 2019 17:52:22 -0500
Date:   Mon, 29 Jul 2019 17:52:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] dmaengine: imx-dma: Mark expected switch fall-through
Message-ID: <20190729225221.GA24269@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsEVB-002HF4-S4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 52
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/dma/imx-dma.c: In function ‘imxdma_xfer_desc’:
drivers/dma/imx-dma.c:542:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (slot == IMX_DMA_2D_SLOT_A) {
      ^
drivers/dma/imx-dma.c:559:2: note: here
  case IMXDMA_DESC_MEMCPY:
  ^~~~

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/imx-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 00a089e24150..5c0fb3134825 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -556,6 +556,7 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 		 * We fall-through here intentionally, since a 2D transfer is
 		 * similar to MEMCPY just adding the 2D slot configuration.
 		 */
+		/* Fall through */
 	case IMXDMA_DESC_MEMCPY:
 		imx_dmav1_writel(imxdma, d->src, DMA_SAR(imxdmac->channel));
 		imx_dmav1_writel(imxdma, d->dest, DMA_DAR(imxdmac->channel));
-- 
2.22.0

