Return-Path: <dmaengine+bounces-747-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4479831877
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 12:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E8E1C209BC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398F2421B;
	Thu, 18 Jan 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EvmJHLWl"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0C24216
	for <dmaengine@vger.kernel.org>; Thu, 18 Jan 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577424; cv=none; b=OOZJHme7JB655W9dh0FN3wMJRXNYP6RqaDUSmpW3vSUo9bA6/TClmJHDDsZxe7WIK/g3DFxtYjvSnWqYW2I9yRVtv1+xkaXEdlnQiy35PUsO89chs6q4XsNHnJJP72TGr+RMct3vI0pFVC5V6IwZlfTpqaz1tdJRHPCt5kubkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577424; c=relaxed/simple;
	bh=+tU00TyfvYfvBv6Fkl/lVMZBaXGMZdXtOKcuhl+DvRU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=UCish1NuzZgtDRh8dbTrB02YObJMPb23LGZrUXTY2Q1/Seo+JXnUGaSsjISH4Eajy2y9r8dpr9ChuU4GmO4Te2k2P0t1nGv1Zj85TuEb9FxIrHuv9vakcL3UysDAqUg7KqqpF0hLIWpwUv1iaxtqNiC4ZsxHTSUCXgRLsPQJiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EvmJHLWl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3C7C735;
	Thu, 18 Jan 2024 12:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705577350;
	bh=+tU00TyfvYfvBv6Fkl/lVMZBaXGMZdXtOKcuhl+DvRU=;
	h=From:To:Cc:Subject:Date:From;
	b=EvmJHLWlyGgVRee7zcnGxn15eZT1miD/kLuupvEG2r+GXRjSBNdlnENcucy+yLDnJ
	 fuGSl8TAB0Cqx+JhKYOrhEmctsf07tYuptrNtUaOkxSw4ClzQSTPU3aANpy/ypC5kC
	 oipKhmFVb2pugmmckjpAbYRpYU9cy4LLmiCSpLcA=
From: Daniel Scally <dan.scally@ideasonboard.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH] dmaengine: pl330: Clear callback_result for re-used descs
Date: Thu, 18 Jan 2024 11:29:59 +0000
Message-Id: <20240118112959.1027471-1-dan.scally@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pl330 driver re-uses DMA descriptors rather than reallocating
them each time. At present, upon re-use the .callback member is
cleared, but .callback result is not. This causes problems where a
consuming driver sets the .callback_result for some submissions but
not for others, as eventually the function is invoked erronously.

Clear .callback_result along with .callback

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/dma/pl330.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3cf0b38387ae..ad8e3da1b2cd 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2585,6 +2585,7 @@ static struct dma_pl330_desc *pluck_desc(struct list_head *pool,
 
 		desc->status = PREP;
 		desc->txd.callback = NULL;
+		desc->txd.callback_result = NULL;
 	}
 
 	spin_unlock_irqrestore(lock, flags);
-- 
2.34.1


