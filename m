Return-Path: <dmaengine+bounces-1310-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B67B876593
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 14:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669A01C212BD
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C93838A;
	Fri,  8 Mar 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdnS/0bl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EF1DA5F;
	Fri,  8 Mar 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905675; cv=none; b=AGL8HHhdPC/JAJkVNkDpcOGT9YMhUJefLT8VvkSpi24O2qKy8CygV34875BHQ7nMOhNgaoixudPBvlEGV725SCDuN/6JGXlLBsJeDyrkgik5rg6db+9p1P7xk8z0rfrl4H6R+vgknRnFIn08wIfbzor7qZHA49E/NS0GOJfjHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905675; c=relaxed/simple;
	bh=/PRw9ccKt0T4kEd8hXPgc3tzzQevKpZOpxLku2uhNBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZWL+TWXyqYioA9YIo68AIlcsmNHEmDmh1caPs3gkaPjs8bvldckcTzvNPTalsRxWPyqeqfo/aaO26VYO5vIWRipCOSZxZJAuMJxmpsaPV5EKKHcM1Q4F8uYXIfniCHX9jMqyUZuBSyKO2ANSIogOSeQ6uKaGb6T7jDvTZPxfdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdnS/0bl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413183f5e11so3738345e9.1;
        Fri, 08 Mar 2024 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709905672; x=1710510472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3LkD4Cs569/mWMx7CY8g9v6QR6hNkaicC0wA3uOs4A=;
        b=PdnS/0blFjT5gD8GVCBQsmM2DYkC61WiuPLD0g5/gqC9rvggl5vOi4BTrUSs5IKDBw
         +HBQLosEN/T31uuFdLFxo3oWixF9UpCZFSL/hOGGsrCEE5LPt8ESahz+MAGQ2dfZsrxQ
         zY2gDdwjE+6ViNrMjHEyEUPE+mXw1nLj/Y/Uz9EqfPMK0tYO0YOQNWBPkFTHO9wiaxeN
         btku5QsXJMY1il+kwRO2wGFkP1ITQ7xQA1UqHCZqgTLT1pH46JVKY+AOc5q0symhJupl
         NtHuBn5MwdzYST41rGmpk8womVFqqhBWipqL9epG761pWQM3+wpYHheNR/+Jl6Gzn5c3
         Rqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709905672; x=1710510472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3LkD4Cs569/mWMx7CY8g9v6QR6hNkaicC0wA3uOs4A=;
        b=Q/xB3dupvcZpvxyOdyq4QFcV+mF0a2/LC6WaH0aEvdRf5GdcCRPGNlmFuZhFcJ4yGL
         Wgc4DRvYU5Eo+FEzJ1V5bpw05rvnehDREnIpusFVJw9wb4C/seHI5wxsLCcLHXhJvKUf
         AklWn43SmjLvW+FghO4h9M3HMBT2HOv0s5XzUaPgM4wNvI/bpYObJ4WLweXw78+hetuS
         akPRWuk4lqbo+T966+qPZbxUmjGK2h/na5lLMeEFoO8nbxYZJ11xFGldmHSEbRMAGbHq
         V2KRJ5PwYkXGXiCrbvOZ8jcHvJy9n5bQFS26FwC8BhNdavd5w9lLKXJSYa/2czSceK6a
         6JoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwhE7gZnjGbB1KrkAVF0TONYbwvpsBOnQ0T6umAtwa/7d8s5F/hNHdrORpQiCxUsji+HeZ01kw9/YnrDYizCRE43utpiuc844Qsg5AiJ+8bgz/xAjisKa9+UR3Y3lgboZ8lV9KZk6f
X-Gm-Message-State: AOJu0Ywy+zQxMEu0AATj1vt380FXdvmwpMdKF32SUqkB/kO7cxTB2Zdp
	/3GvOcozVJx9f7E2pYuvpUJStJ5rQO4eb7AbsYwETwyEP4mW6Hb0zkhZOWSce4M=
X-Google-Smtp-Source: AGHT+IHz13x6X2BWLbykrXVF/3dnnmS2gP0gNigiX/RmQnrD0Lb3lyONWH83Un+e7PrVA1AjP9sS1w==
X-Received: by 2002:a05:600c:524c:b0:410:78fb:bed2 with SMTP id fc12-20020a05600c524c00b0041078fbbed2mr289359wmb.19.1709905671793;
        Fri, 08 Mar 2024 05:47:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b004131d2307e7sm85386wms.12.2024.03.08.05.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:47:51 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: pch_dma: remove unused function chan2parent
Date: Fri,  8 Mar 2024 13:47:50 +0000
Message-Id: <20240308134750.2058556-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The helper function chan2parent is not used and has never been
used since the first commit to the code back in 2010. The function
is redundant and can be removed.

Cleans up clang scan build warning:
drivers/dma/pch_dma.c:158:30: warning: unused function 'chan2parent' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/pch_dma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index c359decc07a3..6b2793b07694 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -155,11 +155,6 @@ static inline struct device *chan2dev(struct dma_chan *chan)
 	return &chan->dev->device;
 }
 
-static inline struct device *chan2parent(struct dma_chan *chan)
-{
-	return chan->dev->device.parent;
-}
-
 static inline
 struct pch_dma_desc *pdc_first_active(struct pch_dma_chan *pd_chan)
 {
-- 
2.39.2


