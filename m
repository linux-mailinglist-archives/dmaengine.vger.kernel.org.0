Return-Path: <dmaengine+bounces-8883-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLIAOSOMjGndqwAAu9opvQ
	(envelope-from <dmaengine+bounces-8883-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 15:03:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1911250B1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 15:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB2253016EE1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749B296BCC;
	Wed, 11 Feb 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxpHi7N0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A025A359
	for <dmaengine@vger.kernel.org>; Wed, 11 Feb 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818567; cv=none; b=mSa5xhYgHpoLJknw/SbJfhzAF83y+F4vtjQkWtWNBnWBvi3/FLk9ZfmmEa3KQwaRYnQ3+T7Z5g2X4SCIQvJXDPYGuo/q+fM+JxP8iAHlGY8EgAXy62TrXA7330gLa8+GqIhY3h7yy4h3Qs8lGMeGUuRY1B/L+g2MfWOpS+7xytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818567; c=relaxed/simple;
	bh=BWgzr1X+mxTiEyNLlQnKUkCirXWnvGZN54MRv5woVDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ml9FsNXEDcQCrpiZivKFGgK6zPzlDxpy+C/8gnz5a+HIqfU6lo07AfWrxtPtgvJB4yLfup0dQpo/q4FjYyEpzCAYMRViPVgwYWNiX9I0H7gZxbv9juYQsR4LfFMmNsDJ3WH9QRhULc7ViCboIRF8cNHgVvGd2QT7nS+Y1VfyHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxpHi7N0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354b79a9ad5so2498290a91.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Feb 2026 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770818565; x=1771423365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkv6yEZIu6AjpO4/Olv6t/LeNmIBj39aOisBe+pVOfI=;
        b=WxpHi7N0KY9oGsMx/M0FuGh9NRSG4MgUjUTWJ6+hLCwuckwWrjpS4xhW7XzaKOe8FL
         gWRTXrtV/o2mBzTSk5OkMN8cWaBqOXOwHAfBhNNN7t/joVfcxSORI2kE6oR/QL/G/p28
         GWPxtHJ1ZpktI+JM3wxhtzznB8NUbmVlGRiQ7iaR4EtAdMt4hI7j+ypVZuXSFu9H2pX9
         BDgDlyJsf546wfL09tWdtP1EKrv4li3oT0kk1AIzduYFsMVJlF484dfIDx+QMj4aExtP
         ghEWxR19N7PrdSqsPaB0YR0c2UulZYnDk2L72LDTtfj8C+q+LuhsISmD9eStOtIlJJTc
         vrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770818565; x=1771423365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hkv6yEZIu6AjpO4/Olv6t/LeNmIBj39aOisBe+pVOfI=;
        b=P+UuC/ET5kCRLEr5SUloQdDXLJ45KhcpRAqyw7owe/NPynD+5sd76A7zv+cl7YWYNm
         nFsJFtoiL6CP+IETDLfJETmSqCDC4BvvNAL4kaNdIuxILGZkopjfMey6Rye3Sq2RH0ib
         YfKpxsZXVBdTNutXshco6mwP/Van+FtkZipsFmBVZv+ZXRuQAzUBqBq8o9tBJjxBiq5c
         jvk380jofkuqlLi4RTz16NJoUoE4Ci9oHgTBVSxMuJVMN147GjrBPj/PbK95XNJxMwKS
         JNPqu9pbCLfWoT+5PkT0wylLLlwYzqbELx6H5wM+suRHkByvYCXqECQMwreYpPyzYWMg
         D+Cw==
X-Gm-Message-State: AOJu0YwnFPNF2LwzWvESG8gWZovCSfC2EkAuOhX68CqkpQhBe/l7Tf3u
	GxE5xKNP5l14WbMT6mrL8dlwURCGvxglAAKcvJkt/VGuoMwzAR76wpULFppu7w==
X-Gm-Gg: AZuq6aLFvkY6UeatdR3vDGnPjXdPllqDOPcixmA0zwJ+qvSC8R6ZSC2FtqjAMlR3YAz
	UiMhag8bQ4RT7JCv7RayXPGafDqxldA1IaS/8KUt9TbQE3WBR6AD+EahcxO4io4K6AmvLZ7hmLA
	wCu3b34UH0JF2diEQh3BkxghArwt7sUXeJBD5sI2sD3r+kdHphDaPmrL/zMrsj/5MtJsFsF7m8c
	dLOrLqvu5N5OUB031j4FS05x/HJVC3d42NR+ZAv+1SwQ9KQ2QAVBLC4qn8GBe5yWtcdINDnDDnX
	Qt3oDLCFo1OtaWdY9T5J9GlfRjabJ5Efz0dpH82gl0pDf7D6UXmfRTHL46zuufTMxlvbYj9/+dg
	t2ErNGkNkNtAk91YDV6ijaAAakdDbwSeaV8fhJfMjO7hUt0LmYV2VsEFGvwwUgebMBKYRl0eKar
	PNY5petOmvavnXlBC/43vHkVgYzjlvn80=
X-Received: by 2002:a17:90b:558d:b0:356:1edc:b64 with SMTP id 98e67ed59e1d1-3567af6f668mr2508787a91.8.1770818564538;
        Wed, 11 Feb 2026 06:02:44 -0800 (PST)
Received: from bsp.intra.ifm ([123.252.218.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567af23fb7sm1874714a91.2.2026.02.11.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:02:43 -0800 (PST)
From: Rahul Navale <rahulnavale04@gmail.com>
To: dmaengine@vger.kernel.org
Cc: vkoul@kernel.org,
	michal.simek@amd.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.gessler@brueckmann-gmbh.de,
	radhey.shyam.pandey@amd.com,
	Suraj.Gupta2@amd.com,
	marex@denx.de,
	manivannan.sadhasivam@linaro.org,
	harini.katakam@amd.com,
	marex@nabladev.com,
	Rahul Navale <rahul.navale@ifm.com>
Subject: [RFC PATCH] dmaengine: xilinx_dma: device-wide directions cause ASoC cyclic DMA regression
Date: Wed, 11 Feb 2026 19:30:51 +0530
Message-ID: <20260211140051.8177-1-rahulnavale04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8883-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C1911250B1
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

On ZynqMP platforms using AXI DMA for ASoC PCM playback, upstream commit
7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions") causes
cyclic playback to fail after the first buffer period.

Background:
The upstream patch adds the following line in xilinx_dma_chan_probe():

    xdev->common.directions |= chan->direction;

Its purpose is to coalesce the directions of all enabled TX/RX channels into
the device-wide dma_device.directions mask so that dma_get_slave_caps()
works correctly. This is required by users such as IIO DMAEngine buffers
that rely on device-wide capability reporting.

Problem on ZynqMP ASoC audio (PCM):
On ZynqMP, Xilinx DMA provides fixed-direction channels:

    MM2S channels -> DMA_MEM_TO_DEV
    S2MM channels -> DMA_DEV_TO_MEM

ASoC dmaengine PCM relies on these fixed directions to select proper DMA
channels for cyclic playback and capture. Aggregating directions device-wide
can cause inconsistent capability reporting depending on channel probe order
or device tree layout.

This leads to the following behavior:
- The first DMA buffer plays correctly.
- Subsequent DMA periods repeat the first period indefinitely, breaking
  cyclic playback.

A temporary local patch that removes:

    xdev->common.directions |= chan->direction;

restores audio playback on ZynqMP platforms.

This RFC patch is a workaround to demonstrate a ZynqMP ASoC cyclic PCM
regression that appears in v6.12.36+ (backport of 7e01511443c3).

The workaround restores PCM playback but may regress users relying on
dma_get_slave_caps() (e.g. IIO DMAEngine buffers). The goal is to start
discussion on the correct upstream fix that supports both ASoC PCM and IIO.

Fixes: 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
Signed-off-by: Rahul Navale <rahul.navale@ifm.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index aff046b03ef7..8da86e322c7a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2938,8 +2938,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		return -EINVAL;
 	}
 
-	xdev->common.directions |= chan->direction;
-
 	/* Request the interrupt */
 	chan->irq = of_irq_get(node, chan->tdest);
 	if (chan->irq < 0)
-- 
2.34.1


