Return-Path: <dmaengine+bounces-7935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D883CDA90E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D087C301E5A9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC800314B72;
	Tue, 23 Dec 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwny22xa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B7314B61
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522720; cv=none; b=djXvRwUmHCAUZOcDzIXIv+B3xPZ2SdeQKgdYqsEMFD+yrcdGdTQ/O11R43p87YHHVeb+0/hUT6NG5gNH550rofpAtR9Cj6QMDdJODXDQt6Gh+qbQ7JpJ5nuLRi3U3ftA1PFd9Hl503mTSdIPKp9lfYExC6NYBs52foRwFFKjzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522720; c=relaxed/simple;
	bh=i11iIqletltTlsddp8rmwaKPNNM3aHJLCnJXq8POUvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMkmk3tg+B2tEpCpwjTk7LjCQbimKl5GxcIoXoVktcPopYYoXezTnN2k1NMtU4JJxJInK8DXLs7rEbnK26E5zGVt3c74+b+fpDvWPyeEF70BVj25T56BLkSy1hqk7iCQhavluYVLBWmVNC3EBsGrG9G7qi4PoQR1Mczf0lz7uCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hwny22xa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c708702dfso5586006a91.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766522718; x=1767127518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oQAEnWpO6Oqbj5Jtu/QHyDVNaIs90kFoPT4vwaGjXY=;
        b=Hwny22xa5Nh/QuNYh79/Y6CwYj5bMZ7aXHNTDbk8badRrbuDlOAnz2wATeuXeMO/IP
         LVmKLTw2QHGt1FF2cfUJhHZU4iUXHVp3wOUiBpZkSZu0+Nmj+MMFKUvRut0lVPZQIhcC
         gjv0bFOVgRx1bNJ8kiZ4/C6Bgm0sCCC7Q6qKP3huxu5HJEM7RwpCNIF3NDkobqNtCvUq
         6f7P2y9UpzDZTTxsd7omjjLw23fTqZBybSopOUVFJ6mUaJRnl5xe8azZZrCVXbo7RroN
         ezBqErSIISs9fCzZTWiWIM82qfSje8ZdgnxZvFvNmx7ogH7Awh6bB192FXpkmGSp/Ch3
         8qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522718; x=1767127518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oQAEnWpO6Oqbj5Jtu/QHyDVNaIs90kFoPT4vwaGjXY=;
        b=aCGQc876chMPPATyiKiroRSXjoSl6Dr264VvCzSwIR7U2nUhJjYLxJ6QXmFtKgCYuT
         2I2ll3FVUZa4ZaSYjt9Ofq3C2FCmGZOBWbGMCIIuHtYCTAq1NIWfMhPyWQt0FECmbVdc
         9VFWdZHsd3qBQN2Slq5PgU2nc474BzPGGrNQ0Rh8dyaO/uCK1iRBdykp56DjNF3hpd7O
         CPRA7YN8ZLVdwwTSSJeGMLQkrOuLMUjTQWNePW043bQo9rX7h9MlPGH693QJ+yd05d5n
         h09QwMGislB+VLBbvM+EosNbmEh5f+PHWosLTSthh5PV4MXvQhlqDzBKn+eU7RuPqTqc
         OfAQ==
X-Gm-Message-State: AOJu0YzSvF7Z1v1u/97bIobKRh97KV8m7c0FNkpQCsu1vFrbUI0KTKop
	smE2mXZXCpOJ+toIrFBl7whpnR1igUOEuK7QgS2rI1LzIsvsqM+5CvEG5LjwiQ==
X-Gm-Gg: AY/fxX5HOO6nLO/Nu2w1M9WFd/cATX4GYz7vw5kqcwO859of0Cx7niQtYn/HgDGdnET
	ePjGtxpw3bbAtw9zpfs49p01fMd2KR03EcLLnno1ns1FuH9qyrat6Y6EVHkb3AqPq56ZYYnYGzy
	nQppwis2GoVSE8hAWMWnoEurS8NsAlPCQX3GtLlraJeMgea+Lx3wKT7hI14zr9HS5SgP4ziz2G/
	7sLWhuFBciSL/Rfi/dTh/AWV+FhytahcXECzHfV3JytOQd2zoyCCBqhhEsZ/pxCP2f7DGTPa1vs
	IGMz6N6XjontkJGdZY8YQ3z+/zOnGHGQ59B7XBl+o6FUOEnJMaaYIPVoK4SN3EqQDkZdOq8NX+V
	9n8L7RjU1xAGaSze6X/09ABt1HxeWpVdf6xWMd1xcODheyhaZA6THwyVjIg==
X-Google-Smtp-Source: AGHT+IHQ0Kf8SpV9hfQHABog88xBfm459Ytl9xDU+wUjlkwWMyM1lE9u8V5rqWV2RdJyiAxIv5ghrA==
X-Received: by 2002:a17:90b:4d8c:b0:34c:2db6:57ec with SMTP id 98e67ed59e1d1-34e921a3d9emr15715648a91.17.1766522717862;
        Tue, 23 Dec 2025 12:45:17 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7d3sm16769851a91.4.2025.12.23.12.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:45:17 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: pl08x: add COMPILE_TEST support
Date: Tue, 23 Dec 2025 12:45:00 -0800
Message-ID: <20251223204500.12786-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows the buildbots to build on various platforms to check for various
issues.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 66cda7cc9f7a..111d5236fe08 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -66,7 +66,7 @@ config ALTERA_MSGDMA
 
 config AMBA_PL08X
 	bool "ARM PrimeCell PL080 or PL081 support"
-	depends on ARM_AMBA
+	depends on ARM_AMBA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.52.0


