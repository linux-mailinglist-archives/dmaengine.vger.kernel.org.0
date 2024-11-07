Return-Path: <dmaengine+bounces-3692-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A59C0481
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2024 12:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3622B23BF3
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2024 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE32076A5;
	Thu,  7 Nov 2024 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXY15Ro"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7B20ADCE;
	Thu,  7 Nov 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980020; cv=none; b=bK4/Vjf2DQStfdqqdSNAJqbaD2x5Y8SD4viqJ0Xf6q7oohR3Di3dAWS3joGYwajZWA9zCmzxgEHWJy5qTd/2abWfOoBZeB4uDTIA5Amfc675WC/a0OoQkXTracXeAXzK0dVMn61qX2gwrrs7W1q6f9By3AOOL01arTVOUpJq/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980020; c=relaxed/simple;
	bh=VMLxWzwy+PPCFwHSO7V7B7rLOc/FSCV2LFnh7wvPtZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kBqTtWtYtpDKdOzDTam6O16pgvPoSeUYUA6+rbjxnFwjnYtfmgTjnIdZdlOxlcsyfCrCv0xNbOKBVZJ1Sd72/hQs0hQqaEpLhNmRSzj+3upAJpe7E+L/ZAQSO3c+6s2UHpHKVLGp/R6GYVZDiqEDZaREnY3w0O9TqMIwpprjb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXY15Ro; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d808ae924so545326f8f.0;
        Thu, 07 Nov 2024 03:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730980017; x=1731584817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6bPQJwYqFCPY9Eo5614F+YujOvB4HQyUxWDCNoS0mk=;
        b=ezXY15RoBroew1qqw69n6v2b912H9ZKWYjrfTC1wb52QXPuCw68N0/yEiaq5lHF7JS
         WnzvLbr9sx50iKLwicEozOsbcVgO7Mz3FGwz2GK2wXIY4lcaU3khkap8JpTY1oq5dBsW
         MzuVn5JDfCMOzPRu/g2Eo2eoen+ufEI2ktI+2j79+L6JQAS6bpVHOzYdbpUeSYRz0fyC
         cejlGaLkkB/uxsnBFnGm5bngnRT2PSjqrpLfsgfm+/FDpQfRNm132uvaYmhHqbROa73a
         vBh65ypHUKjE8dwPoZF9e39lWy60MWRfYuY5GmPsunfZbhmp1LFl3XPpLz7uH2rA9CQ6
         qIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980017; x=1731584817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6bPQJwYqFCPY9Eo5614F+YujOvB4HQyUxWDCNoS0mk=;
        b=h7CYnsComwJYGBsH9KIX94qKXdBBE46/OZrKEFsBGfx0HksEJVLymI6NWYxzBlUgXu
         5IKW5NFmKx/QrRA6nWGP2Sfrm+Jpl2T1hLWZH0nb/lb5f7oxAQ5e/ABmiu4V3MmAC8SU
         CnTn5lmBGxGJdDaQCvugyuDY5f4Xlwm7wp7OFI0VTzy3TEotLtamTj20z/6ESrSqpgSx
         XVH3s+T0h9V1ZQAkAEMh4nfWDADFgjW/5ioYP4dravjBq2XrySmMlVbNG9SAzRKgw3wr
         3SFgeqpjkZ6fEs50IPm3ErnVHp9fLHVZucvEsUKnFU+Xbz8w64WNilfeTJhaNZguO0HB
         OAOA==
X-Forwarded-Encrypted: i=1; AJvYcCXJScbvTysemJBrd8+be+Xy+SFy5lT0/TZaDQWf8FgHnN4LmU7SYwnhijsVDATvP2GquP7CehkLPX4=@vger.kernel.org, AJvYcCXLR+1hCUXVf9RrKjjA+M9jZ6teti6m0tyTnJLtKSjoNSQsLRldLK1/YjJuvV2xzclCyjTpoGyakn4TzZpd@vger.kernel.org
X-Gm-Message-State: AOJu0YxorQOTIg1lBA+900xi0qRm7Do600deSyIG1PqhtB5KZTA1RXKm
	LM/fMiWryYwR3NXYAyRCsNHlZ9OlftsClT2cVMI1fB4GVmxzmt2F7yV7Yvuxamg=
X-Google-Smtp-Source: AGHT+IGmxmbYT6mTGdynIW63d8rNVanHSb020FXVEWto0gTCU+tCmgRKqEA3n/WHVPuMHIMQRosUcQ==
X-Received: by 2002:a05:6000:12c5:b0:37c:c5be:1121 with SMTP id ffacd0b85a97d-380610f7bb8mr30048320f8f.9.1730980017021;
        Thu, 07 Nov 2024 03:46:57 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda036afsm1544294f8f.86.2024.11.07.03.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:46:56 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: xilinx: xdma: remove redundant check on ret
Date: Thu,  7 Nov 2024 11:46:56 +0000
Message-Id: <20241107114656.17611-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being checked for an error and returning ret
and the following statement returns ret too. The if check is
redundant, and remove it. Just return the value returned from
the call to regmap_write.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/xilinx/xdma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 93772abc3b49..0d88b1a670e1 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -390,15 +390,11 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
  */
 static int xdma_xfer_stop(struct xdma_chan *xchan)
 {
-	int ret;
 	struct xdma_device *xdev = xchan->xdev_hdl;
 
 	/* clear run stop bit to prevent any further auto-triggering */
-	ret = regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
-			   CHAN_CTRL_RUN_STOP);
-	if (ret)
-		return ret;
-	return ret;
+	return regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
+			    CHAN_CTRL_RUN_STOP);
 }
 
 /**
-- 
2.39.5


