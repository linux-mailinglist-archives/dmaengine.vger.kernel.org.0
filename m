Return-Path: <dmaengine+bounces-237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B857F84B5
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 20:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E47B232FE
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C439FEA;
	Fri, 24 Nov 2023 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="YM4Yk35t"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8B1BF8;
	Fri, 24 Nov 2023 11:25:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id DE5CA2CE00D3;
	Fri, 24 Nov 2023 20:25:36 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bE0tyA43a6JX; Fri, 24 Nov 2023 20:25:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 554EE2CE00D1;
	Fri, 24 Nov 2023 20:25:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 554EE2CE00D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700853932;
	bh=N9oNcNEz/+wUQVlPr2Fof+k+KhCs0HIeg5s/pAv6Gxo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YM4Yk35tldo7lFH8d6UM4t5DCS4Jf62jpH1bv4wpDXhh51Cxc5dwLL+J6oPqF/q5J
	 O8kDG9C0GHFmxAlpQT9wvMroTgA+R+x0uw7gVncXnYfDZhxVM4Ui5VelCN/9TOruUu
	 Bvaw9hqsuP3CXahlhTRJTUWfOtU/u4rTv/1jIJ5L2KbJWWsWeJgTyM849FNx9jLkJ9
	 P4uWNNjVv2lovj6Fhpy36om6TpbotQ13sNeHFRFIflazeOQo9B/KECXXzfq4c9jAFD
	 TlokJ8KD4UrjgPxxBjkyR+FGaVaXMgh9FtwZvpdU6yDPCtjds1kBvH8GORKDH6Otau
	 Xgb1aCBDN1v+A==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id AeNaMHAkrmQn; Fri, 24 Nov 2023 20:25:32 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 11B052CE00D0;
	Fri, 24 Nov 2023 20:25:32 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runtimeca39d@amd.com
Cc: Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH v3 0/5] Miscellaneous xdma driver enhancements
Date: Fri, 24 Nov 2023 20:25:24 +0100
Message-Id: <20231124192524.134989-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This patch series is pretty similar to the v1 version. I've named
it v3 because I've already sent a v2 patch as a reply to the message with
[PATCH 1/5]. The problem is, that this v2 patch is broken and
should be ignored. Sorry for that.

Jan

Changes since v1:
[PATCH 1/5]:=20
Complete a terminated descriptor with dma_cookie_complete()
Don't reinitialize temporary list head in xdma_terminate_all()
          =20
[PATCH 4/5]:
Fix incorrect text wrapping

Changes since v2:
[PATCH 1/5]:
DO NOT schedule callback from within xdma_terminate_all()

Here's the original message:

Hi,

This patch series introduces a couple of xdma driver enhancements, such
as two dmaengine callbacks, partial rework of a interrupt service
routine and loosening of dma_pool alignment requirements. I have tested
these changes with XDMA v4.1 (Rev. 20) block.

Jan
---

Jan Kuliga (5):
  dmaengine: xilinx: xdma: Add transfer termination callbacks
  dmaengine: xilinx: xdma: Get rid of duplicated macros definitions
  dmaengine: xilinx: xdma: Complete lacking register description
  dmaengine: xilinx: xdma: Rework xdma_channel_isr()
  dmaengine: xilinx: xdma: Ease dma_pool alignment requirements

 drivers/dma/xilinx/xdma-regs.h | 24 ++++------
 drivers/dma/xilinx/xdma.c      | 82 +++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 26 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
--=20
2.34.1


