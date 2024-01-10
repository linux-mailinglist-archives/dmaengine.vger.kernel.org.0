Return-Path: <dmaengine+bounces-713-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0E82A3F0
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 23:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FFB1C2251C
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885FB4F88F;
	Wed, 10 Jan 2024 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZ8P90n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DD4F88A;
	Wed, 10 Jan 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so19726675e9.3;
        Wed, 10 Jan 2024 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704925674; x=1705530474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tV1DZHUcUVZrnewacKcGxbUMRr8vxmCiDHV3WTeMLmU=;
        b=JUZ8P90nhLvv0mWmCaSxWsarNRaY1hnkNe+3cYZbxR//2iLCRgggX0zRk+UuKlPtlb
         oYsPg/y6/Zqb4BUAUxmyXnw8lgXYuVjdinDdC78AEdksOPIpcBMCK5A/9w5403dIJHVB
         nxyACGNvMwWdiQfkOlN3HJ39ayXvvcjP7vkq79GeHO/K77mg3eEZ2eUPjS9fBMFg27V9
         SCUFVmudHTPI7wV8Esp6kCndJFiDrMvktcceW1+nyE8xqItRq/vQMhTExQ5wrvb/O4KG
         dKlr+SVnTb0K2oWRbdbiYSuVeRcBqFKyK+VrkJsaZxPy/5guaN5aT7E9l28Hy1ThITGG
         nlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925674; x=1705530474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV1DZHUcUVZrnewacKcGxbUMRr8vxmCiDHV3WTeMLmU=;
        b=NDBoCFZK+dbkARp5cg6L0PmWzMGnSJEYxDwDlIujS9fpFruEUP2GcS76uY8kcLHaQG
         a1EDAxONde+KAMP2K28nUYk1MdxuYN0dleS7xn1T605x1lBIfoEQae4Wpd9vn3aQkuJa
         y1nyxaWb1pR1JiH3Gc4NXnECiISkQj+Infk8tcV78KcYYSqvHzZwglhNEjrjT9eKmiBf
         t72doZbvEUue9Q30VcCICgIVJoCOl/kJ+sWVw21ih/QJTBLbfhBsaWvI1XSR9qmHFCFu
         E0ddpMbQYwmTTAAtRdNSe8tqs/NWyDe3ieHyhAPwk2kv/qca/LZZ7PpbhJ3SUK8wth7u
         XScQ==
X-Gm-Message-State: AOJu0YyLxiRx/QfbvZZnY650jkPvOgPEBLij2OdOePEKrPhoC3ABUuoS
	7oLKeI5A8o1Q0yiUCRpUAUw=
X-Google-Smtp-Source: AGHT+IGgcKxsjJ5XLQF/nuLg27niyjgQizwrV8LQV7EMJR/OLVcaUufsQ8IKHpTWo+JNwGlcf2yhBg==
X-Received: by 2002:a05:600c:2d15:b0:40e:4a88:2de2 with SMTP id x21-20020a05600c2d1500b0040e4a882de2mr54041wmf.155.1704925673813;
        Wed, 10 Jan 2024 14:27:53 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3989:437:3f03:172f])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b0040e4ca7fcb4sm3637953wms.37.2024.01.10.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:27:53 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dmaengine: sh: rz-dmac: Avoid format-overflow warning
Date: Wed, 10 Jan 2024 22:27:17 +0000
Message-Id: <20240110222717.193719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The max channel count for RZ DMAC is 16, hence use u8 instead of unsigned
int and make the pdev_irqname string long enough to avoid the warning.

This fixes the below issue:
drivers/dma/sh/rz-dmac.c: In function ‘rz_dmac_probe’:
drivers/dma/sh/rz-dmac.c:770:34: warning: ‘%u’ directive writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=]
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |                                  ^~
In function ‘rz_dmac_chan_probe’,
    inlined from ‘rz_dmac_probe’ at drivers/dma/sh/rz-dmac.c:910:9:
drivers/dma/sh/rz-dmac.c:770:31: note: directive argument in the range [0, 4294967294]
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |                               ^~~~~~
drivers/dma/sh/rz-dmac.c:770:9: note: ‘sprintf’ output between 4 and 13 bytes into a destination of size 5
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While at it use scnprintf() instead of sprintf() to make the code
more robust.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index fea5bda34bc2..1f1e86ba5c66 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -755,11 +755,11 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
 
 static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 			      struct rz_dmac_chan *channel,
-			      unsigned int index)
+			      u8 index)
 {
 	struct platform_device *pdev = to_platform_device(dmac->dev);
 	struct rz_lmdesc *lmdesc;
-	char pdev_irqname[5];
+	char pdev_irqname[6];
 	char *irqname;
 	int ret;
 
@@ -767,7 +767,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	channel->mid_rid = -EINVAL;
 
 	/* Request the channel interrupt. */
-	sprintf(pdev_irqname, "ch%u", index);
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	channel->irq = platform_get_irq_byname(pdev, pdev_irqname);
 	if (channel->irq < 0)
 		return channel->irq;
@@ -845,9 +845,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
 	int channel_num;
-	unsigned int i;
 	int ret;
 	int irq;
+	u8 i;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac)
-- 
2.34.1


