Return-Path: <dmaengine+bounces-564-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD760816D1F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF41F21054
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959EE20333;
	Mon, 18 Dec 2023 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="ND8zoMLw"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1F2032C;
	Mon, 18 Dec 2023 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 1FD762D01867;
	Mon, 18 Dec 2023 12:39:20 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gGqg9rPT4wgP; Mon, 18 Dec 2023 12:39:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 9A9E52D01866;
	Mon, 18 Dec 2023 12:39:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 9A9E52D01866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899555;
	bh=mXCs9y64eWuttsE1FX3hE40mVputIsPbWNfeVVkmAa0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ND8zoMLwVg7nNq9XJv8geoSeRIuUgImoEICKkDj3RCiiZmULbzn5QHg1AIkbwEYoX
	 mse8q4fJYmAVpDhUVoVXsSOXuMqHWahxRVvqALmAIjxPpnGF9E0HadhI6K0v6QdIi7
	 vuQvVn9jB6j3UvncQpKip/SDF/M08uDoTkDEvGEYccKHauTEr3Z/rvrBaELMyzi7lF
	 1ePYjxMpe+H0zFwaA8VNcFHu/x+4qtjtK9pjH6mWe91W66O6+BgD4iESDd5govgUAC
	 zYxrZV/L2c70fnUrRJXc4hrsrfVmP+Pm1vE1MlrV/GtGyT+5RXnke0YoWBFNupTI8J
	 qQuHM4RWrL9Eg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UApvNHih8UAM; Mon, 18 Dec 2023 12:39:15 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 4F0E32D01865;
	Mon, 18 Dec 2023 12:39:15 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com
Cc: jankul@alatek.krakow.pl
Subject: [PATCH v5 0/8] Miscellaneous xdma driver enhancements
Date: Mon, 18 Dec 2023 12:39:04 +0100
Message-Id: <20231218113904.9071-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This patchset introduces a couple of xdma driver enhancements. The most
important change is the introduction of interleaved DMA transfers
feature, which is a big deal, as it allows DMAEngine clients to express
DMA transfers in an arbitrary way. This is extremely useful in FPGA
environments, where in one FPGA system there may be a need to do DMA both
to/from FIFO at a fixed address and to/from a (non)contiguous RAM.

It is a another reroll of my previous patch series [1], but it is heavily
modified one as it is based on Miquel's patchset [2]. We agreed on doing
it that way, as both our patchsets touched the very same piece of code.
The discussion took place under [2] thread.

I tested it with XDMA v4.1 (Rev.20) IP core, with both sg and
interleaved DMA transfers.

Jan

Changes since v1:
[PATCH 1/5]:=20
Complete a terminated descriptor with dma_cookie_complete()
Don't reinitialize temporary list head in xdma_terminate_all()=20
[PATCH 4/5]:
Fix incorrect text wrapping

Changes since v2:
[PATCH 1/5]:
DO NOT schedule callback from within xdma_terminate_all()

Changes since v3:
Base patchset on Miquel's [2] series
Reorganize commits` structure
Introduce interleaved DMA transfers feature
Implement transfer error reporting

Changes since v4:
Get rid of duplicated line of code
Fix various coding style issues

[1]:
https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alatek.k=
rakow.pl/T/#t

[2]:
https://lore.kernel.org/dmaengine/20231130111315.729430-1-miquel.raynal@b=
ootlin.com/T/#t

---
Jan Kuliga (8):
  dmaengine: xilinx: xdma: Get rid of unused code
  dmaengine: xilinx: xdma: Add necessary macro definitions
  dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
  dmaengine: xilinx: xdma: Rework xdma_terminate_all()
  dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
  dmaengine: xilinx: xdma: Add transfer error reporting
  dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA
    transfers
  dmaengine: xilinx: xdma: Implement interleaved DMA transfers

 drivers/dma/xilinx/xdma-regs.h |  30 ++--
 drivers/dma/xilinx/xdma.c      | 283 +++++++++++++++++++++++----------
 2 files changed, 210 insertions(+), 103 deletions(-)

--=20
2.34.1


