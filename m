Return-Path: <dmaengine+bounces-1737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688F8979C6
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 22:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8DA1F224D3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E43155A50;
	Wed,  3 Apr 2024 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kiu+WDGM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m6014.netease.com (mail-m6014.netease.com [210.79.60.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55943AB6;
	Wed,  3 Apr 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176027; cv=none; b=HUAnObYAUe1LG0ZjCQmrfeSzdINYoNPZP6wC9xWoIzVb73r3d8qE0LnliSLlZuaDc9wiBna0VmL8wcaRMw2mYkxulx4SVb7qufnKNXBELDO5/n5DJHuN2gG5m81U1I+QDj8ZS5GM49fch0MS8+NsoFK5JvxDFuhdjsAegEo6Zo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176027; c=relaxed/simple;
	bh=U2xSqop3iP9OvAHe9UuvwsdYhhZGuH+/HFJZlkCMXh4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bBoU4bqgOdSkgjAyneyb/0km3KfmnJBZHNrGqSge89fNvHE0bwaUbuHLA48h0LYnsVf5ZJnbRDBMDvPl8tmEnsbbKt72d/N2KLz87HUzpuIlwNCX0t9LaM6gsr5MZGMlL+IJ5VIe/LhdeHUiKF8cf0mbovVz12d3NiFlPH6M7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kiu+WDGM; arc=none smtp.client-ip=210.79.60.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=kiu+WDGMWW0Zqm8Wc4WRUB7U+gnsBn3gag8KuwWdeTUJu8+pGfxmZ+zU710CS1Sqo66RjwujPrvEf0G55Rsyz0Y6dpHAndNfh57rMgxbGl2seh83Ut1vcYdzx6gUQBrdkQGO8w/fFJrfen92MwP0RvP6tXKF9NJOCw7i4BucJKs=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=5ivLh8M4acymImJP1Q9OUpWegv9iApTGSSCamSY9LFU=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BBEBE7C0399;
	Wed,  3 Apr 2024 21:18:38 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de,
	vkoul@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Patches to Add support for audio interleaved transfer
Date: Wed,  3 Apr 2024 21:18:21 +0800
Message-Id: <1712150304-60832-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMdHVZCS0tJH05CGBhIGUJVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8ea41c8fd209d2kunmbbebe7c0399
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6FBw6NzMSATUPTDccHg4T
	QgIwCUhVSlVKTEpJSk5LSEpCTkhKVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSk9LQjcG
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

This patch add support for interleaved transfer which used
for interleaved audio or 2d video data transfer.
for audio situation, we add 'nump' for number of period frames.

Changes in v2:
- Add the pl330 interleaved transfer

Sugar Zhang (2):
  dmaengine: Add support for audio interleaved transfer
  dmaengine: pl330: Add support for audio interleaved transfer

 drivers/dma/pl330.c       | 169 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/dmaengine.h |   2 +
 2 files changed, 165 insertions(+), 6 deletions(-)

-- 
2.7.4


