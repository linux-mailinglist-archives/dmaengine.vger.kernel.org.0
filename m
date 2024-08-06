Return-Path: <dmaengine+bounces-2811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE194875A
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 04:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689C31F2399B
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100CBA20;
	Tue,  6 Aug 2024 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWGMqRWx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D901B665
	for <dmaengine@vger.kernel.org>; Tue,  6 Aug 2024 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910144; cv=none; b=hoh9hrFNaNBp3YyQNVGioG04cRFg90W47OwfWjmGi7dK35hXzKUatkQ/jNzCcvi/Hn9Zk6wCdlEBHOBvFQDGNpTIeHAP+PClEF7CTdLpK2ylYuMiSXGqkEuo9P0lx0mXeMCp8NpqJnbq//E9JPYCxUFR6+66JgAVj655J7SBYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910144; c=relaxed/simple;
	bh=Ca+d0ODx2xoiiM6ESfjF4cXQlY7wYJydrvzYpinB3Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILahgbpbSwuYY+oRsnucztpmrm/X5RG1SR7r35MppXxvqBtzrWCdifLKjO5shbHVCAc/xsMeVOETeAELd8gWosg9UF5mgUtj3fc64RqCmjTCs34ZsZJhLsB5PWDaQb/5sK+UdwwOaOb6yHD5Ge6haNHvAU057ODb0eOSNAUOhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWGMqRWx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1876e748so83082b3a.1
        for <dmaengine@vger.kernel.org>; Mon, 05 Aug 2024 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722910142; x=1723514942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITxmvtMqI6oEXAlVIFKQnzOzb4QRVO0KBmpIZf0cbRg=;
        b=HWGMqRWxRIsKg+3lYI5aIngb7AFgMq7Nriv67nTrYszjvtoeiaBZ7H0/FEVR3AaAGZ
         nsV9HEH0opJx1ZIOn0P+HH32+Jrbf+YfMEcUAkqT2izf+p4yQLkz1IU0nfj0nHfCsyJI
         cJNblTAGgzGsQGUMHelmOp6oH4tCRsfa7ECHtJocqNITuNudNg08cNExRvNTz/57tWpP
         dV6xgkN/Rw/vtsWu37uIcKLyr8BMyL7uVnWC1SneBV+cvKpAsSWQ798sP73JCKnAypqM
         7JPmwMriaBOKYNQit8GvhI2OK+xRQspHbHx8F3EShOCMkJ0uN2TL/kqeuhd68tKx9LM5
         sjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910142; x=1723514942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITxmvtMqI6oEXAlVIFKQnzOzb4QRVO0KBmpIZf0cbRg=;
        b=r7rQKlnGvXre75fAbm1U73f5/f8vXKRvDincsLqy7P8O93D/fYejTmSafhULHPLsmm
         r053KGlmx/DfMkANy6vu3hpdv6z+RP5xANzWDYJxkDNvRVzGlXZIan3zQtD5WE0ptMgV
         /IyrkfmAHieyMG8IUJSfYavk1TZmF/wdhlf/Sh+48EyVRn4rUqQhaJWuZzrdPXOP32iy
         8ym93INjl5Su6LdnTpYSqdziyTLKOLbnrwHyRs/YhaUUI//fDp5ZGC8m623hyLq2iOjQ
         8MzXFs0nF4WI2jGsZDRDCeo375oQXk4Op8kxelhOkbx8MW1dbaXByJCA7Ft8M8Xx+GWj
         fP8w==
X-Forwarded-Encrypted: i=1; AJvYcCVuVK44ZK2TvkhYnJqQLaiK29ts+ju8HtcSdTtH7tBBxNMSOiWRowZaalw/CBPR27JV8w7FRxzNBJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1oYdxw1XmKtiMFuw54dm+nYUJXHuvt7tbctHL5Y7pm+hau6J
	I3bdoSvbxesXp/Gww2VqwhfYulL8ib1QjvpUJoJpSgrynIxgCdHC
X-Google-Smtp-Source: AGHT+IGm86BtUIgU/4uwcrMKoqg2zL00hi5XcphKLl3E77gl9tqQQi0vo/VbarUVUzbq3MWwHzxx1w==
X-Received: by 2002:a05:6a00:21ce:b0:70d:2c09:45ff with SMTP id d2e1a72fcca58-7106d0927eemr10616080b3a.4.1722910142369;
        Mon, 05 Aug 2024 19:09:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3668:14ca:30e:638f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc344sm6058092b3a.151.2024.08.05.19.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 19:09:01 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dmaengine: imx-dma: Remove i.MX21 support
Date: Mon,  5 Aug 2024 23:08:54 -0300
Message-Id: <20240806020854.2522412-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

i.MX21 support has been removed since commit 4b563a066611 ("ARM: imx:
Remove imx21 support").

Remove the i.MX21 support inside th imx-dma driver.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/dma/imx-dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ebf7c115d553..e913f0db99da 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -167,7 +167,6 @@ struct imxdma_channel {
 
 enum imx_dma_type {
 	IMX1_DMA,
-	IMX21_DMA,
 	IMX27_DMA,
 };
 
@@ -194,8 +193,6 @@ struct imxdma_filter_data {
 static const struct of_device_id imx_dma_of_dev_id[] = {
 	{
 		.compatible = "fsl,imx1-dma", .data = (const void *)IMX1_DMA,
-	}, {
-		.compatible = "fsl,imx21-dma", .data = (const void *)IMX21_DMA,
 	}, {
 		.compatible = "fsl,imx27-dma", .data = (const void *)IMX27_DMA,
 	}, {
-- 
2.34.1


