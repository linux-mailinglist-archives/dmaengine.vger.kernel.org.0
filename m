Return-Path: <dmaengine+bounces-12162-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AnRSM60+T2oVcwIAu9opvQ
	(envelope-from <dmaengine+bounces-12162-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 08:24:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11972D17D
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 08:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rBj6qjz5;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12162-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12162-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7FC830696CD
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C03BA236;
	Thu,  9 Jul 2026 06:23:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22363ABD8E
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 06:23:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578191; cv=none; b=rJdpDS+JCoaJATM2Hp/ORZTWH6W+v1MGtPencripUp5F/P2cJUYGkhfgyMTn4iuwQsGbe59fdW3GEm+KDq/c95rm3QEuPwWPqQm2cQa2RPUQM0ABIB8cDHbLpSEcIyrzf0wzI1Z9/yeYRqiztSrTUThwL64vvJG7bKgYd/fdcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578191; c=relaxed/simple;
	bh=pq1wmXw71YCRzR+cu7V0HWBywIZfXDGwW6no91IJSGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUapPISEZ72j+ffieW/hQmxbVcTFqQTT7Hwv3t3d9oGL2YNrq0ezNAvuYb8NiFDLkhjKB0XI3zUxZy36dpEDYcJgnwY15ojoPRX/OO3V/WDqUobcYEpgiSUC2v9EwJtCu1XnrB8YKuQMyvYyhT/7fvRYxF7U8WOQvjpnnPSdgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBj6qjz5; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381b831d535so1785372a91.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783578189; x=1784182989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1+ya/9yyEu4sJpheJqx/dxg2ovJThfipd/qF4HGIA8=;
        b=rBj6qjz5eIzieJYcMW20WohRYr24efNLbbdNMWWoDV8EI9GgpEAiBd73Yz46ZbQZzQ
         VYB/R7gJrWuhIy1SRC6rAURUQBalBC9bNKCaBZJIepfm2rwOeCQhG7Fim8o81cTTms0D
         4+YUDBdmp9RZyImA8KgLmXktKBrFq3+O+dcBsa6qVSEh5aQf1yjcG82xmGguyULkvXL2
         zVM70J5uAUvUK08plVc8BzrP1JckMAgRkw4NkapcFyE/9+Y/IWrF5wHYTDy2a5X56Y3T
         mlqw6PvNP3mp94wnS95u8Vu7iUNfuqthCm/MvohYuMrbH9yKE6Lf2SvyZszLPBW2GhsW
         Gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578189; x=1784182989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1+ya/9yyEu4sJpheJqx/dxg2ovJThfipd/qF4HGIA8=;
        b=D8hrf3sQgKgc9+rb5IHpwAD244hW39KCEw5Qj9QQp+IbnsD8SdbyH8kppQpmxc4TGf
         dCaXaRuExYg/rEFYjm2qnw2gCJ2VaBzRQcmJssLHLlt9iKmM94JzmfV0bwRJzTMFkyuG
         yjl0s9PQDtrOlEa55J86fd4v50bHvRmCqclh8RJqaatdJzDdE5LHsruwYGtz2W848x3/
         0QesnAkOemqpamCEMBz5uONw/TUUXAKnRZS4G4YdrKGvlrH4uxkWBScgbiEC6QyCD1eI
         ATXBpBUmbyKXG1yCDyULcR4Uk2TPSE7R3ZGWHJW7xzyL4pRuCKWwHJrQt8dBSvykoefW
         KnWw==
X-Forwarded-Encrypted: i=1; AHgh+RoYBkUDK74nVLdkw+8EaE7Ht0Gj/5LivZsNVpUATEYsBSDUoWwGvdALBbVL0hTjdXr62r3NmCB5z8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mXz/YI25Fck3w0FqIU9mbQJ8erYM+H7FsvFJCl5px1RUYqMv
	SBciNPzsRZUClSuSA7HHYR7VtbOna2T/jmQVSBCmBKO8kA/pSOEmX1Bm
X-Gm-Gg: AfdE7cnuBRjlongPLtQO6malx/dLo8qrmFT50bxg96EUvuwGhNtgbNxDsx3BIy8kvuv
	ERs/WIq7t0caHTUTwtoOV4zteolVAwu7tmEQ76i0JpDE/0kew2x/O2duuo7HOiKihJdRLyc5Kcf
	AuB0mOFGDAsf3tF6KmJPLzx/c6QWolsPCeFdXMgnna3mvxlNpI7mGexkjpecPGLPaBQQf0kX+fR
	ItQ2Ffd8vAxdZ8d6ponuj+m658yszLQ7fk/MxQ9y3hCiteDBnd3qTiUxtECiwNS4aGWaarydA+n
	K4Gp7iulAiVQD1+gB06wbeN87cHdntmz7uTx7SqlpV4oGDo2QQRiTeXbd8aKLZ9nZIx44ZBFPJU
	bNkgxgvdLbsAbBwAYAjq9LGX63oowo0JmRHZn03FF2Xjbwg9QR9NStzMlwovvSBORLUf15ghHfL
	I7rIzI2hTOeoIwugYmYH9/naKWvDyDV7Mq
X-Received: by 2002:a17:90b:2fc6:b0:381:20b:a9ee with SMTP id 98e67ed59e1d1-38940631b27mr5682814a91.14.1783578189408;
        Wed, 08 Jul 2026 23:23:09 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:ea9b:46f2:6d0c:46c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5632235bsm586232a91.15.2026.07.08.23.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:23:08 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: dave.jiang@intel.com,
	vkoul@kernel.org
Cc: ashok.raj@intel.com,
	fenghua.yu@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] dmaengine: idxd: Remove channel from list on registration failure
Date: Thu,  9 Jul 2026 14:23:03 +0800
Message-ID: <20260709062303.4167624-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12162-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.jiang@intel.com,m:vkoul@kernel.org,m:ashok.raj@intel.com,m:fenghua.yu@intel.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C11972D17D

idxd_register_dma_channel() links the channel before registering it.
If dma_async_device_channel_register() fails after that, the error path
frees idxd_chan while chan->device_node remains on dma->channels.

The DMA device can therefore retain a channel list entry that points into
freed idxd_chan memory. Remove the channel from dma->channels before
freeing idxd_chan on the registration failure path, matching the driver's
normal unregister path.

A static analysis checker reported the stale list entry, and manual
source review confirmed the registration failure path.

Fixes: 397862855619 ("dmaengine: idxd: fix dma device lifetime")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/dma/idxd/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 9937b671f6376..f2c03f3cf1925 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -289,6 +289,7 @@ static int idxd_register_dma_channel(struct idxd_wq *wq)
 
 	rc = dma_async_device_channel_register(dma, chan, NULL);
 	if (rc < 0) {
+		list_del(&chan->device_node);
 		kfree(idxd_chan);
 		return rc;
 	}
-- 
2.51.0


