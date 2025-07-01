Return-Path: <dmaengine+bounces-5699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A8AEEDD5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 07:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5411A16D5F7
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9B23F28D;
	Tue,  1 Jul 2025 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="BTD18JZG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4223AB87
	for <dmaengine@vger.kernel.org>; Tue,  1 Jul 2025 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348299; cv=none; b=q4iGEOIQocnuyZg+teb9Z9DNMznuCE262zrhTvzQdC20ydmG6eyF/pZFrOtCGY6mhm2GqCCe7Q809xXn6n6tnVkC1BoozVql3BbbgZGKfG+RohoAoefwiHG9e3ERZEydT8z0/CsQREzNyZVPs1MdrIN3JfoK65UpP8Y/xXZ51b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348299; c=relaxed/simple;
	bh=fKfOf8gVMMFphhh/Km20vvANfTe32lWbtdBJasF0Orc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERZn410Lko8m2sAypyKkb/8IkdgMmUZOCazSwzFqspNejZUGZQKZ87LDWD5sDuPXjANKReBQWAjrqYBo1rm2KKEXCr4cOP6o04hG6j7C7B/1/KIj/M13rlWx7KB/2EM0IVkbkeBkFAs2gFyncKtqNAfjzNm6AV+g21qJvBGH+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=BTD18JZG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ea292956so25137335ad.1
        for <dmaengine@vger.kernel.org>; Mon, 30 Jun 2025 22:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1751348297; x=1751953097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBY768blUCx3GgOj3PZ2sE3UTLG71MWHW7v9NvluTM0=;
        b=BTD18JZGfdzXvMoFzXLrdIzpONCOMi3K7y7s/56UWpDomNDx88Z18Yps+OpMLOQc+O
         sdnh+E3pV9ZP/vyQEr1NRJ/8GdAKHMZiP31xZbShe9qps4i6UXKXLrtXpZ4MsrStLURl
         BFXPIx457kUtv0HP5dEChO+3cZs/eq5XvWjouW2bh+c2gNAWxS9FEouteRoCmdSnoK04
         I6HDy8PkZ+c4PWkRWtQJFY09/odZ8p2K0OjUQ6Ql00dnUc0DJ1afaSHHliHVvaudo8JF
         GMW040xMzmlflt+VH8Q3BssZ5XCbwBnEc7kqdl90Pn7WCoqYv7O5KK2kj9jIFyZqfH2J
         wRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751348297; x=1751953097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBY768blUCx3GgOj3PZ2sE3UTLG71MWHW7v9NvluTM0=;
        b=ZKJmGGZijWmCQbQXn4++Mv5wX18eepJ4aLtVZTe91UWjsBu4Beu4F+o3wAXXiILJs7
         /cuVB6oVLVxrSFK7uchu64bthctb1nThRiGLJ43fiA9VY5Y9zVI4wPE4htTbs9btglQD
         uL/M105wFgNdewaHdSBnV4ltzUZgMrtnpoq8Aen9eYcAZ1Uw3n+Z+KSzf6PT76DAmBOE
         GBQKoUflifDWyGENnPzuByKvnslHAuU/2f2gdOsNkm2Lx7oG8CjdI/hEI8jHeQI9LE20
         8KKZ3uyAe8wUwGDbqN7h+PtxyJ5vPxI+iBf9981IzmvGXIz1UtqJhn20XgV98xA3NBNG
         ZrBw==
X-Forwarded-Encrypted: i=1; AJvYcCWSrXesvBZQbPVD/6XgoVeOqlboh1yPlPuwp4tFgClmfe6uQ1LYm2Yz641iKiz1Tn0h40k40oIfxD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyhz46iUpDocPLZMVbdkLFW5lklTRn8YgKJIubEbdbIKPGR+6
	B8+gucwcuPYKPcZGP4OEbhTm0cSADFch2Wt1sLgGaIytQaggbaH6E2Qb0OI1dlUU8hs=
X-Gm-Gg: ASbGnctqPu5nxSumRIOuMFuL7Q9jFzCCQgLBoWy8SqLGal7ykTJMZnhs2Ih7PKAQmrr
	pB1zjKvAHX8JHJYZhAVaIT7QZgwanwoisZCLznxW2B8KQ3Ccfk2jlm5R1h34R2stTeSf/gP12Sl
	CjbeVO/PdKqYy6Oo0TtyQDRfyfNdMF4QFbDMVNtA9bE7LSnhUKA5eqPvTrWfKow10jxtJxCCmxK
	5WA9JtBInt3TGdMY0CBPVP924QS1uisBm0Q9D9T8ppQqADUH6EEVTFSyOye7tTMRAGeisbuoqKk
	/TVJ7ohHRnCbD4Jm+12DthwQyK2XIk2G3FrjMys=
X-Google-Smtp-Source: AGHT+IHwDteRU6Yz8aP+7dgjVpXAB0rA+2JkOitsu+96XwoftfjHHSIxcqXxmNoS+PXV1A0eJAitSg==
X-Received: by 2002:a17:902:d603:b0:234:8c64:7885 with SMTP id d9443c01a7336-23ac48b6862mr236842415ad.53.1751348297431;
        Mon, 30 Jun 2025 22:38:17 -0700 (PDT)
Received: from [127.0.1.1] ([2403:2c80:6::3092])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf5fsm101729865ad.115.2025.06.30.22.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:38:17 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 01 Jul 2025 13:37:01 +0800
Subject: [PATCH v2 7/8] riscv: dts: spacemit: Enable PDMA0 on Banana Pi F3
 and Milkv Jupiter
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-working_dma_0701_v2-v2-7-ab6ee9171d26@riscstar.com>
References: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
In-Reply-To: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Enable the PDMA0 on the SpacemiT K1-based Banana Pi F3 and Milkv Jupiter
boards by setting its status to "okay".

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: added pdma0 enablement on Milkv Jupiter
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts   | 4 ++++
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012fe56d42ac8a7efdbbdb694f31b6..39133450e07f2cb9cb2247dc0284851f8c55031b 100644
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
diff --git a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
index 4483192141049caa201c093fb206b6134a064f42..afb88ddf36eb8e5e3bf74fa29f9bc006e45814e7 100644
--- a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
@@ -25,3 +25,7 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&pdma0 {
+	status = "okay";
+};

-- 
2.43.0


