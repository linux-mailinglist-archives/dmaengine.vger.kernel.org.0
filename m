Return-Path: <dmaengine+bounces-7614-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E40CBC172
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 23:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12ED53008567
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1CD2BDC05;
	Sun, 14 Dec 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBJHfYhS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5F270575
	for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752436; cv=none; b=PaiuG6Kao2VKKKXlfDEE1+rW7oiluZtgyJWX3b6iVZdQimDe8tqCFb8Euelqtb7sZh5BBElX379zpmvZWrbGit17qx4pwh+CUZ3LPTY1gfUcOaUvGENzeLRpgJuHKy7xLa9GziDjc0TsYJ8pY6qyUx7B2gKv1ET75IQ7vIhH6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752436; c=relaxed/simple;
	bh=9q5/APX87RGgYmhMNh/WDYwQpX7HX4MP+fy+fzWDQzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q41CBceXsW1VJauKs/w8i7l7CrvM/M9/pN4ZO0cNVvav+gV0z3Y3fiXnJMugCeguOnJSZGkfNBNru4DGp/9lSu6BOtgqUHJIkeHOtWfLpxsQK68nR9ddi0MH8Xm0UmjL6dpvMY4+SueMyLi/TRld3FQT8xvYZTUkjFd9Ike3/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBJHfYhS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0a95200e8so7783615ad.0
        for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 14:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765752434; x=1766357234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDRFsyvQwwFF2ebD1NnNsyQGvhsS9i0D0wecAIBs+ow=;
        b=WBJHfYhScueo0Ftt0iI2I875LYaSlMLZH7xJUQoUrZz/EObezqRr5Gl4eMV5ODmFpY
         36TXwHUvqIGQzCzSodl86whdSsm9p9K4h+HhlCsJ43qwXu4AzwsYte9wlCpWPSPM8Boe
         xAgttzDQIxhjbKmR88fetT4fQKecKlwVyut4G0r/kBRjeRquedPner1Vm3vgZDJJFALy
         tECfyk/Iq0mg8KURS0g2wYDW173P+9nxYsRNHUvKLXCfjQnDfZDLamj9dPE85FwxbshG
         73SBwSVsTQf6VccjfkoxzCYE2XJNQURVY2Jw9mPIFOr4Y/HPaP6nSumRSiEy/sX8NduM
         IEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765752434; x=1766357234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDRFsyvQwwFF2ebD1NnNsyQGvhsS9i0D0wecAIBs+ow=;
        b=rw9v5uL7m6ZmrbZqsmYmwb8F43kCO39redmOqbaelejlOQbNYqkxl5KT1PGpg9UuFn
         b9n2LPOS9lELoEbnWecZ1yKROI5DNLdVcAxh/L6LHTf+ejSlsauwVjL5u0Rj8MMppESm
         94/CYjwIxMHdP9hN53INOWZxBdByHjt62XZDq2ZvV+l+/BELxKtNYFZzBEGXNUtCjTL0
         1layxxuwTE47opSXs179ZY5zCwHMpcdVUdHz40idRDtCxET4XEVFG2vSmNt6bjbur75X
         pkpvPSyRJkLU2LiNVBUkHZ08x9vnvstmEpK32JZ8Me1p9iyiMudso3/2p3x3AVr9P7oZ
         Ty3A==
X-Forwarded-Encrypted: i=1; AJvYcCUv31M10sKw4eJufi3YlyA7jnIblAHfar6sDVA1OJl1ljQaqBbdUj772wUkJ/U3GOCyHtXChURQV40=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5WyHVLId2B37+OJOVD/FTdMIfwoLt1U088GgOk67qd8D3rxU
	s5hFRBCfIg/wkOqEtIU1S6oX5pTCgNyQWy1IUj/ftKadR5m5qcKhZAgs
X-Gm-Gg: AY/fxX5z85KBqFV1Qa2uZ/I5EhLe7q5QMt4/uaM592/eclq0nf+elSdpp0LPRnywNw2
	0X1cW+ebFDIFXdt6V4T7f4fYjGiRxNUZKdF0kgz0/I9x17k5cnL0jTMS/uRB9miYQnLhbaEXJaT
	II3PsyEIJMPtBoHA8b6iG1ZV7+s0YhJYrcFQvNL6mrUs46oKv/RTvHtn7f86zIyF8BoURfBkFuf
	q3mCujzamWClqWHXuzVtnFBX+3TMm+mciV0DdSGQvBMYWUjrK5NpPWRGGgj1w2m+UNm4Ypii885
	9k7lbdf8dV8zxNnU0lZLfrC/0n04EYxW3c393qBFWNJdACiYol0pBlq4gPGx3XCuF3zUS3edwpk
	TaR2rSYRo5EpJAlMzT715d7GzflMVuZArqJ7JxaCY1+BEvR8h6DRf9pRepdpV59ksny6j2SNRo+
	xTGPEcMUkGOQ==
X-Google-Smtp-Source: AGHT+IHY+I6N505J8tBBxCiWTM4hXbMHovgZ3qawJ/YmUXRO/axk7y7nKaNrWFiQXdKScyMIfR120Q==
X-Received: by 2002:a05:7022:6184:b0:11b:8f3a:3e07 with SMTP id a92af1059eb24-11f34bee60emr7877296c88.11.1765752434409;
        Sun, 14 Dec 2025 14:47:14 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffac2sm39963363c88.11.2025.12.14.14.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:47:14 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 3/3] riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel number for DMA controller
Date: Mon, 15 Dec 2025 06:46:00 +0800
Message-ID: <20251214224601.598358-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214224601.598358-1-inochiama@gmail.com>
References: <20251214224601.598358-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the DMA controller compatible to the sophgo,cv1800b-axi-dma,
which supports setting DMA channel number in DMA phandle args.

Fixes: 514951a81a5e ("riscv: dts: sophgo: cv18xx: add DMA controller")
Reported-by: Anton D. Stavinskii <stavinsky@gmail.com>
Closes: https://github.com/sophgo/linux/issues/9
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 1b2b1969a648..e1b515b46466 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -417,7 +417,7 @@ sdhci1: mmc@4320000 {
 		};
 
 		dmac: dma-controller@4330000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "sophgo,cv1800b-axi-dma";
 			reg = <0x04330000 0x1000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(13) IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk CLK_SDMA_AXI>, <&clk CLK_SDMA_AXI>;
-- 
2.52.0


