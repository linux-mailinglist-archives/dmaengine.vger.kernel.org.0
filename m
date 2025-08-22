Return-Path: <dmaengine+bounces-6127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B3B30C3C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 05:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6D37B18F2
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 03:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A14272E56;
	Fri, 22 Aug 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CjEpCZY4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E822727E0
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832031; cv=none; b=RQG3q0dpVwU/io1zPk1pZAfwzis5HQF/eigfCzcspeSlrK5NM49LR6ye8HseSarYxaZp95XGcic5Zv0Ds8uI7Bv52tpnngn4niwCVDafoa0OdZxWZtxZiNqDpbZ5szpaMiLskjqx3zcb2yMKybFvSJ/GTbCTP+YVr8AJXBsHeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832031; c=relaxed/simple;
	bh=It+6CdxdN9UTL6bK8NFWI1ps3A88WSuPyJvweDqSJhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ur9XeF31c7DwtsMEsbptHtZ27RjzLsUz/VxwBC+gJtXIH2dsVE75K0nuqTUfrz/jvt4jGuclnt8O9M5ZePne3Q6rN2Ggbrnvcgx0b0grDqc9GVmPzoIUsRMR3abKLRXNmUes4kE3eIP4aFaGiW8kK2drOlmHAGn8JrSAQHUJamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CjEpCZY4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1534758b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832029; x=1756436829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBarAmiAVNczS9KrycJoO+goP9AfyIOpybp54mi0NCk=;
        b=CjEpCZY4Rp80jkkNHFA4ZwCLF0E+Uy+ASeuUw2bsiOvMzCPsVtIGoOJrzyrcU4k05Z
         mgDCDmtST8jBkVh22F8n9To9wtuW7RJ7+qpLbtXqkFpxuB9nI8nbzDhMptt/Ck5v0Yr9
         gJogcay+190yC27p55Lgrs+U4PZOLJlfpbb5gxoEES3e9uewjGPA74wHCMj1zWNd3PTH
         S3HgKHwPKstHeqyv0u/Age8PlYrxIgunQXhAgk5WyIQEdGeqyZHaEIULCuOHR+3OlApE
         954ijYlGqrWppWAO1MHwtly6bVLo7e+RA00YlLzfD2Twgh9ldHfMXhFJITU7mTZGmz/Y
         vwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832029; x=1756436829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBarAmiAVNczS9KrycJoO+goP9AfyIOpybp54mi0NCk=;
        b=hV7VYZ3TjKwl9zoDjBQFBr3lJAsoZ72lrVSie7+zoVALamlhJdoCjzI8hn4lY0eWzy
         GhsHeWWlNU/EuQQWlUtRqlo8O4DzBHKytEUZFfn9Y11IqhYtB1GyRGLT0373SGNKoGC9
         zQN2hssgZH5p9Ifv4ZmVCJN04rXfoe+Na6W4vrSv57emi+0v9MR6l76aDCIuh5iVErR9
         2ObpXk0RhX++gXV/sP0OkKczjqBjoeaGYpPXpOLehO6A3qWH2A7isG4TnirFX3tH4wzj
         N7gVxaF8kSK8AV0CYcI2Z7hPMvr03yrBPmzlpppwD/VISMy4jxRcp3VJEDmvHrJbGZ20
         9nUA==
X-Forwarded-Encrypted: i=1; AJvYcCWR4Gp8B4oCPZ7zQPrlRAc/DSCdId+pw4K12opoggkFq4xUWGqCR75mfl/yxBb8o17XgX9j46T5LEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblqjvQO85P8ZT+ICnuLebHWW/X43VTd5uyjTLVy84czPSklzi
	F+Xx+ksqrJHTVu4lt1Y7Jb0YFINBqb6Di9L57Pec00k+CVUqqm1bACRx4wtaJuO35vQ=
X-Gm-Gg: ASbGncuwFhT4obLUnr8JJnrhw0diGzIIbFIRwLkf07wE4T6igpzPeOtyd7MLhhFL06a
	l/rfTIi3sQhZRzRzki/NwMohJdcLKAYjk7F0DlUPN22jPiHXLZIN9kaHOn2ztm4yKZE4c/vqw4u
	CUfOrPEscYfr9XU/1OmJhKm43LU4A4ItmayZ7v461dKuPd60CkFSexRD43v0F1W+lzKL6fMXIeP
	QpT6WM8HeYaH5cnHoYnREq4O101seYgaBEvlIAU3qCezQIY1MwGveCJNwY/U5uzj01ImJ3aia7v
	qS7g16UHwYo21ZxD9yDxC+F9fEnC9oZrOHw1Bfum5GaNbxixZdBcRBhckQJTwai5CMezDZa/Plh
	UQmLNIUT4p7/kamc3Fva0AAOvT2yAt0WV4w==
X-Google-Smtp-Source: AGHT+IG9r1IW40WvsK0ieNWX502Z1iaJ5R2nE5AB//lCMTQKx+lUDc3v2aZziBxwICd17ogNaz3RaQ==
X-Received: by 2002:a05:6a20:2445:b0:23d:58e9:347a with SMTP id adf61e73a8af0-24340c964femr2260198637.26.1755832028794;
        Thu, 21 Aug 2025 20:07:08 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:07:07 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:33 +0800
Subject: [PATCH v5 7/8] riscv: dts: spacemit: Enable PDMA on Banana Pi F3
 and Milkv Jupiter
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-7-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
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
v5: No change.
v4: Rename the node from pdma0 to pdma
v3: Adjust pdma0 position, ordering by name alphabetic
v2: Added pdma0 enablement on Milkv Jupiter
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


