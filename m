Return-Path: <dmaengine+bounces-6041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EBCB27845
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EEF587C70
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 05:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322023ABAF;
	Fri, 15 Aug 2025 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="i2VTaa0H"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EB24EAB1
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235104; cv=none; b=i4cv4/SGkxXa9TtTL9IkEPfI/OFLIHNMmZPP+6cJJecy94MtW2gEeHwi9h17v5mi0+6f4DoNzizwsFRLPP/Hnk3z3u1AbBhhicPAVGTuK/nOus7dG/6MH0TytlEn9G8F9pk94o0rsGsjZvxo3kQ9giatNirkxhRZgMUH2+ogABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235104; c=relaxed/simple;
	bh=wAbS4Hm5Ej3gB5y17PgS7507wIkyUc+hhTmlBTFT2ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxe+INJEqppz8zmNeGyFOE6MxrloDjEEVP1Hxayu6Dx5XLdhV/v2FwjShkFlsYn31MF8fH0PtNEuwlO0ALM2wKB39paNjnAzIp3u17TjR+tb8x0JnCe2WZk0IORB+Hh38AJjPvgY/fl72zVoRsWjcMTVW+J4Vu4MwxsTNiBy6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=i2VTaa0H; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso1701660a91.1
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 22:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235102; x=1755839902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tu3VbVvBVdJX8NKXRo9aN8ru1kGERA/t9NfAcjD1b4=;
        b=i2VTaa0HOYYEFjOlc1pUbrQ4CacopiQIdqOko7GMSfF2UFgNyeKoRq5BwxJD0J+w+j
         Sl8ybWB6K6BEznR3cLTCilgi2wlwfQYXz18pH/0ltEQ24fbOv4xIlrDzpWkLO2DvhwNu
         w6UXfnYUVyeI6F2Btg7Clt79vLmOjaqrfFfIGnv5fvKH2g7K2xgd4UnjUEuRozIn+A04
         SPxDQA7XJuqrQSWks40O0j/EtSvItnMfW3W05x4B2IhIfJHgCCS3dtZAyVEOKgT7hWeM
         eZ2I3xsr/3WA6d7a81Ce1E+jOhgBcQCN13RzuTyRlkCB5oDoVYH1p0mtc40d7muOyEq3
         2KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235102; x=1755839902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tu3VbVvBVdJX8NKXRo9aN8ru1kGERA/t9NfAcjD1b4=;
        b=cgamAhUmt9E+hiCMruVijHsNOLLX64KoYpN/kz/UrAV1XgfONWM+iBB4r2VM9OS6HE
         hDaV3UCpeWrgbfJd+Y9P+iu27XkklKpO4WIdiOIU2Q3EfubcxuLgT7f/YA7nCCRi/fBS
         xv2zYim0fg4ar0jWzJUdVUZduGTz/0VDX0A5gbi0m54vLpRkQwzU/GoD/MsM5bILSpLm
         eJYFTM+/FcSEk7CJQ9ocWnr/YTaYa3vVqZ8SlW7OOF9oq7rQEaQE02Y3h6LlcIUHETc6
         0BGEzM4Z19IpLilQwrdX/VPK8cSFd4eQ1wfUEt9lMXDEzk1Pf0fFZwQDYRJC42GwznJO
         gGXA==
X-Forwarded-Encrypted: i=1; AJvYcCXvhjR/JIIUjzc8ul23q8Xn2IlA1n4nTH11FxJGl/9Pf9MpiK9yPQ4iVMutWerBqjq1eQEldfJkDpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTWPhs3/7n5P11gTCX9V1f0OZx6LR+k0tLWdh/LBfhFjIS4Lx
	ugE6GQn5TXCnX07KvUYscOMVdlQE6hB02TuZQcanSsrnRI5eNf40HmscRQBftlfdrfLJ/KSP8/r
	h1WupDRAN1A==
X-Gm-Gg: ASbGncsi8q9rCxB0VPR3e6QpmleOVwN5Ci9xiPb4vzsEUEMy1xoSfe2ltUwoQBDPAeS
	/7dofhLN8UUkXbM8Qr2/p6ULAy2zBmMOen2V2rcDUXgF854NAE8Rh05vh4bypOWWSQLKh9hC+Qc
	A/Gx0CMKZ/X1Gsrx9MJtENJyumB+wXLJv1eLtCumQVGHCGQJWBBuGmga7twNLDi63CWAIvMue4T
	KziZKlBb9Rmm3r3qzdMYIOE419lyk8/QuQyxCYPB9p2RGoICi5Gv8DJd3W2t1HydGalfi4vy8Ox
	OalG8quoOsaboyn6YOmOXCb8lwSUPKPQxQLTuDnrwVZHcEBZAiMNDWuLAMiFG4xXe+bbdqE09oc
	3zYKLpasT/PbvxoyATxlk8w==
X-Google-Smtp-Source: AGHT+IFDtHgfFvQxxm6fxEwWXi9awBBZD5Ua19+tFUlmmEm3vFbmRHegYSTVwFsXKmUcUeczaz7/jA==
X-Received: by 2002:a17:90a:c10e:b0:321:2b89:958b with SMTP id 98e67ed59e1d1-3233f0c1a4bmr1740600a91.0.1755235102576;
        Thu, 14 Aug 2025 22:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:18:22 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:29 +0800
Subject: [PATCH v4 7/8] riscv: dts: spacemit: Enable PDMA on Banana Pi F3
 and Milkv Jupiter
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-7-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Enable the PDMA on the SpacemiT K1-based Banana Pi F3 and Milkv Jupiter
boards by setting its status to "okay".

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: rename the node from pdma0 to pdma
v3: adjust pdma0 position, ordering by name alphabetic
v2: added pdma0 enablement on Milkv Jupiter
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts   | 4 ++++
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012fe56d42ac8a7efdbbdb694f31b6..6013be25854283a95e630098c1fde55e33e08018 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -40,6 +40,10 @@ &emmc {
 	status = "okay";
 };
 
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
index 4483192141049caa201c093fb206b6134a064f42..c615fcadbd333adc749b758f7f814126783f87fb 100644
--- a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
@@ -20,6 +20,10 @@ chosen {
 	};
 };
 
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;

-- 
2.43.0


