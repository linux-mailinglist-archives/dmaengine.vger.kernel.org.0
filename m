Return-Path: <dmaengine+bounces-5837-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D8B0B334
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jul 2025 04:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445913A6DFF
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jul 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335E17A30F;
	Sun, 20 Jul 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXL6djaI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9320322;
	Sun, 20 Jul 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752978624; cv=none; b=T1bSxFWZOm3iMtQaUC8jC4rGDpuY+cbhJo4W+w9VomBUgHY2GkoOODAO/s03XK1cN4Cn8wbWABNbwl/ll4toQeuGwehj6iT1F4Y4VhoHU9oe/wDMu4Vl/FgjV/naroaqREtBrStXYybfgVPS/yYsmJMn726DB38bgNwQMd9I58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752978624; c=relaxed/simple;
	bh=sNOncHhbQ8qd7tyK0k7RrrcYqfgqJVInfaxQnYb802k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvTN6JeG1p89m9WvPCl3+Eba0CNNpi++4D6pCK63RwMRDxA4TIXtLpM/57TSVIee/EZKrLrkqbKbbxuRzXbdeBzAmsVhneouJv5p0hQvZSpGvLUmYtB5n5J4X4Kk+eV0l8qLHQHyAu736uItmoKPSTHibenMqQ26HhzFppHwNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXL6djaI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8d713e64c5so2879421276.0;
        Sat, 19 Jul 2025 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752978622; x=1753583422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amtKtl3ooRtvC2li8GbFmMMnmVXBsukS4ItRHONf2VQ=;
        b=mXL6djaIBYTGmD5GjDlleI0687v7MO/mUvtvjccRjNg83yUMnEo2bHFMtxWGKD6GqE
         Gf7gqv78i6VYVah5FOsnctbmL3vmVFJaJwZ0ALs644CV2HxBPWISjIeDE3OFZH0EgSKK
         GOo/wOdgd4Nw5kCPpDr6qBmvHJ4tIobYpO4Og2YCDUZfN0GADNguN34OPobK3zuj1zp5
         QQNp/QF0sps79LrKlheYRXXB28V72sXi69rWSTr9mlYwuQ1uOV/ZfJhvyoJtgESKWpy7
         c2ddawwZnHTR4STKIoxNBx67nhlv2KN2j8ZWJ7sarIzU5cyjiR4OIeIpqiXZt5kI3o4o
         jscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752978622; x=1753583422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amtKtl3ooRtvC2li8GbFmMMnmVXBsukS4ItRHONf2VQ=;
        b=e5qmFcdiC/SdQhOPJIojPL6poCWyR0HMRZeGE2WVyGS4K2IRhD+h4FX2MAxwgzI3G9
         JAa3g3L17I7VL6jkLfOiov2KBBRdgYTEJZb7itlzMBhuKu72mbV69lb6yDm4PKRjPVed
         MGf1VvyV2PfC/BWOJ+pFywNrei5f2OvrF3pMCrcCgcGB8reuYAncw8oMEuFiB8WwXjOP
         BkXY3LiT9zPQF7xfKEkNBGQNvkemNI29IoZBVCy3MCln46TYHuj41NLi6aAwRlbAgpVq
         FMpp7ejc209L+7/WKHmblxbDgCPBIP+IwGzHwx02cfIz8T570OzzboSOgJpYa9LMy1xy
         ggXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIJPSyuNAjoEVxx0y8xOTNHID1+fctxGco56ekawmnFpKLUkJPx0TToO6nkjojyA7XLVps4aJwy03wgZ+Q@vger.kernel.org, AJvYcCUpDKCexZr/ut2qKDSA0OCxPmU0HVjLDafW0KRcfy8zCpGktWzDI9RCNU1/lwnWh7sIS/Amg32Jl7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QgZK+Z0cZO12NJk9m6TYbrQ+nUocO6I7tmyuj/0g1xUoqQm5
	L3pEvOgKcDx2gjinjBB60F3JIq5h+LciP2FAqCmr2Ba6QJQ5hMdvK4MuTWCnbA==
X-Gm-Gg: ASbGncuUCYcZKUTZUf7I+mJK/47VMc1WDglMZxAF5BTY8EXmr5MJY32oGpqa1LIGkcX
	TdIQK2Y8MqW1BwwykBAA0QCroK8+ZV601KejYgDj+vi90XFD46auUTd+EW7MjengxTgxOUbn9ev
	v/0fItVAYCxNkJKzGQ72QrZlHK1nCaGwR14Zr+eHDPv3p0ITHTTaJ9ANk+g4+t48wsu0enN9HTq
	svyGPwBjeserCNAkU7asVowdtAy8hR5i6YX007AiCi7rznKY6DoYnP6FBMe5dPsA/R34owc3NMe
	HyB/xfvmoG0pEzCZCqfvJJwsllaYZUMme2Kj5ky+zY1tD9oj761Zi/egmBREygLfLMQWbnQEJQn
	0jWUo2i0FUaZuQj7pb3RfJPHxON/kUFrmxeXjjDEhOQQyTVxkdQ7Eb4jPJw==
X-Google-Smtp-Source: AGHT+IEQi0X1Asb3s9ewEa5Kj33UUXsHCr3coX/Md+u+3jpgmC6Ue0NQdTxHvASjXYp17Oi2SG5hNQ==
X-Received: by 2002:a05:6902:2289:b0:e8b:9ef1:f9ef with SMTP id 3f1490d57ef6-e8d7a5c06e3mr9892999276.45.1752978621942;
        Sat, 19 Jul 2025 19:30:21 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce0e631sm1545723276.32.2025.07.19.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 19:30:20 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] omap-dma: simplify omap_dma_busy()
Date: Sat, 19 Jul 2025 22:30:18 -0400
Message-ID: <20250720023019.437925-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Use for_each_set_bit() and get rid of housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8c023c6e623a..ac5c1f32c856 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1530,12 +1530,9 @@ static void omap_dma_free(struct omap_dmadev *od)
 static bool omap_dma_busy(struct omap_dmadev *od)
 {
 	struct omap_chan *c;
-	int lch = -1;
+	int lch;
 
-	while (1) {
-		lch = find_next_bit(od->lch_bitmap, od->lch_count, lch + 1);
-		if (lch >= od->lch_count)
-			break;
+	for_each_set_bit(lch, od->lch_bitmap, od->lch_count) {
 		c = od->lch_map[lch];
 		if (!c)
 			continue;
-- 
2.43.0


