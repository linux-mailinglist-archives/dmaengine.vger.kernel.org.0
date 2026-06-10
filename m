Return-Path: <dmaengine+bounces-11391-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v6dECOQLKWp1PQMAu9opvQ
	(envelope-from <dmaengine+bounces-11391-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 09:01:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42C666725
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 09:01:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JKK3JxOi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11391-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11391-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47D8731653A9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E6382F0F;
	Wed, 10 Jun 2026 06:58:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B904382398
	for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 06:57:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074680; cv=none; b=MF/nwU5r2S4ecB9N67s/z1/8dPnddRqHEYAdYTETPRrbIMXP4qSuzjNZeRWUZL47fdprmxT5St7dPRqGfHiAkvDd0YybjCS40Nu7GGqyRVU2virCz6mMT7TV7SN55U8vjhVVEl8IwqZcLoAf7aD9ZfC4fwOKR1kAzUKRPmE36d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074680; c=relaxed/simple;
	bh=WJIzuDJasOYvuMgvG7Z+VZObw0JRQQ1y90Jp3zccoBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p08rVlKzrUlR71JcHlIfIi2USP66urmraUqDc1fw/myy2tdxA76iINymi8I19DH69EXvbnKXHz28+hitJl/0i+FnvoF+lphvxwmnn6KW9qOkkUe9o6xRiDZMgRaZXbFwHlr2/eTp+as0/ZXgnKkdhSzkrGDmhYS4/mbj4dd18AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKK3JxOi; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5956954a91.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781074678; x=1781679478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IpAF7CoB1il0GFwhvQu8VHaL8UO9qbHKNoxbe0clO0=;
        b=JKK3JxOihUx+XZG5f/CZb0zKT8Ww31/kPG7dWjlE2qMQOsxpQ7LUGrvl1r4GQe/dYg
         +enDDZx+QVGRUR2711ekCE4SsnoQlf8Uz6SIzFLW5PlDbCna6MFEjPFsWd9uGS4q5yA1
         0Lyqts+9y10tOE1C6lE/YD5y18uNZkVwz9ELUxT6ogSJEOgZWeF/HG7nehtiZFR/gnAS
         0vwNeRxGE7grZFbxfEavBdgthfXyXwv83/jlDGajo6POcFB/wkbQQ6xG4u7fYtGEIKYl
         I/whaMsSaABpjTf1NGySjUS4AmL7D4cGZ5WUd9/nWUwbD1+u1vOkmphCuWecg4rq0kds
         +uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074678; x=1781679478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IpAF7CoB1il0GFwhvQu8VHaL8UO9qbHKNoxbe0clO0=;
        b=SzBUGf/97NMueyCWGevt8ep2g0RQDH0hz20jThui2f4aSZ1XzAPvgrFVQYTxf6C1wr
         pIgcz/D+aWsODg3uTHJ1zE8uuEM9U4fU//UhfXoFONSjHfpj3gfGCB/Z7VvN5v4AqytJ
         MFRfPuMSwU715xmswyICSF9dbay9jplNvOHVnUNMl89mI0MDVs+7L7fcSIJQ5US6XS/Q
         aXf/EsHAWxIPqhIKKZS83hMQyHnfHZDbrZ4MFT98MuMXV5s8tDx0wX0iNURfAppXT+ti
         ejDKTp1JIJMuQiYNIGSkG2X5aitpnmKhDlkabGArDN919dItDZjvdTP71UZUL+lsHg1h
         Obyw==
X-Gm-Message-State: AOJu0YxzauhNBmLd2dfX1u1ZrqlQtX9ipuaVK6qHnPRH4We2qrLUhepK
	Wd47E5bkjQ2kk0TPfyVg9ZglAwxvdKjUDdrmXjGVoD4sxzpi46MCVjGg6t5Vpsh+
X-Gm-Gg: Acq92OFtbdvOSvfaksnu5rJfyZ3wzIxfK9qjAnSHkLHZHRQ1aPTGsknLEzy+eREMLUt
	6WsJZCci1vBpFbGkwgswGx505Mq8B6iSW0v9WDVG99Y4kEdrHB5j/3N2ea0ldjdf/G3qK7zCrNn
	00+BWQIlrJj6SBhOne/VUfeWSLiUh92nQfpvVgmWrzNRJlih2b+MYY74IGEzuQsF6KCE7eg3yNO
	L/gpgVURw3G0Xiym5f55TXwju7mYaCn5lSQ2WDb7DNkoI4BNwITXQfu24qxKuWPz9UqhicPHTt8
	/S4Ph5kTRw0MlmmEbxL4cHIiCr+6LcvE3VtDO8q6F3UM/KzOBdVfsHJ6zuzcfy/xDtfxGsNFFTD
	7njemQ2ryUmuaFv7zxCWy6CPUeHhIzpIT0RiKFZvKPYJwB8PHbKvYlK7eXA3zHIl3suNpOiT+xU
	XccQnopRWyRhbhHTvpm/YoH1K+xCAYB/o43VLyuwa0c12mc/v1NONJbWGFeDAo7q8snBx+PVeg+
	0yqtSlaFb/ekHclbtUcb4uyvzr7rz/qx4pq2co9o81mSA==
X-Received: by 2002:a17:90b:558b:b0:369:de03:29c8 with SMTP id 98e67ed59e1d1-370f122c744mr31101897a91.23.1781074678486;
        Tue, 09 Jun 2026 23:57:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf830b2sm20064781a91.4.2026.06.09.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:57:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] dma: mv_xor: add missing platform remove function
Date: Tue,  9 Jun 2026 23:57:36 -0700
Message-ID: <20260610065737.118211-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610065737.118211-1-rosenp@gmail.com>
References: <20260610065737.118211-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11391-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B42C666725

The driver was missing a remove callback, so channels, DMA
devices, and IRQs were never cleaned up on driver unbind.
Implement mv_xor_remove to undo probe, patterned after the
existing error path.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index a97fa0038652..3fc39cca7cbd 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1452,8 +1452,22 @@ static int mv_xor_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void mv_xor_remove(struct platform_device *pdev)
+{
+	struct mv_xor_device *xordev = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
+		if (xordev->channels[i]) {
+			mv_xor_channel_remove(xordev->channels[i]);
+			if (pdev->dev.of_node)
+				irq_dispose_mapping(xordev->channels[i]->irq);
+		}
+}
+
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
+	.remove		= mv_xor_remove,
 	.suspend        = mv_xor_suspend,
 	.resume         = mv_xor_resume,
 	.driver		= {
-- 
2.54.0


