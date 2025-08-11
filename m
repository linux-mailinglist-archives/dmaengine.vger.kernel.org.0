Return-Path: <dmaengine+bounces-5977-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25259B204CC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 12:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5962166069
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44C2144B4;
	Mon, 11 Aug 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwGNs/wC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8D19D082;
	Mon, 11 Aug 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906360; cv=none; b=EpSW3helblY5mSw22i4PHk0robUKD6L0LMpUpVcvDLI+3Iid0E/WS0EMk6nodSq0bx/QCBNZXNI/pKz4vtZciiHYufEwv4JB1lcJXLcUq9o41L7VryAlKOP7bhAyq7z/e3Nq0hUwf7miHit46MtRcMK+ArVk4ESPOL8BZui7QZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906360; c=relaxed/simple;
	bh=Le+t3nZmUIhxp9p5vM1H1jmbQTclhIhQMZD2svUIPuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blgENHlx1cRjKgRT0a7qWMnyjEawb0/m849ZJpQgUhbHExGFIH4ZrKF8sAC9xYZfllplllKpaTW0aZ4qe2+v9E+Xf6TUZ6D8ZwkeaZ4q1v0AlThEudT8SdGdSBRbDoUP5a0K3g/1SyzHs4PDESuvraw2PzTXQGt15qWPPPoXAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwGNs/wC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so2438848f8f.0;
        Mon, 11 Aug 2025 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754906356; x=1755511156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHrrEYPB1b5QIK6lDkT+p47QiIDVum4Z/muZUQOm1MQ=;
        b=PwGNs/wCqfZvpqnNG6mMlkChMkOU9eOt94bkZ2rN5Wtlj0LiznXF+zwlNGfoNICePe
         54yAAoQl3hYYFObB14sVCTg11Bdr0Nbb66bakSQfOylX1mmsu3gBxyzEU9NBG7b1kpjG
         QgtCrW6dioDY+5DIL8PvFPYo6XHeIKMSt89aPDu9YildHcF7G0nG4TJH9zJqfYpKkXl9
         f6AU4z2vxQfZDpYT044OPLKBmxLxI+YSN8E5x9dwDkzJZBC4s7V6Q0bEGTX3h9bM9+HN
         faijiz600FMq6gsphmJBrirZXmngdRp+bp/PVdqscrMkj3mkQbunLGD4FkivJQFaCK4R
         ya4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906356; x=1755511156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHrrEYPB1b5QIK6lDkT+p47QiIDVum4Z/muZUQOm1MQ=;
        b=DvLHvtc/PYtO8hutlX8ks821T3tBZWpofzugARhlTzhcgx6RFutx/xBPvEItx7rtBZ
         H3hMSBVTaDSIKZ2aumKaHaDA+6dk8nmdjJcgtcDTd6LcgVDzKKQ0DYZ+r23H+vU5k1yf
         gJFiJpKaDtHvNmJcvsqVd4fsKEsETdGLYdl6b1/BVYBTbQrZ7ritaINb+1J/UcnaWRaC
         4yfnCfg93zY5YuR0UvAL7G+6fMnW/y4g6R/6B9M9ERSPFMPYjC2n5uNRQRe1Z3XVMPuy
         lYguLdclP/D2tUsiXReH2/AIqbKsSByrzfcqc3bfYA5f3m8aIToC7u0JoijWdSCet/gI
         uPTg==
X-Forwarded-Encrypted: i=1; AJvYcCUcwPGbG6BI482o8SFAQbwdqBMgkhjD48TYpWNsiXgp5X/dPRLO8WIOoxASEnbWjrTnh48nQOyPvLE=@vger.kernel.org, AJvYcCUxwfqqmTEQUFPUiDYFIf8n0Ca9r0kyywvQ6CTdlzTWojRPCTkgNGJiE4ya2qkuU+oqqQf7YfYAo/0F1bWp@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbnRW9MZEAFlscGNsPBqrEEBIgHTnT6gcw7m9SAEggjakSBND
	aoUqyRQ0yh6yTj8UtYBT8nkgQNAQ3Fq2Jxcah4gxBFch2hHA0a/2f7Rs
X-Gm-Gg: ASbGncuv03H4ecTfkQrkdtipOugRctt9LzaX4eXGDwYoeYWayCN19SGVT5gJ7FXWE+i
	53Kusv71WiKgxCHKwokaPETN+UdqrF9HB3vpw0At+fau3GNWmC6kIZGn+QcvxDs4TRllDZdimiX
	CcLGTcgH3zTdPeIraleSAh6jP7PKQsqyGGa33eE2iZI//axxc9tL9lH8wVcWmPGAHEiqGFdoom9
	St6N9fK5E9zLmB9XJ/tkxHPsCCjscx6mBawluUzdKFJowsCDUPcCf5d0m3KmOIKP3RqGPwi/sQa
	iA34/1iJAQNd9eG2YRRU09RSeF+imvQCcaLhfY1fGVh7sPatvt1w6IM+F0/G5IHYaudTDBcrxyH
	x37B8BrO3Y6l3x9ggrZpV
X-Google-Smtp-Source: AGHT+IFJtik1XnVm2H2h8zurmExW28TdLGAWPI8wIWs21Eih4/9SIQP0+l2lERHs84nC/K0BOIEOpQ==
X-Received: by 2002:a05:6000:2510:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b900b4724dmr9036674f8f.11.1754906355537;
        Mon, 11 Aug 2025 02:59:15 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4a2187sm41377170f8f.70.2025.08.11.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:59:15 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	dmaengine@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix dereference on uninitialized pointer conf_dev
Date: Mon, 11 Aug 2025 10:58:36 +0100
Message-ID: <20250811095836.1642093-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently if the allocation for wq fails on the initial iteration in
the setup loop the error exit path to err will call put_device on
an uninitialized pointer conf_dev. Fix this by initializing conf_dev
to NULL, note that put_device will ignore a NULL device pointer so no
null pointer dereference issues occur on this call.

Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..2b61f26af1f6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -178,7 +178,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_wq *wq;
-	struct device *conf_dev;
+	struct device *conf_dev = NULL;
 	int i, rc;
 
 	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
-- 
2.50.1


