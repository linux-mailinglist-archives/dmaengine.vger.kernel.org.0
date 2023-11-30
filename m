Return-Path: <dmaengine+bounces-323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE67FED97
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30011C20BE6
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1293B78C;
	Thu, 30 Nov 2023 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RR3ng+9I"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13406D50
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 03:13:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25F49E0009;
	Thu, 30 Nov 2023 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701342796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8V3ujd/rftS59b/t6fdmENtgEWzOHd92a0x/FPbG0Nc=;
	b=RR3ng+9IcFSOm+RHv+MpmVjFc3FA3Mjl0pGGTNQqnC0R1N7XJN3uXbI5Hj9UsxmGp1quuP
	v6pALZ55wYl8CirrDfaetXJeuo+/ob2f29rn6ZkIXQdKl8sOyNHNChRuUezvn8+HvJQQCQ
	K+M4jVhA6cviZ2BoWBLFPoyHfFTIYgDihoquWPGxt3YxSI10ANJz7b0bjtgyN3frTmtnO9
	T4SWXo19W6o7yyCwnFKeUMYXOeYDR9kNLJvZCwvGIswDf2zy529553bswkhHLwZ2yM51Gx
	sy+vO/mlzg5KB816Nccox6flQbusgI004hcu8ene99ZIeek7HuzpRq3WKl7z3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michal Simek <monstr@monstr.eu>,
	dmaengine@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/4] dmaengine: xilinx: Misc (cyclic) transfers fixes
Date: Thu, 30 Nov 2023 12:13:11 +0100
Message-Id: <20231130111315.729430-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

So far all my testing was performed by looping the playback output to
the recording input and comparing the files using FFTs. Unfortunately,
when the DMA engine suffers from the same issue on both sides, some
issues may appear un-noticed. I now have proper hardware to really
listen to the actual sound, so here are a couple of fixes and
improvements.

Cheers,
Miquèl

Changes in v2:
* Added a patch to clarify the logic in the interrupt handler between
  cyclic and sg transfers.
* Fixed the count of elapsed periods without breaking SG.

Miquel Raynal (4):
  dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic
    mode
  dmaengine: xilinx: xdma: Clarify the logic between cyclic/sg modes
  dmaengine: xilinx: xdma: Better handling of the busy variable
  dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks

 drivers/dma/xilinx/xdma.c | 103 +++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 18 deletions(-)

-- 
2.34.1


