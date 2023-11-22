Return-Path: <dmaengine+bounces-189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9127F5322
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95BBB20D5F
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB71F607;
	Wed, 22 Nov 2023 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="YNW+agj/"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B4AD;
	Wed, 22 Nov 2023 14:14:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 3C4812D00B5B;
	Wed, 22 Nov 2023 23:08:50 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Npj0OrRRbQ5m; Wed, 22 Nov 2023 23:08:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id BEA1B2D00B5A;
	Wed, 22 Nov 2023 23:08:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl BEA1B2D00B5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700690929;
	bh=PTa268/JX+mlRh2pftJ7srsiSRZlKXzy21FlzLAe5Bs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YNW+agj/fsLXUNs8xM0/H5ifHDFwktw8wkaao56kuymnufHKcZyKgKJC+MspTCSDG
	 4OShWE8s8QJBSCBFxJgoaxid/HPMyc+9vob4Q/X/N1m186AFBl/n6DNI2SbMDOGauD
	 4yMklW9I5usHXdMmezlei0sBlnmqFH5g7r5dFiM0xVk9f/E7jmirY1rp9Qrw/kamZn
	 Uc4PzP+7ozfPx/jsZa9wYn6eSI+WrzwvEiP3uWuwR7yXuUJoNvALEDGRWTTZTs56v3
	 c/ldIqLOp6Vw1rp2/Nx/pG9joyVjEqOpibKqzbf+SUflJgOBGIjqmN2f2NaExyl2I4
	 CQpkjv5dyy5VA==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vJcjfbOJKJxQ; Wed, 22 Nov 2023 23:08:49 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 82D562D00B50;
	Wed, 22 Nov 2023 23:08:49 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH 0/5] Miscellaneous xdma driver enhancements
Date: Wed, 22 Nov 2023 23:08:30 +0100
Message-Id: <20231122220830.117403-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

 drivers/dma/xilinx/xdma-regs.h | 24 ++++-------
 drivers/dma/xilinx/xdma.c      | 78 +++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 26 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
--=20
2.34.1


