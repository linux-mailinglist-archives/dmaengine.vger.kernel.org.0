Return-Path: <dmaengine+bounces-11077-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHyFDSrUHGqUTAkAu9opvQ
	(envelope-from <dmaengine+bounces-11077-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:36:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A9618796
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCA70300F5C6
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C51465B4;
	Mon,  1 Jun 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEdxXqOI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BA3FCC
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274172; cv=none; b=hYmb4z9jcwM43u+vvdWM0WCzEOCNeJj7B0HtpZNKpyM2ieE3ASLovwbQ4MZLvB6VETtpeUNejyyO59xWbKDQun30NtrpRUWbVhKHE3R2PQrKeLbRMC7a8LOz/9FueoM8hPHod1qkcbMPkmBbojNfXK/agzuXoUHUd3IWw07AMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274172; c=relaxed/simple;
	bh=gcaMmQL5aSHOZSqhYIGpQ/vmrflYtD4AIwc9UwgHGsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ee7WSHNxRwK7oJBz5j6S+tPoBKjnUeycL6ktgfKzHUvJg3lPjSVOMRoI6D9YfWnttAqk0kOwiQoMe6ch4cAfMEPrqBniT+GFhtjWPFtgTAKYn2s1sslLlEwGKrja7RPa4htfJy+yTG/2be6oW9ikWlIev3VLbimVmZHyHJEI3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEdxXqOI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c3546924so4796025ad.3
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274171; x=1780878971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/AeC5xF+N7wupUesSXYRJq3Cx5QwhjNowYSmJnz/ao=;
        b=sEdxXqOItIbJ8kUItd345BF/K5NYTkHFOBBnZhHAK9LKqbyKJoQID4Ar17hURkEk5g
         h+9IotyT4ZsM8EsF8iiZQ7uH8ZynF7SYXd0AgEpDFziIFZ+ymzi9RLkA1ft7YGquhYvW
         a6N37i+E6IB5WVI76RKfI2MBEupHV3ShGbuI/a8sKA4b2+Jw8JwwtUXX44jA3B729WH/
         k5RJcEwNE9MaBAR7iRx7BF6wYqTBwTs8/6JiAknSIpim16m4L4E8v3lAs6uVfqd9ETWF
         HR8KwGe4f+mVqfnKsnmpZVtD/21li90BW9en1xLgNVl0DnCVLF9QCrShez1woza0wS4h
         Jq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274171; x=1780878971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/AeC5xF+N7wupUesSXYRJq3Cx5QwhjNowYSmJnz/ao=;
        b=hkGZ5ZAkerxGKBRbeOfqwia255fnraXRd4gqt6O+z0sVJX3XZobf+58Vk5OQT74qGw
         kcy/0DG/u0P4xB39YoJ6lsZwu219L5V4Trvg49sECoDvFG2QMZhJS0t6WcDivm5sG4w/
         U3S0cM3hzenzWFnXiJx7NdUcTPMXz+Au2R2RadBURg00WxboDUHl2+LDG8O8akJMlTsn
         KIGlOGpg0o3uey7gSPsuSSjhb9GDF1LsSceJ6LtTt9wRnMFRinM0mz3RD/BQkcmLaIAh
         QEEIhMQoInUdARLtsjOE8gYLLiYYLMMkWoDVHGB9Mt6nnzC0wICY1Ft1e9DnRZWLnGrF
         4rcQ==
X-Gm-Message-State: AOJu0YyjzeNJOnmMig4G3/5oeyRBRkmZMAQbQzu/cE/GxKKZT4+KVzEV
	knq2P54Rj45kr9JcrMY0wB6+iVBFOaoK/9yXVeNsn4nbqk1bTLM6ff522Ie6dA==
X-Gm-Gg: Acq92OGy+UMdeYnZVdrPywbNwajsOcA0a/7rIUJfLH0TE/G6kNnhI1kmYkPiVb5eStq
	91beV+8jNj2SD88sTfIECMmJOjeAxmRVXl8/mAQsw5kj5tjQaFGOvW8HYPMIOqeqeaM3/V3q541
	FqdA4ELhrJUqMSzkthnkEkSgXZkxCODoApY8IUJqjhxKJIMOsOyXaz4qY0IVnG7Kqa0uw4BUjsw
	kwbAZHCRmLip0qMPBgw9OQR9r+H6KG3o87tsyr85M+jYm8zMQuMWERiuEZWuCqn3rxHIlyXY+cs
	d8Dj7+lGtJXYjkJOeSteBV5QE+dHvXz+8gSpghTqxNyt4OA/iUPFKrdpqvDGAMIdOuSjZau8CX6
	rKwziKqM0neI8ZTQCv+utn4ikhZIil4MgH8yx3AccwUj0QrqPW7+y2yTbYW6GNBTABYAl6TkAme
	g6mUoyvjX2dmKyZnezQRAM0lpDXNlo6fpMgLjM2z4vo4lDWufEk7MRFrIwUeeeudgd8s1l/YTv6
	xQD83Ue9+/40MhlBNiix8vStSqKjYCN5B9g5CwqAYvO/w==
X-Received: by 2002:a17:903:8c8:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2bf36833abfmr91184195ad.26.1780274170723;
        Sun, 31 May 2026 17:36:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm111929565ad.41.2026.05.31.17.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:36:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/5] dmaengine: ti: omap-dma: various bug fixes
Date: Sun, 31 May 2026 17:35:48 -0700
Message-ID: <20260601003553.72573-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11077-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 854A9618796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes four bugs in the TI OMAP DMA driver:

 - Patch 1: add missing return statement in the probe error path
 - Patch 2: fix a notifier leak in remove
 - Patch 3: fix dma_pool_destroy being called before omap_dma_free
 - Patch 4: fix interrupt handling in the remove path
 - Patch 5: use dmam for dmaengine registration and remove devm_free_irq

v2: fix sashiko comments and add extra patch

Rosen Penev (5):
  dmaengine: ti: omap-dma: fix missing return in probe error path
  dmaengine: ti: omap-dma: fix notifier leak in remove
  dmaengine: ti: omap-dma: fix dma_pool_destroy before omap_dma_free in
    error paths
  dmaengine: ti: omap-dma: fix interrupt handling in remove
  dmaengine: ti: omap-dma: use devm for dmaengine registration

 drivers/dma/ti/omap-dma.c | 50 ++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 17 deletions(-)

--
2.54.0


