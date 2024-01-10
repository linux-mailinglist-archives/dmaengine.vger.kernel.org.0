Return-Path: <dmaengine+bounces-711-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AC282A01B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ABC1F21EF1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C44D589;
	Wed, 10 Jan 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="k/Dg44H3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C507B4D129
	for <dmaengine@vger.kernel.org>; Wed, 10 Jan 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Nd1PrEy2wZnJmNd1PrktNi; Wed, 10 Jan 2024 19:09:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704910188;
	bh=I/Syw+xZ1pMl3p/4Pizf8euGIKMqYvenieatrvL0vyA=;
	h=From:To:Cc:Subject:Date;
	b=k/Dg44H33idzjy/Lxxmk1vCacVmQWz88sutI9Wms8RoOQ9UazHFwyPl1GFaFJe5kc
	 Tt2WTk37HBS9x41OBc9Buwn2TPz4HaMSUPpIU8JcgNbGMUSgp1TYFhZI7TE1tq1vlU
	 kbd0FPzKGRgLgY2VwdxVVgyZ4BQBS6HQQ37fTckAZ1v/yh8SlS1O7Hlg/3/7tCPMOs
	 CTdnxmXaBSr3fHBxQvd+JfMbNU8pcHjO+OIDeYSFixOnKSvWNZG3d07z3xMEpbnQOa
	 CdJ9Kyv62ebYm+giq4rqnXpqrN+/wh+iMwhLiG7Oknsck5lSJqBSx2aWwAAghBFydL
	 raNndpjfsQLyQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 10 Jan 2024 19:09:48 +0100
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
Subject: [PATCH] MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()
Date: Wed, 10 Jan 2024 19:09:46 +0100
Message-Id: <8069c4aa2328555cceded66d7dc4e5332a6299ae.1704910173.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling spi_register_board_info(),

Fixes: f869d42e580f ("MIPS: Alchemy: Improved DB1550 support, with audio and serial busses.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/mips/alchemy/devboards/db1550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index fd91d9c9a252..6c6837181f55 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -589,7 +589,7 @@ int __init db1550_dev_setup(void)
 	i2c_register_board_info(0, db1550_i2c_devs,
 				ARRAY_SIZE(db1550_i2c_devs));
 	spi_register_board_info(db1550_spi_devs,
-				ARRAY_SIZE(db1550_i2c_devs));
+				ARRAY_SIZE(db1550_spi_devs));
 
 	c = clk_get(NULL, "psc0_intclk");
 	if (!IS_ERR(c)) {
-- 
2.34.1


