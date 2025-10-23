Return-Path: <dmaengine+bounces-6971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAAC035C3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A44E70F6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 20:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4B25DCF0;
	Thu, 23 Oct 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgNeFsJ5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428226E6E8
	for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250907; cv=none; b=UUDI7iNtPjKzUWcU+S1D/HEdFjt73EkMIiQe0Mk5+NgGJWejetXyDkB562DntKuKN8Dc/mI/TKtsMOh6MxiJk61nOJbmhi3i31yNhn8usmLQxi830+Ih8D0uUfh44O8EZetkptTPvtLbOE9nnBPsRot1wjyTMzZ48tkHgCM6r9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250907; c=relaxed/simple;
	bh=jg9Nj/uwtLYP7rKhbQsQ7kSR+mSXhYHhP6Bl67TYfp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL6/EfVqprVwlhMID8Jc56F0aq8AabNKmccnSI4fN7N9PdT9VhcMsMtpQtFOYqcepfAIUgaQL7mfWgRzf4nlcQHOl6k00puhrpf4ORJKvLapUC+aaZOkr42wGfSIxCUztsQEuciq9neNYInPgsJ0xjl7z1MlFZJ67XClGZ/EpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgNeFsJ5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1209113e87.1
        for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250904; x=1761855704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kL73NZxCKZV/Vxcl52xdrdbzC56KEpGIIaj0Zz2QuQ=;
        b=MgNeFsJ5mDS9hgqPEiHM8XZohT68JrGOR6rFST7m/O/hjr7MLmKNYBxk7shgAbK0y2
         Fi2/gATE3hJS+B1qphOCTk2LbCsO0Fqcs85WmMKUX02yxgvrhyAgu+eHRGgQkoQkdlr0
         bcnXKC/+74+S8ITaAjtcCyR1d8Mx3xUaR/Bulyn7xPKDFCPwo+TsWpVH8Jb3L+K7lxou
         H0XYAjXlkneoUcex8pM1GGH75jwkvsKH9aSLSR/nCG8CWV3N4Xs8BKqqAIfZ6R52e8TD
         CpC3CDoyhtfxkDLoumoeVpChIMGJrqAWXjrGuiWv4jxSgQ17LfJPP/0aLsdQBC6LvOZT
         v+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250904; x=1761855704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kL73NZxCKZV/Vxcl52xdrdbzC56KEpGIIaj0Zz2QuQ=;
        b=wvuknmLsBG13WtjZfopzHYgjl5I01Ji9y/lw4wUZcSqcuGN+8nsjVs6jX3VhZHJRmJ
         kT5NI2z6U8RxhPHc8Cu8mqSAxt6zDs4SwiyNfx51Tz4KWmNaFMNDCtNY0gV0XKS9+SWt
         3Evabc5kAgVfZmNXeEvkXze3bkz5f87h5y7FWDhi7V5aVQnVpuEiOJXM9FNAzc1pkh1q
         Ujm8Eqkc9d8+hwlbi1yu2ptviKzQ0qnIRtk4FNMg/pnCmefQ9789y7O+HHoICtOfcBG/
         MJIi3M2IzZ9OEnu7gkOCYjzZEZRAvobcVrjbV6F01sG+9PVSOx6tFhU/ecAmfTYHE19W
         blRA==
X-Forwarded-Encrypted: i=1; AJvYcCVp8a7hJnbgHk2MDOZvNIm7qyWQiiwIfgNZ5CHpE+uWt5t8Kc6HUdBQVKu/JFU294OYJTQPhGvAJHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xmHZ3xUSdMqszfxEL/hgjWOQUobl31qWdOy6fNgE5GOJPbqb
	uk2ac0z6iEk2zhuwgMtjuhvfGX1AijfVM2HOfLQoizlgFS0teG+fScIS
X-Gm-Gg: ASbGnctwXkvdMo4FwvgTisyoekl3KVxGqI93G2wtJ56pAxbzYfGG6vT+X0Qn4XfH/04
	aS14/pww2R79KNMtAUHGPFUv+LqVHrj0RzDk6SR60SlOLiPaWb1Np+Ce7VTbhsh/rWY6j5MAw9g
	klpk2HNwchOa5cWFClJiXrfmAM/Wee8FZjFfiYrz+rmvfF6gP8zMQ4O6Hw/IKjSjxMx1tHMwWh+
	WCTRFYFejbpPrbunyfykPPBz3GlgFZQKaiZhlaoQjWbSrO5qQlogRNE6PDghkoCXmcRENnJKMEx
	tJDvg2swx9AClmjRKzM4Aala3FQxa4BfBpYVKVSrnUbStmb9TrI3swEOTepdQBfRSv4h35xBv3P
	WBnTC/QvMYxIuRoLb6xQgk73lW4PJfn9VNymyxhCuIoaO77C6LqhJYB4L/wqTfocw+bz8SryCyI
	y1iegwpeelaxLCF19KNodXpFXJdGhz5ht3WAcJ+FE=
X-Google-Smtp-Source: AGHT+IFTmBTr6oLYnlbZQcvona8DC7BiSktyWlirSoHiBOhCLaOcy5aDyxlYtINFoyEba3yb5UlPpQ==
X-Received: by 2002:a05:6512:2246:b0:592:fae7:52da with SMTP id 2adb3069b0e04-592fae7531fmr311361e87.42.1761250903821;
        Thu, 23 Oct 2025 13:21:43 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2cf30sm977522e87.97.2025.10.23.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:21:43 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	dan.carpenter@linaro.org,
	Eugeniy.Paltsev@synopsys.com,
	a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 0/3] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Thu, 23 Oct 2025 23:21:30 +0300
Message-ID: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers and reviewers,

This patch series improves the dw-axi-dmac driver in two areas:

Patch 1 simplifies the power management code by using modern kernel
macros and removing redundant wrapper functions, making the code more
maintainable and aligned with current kernel practices.

Patch 2 adds proper reset control support to ensure reliable
initialization and power management, handling resets during probe,
remove, and suspend/resume operations.

For debugging, I used dev_info from the suspend/resume functions.
Before pushing, I removed dev_info from the driver.

Suspend:
echo 0 > /sys/module/printk/parameters/console_suspend
echo mem > /sys/power/state
...
[  195.339311] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
[  195.350274] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
[  195.361223] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
...

Resume:
...
[  200.669945] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
[  200.680975] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
[  200.692108] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
...

Patch 3 resolves the following smatch warnings:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1237 dma_chan_pause() warn: inconsistent indenting
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1284 axi_chan_resume() warn: inconsistent indenting

To check the fix of the warnings:
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) C=2 \
    CHECK="../smatch/smatch -p=kernel" \
    drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.o

--
Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251012100002.2959213-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * https://lore.kernel.org/all/20251013150234.3200627-1-a.shimko.dev@gmail.com/T/#u
  v3:
    * https://lore.kernel.org/all/20251016154627.175796-1-a.shimko.dev@gmail.com/T/#t
  v4:
    * https://lore.kernel.org/all/20251017102950.206443-1-a.shimko.dev@gmail.com/T/#t
  v5:
    * Fix smatch warnings about inconsistent indentation in dma_chan_pause()
    and axi_chan_resume() functions.

Artem Shimko (3):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support
  dmaengine: dw-axi-dmac: fix inconsistent indentation in pause/resume
    functions

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 90 +++++++++++--------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 52 insertions(+), 39 deletions(-)

-- 
2.43.0


