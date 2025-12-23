Return-Path: <dmaengine+bounces-7891-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B82CD97DB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8579F3019199
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1F279DCA;
	Tue, 23 Dec 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T/ONAb6e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AB2741B6
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497843; cv=none; b=InEItXCoNki33BFTNgQ6APwgp/msZEzClNa2qmut/xG+gvF0JoV9pv293yIm4Qt8WE1s1dV9l8oD3DpR/fJXqz7HrYdPAMQRToA1KYG908CRisYS2stpl0X7mHpWgccPjgG8cMuv5aa7aAWGsynIEIkqOLPPzq/p3Cra3l4p9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497843; c=relaxed/simple;
	bh=R5YlQFivD0z58iZAMVJliC1tEHPcqljapZwmSPcdxck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6bgaUIPN/zpL7cA0ocJbsdphsloAGLluhhFAG0UkxWUc71mFuWeMDOd6Ts5rSdXx4VsJGt3nLTBm20rK3PbILiinBrfN5weg3pVbFZa0kuABKn3FYctYNaZaLwiO1uqonN/9uhNDN6FI60n5ItT/HU2MpwrWVCnGMNP/aY8QC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T/ONAb6e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so49112215e9.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497839; x=1767102639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSLSTBCuxYpWQX70zdRdCRHrxzQ3ybHMPnhlQz4+NDY=;
        b=T/ONAb6e6EdzKehm3Q2ZKbuGfNKB+5FjoyghRV8w//gA6oQIcj4dNjJ5Y8zrXcg6Jp
         aP2cIywdx7RC91HsI4DuvUmWcR+hHTlqeOfB49GKX9QWNZab4LJBWFqKMavyqa6RqUMe
         TG1oHUnja/WENJ1VwcEtgYaassrPtf+i4S7n76c61Dg3r6lB0S3UHVKDXb0Jp7hQxi+i
         +DhTbxwDim9YCyavpZGueCKOhiDXeMEL74e9LEVfQBaIH7BseMejHCdl5HOvlU77JOJp
         icTY0ycSwdKptA2x8dwqoorRs589WKHsEdaM8yjaTcTUvu5iDzIzELDvcjwEKI7N+uWr
         1N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497839; x=1767102639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSLSTBCuxYpWQX70zdRdCRHrxzQ3ybHMPnhlQz4+NDY=;
        b=ORZV9TTpUpwloJGExeDWGFrxcmGXXJxzSRDwtX16tBIc+ldByxCPrwiBEgxcfey9Rs
         SEfjaAg9hP/TSyh6YJJW9LlPqJJ49OjpNzO8sLie1M22Z3oXwGNP8r7gx4rJteORPydi
         ahT+qqPTsYCPUMdFDyAEGYzqlpZypJzeqmWqNII0rU9mowokkIBjH+WqQCl/kLQC1RNr
         ZIaPTkthP27DCt5hfUPGP6MFkBc9QVUXOsPx8Z1MQzjq4U6Bn6DNIwE3rR3yrzCuzNLC
         soJQ+EGFlNUb7ev8GuMQiO7r0ggfEPjbunyzFb3Tk+NrBiuKKHHqQNZTRA8NVUasoi4f
         pp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXHiEDDu66bY7eOvbqIeuT9BBg0NZWUX21PhI/rVa37YOKD+0SOZNtvctBfaM9hzecXJmVqWtpcl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7pzX2DdlGu6DIYgbiT+A3kv0YLoIq9cdgf99IQNCbve86QI3
	BhuWPt/7dWzSW0qjPnTfrIB2OVWrFuurM69hOjLiwL+ZMk7JUXXRHEPkDYOc95Nc5Cw=
X-Gm-Gg: AY/fxX4WIwJm8jhNSiXX9zQcMN/4l2tEkzUDzML7m3aa+FXOJUVgJHRXNYix0DFRz0o
	5YiK9zFmh/9rOAzMKSJ2kkndYrDtXsfTcVEGNVnGjF0dCKRqN0vM+iEbwh5Qdw5IA9qb6P+cDKj
	7TsgW5k5OW9BdB57xdS7sc1PJfj5UzFRQ6+xA9m+0AQbxYHZeX/8ZVBKOthVAuds2JYtvMw7+zS
	4JutnZtNkuNKD75m3BcunznldtMAhrgXpA8dOzx8F/niR5aVuqoX3k6+y85KzLt6Q4vtEop5tFg
	MchZLi2G8Udinsrk7LfkR0spV3uj6ln3J4Aw6PbBgWRK26rvcFIPXBuF795tHzOp9N4qQqrkz4k
	reMcrTE6sWRRDeeKmIPGB0nENrt9lbNyVqp1Q/EfYD+rwFgMdXWwxJEeZ+7D8ha789QeLGiIqR2
	PX5u5KxVnLprMoXS98WzjeuvTuSYIowcigY0cgLZ2MrEqb2pr1yRCBGkwDG2E6Mfik3Agzj/Q=
X-Google-Smtp-Source: AGHT+IFFvIkSqaMDo61ZCu99zvjXsDbrrlIP0g2MTNusrjNtnv6buJ7QPDHENNpiJsBuRLIuAxu/GA==
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-47d19593d0dmr187785365e9.32.1766497839109;
        Tue, 23 Dec 2025 05:50:39 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 0/8] dmaengine: sh: rz-dmac: Add tx_status and pause/resume support
Date: Tue, 23 Dec 2025 15:49:44 +0200
Message-ID: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds tx_status and pause/resume support for the rz-dmac driver.
Along with it were added fixes and improvements identified while working
on the above mentioned enhancements.

Previous versions were addressed by Biju. The previous versions were
posted here:

v4: https://lore.kernel.org/all/20240628151728.84470-1-biju.das.jz@bp.renesas.com/
v3: https://lore.kernel.org/all/20230412152445.117439-1-biju.das.jz@bp.renesas.com/
v2: https://lore.kernel.org/all/20230405140842.201883-1-biju.das.jz@bp.renesas.com/
v1: https://lore.kernel.org/all/20230324094957.115071-1-biju.das.jz@bp.renesas.com/

Changes in v6:
- added patches:
-- dmaengine: sh: rz-dmac: Drop read of CHCTRL register
-- dmaengine: sh: rz-dmac: Drop goto instruction and label
- use vc lock in IRQ handler only for the error path
- fixed typos
- adjusted patch
  "dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks"

Changes in v5:
- added patches
-- dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
-- dmaengine: sh: rz-dmac: Protect the driver specific lists
-- dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
-- dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
-- dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
-- dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
- for pause/resume used the DMA controller support to pause/resume
  transfers compared with previous versions
- adjusted patches:
-- dmaengine: sh: rz-dmac: Add device_tx_status() callback

Thank you,
Claudiu

Biju Das (2):
  dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
  dmaengine: sh: rz-dmac: Add device_tx_status() callback

Claudiu Beznea (6):
  dmaengine: sh: rz-dmac: Protect the driver specific lists
  dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
  dmaengine: sh: rz-dmac: Drop read of CHCTRL register
  dmaengine: sh: rz-dmac: Drop goto instruction and label
  dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks

 drivers/dma/sh/rz-dmac.c | 281 ++++++++++++++++++++++++++++++++-------
 1 file changed, 231 insertions(+), 50 deletions(-)

-- 
2.43.0


