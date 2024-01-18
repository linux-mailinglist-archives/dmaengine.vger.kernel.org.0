Return-Path: <dmaengine+bounces-739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE848311D0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 04:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33B41F22BAE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174C566D;
	Thu, 18 Jan 2024 03:31:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C95395;
	Thu, 18 Jan 2024 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705548666; cv=none; b=YidWzbyWPNH/ROd4hphopF5+jtS5NE73D+UcPrrvcEiGyL9LmZ+KWNvzcwcH5EnNh9bHEtG6ApCkG2C8WPTZ60hMBZ5kokoP2HjKgxNBWkH736QpAPGbKuOl5qL7jbjM0g+J5zRPQQYlkuYTwf8Z852kItnON/Ybb6HUtdKiqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705548666; c=relaxed/simple;
	bh=1uEZ/UjPZ+qsSZH6ZfSum6cH3GHywfS22FKTLNF3V9A=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=uYaNw3Tc8zwYfksvX5EHelJGoTE5JRzm2FKdPD98qI/t9z9NCTAUhBkYZS09zoNYyjf/66JkouhQtd+JU9x/v2Vu17Lz7CWsXUwGGRe3G8iAh9y40P+W6gvv3AERBUZLpwdXMqvV1ljO6HwMN+ZImqzVsWKXJh0RqFXrYU9n8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f032b4793c81426a8679b14033fbc4b5-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9d484e5d-084f-4503-8daf-18a4a4bf525b,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:9d484e5d-084f-4503-8daf-18a4a4bf525b,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:928f4a2f-1ab8-4133-9780-81938111c800,B
	ulkID:240118113055HYPNW513,BulkQuantity:0,Recheck:0,SF:19|44|66|24|17|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f032b4793c81426a8679b14033fbc4b5-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 28929864; Thu, 18 Jan 2024 11:30:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 29849E000EB9;
	Thu, 18 Jan 2024 11:30:54 +0800 (CST)
X-ns-mid: postfix-65A89B6D-894983688
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id AA663E000EB9;
	Thu, 18 Jan 2024 11:30:53 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] dmaengine: Add a null pointer check to the dma_request_chan
Date: Thu, 18 Jan 2024 11:30:52 +0800
Message-Id: <20240118033052.193282-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/dma/dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 491b22240221..a6f808d13aa4 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -856,6 +856,8 @@ struct dma_chan *dma_request_chan(struct device *dev,=
 const char *name)
 #ifdef CONFIG_DEBUG_FS
 	chan->dbg_client_name =3D kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
 					  name);
+	if (!chan->dbg_client_name)
+		return chan;
 #endif
=20
 	chan->name =3D kasprintf(GFP_KERNEL, "dma:%s", name);
--=20
2.39.2


