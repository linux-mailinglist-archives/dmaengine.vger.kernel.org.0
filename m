Return-Path: <dmaengine+bounces-8102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB1D01DE9
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88ABD335BD8C
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EB39525F;
	Thu,  8 Jan 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8kchsQw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932B7DA66
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859428; cv=none; b=UXOWsIIf44GeV9u2bp5XqcQ5mRXFxQHSf6B1g9/ZThytLd3MsQHk4iWWeBxdB03gsEFUHB8jDNWKlMTbymY6pH7/RjR+I7o8ZDSlSuSqyVU2EZNtuUQZs3aaHdjjbQ80sOJric+Nr+Ui62OgQZ5bquIvoYEMejM+nvN3R/v7kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859428; c=relaxed/simple;
	bh=K8+S8wlkHCLpmfN12yfufF6IQiXYBdMOseU37KncohE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VlNM4X2RAzhG1g9AF6tpECRgpFqgH1PDkSF4Ze1g24QAVtbWNu127inCTCeEgGcJNgE2LQzHPukgcneYX4rEmzpmbTajDFyoWqKnSBbnOrr8U3I9HTy4HE1zrbqGjYlXuhD5at+3k7xK6nBZle5r1CtRE3ihnLl74okgLQUFbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8kchsQw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso1252987a12.0
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 00:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767859415; x=1768464215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iokw+Jrr9BhDkjtVXkW0pvpB6fNxp92CDdDqaj5p6cQ=;
        b=B8kchsQwoUHyVmqB54t/pwDMkSGy850dzz1CmIR246ZkzIL8KGH5AaCU4EmEvsyhPu
         gOXwyEcth7UA2SsvzZGbXVfrEku/ZeNO1ozDrJKINQaHG41/CizGp17PCk5AJUkbeQz2
         aCrlpuT1JIxaFYBQX0B2h6eg1K9hgF0fPha+AW0jEkXPfe3V+dP2Zb+UrxLV8ZpJY7qu
         4WQZE1Wtapd+m5N3m4H4yGUd9zvg0rTRZZQpSA9NCPGtGaeBbjQBE+gLt15A7eScQtZL
         8N3qgnvkJ1cVqGqEYyReUMp2IdnsKHMUp7wgBYELspQr8zMltbm7go8bAnEq+7dHcfW0
         ARng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767859415; x=1768464215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iokw+Jrr9BhDkjtVXkW0pvpB6fNxp92CDdDqaj5p6cQ=;
        b=ICBUfmSqRshLRJXijVqMNtYtOj9kyJZKqC545Tx8vsWt2qQGalb0kedQg4CCywsqM/
         nyMU1Tu2tBte4hEAcJ98BtEqa7x6SaEnpyAIdNjer5wcE7pzA0cTt/i+ZTG8GNHEny16
         LNPPzHumWwLmgsnruHPaLKiJ5zdCJSBEWt6ehQRD7X2iVwyt19TB31rX4ZhJAz+17+rM
         ovMQFNvAd3jMLS5a1fe3+jfti98pJbKtpxQ7c29YnAqe0vgtmvVXZ4g7GPPXcsccFkIE
         jdzBqo/1uap3JSSXwfGJ4bsiU9BIOjAVbnnuZboelXvpfZeYdb7/4lOSLibdVmFUmLPv
         QDSA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6hbbiLjBcJI6EXYb9PUsXrXcCOLmqsy38qO95eNyu5XcyAaMHAs/5N6QS/lhZTO2lueD+rAmnPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2lJxYghVbx//FPk1WXimg7h4EUW8peRKXThZTUIpwD202RJQ
	t9ox8GN7cvhKuRk6RdsPFhklL8EfOpAN4HiNOcQY82OdIrcl5nMZ6kWM
