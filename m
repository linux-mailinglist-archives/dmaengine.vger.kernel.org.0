Return-Path: <dmaengine+bounces-695-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98B8263A6
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jan 2024 11:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7481C211F9
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jan 2024 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92012B83;
	Sun,  7 Jan 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MraMq4LM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B212B7E
	for <dmaengine@vger.kernel.org>; Sun,  7 Jan 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MPysrRwtE9WXyMPysrZ562; Sun, 07 Jan 2024 11:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704621731;
	bh=8rP1vEXSeP3Uf/viFGY7Jcv0EE73WL/nsI+Y9nJQRVU=;
	h=From:To:Cc:Subject:Date;
	b=MraMq4LMbzLGfgWPcZyz9W+JAq/TnmdWHpMmmTf5zHQkGHtxf3wkCqR02yz/5NaWC
	 TmwY/8EBB/RKuccHwX0bEDkaNCiLuNvP5ZVKMKU/m2Pjp7rK3BUF/i+ez60oWtAE6S
	 bdzZR64yBoU8DjX4gm35eMxEiXEroFDdo5SG3b86sRFEt7wqmtsiFWu1K/1FOAfJ9m
	 1sTUPGOQCMRvDyU+NaxY5OgrZa6lCau8iUFK1AUYMcqxWnWqDNRDQbbwoBiuvvRGfj
	 aeWcbJL490dzeVR0HYuzTf9iEesnEYs/eUWfEuOGCJYVrz5oR772sQJqln6XfYzlWp
	 dttaO8ag7RTDg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jan 2024 11:02:11 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	jiaheng.fan@nxp.com,
	peng.ma@nxp.com,
	wen.he_1@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] dmaengine: fsl-qdma: Fix some error handling paths
Date: Sun,  7 Jan 2024 11:02:02 +0100
Message-Id: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 2 patches are bug fixes related to missing dma_free_coherent() either
in the remove function or in the error handling path of the probe.

They are compile tested only. So review with care.

The 3rd patch is only a clean up.

Christophe JAILLET (3):
  dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
  dmaengine: fsl-qdma: Fix a memory leak related to the queue command
    DMA
  dmaengine: fsl-qdma: Remove a useless devm_kfree()

 drivers/dma/fsl-qdma.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

-- 
2.34.1


