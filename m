Return-Path: <dmaengine+bounces-7269-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209DC757F3
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E44E1389
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A5236A00F;
	Thu, 20 Nov 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqBjvFKQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED03644AD;
	Thu, 20 Nov 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657360; cv=none; b=dld4fH2hT8YN5CT4HXK7e/uH32I1UYbJz3Lel/Uw1hLQw/kAv5NDa3DypeDr9iUqV4GiznolMW3TcxNCdPrOvmcOia6qlxUSe+NSmJgzs0HqyewhvajRP+QKU/w6KbDaDR8mx6qc9pIAoGUzvYiuY8qUlgRtpV9wtplnXnw7+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657360; c=relaxed/simple;
	bh=dP/aO90JHgoqpHYU1iic8AxbAbLplWQN9Mbslc/6cws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDwRwiaD1C00c+sO2Z96m8189SBFz2L5xib/ou21DLPak5CjUnmfXF5sWM/nI5hq4bSBt8vARNXYWvytG8qjsTk0t5RwxxfCjbsRyKV/RFVxfhLoQ0Bxvh0RPHglrCrsuw8XCwcMhJwjUUqZ5j1rIIa6+AZ2+p4o0NFF71rFQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqBjvFKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B182C4CEF1;
	Thu, 20 Nov 2025 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657360;
	bh=dP/aO90JHgoqpHYU1iic8AxbAbLplWQN9Mbslc/6cws=;
	h=From:To:Cc:Subject:Date:From;
	b=WqBjvFKQW7UGaWlcdXoTGO527lEwt6WfzYQ4GQCGKDNSXA2NQMo0vDwpYGZQwGIU+
	 ck+9+OvZ2k4ruoxTKEheFA1SfKBiDNInqtWkpEJUa9r6tOBB0ORWBuXpQL1Sgi312J
	 HuyGDaP3Y7NNlbKRHSLyF6doDxOGMsjwVtbVH0ft4ZI56Ra1zY8U+kcZxm7//Dm4tT
	 zcmro799wSbKYoy33Ua39yewgmz04e2+0muR/M6jku6w98EtDXG7D9fSrawi9oKfx3
	 KXVZnKPTa5dbIGaRu2DS8kBrKT8GMl2ExzYpY87a46HYDPVz/sodw0/tIpzGiprYqv
	 gcOEvURQS21/w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM7qS-000000007I0-0kr2;
	Thu, 20 Nov 2025 17:49:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] dmaengine: st_fdma: drop unused module alias
Date: Thu, 20 Nov 2025 17:49:07 +0100
Message-ID: <20251120164907.28007-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probe so drop the
unused platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---

I apparently missed this one for my series posted earlier today:

	https://lore.kernel.org/lkml/20251120114524.8431-1-johan@kernel.org/

Johan


 drivers/dma/st_fdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index c65ee0c7bfbd..dc2ab7d16cf2 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -866,4 +866,3 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
 MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");
 MODULE_AUTHOR("Peter Griffin <peter.griffin@linaro.org>");
-MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.51.2


