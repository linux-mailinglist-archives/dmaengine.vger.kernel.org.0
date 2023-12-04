Return-Path: <dmaengine+bounces-362-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974F8035DB
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E9F1F210F7
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C025762;
	Mon,  4 Dec 2023 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tOvWWh3x"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC0FD;
	Mon,  4 Dec 2023 06:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1701698643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0R6n2GdeXzFfYLayCJ7fH/bR9FIh7AyGBXRunAkFdY=;
	b=tOvWWh3xPDptDfio68Mh6k02djeZhZclseZwiQh2JhDB4WZO7JJPTghYXlyr6WfM8/tAo6
	pRlnPuyTZ0RYqSGq5K1pHpYBmGPc3NeMyPNY0zZqIaQXdm24BtObai2Dj/rvhInM7sfg78
	3FmRi2R374pvf3JbMnjc8SwzQ4dhB8c=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/4] axi-dmac: Add support for scatter-gather transfers
Date: Mon,  4 Dec 2023 15:03:48 +0100
Message-ID: <20231204140352.30420-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Hi Vinod,

This patchset updates the dma-axi-dmac driver, and introduces the
ability to use scatter-gather transfers, that are now supported by the
IP core.

When using an older version of the core, the driver will simply fall
back to using standard transfers.

The patchset was generated on top of today's linux-next (629a3b49f3f9).

Cheers,
-Paul

Paul Cercueil (4):
  dmaengine: axi-dmac: Small code cleanup
  dmaengine: axi-dmac: Allocate hardware descriptors
  dmaengine: axi-dmac: Add support for scatter-gather transfers
  dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather

 drivers/dma/dma-axi-dmac.c | 261 +++++++++++++++++++++++++------------
 1 file changed, 178 insertions(+), 83 deletions(-)

-- 
2.42.0


