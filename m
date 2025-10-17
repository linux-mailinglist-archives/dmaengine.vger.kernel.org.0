Return-Path: <dmaengine+bounces-6878-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8BBE8119
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 12:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D7854ED2DB
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603C311C1F;
	Fri, 17 Oct 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gavs/aOc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F429BDB1
	for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697001; cv=none; b=gipzc1rIXne8ktdxgS7K2SSH3MVasZLu4K8AQqeha+q80mBYonW3QdqAzDv2e1DU7BD4D2IUJ/RNm6fJOhUMXHvSrk9pecncz/j5F4FImqaD6yAVCEzXdhTV1qwnoubMSXUXapT0mEmUaqfLhJ7eURnzIN6MB07uWT8x8PVDtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697001; c=relaxed/simple;
	bh=bFzBxCYSLJLC2MX2D/+1wvpsD2+zTvyLj1zRe/3pI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmFk+3bDc5PE/LviviXKgsoHUVPkzmYeAK2HjE1bi0SGn6gyfi0Qv87PTFyXQ35AL9GswtM7TLZbggPdvnoF6SauWWPV32K1VL+sAYgIkKo05Uj/eu/yp/tT20D1G/8qU36gnR60XRP5mYwiSu0p3UMCAJThxO69WQNq+dbkegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gavs/aOc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3c2db014easo389031466b.0
        for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760696998; x=1761301798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqvm+FvUGGdtRylrUSb6iKBuvJCIycpT57JXF4tXRWc=;
        b=gavs/aOcok0WY5orXnHMHR+cleSjgXPykIdUWrMHmBX1pTfwgJ6ceTB1F73CI6u10P
         RzjE/eGGWnNUo/owF2ejwG5KUeX3vsSIOQ6+2IfYCwTprt5ocLf82IH2wlnuxQOBguSQ
         DxUrX7WvjHtdb9D3IT0AsuhkF0gdxrRQEDVp2qQ7DXUHdQGd5MQvKuJEg2fZOrCITRFF
         hnkZpXrjxAX3G2XlENfzSAzdE6toj/XODldcACb4cuicsQMJbnBekcammz7G57critoj
         IbhV3kRAbJMS47pHHp31giZYmYoNhE4p1cZHJN9HsJ2KyH2vkmMn6cHYKayvgyijlT6g
         cfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696998; x=1761301798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cqvm+FvUGGdtRylrUSb6iKBuvJCIycpT57JXF4tXRWc=;
        b=Ck7QQsrMmvEvLrqcp2cy+IWXpofCkGSnaMIKtifLN5tL03Q+YC9Y7FRrLljOdVvsr6
         OoioTEQN7EidLPGLxFdeiWAsw/mfkjZ4h0xbQUuJCXUpnmUhSDZv8IfKJX9wLF9hNGWF
         yGqYwJktGOXN1ur8LCFpizN9fdGNF+OYugleKGIoqRIUAsiIy7743XehAhzyTpzNgLUu
         2PSTSwRq9cOM0HSVn/n6NEJf8zLwIEFj1ZrSyDUJDhf4ae1tbV3PJZd1UpW0i60kSJ+7
         xSvRoE+ADMElNfy0GeGKD/dC4+vIjE18ZS/kefZHkB5MQF0ScNFsB0V1n40XP6zXefMO
         Jllg==
X-Forwarded-Encrypted: i=1; AJvYcCWJJpGHUSBbmS/8OxCBrOCYcw1SS7NC2q9JRCIKglcPX8oJ544a8DmSf0oTcPCDIHdyPEIOySi7SjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ywA4594NcAcv4LNQcubdzaT0/qgqcsi83WN3XD0jyWuZ4TyM
	K7UvZWuN/QG81mz8o9TZxrzd7fbcr/6VlnTfPbCyOHsmGYXRrVHa9VRng+DK/1qVkPQ=
X-Gm-Gg: ASbGncuwLkSSg7Fgm9z+ytE/QIN/scbI9/NCN3IgGGQ+gYAxsbVhegWLjdds1Q3Flqv
	jzbMxcAGhaiSlfi/SKF+VpZekp65g9AYuGFz439CFAi2dqIOCKZOW4LQwO/5WiAcD1PJyNeGBve
	pZEb5TVG9VP9RgXEZvgFkszEM0S5ARlEYjVISC4i0KLM77boWwAYt/7yzgZkEPzsxwLBzZ+R8dp
	u+3tvC/MtZxkvozoj0w4QmIivdWsj5tAhtnBSb4lVvua4XQyoF8xnVbJFxp+yAYaeowav5kTBUX
	CT78NHGLWfEWxKn25Qv8YR3VxaFy9fWNOXMiamdBoyhmVk5/r+7SpRXLV1k78zqe8OytavG9w3U
	ULGM0F97qivOcleluRSMnAB9o2VMuIycGZP7DWrdaYhm0csSsv9aAVOG8Wd5SAEFZ42YofqMlTG
	fTrLaVMNRETIRsrSbc
X-Google-Smtp-Source: AGHT+IHhRfymyE7H7W9XmHZdTf7jW9emSkbTcMJSr3rPCnTSzRknlKYAgBM44E0dPLSJ7+01KB9GgQ==
X-Received: by 2002:a17:907:94c3:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b6472b60410mr328553266b.4.1760696998502;
        Fri, 17 Oct 2025 03:29:58 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm780513166b.43.2025.10.17.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:29:58 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy.Paltsev@synopsys.com,
	Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 0/2] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Fri, 17 Oct 2025 13:29:47 +0300
Message-ID: <20251017102950.206443-1-a.shimko.dev@gmail.com>
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
    * Add error handling for reset_control_deassert() functions
    * Add error log for reset_control_assert() function in suspend

Artem Shimko (2):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 81 ++++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.43.0


