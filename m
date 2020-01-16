Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8913EDFA
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 19:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393494AbgAPSG2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 13:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390757AbgAPRjf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447E324713;
        Thu, 16 Jan 2020 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196375;
        bh=5Hqvj1d0sGbjAeExLTLRYC4kjmNKiEF1Y0ULRa5GIMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePYr0LiY0GZp33xW+oHNaUbYeQSXXjWq7kL0o0KM8olnPhyE21LX1ajmfjqwyaIkg
         ZL+nFhzw3v9nMrPfP5Js+WNxdRqNTn4+qpsNJU75IDDboymaxQFBMefLY+hbndhZmA
         +evKj1tzxIVrzxb2A+bnK0SayTpmTu1a2QCTPdBs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 160/251] dmaengine: hsu: Revert "set HSU_CH_MTSR to memory width"
Date:   Thu, 16 Jan 2020 12:35:09 -0500
Message-Id: <20200116173641.22137-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c24a5c735f87d0549060de31367c095e8810b895 ]

The commit

  080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")

has been mistakenly submitted. The further investigations show that
the original code does better job since the memory side transfer size
has never been configured by DMA users.

As per latest revision of documentation: "Channel minimum transfer size
(CHnMTSR)... For IOSF UART, maximum value that can be programmed is 64 and
minimum value that can be programmed is 1."

This reverts commit 080edf75d337d35faa6fc3df99342b10d2848d16.

Fixes: 080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/hsu/hsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 29d04ca71d52..15525a2b8ebd 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -64,10 +64,10 @@ static void hsu_dma_chan_start(struct hsu_dma_chan *hsuc)
 
 	if (hsuc->direction == DMA_MEM_TO_DEV) {
 		bsr = config->dst_maxburst;
-		mtsr = config->src_addr_width;
+		mtsr = config->dst_addr_width;
 	} else if (hsuc->direction == DMA_DEV_TO_MEM) {
 		bsr = config->src_maxburst;
-		mtsr = config->dst_addr_width;
+		mtsr = config->src_addr_width;
 	}
 
 	hsu_chan_disable(hsuc);
-- 
2.20.1

