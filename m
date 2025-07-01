Return-Path: <dmaengine+bounces-5698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B1AEEDD1
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 07:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE517ACBF4
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 05:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F3C23BF96;
	Tue,  1 Jul 2025 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rjNU7r+s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55D25BF1C
	for <dmaengine@vger.kernel.org>; Tue,  1 Jul 2025 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348295; cv=none; b=d3l4GkxjTvbn89niZ+SaDnsHqCgISvVoKmvWgvT2Mpx5GpybppWN8IUDaI1zX9dKZlGpjpweM03hWcblISScc3WWVot3ZF/GI8xmG1EJEv3X6RCT8fPEuUIeRM4uGrwIxXAVt8ZQy+M463FHesKT8ZdrUA0AcCRQaBUC77RK6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348295; c=relaxed/simple;
	bh=jeK9tZE+sqx6u/AlkHuW+Oi/yjhHjqxpmQf98di5WaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUq+O6Yr7YS70j10QVxmTjvA1OXzWqeFq2G/217jxGK2SWMOcJPiTzNbrdu6XDNq0Q1Lu/3z8NYJdbyTvLuv0mDKiL868zpucN61+r0SlT5IFOg+uNYnsKTYMF1o9CFIRy1v/hayhk93o5xyaVhUyrbiJ8XNs7nxuz5e+qDmYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rjNU7r+s; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5509556a91.3
        for <dmaengine@vger.kernel.org>; Mon, 30 Jun 2025 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1751348292; x=1751953092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmX5fOXWCoBnrBEU79U5TxH9E1pYhnhJLwNdCcpNrA0=;
        b=rjNU7r+stZYLIlSXDSPItldbfXqkn1IeWgdUjNRmnGZZPC/Jgt8Soa4ocBgI7RVsds
         +dPVyDVC2gJGLbW2bd+I393mIEIOCEPEr1oETOoqYiMo9uZqrkhPiI24dUroaRx9btt9
         50N4Nd421QLjVYrdbLGzb8YNlKmYJmeHfJBR8zWaPLDoKcJ2t/8m9gi2no8CcXVnu3nR
         LDjGz3pPYlCowWdNXXWUr3FVElwj65M/Di1jusq8xRDLDvgESVb6+EXd5OrtcjdQSLHG
         +tCdwPshfRVJDoZ+At6lC73bKGQaD0ySns1cWPpkiIhlavj1UgZE4kNrKshPzzaaZ6Qk
         qbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751348292; x=1751953092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmX5fOXWCoBnrBEU79U5TxH9E1pYhnhJLwNdCcpNrA0=;
        b=nxJXM4I8k0uxO+M37wegmKQLZnDesblIWezuJunABMHkyNyDq0T7roEsGgB/zvJlil
         Zw1RNPtF5sRWY+dX+o/trdUOZJBrUUyd4ZI6Kct1yZlrKpCS3v2AlCWVrl1PprZfUsTy
         4JR0IvbwriIZLKGflWR3tBjLG1J2E97oZDd7PKnykRcRWb0kP5pDt5AcaBTL0tnDVqpO
         EAhDGSei2Ibyfht4MSGBkaA2AjzqpHI7EpMnXPk3fMQljvp6PkDELikTN6Pfabg1MLbP
         cmvTnH08sMtWxypkBiQwHG1v7ENEXOadCQXxCKfyIYqL7eQlEEJ4Yy0sA9NMo+mkbrVG
         niQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUezMUbdsk8Fm3To6dl+/C9vD9LSQ+LUoJ96kQE6AZsCenuXW7+uHRzw+xiYZTG/NBdcY8sLfZ4VgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYib16MiJV3Nd+4Oj9N7On39UGmrBZb4BpW4fvO8F2W3WHJw0
	KU1b8DZh6ldNU41tq6a8txtC6VjmOqqpONqfN1Vb4rkI+gKBxsC5KuUUv8yPByoSZSQ=
X-Gm-Gg: ASbGncucvpKlqroDTjMtAoqEBDXDmFsazvaPNJKZOBANpv8vnYe2igZe9ialTh0tSHx
	8QYAD2RfHgAE8hm7J10FBWk0J3/ZP24Rg+Q2+9qpk2rb8FLvXF8xTN5rr/iqLYasbIyotFd4YyY
	mYqAKHSwujjfVmu3HI7F62rL7cYd+c0l103iMYNrO+2KUhdh4LkUG9k7Ne1qi7M7JMCgIPG9fH8
	0JMcSEQoWPPq0oMQciYBgFpaa6s2BDO1EAnRi9ztdmLRUvDRPOOPWAr/OwK2tF3weHckihr76QR
	tqm2weHbdVOv/BeiJYZxwV2K+SU0dyL39mePtiU=
X-Google-Smtp-Source: AGHT+IFg+6q2IUBlKBteqcounl7lX9NwIth1jTPA47B/kJW1lDcCrpe2PThA1nJP2lbTdGGwBbnrEQ==
X-Received: by 2002:a17:90b:1dc4:b0:313:17e3:7ae0 with SMTP id 98e67ed59e1d1-318c93252admr20461773a91.34.1751348292231;
        Mon, 30 Jun 2025 22:38:12 -0700 (PDT)
Received: from [127.0.1.1] ([2403:2c80:6::3092])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf5fsm101729865ad.115.2025.06.30.22.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:38:11 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 01 Jul 2025 13:37:00 +0800
Subject: [PATCH v2 6/8] riscv: dts: spacemit: Add PDMA0 node for K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-working_dma_0701_v2-v2-6-ab6ee9171d26@riscstar.com>
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

Add PDMA0 dma-controller node under dma_bus for SpacemiT K1 SoC.

The PDMA0 node is marked as disabled by default, allowing board-specific
device trees to enable it as needed.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2:
- Updated the compatible string.
- Rebased. Part of the changes in v1 is now in this patchset:
   - "riscv: dts: spacemit: Add DMA translation buses for K1"
   - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn/
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 8f44c1458123be9e74a80878517b2b785d743bef..69e0b1edf3276df26c07c15d81607f83de0e5d57 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -591,6 +591,17 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			pdma0: dma-controller@d4000000 {
+				compatible = "spacemit,k1-pdma";
+				reg = <0x0 0xd4000000 0x0 0x4000>;
+				interrupts = <72>;
+				clocks = <&syscon_apmu CLK_DMA>;
+				resets = <&syscon_apmu RESET_DMA>;
+				#dma-cells= <2>;
+				#dma-channels = <16>;
+				status = "disabled";
+			};
+
 			sec_uart1: serial@f0612000 {
 				compatible = "spacemit,k1-uart",
 					     "intel,xscale-uart";

-- 
2.43.0


