Return-Path: <dmaengine+bounces-8390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2ED3BDF0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 04:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFFA04E4AE0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FAC1A238F;
	Tue, 20 Jan 2026 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdISQSpx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6F32827A
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768879748; cv=none; b=OJTbydB8TSjzRBgC/T7+m3cmqbdShfK5FzA0sjzgaRwlynoR+AquKzJIecvrykbCtSShyOJAsxVw2zbBdAegToDzrVssrEu5oM/rgxQfHqXvWgH9Qfby8mu5nRmwKgYJ6E0OlGqajoR9s6IUbmWQhPYdQK4RT6/f8xe/x8ibrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768879748; c=relaxed/simple;
	bh=TnrWvLiHpwdAR1oIsgz5dmEGTJ7Pw1ADVefNWrpsJwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLqdvTdbWvSb08vDmJK0SPe5DyQ0y34fW3X05QpmA9SPrnpuYy8wMArVyAYA44TLbmLDO9nrIc4evdYgec8Db/nUiwpFGA06yTdAe5RMFVSC+SckeF7zDZ94jc1WfuJukQNH9vQT6wciAx2u+VG+i94hQcrn2q1O/ZiLSeLVCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdISQSpx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89461ccc46eso4988756d6.2
        for <dmaengine@vger.kernel.org>; Mon, 19 Jan 2026 19:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768879744; x=1769484544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlh3awqwpSDVfosrs2ZgXu5CLF0C481abnvSQYVV+dg=;
        b=YdISQSpxC4Uvh1tbXH2Ra90LH90G1xjkZjHuxwNUbYNlZzzGU+eFvmloiepoxZJbIm
         ga8MqGoErX4zn2tcC2N6V9gn06oip0jj9BdtDypPaLNdGCnPWVL/9Aczby0jEaUDnhJG
         /eDbxQ9cmZ+YbkO5RGhcoVW0RR/eLMJAD08d1qHPncKrXbXRGin9JO/MlsLItCdDfmfw
         urAyd/C4nn5Y0IIQYs0tUfqk41a6m2ApfqMsdaI/K02bqUyttWMl9kWAWqF0Moqffhjt
         uW7glr4Y6EvmcXK9WB1SJfI8qMwcBej0nhxSC9xeQED786iUBoMeYWIbY+9IIJ96xu2V
         zN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768879744; x=1769484544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlh3awqwpSDVfosrs2ZgXu5CLF0C481abnvSQYVV+dg=;
        b=cy/EUL6sYYee1Yd1GLFB1pLTDgCJUNl3tithK4v25kWEYV2AYKB9RgGEzWsr0XJLLH
         MmmlVOkfpjniVqabfozOH6kKvWynYXQICiFMUhemOs5f8cOONzzNJ2ve9dP+pn/10eeV
         vJ67Lx5Ir9OQFGrvrYyqG2sVQcfemq6i87/VDmZKxCaxktYY/HvlIKFuhnhQYnhmKKw5
         5sFaJuldYu+XPTKs58NU7Lb8iUctD9RRvwyo0dUZST6+XSnYyyj6actVcURPgMNWj59k
         9/jqG5O/xgX9gHdHi61KZd2Ikyvn4xqSN0X3nwE21uSRu4EJ6WlY0VldtCwQy1pcABZC
         VNdA==
X-Gm-Message-State: AOJu0Yz76fSPHQFgGBEB0NFaRnEvPm5Cw2HB4D3q3rxwZSlSlfOs1w2G
	4trGGbOJra4IlpObpQjuyvO0TptVZ+SE2jNYGiNUTftsG0iUdFXG8aAmWTa7jZ7c
X-Gm-Gg: AY/fxX5P1IKC7Y/UAQi9GCeZ86LoCGTcojJWnX4KGB254XycKd7HYlOav719TogybPX
	6kk1UXrPSuGoCC8kCVlmlhzYxwmhEAc7NeAV2HwAFUPTuIJa9sC3ZbD8ovfDf/ajrs+R3eqfQS3
	DAbEt9J6AR2c9+vDlEAc7ZEQ2Uto84/+qEt5CBZCh50bUTKaVe/VM3ZtxJrVo3ke+ATCR8LbD62
	BZZ0f3URqP78DzBmgwRLiq6G5DD3axRIWk+fz3fFvXtp0SbyHOVjKGMlzre7xQYpYVpfpq9SXpc
	LznscBWgyCHkc/Si+qejHFMcnNIUGIDmwSYGSwdQYeLau8XIATceQneoUgzHCGIsbNbPxn2ES6x
	hZVV98BPTZlbKyVN5/AQqT46gy8VUNqKBAiHTRUHv+/w22HxNXJClEut/PvcNrtP1qpl6bH+DUr
	5OB7wItUkklOK7gpGJaDpN
X-Received: by 2002:a05:7300:6c89:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b6b4eaddf6mr9178898eec.36.1768873045971;
        Mon, 19 Jan 2026 17:37:25 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm15337344eec.25.2026.01.19.17.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:37:25 -0800 (PST)
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
	Yixun Lan <dlan@gentoo.org>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Subject: [PATCH v3 3/3] riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel number for DMA controller
Date: Tue, 20 Jan 2026 09:37:05 +0800
Message-ID: <20260120013706.436742-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013706.436742-1-inochiama@gmail.com>
References: <20260120013706.436742-1-inochiama@gmail.com>
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
Tested-by: Anton D. Stavinskii <stavinsky@gmail.com>
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


