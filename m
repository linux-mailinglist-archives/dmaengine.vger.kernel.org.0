Return-Path: <dmaengine+bounces-8387-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC5D3BCFC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 02:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5D8301E925
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A723A9BD;
	Tue, 20 Jan 2026 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFeun80R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4032AD0C
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873037; cv=none; b=VvPpeF2hhfwJNzPLxHVR6BFNB2aqAjJuDqS2RoxaN/A41/94lTIvixxv1Zl4J45a7HbBfKD6HEfH2sf8LMPS27/2uiTW8R3V7IwIa96qi31rB76U9+Qdr0yZy4fFQKnNIpvXTy/idOVQzlsIzbmy74/Ppc0I8l8K5X0ztoj6k1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873037; c=relaxed/simple;
	bh=zUN0mZoREK/NAS65dk2j9AeP7QPIja1OctRxEL4Ohek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQQR6cQKn6C6RUAQU6ZO1sq6chx1LCOp/5fEYMnxPZopIHF1E2YEUVTRlqu0+uTRwitZcCdtu/e05Vu+YxvPIw4gIu9bcsV6TVJhV44aT8doH239egcR3M7u85CvNTRI/Qr7bX1wDuFJK+L5GFrGddqZ9Mr02CYPWCh205fuVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFeun80R; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so224730eec.1
        for <dmaengine@vger.kernel.org>; Mon, 19 Jan 2026 17:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873036; x=1769477836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBib4TZsFS9AcrU1FokovNxktrga1IgUe5Nw342C6rE=;
        b=aFeun80RtuMDdxwmBcSNlYAwe0V3jxgj5wOYnTEg05LnexJjX+j2onQEMgwk6yS3Z9
         p5rpY7e+kOE9cqNdhM/SBQg/tLLGcD/gVbMtbImYRyS6gp8tbpluSpLSjDD705arByr7
         rlQ5qhbViAnHh0XNuXhffEq/pD4WYJUpyQWEzY9wBlS64kMJKH410OB6pROlC1qaRG5B
         yyeDQTnEVO0qyTqovi3IxVK8JzGtJKZPL5Gxi5ulvvrbCf1X8oC8r2khHcArqjTCyy/N
         z+O3XZkWwOWWzG50Vr833TG3EnCbodzoMaG5ACyYYzztGuOsKNanrJGHgrvYvxuMJ/uQ
         BOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873036; x=1769477836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBib4TZsFS9AcrU1FokovNxktrga1IgUe5Nw342C6rE=;
        b=lSUF9p7f8eDyZ6C5YrJomXI7rM/DSpFhKBgxqN5QlrDSKwP0xqrU3bPXP77dJzSqoC
         n2QsFR0sH4BZAUj2tCJNO4hq60fHnB32AyPNgXe6k+OAnFql25ZE4nMqrrWwvLv7s1sh
         X4t071EPTuAgpZTwewFiQTwaQRRBcLpnt4oxjv0Tco3OE5X5uW0+EXddUTu+xt8wYCyW
         vy+B8JXBVeMZKfytIGnFrf2uO8lsO5eIycXG3aXiHblpLT4JTE+OFRVoqI3uJ06bdZU9
         X04PPHim5JZXckLnzLVOErWK57WfWC61UIJfgd5kOj653DPB0t+DuPD0oWi+DuqtyVg6
         csWA==
X-Gm-Message-State: AOJu0YxYSCUdDboayT81Mj0yUmms95lzvRZ8N/zgAOd/lK0mlzD7qZWE
	kM6KCbguZ+ygKfUUUTrq2kQ1q61jo0dSDWy+zwOZ6aFF04HrflKgMXbI
X-Gm-Gg: AZuq6aLjyixha91NqY7fU7FUvjx88vqqU4KoCxmmZw4oiUeBkSOlg4bLcTWk1Yqk+3r
	5BwSJKfVkr+p5vK8EdHalE3wqpi0iFYMNujEQ2oUoynrfpDYJ0SdO4TyvozoK0WW6UbmtsKgHUf
	WFMleFPXpHeFPOcnnkAkQZbnB2xNf2Q5ljpiq6mBWpg7FOog7daPUqxv7FWBAplI0H7Bp63C4mL
	Q4ZcjEzrMQqiy1lnkoJqDwa9Oa38ATgphceEx4/dkvnX+XJMh7VG/VohQmIMGygxd/YDzB7vRlO
	rayrz41DHNzk0bpjAJKxP1hZbt0mVTW+WxUP1/pHxhKr1p3r0k/fjY/sJXGnxgfeEJhgooMehcQ
	Epf5EUMMZiOD10C0uBRCmYJ3DAoxjcivKRsAesibbl8jmZlfFydmeDElAKs5qKDg5yX/RCLE+r5
	QMDmShYxgLOQ==
X-Received: by 2002:a05:7300:3b1a:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2b6b3f1d5eamr8624180eec.1.1768873035879;
        Mon, 19 Jan 2026 17:37:15 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6bd8e7cd9sm14199031eec.16.2026.01.19.17.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:37:15 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 0/3] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Tue, 20 Jan 2026 09:37:02 +0800
Message-ID: <20260120013706.436742-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Change the DMA phandle args parsing logic so it can use handshake
number as channel number if necessary.

Change from v2:
- https://lore.kernel.org/all/20251214224601.598358-1-inochiama@gmail.com/
1. patch 2: rename "AXI_DMA_FLAG_HANDSHAKE_AS_CHAN" to "ARG0_AS_CHAN"

Change from v1:
- https://lore.kernel.org/all/20251212020504.915616-1-inochiama@gmail.com/
1. rebase to v6.19-rc1
2. patch 1: remove a comment placed in wrong place.
3. patch 2: fix typo in comments.
4. patch 2: initialize chan as NULL in dw_axi_dma_of_xlate.

Inochi Amaoto (3):
  dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
  dmaengine: dw-axi-dmac: Add support for CV1800B DMA
  riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
    number for DMA controller

 .../bindings/dma/snps,dw-axi-dmac.yaml        |  1 +
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 24 insertions(+), 5 deletions(-)

--
2.52.0


