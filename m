Return-Path: <dmaengine+bounces-6974-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A395C035D5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 22:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBEF1AA1F72
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066172C11E5;
	Thu, 23 Oct 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6ejnNLy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDA2D3A6D
	for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250920; cv=none; b=Sb0uSYwjxwWAZ+Yl/S4v1Cik7ms4M0sRZjBur0q6/18uimEUIGcuV3hB+TwTDAX0NRgfo3NcpTah13ShBWrTM4+lMq4V3/eG4dsoa/w8hoDFHqkn+aExLEwgs6KkIOhHXEGkd4dCf5Dv4rsy9lAnyuIiTSRA6vi0kOR0VPwpA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250920; c=relaxed/simple;
	bh=0deRAiZNqo43DCs6cJ6stmvrL1lZv3Xvisgmp/a5y6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfJm6KTIleseiYz6EGHS1b7MEbmPvwRyKSfFcvkPwdHgxR9qiPHNq17ea+vV4NlH/ktN14ocZbNC+yIthd6PhnULzhhpwFSEXBOaIxNQMLR/kTbVaYc2/cEDJRXS28FF3Iq5wRgQNxtq6AyN+NllXVoJA4nsakv6HP79vKX3M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6ejnNLy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36bf096b092so13014311fa.1
        for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250917; x=1761855717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWWlF7a8NkxPR0qV542zU2WOXGZPptylUFyt7ljt7lE=;
        b=c6ejnNLytxDMJiXP4D7nUfIhk+lNb2Gt38lWpS/EqMqI+ZWSZh/E8CL+mtNAFIvFLb
         wCzjMOKIQTE3x5G++tmxGkLyBmDqxdAuya/VYSUROUvjra8Fi7b87xE8wwpkrGZrgZOh
         fN5PFu76yvjO6L1mXUX0RiyR3KOG4WbFq6ABYllprgCmR5Da0xfmMt3kfyQE5XHjPQxj
         7S+aa9etbofwDZcA5dudqhYGiKN0NfSpjz6DaF71W8QtdCbfuwAeiiqP6+0UcfSR9Sfb
         CfgzoGJMSAY4vPQMUAly6vaBBoC5NfUbe828SQh0t2ikrZ9WzzW7F/hAht0KekQezpYK
         QJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250917; x=1761855717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWWlF7a8NkxPR0qV542zU2WOXGZPptylUFyt7ljt7lE=;
        b=ZVaN1kQ5qqzkq8DtfqzQzG3bCJ3aXglBOtxGZ2X4SGhNNemKTkIcez5TNmTHSEur+v
         p1Z3atbowLFAOtEeH7xktnXD6L3LX/+yoF4x5wufffllk1ttDSrXzpjTgAHrAnr8VRFU
         fsH09iEE4eQay0tp9jo7gGyleWr+6bdszv2KGuhXMJARNZIuH15NSyiLSW236Ei4tmNl
         9ZbdAKovC/9VSkRxlhE2HaaIexRMYrZhjnAZkx5x/L4dwTkfAff7zJiS6z/qHIPkFnI8
         +dRwbINjemUlVj1+YypDqQBjiIX+Z2IvwSYKKQPxEbQ6AW+wiN1HMwUPe4kTD5vbBbfs
         LM0A==
X-Forwarded-Encrypted: i=1; AJvYcCXPz3jLjNwqpzlxtONAZMzGBTWDPvCL/GGrJI0zMi8+3DceOB0Z4Z5Q72M5wT0kzn2xdixIb06bySw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4WmdjOJWqVyPBeDDm70CD6F+yc3s2zTTEv+GEbBgg5RhUo41
	Qu3EJYqlmH7XGnPLwfH57vWxdUBRTVRom7lFbpooviClBFX1oz7/Iy7P
X-Gm-Gg: ASbGncsW1Gc9oQyzAH0QLrH1WsAjhVoGcTsnUBUVyEK6k0B/8RWmOhsq50LTHbimgKV
	ruoNTqA7m6D8cYXBa8iBM+29iQPX64drjryeZ4zbwJUn4nF5YnSfM902lIRTddQEUXfCHrJfxaJ
	FfiEEtontuzdlpXnCb11YEpZxwxi9DEOQ6LiLC95dxQuxfovsc6t7rGsUdAGxMuiMd3dg6WCdiD
	RgMiZZN7ZNHXzUmKv9S42NUd9cDUKR6L1zezLz5ZzAybhFM+8hfkx5lLi4eKdGG2fYCEzFkti2Q
	U/tSreyBj1RMhSSjTmnq5YBoOeurYvdK9YyBtWFSGD9geQ1L53yhPAdzI5nZ1HNhNHhXe/aJImw
	+VGi3i6PKQdkpY2XMCh67p6oNQb/xJCbNdm96ZI7qBpjEAAndQOX+1owOiJZ9LHEiENs8vDkUlx
	2noDz62WvnHIC+PAt4jyxehLHIWotfRiKiHI86CG0=
X-Google-Smtp-Source: AGHT+IFOgC/A3kynZGTalg0DDaZm7NuA87OjJNy37bVaLvGsbYRVnJB1HXVotgPj69VJBT/wAeQz/A==
X-Received: by 2002:a05:6512:4028:b0:592:fa1b:b96a with SMTP id 2adb3069b0e04-592fa1bbc75mr464709e87.33.1761250917337;
        Thu, 23 Oct 2025 13:21:57 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2cf30sm977522e87.97.2025.10.23.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:21:57 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: p.zabel@pengutronix.de,
	dan.carpenter@linaro.org,
	a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 3/3] dmaengine: dw-axi-dmac: fix inconsistent indentation in pause/resume functions
Date: Thu, 23 Oct 2025 23:21:33 +0300
Message-ID: <20251023202134.1291034-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
References: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix smatch warnings about inconsistent indentation in dma_chan_pause()
and axi_chan_resume() functions.

The issue was with misaligned closing braces and incorrect indentation
of axi_dma_iowrite64() calls following if-else blocks.

The changes address code style violations by correcting misaligned
indentation in conditional blocks. Specifically, the closing braces
in if-else statements were improperly aligned, and subsequent calls
to axi_dma_iowrite64() had incorrect indentation levels.

These fixes ensure consistent code formatting according to kernel coding
standards while preserving the original functionality and improving
overall code readability.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1496c52f47a6..7b07bf5ac72b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1234,7 +1234,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
 			       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
 			}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
@@ -1281,7 +1281,7 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
 			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
 		}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-- 
2.43.0