X-Gm-Gg: AY/fxX6qG3fOPfOl2hGJLULAGEzK+I1+MOBD2xTSlEfSr9IOzyUUP6KyrGWpPUr7PzL
	DSVIlQnrUmT2Pxw0c7MpbGYqLrkVK4oAWBJFMuDGjk/W3kdgbUEnSN9Ko+7mqhbKAcE50l6SpiV
	10dv36smc56RSbxntj+jZ9QsGL7/0EMRPSg+NrCw6VD46TQpRRPRrxGjNL++Dr7604akiOfOVBG
	r9erF3ngIDFte3KyJBaZvF9FssbzCzUkIPbtpSXwNJQvSjMqJ/uYxyRs8m4q4BNDYxRwWUJ8MRu
	mgxIML5ACMjQx/w9QdtZA8mSZZyokd/x7CdaiXR8mKYD0VPI6x5AKunubnKTSzJEow0Q1ay9y4E
	6bEsEz07KP2v8qvBEmL8epZ4RGMcp70Gm6O8l0PXhuhJ54n/lqykPCjHk5NpBbssxwGuZklU7ZR
	mtDnKeQXGFHgRcMoYZbKF4hChuDKrO6+qHQg==
X-Google-Smtp-Source: AGHT+IEhFGyHY3gFuKexpWlTZMpUdjFQ0fP9vd/gv2uAaeVtHl/+xU3q6TaNAL5/pzyX4B97/tFX3Q==
X-Received: by 2002:a17:902:cec1:b0:295:9db1:ff3a with SMTP id d9443c01a7336-2a3ee48ff78mr46223815ad.28.1767859415197;
        Thu, 08 Jan 2026 00:03:35 -0800 (PST)
Received: from cryptic.lan ([2001:569:7e17:d700:9e5a:c54:de19:a242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2fe3sm71065775ad.59.2026.01.08.00.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:03:34 -0800 (PST)
From: Allen Pais <allen.lkml@gmail.com>
To: vkoul@kernel.org
Cc: arnd@arndb.de,
	kees@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [RFC PATCH 0/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
Date: Thu,  8 Jan 2026 00:03:30 -0800
Message-ID: <20260108080332.2341725-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vinod,

 This series contains a single patch that introduces a dedicated dmaengine
bottom-half workqueue along with per-channel BH helpers. The change grew
out of the earlier discussion about moving DMA tasklet usage over to a
BH workqueue and I took some time to get the semantics right
before sending this upstream:

Earlier discussion:
https://lore.kernel.org/all/2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com/

 I’m intentionally sending only the foundational helper patch for review
to avoid spamming the list. The full set of driver conversions is already
available here: https://github.com/allenpais/dmaengine-bh-work

 Once the base helper patch is reviewed, I will follow up with the
remaining driver conversions.

This series is based on v6.19-rc4 (f10c325a345fef0a688a2bcdfab1540d1c924148).

Thanks,
Allen

Allen Pais (1):
  dmaengine: introduce dmaengine_bh_wq and bh helpers

 drivers/dma/amd/qdma/qdma.c                   |   1 +
 drivers/dma/bcm2835-dma.c                     |   2 +-
 drivers/dma/dmaengine.c                       | 109 +++++++++++++++++-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   2 +-
 drivers/dma/dw-edma/dw-edma-core.c            |   2 +-
 drivers/dma/hisi_dma.c                        |   2 +-
 drivers/dma/img-mdc-dma.c                     |   2 +-
 drivers/dma/imx-sdma.c                        |   2 +-
 drivers/dma/k3dma.c                           |   2 +-
 drivers/dma/loongson1-apb-dma.c               |   2 +-
 drivers/dma/mediatek/mtk-cqdma.c              |   2 +-
 drivers/dma/mediatek/mtk-hsdma.c              |   2 +-
 drivers/dma/mediatek/mtk-uart-apdma.c         |   4 +-
 drivers/dma/owl-dma.c                         |   2 +-
 drivers/dma/pxa_dma.c                         |   2 +-
 drivers/dma/qcom/bam_dma.c                    |   4 +-
 drivers/dma/qcom/qcom_adm.c                   |   2 +-
 drivers/dma/sa11x0-dma.c                      |   2 +-
 drivers/dma/sprd-dma.c                        |   2 +-
 drivers/dma/sun6i-dma.c                       |   2 +-
 drivers/dma/tegra186-gpc-dma.c                |   2 +-
 drivers/dma/tegra210-adma.c                   |   2 +-
 drivers/dma/ti/k3-udma.c                      |   8 +-
 drivers/dma/ti/omap-dma.c                     |   2 +-
 drivers/dma/virt-dma.c                        |   6 +-
 drivers/dma/virt-dma.h                        |   8 +-
 include/linux/dmaengine.h                     |  50 ++++++++
 27 files changed, 189 insertions(+), 39 deletions(-)

-- 
2.43.0


