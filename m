Return-Path: <dmaengine+bounces-5359-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E7AD5652
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FC41E0ECE
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876DB2836B5;
	Wed, 11 Jun 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="oXcs3sLQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71527D782
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646838; cv=none; b=eZG/DtJwOZObUlKsm1QdC9sUS4EJTWR7UdFvVbCVExw8Tz9ST+q6Fpf8brKapf1kOMdNJQ3ffLLU5vb5JQhBxSiL87VAKSH4e10oYcpUROHXUWjCEq5+THcwiSOZcfJEkrP03ighDjSJP1h3HWsub+RORQ41xeQFEisvQXPow3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646838; c=relaxed/simple;
	bh=Y/UVoA63Ub/h5tAaXT2Oci9EF/b7F5JY0JZpRJfHkVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi9VJopgUfgNVOPxNf9FDO/gZIu3zGu0a6LkVuZ4TLoHfa7MyQvmXPmWyShx82T8OBKGTLHn/BoKZtZr2KHqjpYQueUR8DKdgb1fEKwdWg+r2rlsLsg+eh/W5W+ADp0GzC1IzaPHkeGS7y7mjtTgDuuN0NDE03kva3RvHV1e05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=oXcs3sLQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2349f096605so79112675ad.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646835; x=1750251635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QndPkvYOfHZnlmLnlurnlWYXTuNHVByXqbm2h3XNBdM=;
        b=oXcs3sLQgxY/5I62qvtj8fnj6WT/YTb5sqJ2liafAM+1KOYQjimlZEWo+ogrgrCiEg
         ImzEEhuZkPRJ9BHoT02UFoM1Ot8KeOvQpiRKhNKaJ6oNgEe6T3wEOAU+utVTd5YRV31W
         r2t1lA7UVzBhyiHyDpcqnSc/Cwodibeo/ATWceagaq0uMu8PA7mQtWEpEOdZa/ji1xeO
         i/XmSO3lylDCvwHu9bkkNFvCpxa3veTcfnb8S7SF5l6GEdkhAQmf0zrfsbt4JWTr+sMJ
         fz6v1GT4R2Ieb9/UZ5WjlUZEQjYNu78F2YjAPmJ7lCEkl38UymNQfkofdC9l+0l9dtBp
         xp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646835; x=1750251635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QndPkvYOfHZnlmLnlurnlWYXTuNHVByXqbm2h3XNBdM=;
        b=EL/rs426lWV6W9yxUkTLs3t78FjCCkWozmd31+4uczpH/92lFiPOL0oejpQNu/OWh8
         INv/Jzq8M5OI151nigem0fIiRiTKSqdg3x4ao6DOjrwqnOQFvXU51t2kI2aRAq1JLtZs
         SLqI91oar3IlbHCmFtR45gR6tsqEmZkWy817Lo9sjPrDYjSeIKM5sPkfpEQ/E77/M4F+
         xdyyXaszF7A20DTqpw5fqauZB1uR412x+NOKok5ExkQ5TeBEsZUbdJeKvVbWu+IbMVQm
         NS71JZWx6E++tAauHtjsKeSWgbmLU0ar3w+8dwown6I7I2lOVZFsu8YuE0XifViwSu2i
         IBGw==
X-Forwarded-Encrypted: i=1; AJvYcCU+KprcqayjgCDISs9xhPzvOB7MGw26LYq/1W9GZZ/QTHMf6blqYiDXy4yZYwAOIFYshXfEMJORyWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+wO+SDCSkAJIVF+pJ4UanTRtvVsy+sQF80fKUPc8NRQX9l3t
	kF1Qg17sYmSBIYhWW7kLoE/S4WmEUzshci20Og5hjLKsda9gM+WFT8NKVN5bsXCHexM=
X-Gm-Gg: ASbGnctvM4fMQ4qTKnkSdsyT0761oHgRgOFsne/fJ/3Cu2BjJgiRcSdPyK9ujXv9R3T
	aP8xF/c/llUpCCvneAKwzFbcRt5UJN6I5bb14FAzVUPwRmBssu7td2Dia2KWwomVD5PZREN/iXA
	nu3i/4AX8DZA08OIulnpqJ/moTFscy+Qn/cBjJXKX4hiVgvQ10TurNvhjX30KQfPh1WHOhDsesW
	eOqJf/GGv88M5Bhz5sS5YtR36UTas0E+QPI1JJXkq81ZJDBZYq2q2a75sU7xLdMgEuFu+SCaHi2
	0PfavrMdpan5Vh6xgL/FBPga0FncVjsDaFz2gxecM73ihDLAG3thMiZlPlp6krqhl+26C+sFaaV
	VuX0+MbEsAOyPIXcesOv7Zo9UYvBjXHyT
X-Google-Smtp-Source: AGHT+IE0KPlnWtgzReoKrdu9Pb1wUUDfgiReHhnIgJSTpMfI8WW3eLySP02w8+TUc5Yxq8BHiDxUbA==
X-Received: by 2002:a17:902:d547:b0:235:ea29:28e9 with SMTP id d9443c01a7336-23641b15570mr50780235ad.38.1749646835028;
        Wed, 11 Jun 2025 06:00:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:00:34 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 6/8] riscv: dts: spacemit: Enable PDMA0 controller on Banana Pi F3
Date: Wed, 11 Jun 2025 20:57:21 +0800
Message-ID: <20250611125723.181711-7-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611125723.181711-1-guodong@riscstar.com>
References: <20250611125723.181711-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the Peripheral DMA controller (PDMA0) on the SpacemiT K1-based
Banana Pi F3 board by setting its status to "okay". This board-specific
configuration activates the PDMA controller defined in the SoC's base
device tree.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2363f0e65724..115222c065ab 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -45,3 +45,7 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&pdma0 {
+	status = "okay";
+};
-- 
2.43.0


