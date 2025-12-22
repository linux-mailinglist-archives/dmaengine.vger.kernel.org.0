Return-Path: <dmaengine+bounces-7858-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB6CD4AF1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 05:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900113006AB2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 04:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A71EFF9B;
	Mon, 22 Dec 2025 04:16:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B433993;
	Mon, 22 Dec 2025 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766376988; cv=none; b=MYU6ilgkbk0DKmf869rFr/dK8qYcQVjoKobfg3kAfSFC5coMXs/D4MAw7fgWy7yJ87bhtN94f2xGW4XkMDZpYkPsYdwMT8vxeevAqgOKpu5jYEySn/LvdUUJkSraHcOud2v8H+Q5+pAVF+3lDBGj5CwU9XZQZGKaxUH3TWLKdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766376988; c=relaxed/simple;
	bh=ScVIEfLOJnXIXYnj68t/1imJqAgx5SDhZJ51F+SMhLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gPXHLPAcqb68FIb+ehBv1OftiBiFDHQpPOcMq7nqr7AfkZ+YiugMmPuw2ZtXufCGGIgHQnVgzNVS9xWgtxqHl54PJkDdC/Vhb36UtIV5MD0eSF0rDZLx58wPLex5mOv1jSXx4ktw+TSbzWia+KwSYMN2k4S2QNQ2X4VrXnZb5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowACXs9pExEhpobSKAQ--.56029S2;
	Mon, 22 Dec 2025 12:08:36 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: vkoul@kernel.org,
	dave.jiang@intel.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: fix a reference leak in __dma_async_device_channel_register()
Date: Mon, 22 Dec 2025 12:08:34 +0800
Message-Id: <20251222040834.975443-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXs9pExEhpobSKAQ--.56029S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryUur4DZFyrKF18uFWxWFg_yoW8WrWrpr
	srGa45trWUtan5uanxXF1Fva4UCanYy3yS9ryrG343Cr9xXr9Yya40ya4jq3WDA39xJF4x
	tFZxXw48uF1UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkEE2lIrP1SDwAAs0

After device_register() is called, put_device() is required to drop the
device reference. In this case, put_device() -> chan_dev_release() will
finally release chan->dev. Thus there is no need to call kfree again to
release the chan->dev.

Found by code review.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/dma/dmaengine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..9d7cea1d6e91 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1071,6 +1071,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 					       const char *name)
 {
 	int rc;
+	bool dev_registered = false;
 
 	chan->local = alloc_percpu(typeof(*chan->local));
 	if (!chan->local)
@@ -1102,6 +1103,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	else
 		dev_set_name(&chan->dev->device, "%s", name);
 	rc = device_register(&chan->dev->device);
+	dev_registered = true;
 	if (rc)
 		goto err_out_ida;
 	chan->client_count = 0;
@@ -1112,7 +1114,10 @@ static int __dma_async_device_channel_register(struct dma_device *device,
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
  err_free_dev:
-	kfree(chan->dev);
+	if (dev_registered)
+		put_device(&chan->dev->device);
+	else
+		kfree(chan->dev);
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
-- 
2.25.1


