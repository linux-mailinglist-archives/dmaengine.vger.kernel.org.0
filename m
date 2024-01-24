Return-Path: <dmaengine+bounces-815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A383A60A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jan 2024 10:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF71C29236
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jan 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120141862B;
	Wed, 24 Jan 2024 09:55:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF418628;
	Wed, 24 Jan 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090115; cv=none; b=kG2M/WGc/sk+ZdFhSqquzkeJsG4LT2ieJa32MkDO0y6bWyToAeGfj/cf45bR1EwTesdM+WsRLptW9XOg05shUlJ+zZe8zcHEHUhAjhGmQKZc9rnC4ZBruXH0i6oH/XbbRZeF0BgKGO/FPZiEd/ySD9g4xho+yBW1PwqaNOMcg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090115; c=relaxed/simple;
	bh=KatxaiUyCap1JiZqCJL1y81/f71hnsHZHN6r4sQGn0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V27jOV07BD2OOGxiGt3+l6Ty3pvjtXNdNav83w9wx3Di0w3R2bIuvuir6TeteTt+LzJOPPvV3WBDEN0/ZdWtn2veu4Npu07JjWtMz6G0SxUl5MrGJgKGibqQmrb5TJs5m/lgFLGu42p5UGnHIdaVgcfxVjps1XGOgO2rBBRmUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9202520adedb4e16ab1c69fb52fa636f-20240124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f844bb1d-710f-4265-be0c-fdc97aefc3cc,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:f844bb1d-710f-4265-be0c-fdc97aefc3cc,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:b04419fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240124175506OUHH5ZKH,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 9202520adedb4e16ab1c69fb52fa636f-20240124
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1964715425; Wed, 24 Jan 2024 17:55:04 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 929DBE000EBA;
	Wed, 24 Jan 2024 17:55:04 +0800 (CST)
X-ns-mid: postfix-65B0DE78-4052591282
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 344C8E000EB9;
	Wed, 24 Jan 2024 17:55:04 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] dmaengine: bestcomm: Code cleanup for bcom_sram_init
Date: Wed, 24 Jan 2024 17:55:02 +0800
Message-Id: <20240124095502.480506-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented from commit 2f9ea1bde0d1 ("[POWERPC]
bestcomm: core bestcomm support for Freescale MPC5200") in
about 16 years before.

If there are no plans to enable this part code in the future,
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/dma/bestcomm/sram.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/bestcomm/sram.c b/drivers/dma/bestcomm/sram.c
index 0553956f7456..ad74d57cc3ab 100644
--- a/drivers/dma/bestcomm/sram.c
+++ b/drivers/dma/bestcomm/sram.c
@@ -90,13 +90,8 @@ int bcom_sram_init(struct device_node *sram_node, char=
 *owner)
 	bcom_sram->rh =3D rh_create(4);
=20
 	/* Attach the free zones */
-#if 0
-	/* Currently disabled ... for future use only */
-	reg_addr_p =3D of_get_property(sram_node, "available", &psize);
-#else
 	regaddr_p =3D NULL;
 	psize =3D 0;
-#endif
=20
 	if (!regaddr_p || !psize) {
 		/* Attach the whole zone */
--=20
2.39.2


