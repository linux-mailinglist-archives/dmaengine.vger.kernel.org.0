Return-Path: <dmaengine+bounces-6040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA0B27843
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEB01C27F58
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 05:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4FD2BDC32;
	Fri, 15 Aug 2025 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZN44vgBf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B52BDC21
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235098; cv=none; b=DuBfTUGv+pj6ZfDPSdqB1S1BdFrMrnIb/LQ9kPlRDZYKXSobwsVpcgQAYk2HQeZT+TR2AJ5Ns0T+Qb4kkqu47aWdOrxJeeyK/DzSgSYldXPcLLgvbLkUjg+K1HwucfWaTzA08s4esAe/FH3jvZHWHcxZTUawfFkVBfDkm/odpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235098; c=relaxed/simple;
	bh=Ytsw7gXr39m4vVol3vpl+U2W3LDg/WGc3tz6dNyrjT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pz7iwSihCEi2m2cGv68SDSMs5/r5DnpmGoA2XIo12bERYOyHRQSxxS2zUxGuay1pWU3FldRclq2t3w48PMDxfDgHOjdjJAOXgMvlb3GldHP0fTZvQa/Ggr9TinZfdv+wDxT3SF90G6L7ZS2oAA0+qIp7h04qGwD2PzQGiEil5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZN44vgBf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24457f5835dso19714355ad.0
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 22:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235096; x=1755839896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=my5gFgxgwwpLbVFYwIJaqegTw7Bp5Dofm55CB0gOBhw=;
        b=ZN44vgBfta94FABFqbwPDjmdUHqiHp7ER9MO/UCEesKr73zyqIsEpPggbz81VC7frN
         uDCWGwwkH8oJl/DZVDWIuXw+7DGd7imSoYu6Zk33fjjLxzodNv9McPSI83U66+ElGpO7
         pGRz6g0Cb1c4JVJDs5oNCKvvYQAzhjV6Hv4MQq0EClLtCXx57TrGJuzfMqG8mK7d/1AG
         VYVDzUlmjecKvqiqo7jhyc4RrBeUdBkjl/+F7Xb931v+axBMbvkDqxS88Im+OtK9ow/N
         ah2HujXdnjUP+4JPUVzpIODiTXVVsvNZMM2n7w9y6vwNrvITV5/iDrRiNoub3wtKMLh+
         u6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235096; x=1755839896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my5gFgxgwwpLbVFYwIJaqegTw7Bp5Dofm55CB0gOBhw=;
        b=Ij71iN9y15vkmZR5neNN3991WxzeDuySGupxMOf3eLX+pXLwi0P2RQ7Mp7cTOMPVif
         dVfHkaH6psWAk9JzHxfKUXj9TaQvrqW4lNQ0mZeQWUOrUPQZRWC86ydK+lVwf6pWeahX
         CqgpSOtlBBDVu9cCZc3VXd3VoXLhTtXVOBNcTLTgar+05N+PfCSEawPPOJKoVuCJxsqS
         nF8Fjnu/zXsZvWG54A+fV2uVPKomzy9YShpAiRrP+PosJVdsnrBKomc3lhs5ONTfjqA8
         nhFWQsenz27MKUnAPURbGaukY+69+2lXdgd0bnrZSoGBe2rJ2l7Um3kM+YdwQ0g1JGoZ
         gKHw==
X-Forwarded-Encrypted: i=1; AJvYcCXORj2Zs/qGp5mbn5AK8C5ZphkWNH/MZ4yRl+E2anLGvSdx2rPb6mDzJ1qNHu6mLO950eepSmSlZXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9b7nKzmV96WEV4rDRbT8V8jLJZmE5YJMhSsACrWpAvCKLKtE3
	ipkWl1hlUlXqBV9oFIxGk+tn90XaHcveK2Wm3ZpakAGVAWWq7vioQ51pkeNVRsAjCik=
X-Gm-Gg: ASbGnctzaEnjjJi8LaEAErzS09+E9vaJCJxbJs+uBL4md1CMLAYc3P0OUOfhYZMS1N6
	H0Ik6rRC6uEbn5IW/yE4DkFCraFvwUD/Pzy3sLuQHWzShnfXmnx/lJET8czcfCavhqvNCaqEpbo
	C97njjnC/6CxguMAam+2/tpHKvYeai94kf0fm2nwGrYO18X+bseRxjGpRarhDo/rYbaeLxqy0AL
	CTgq8tdcIV+8VDEyHJASNK0vLwivNgvTQUvkkkwD8Cnx30rD7fF/8MU/1xKBNaTGtJe5NHjUK/I
	Ph3bYIPtfsT3ltsbAEmmb/xpjkM/sTBV0DG6iD6HgBJspwaAdt9jCxdLnAA62kHEXgUJfXTirjE
	0xyPkma89yvF9AZmqMvs6qQ==
X-Google-Smtp-Source: AGHT+IFr6XYQRBc9U9ia+TIZTQZJnsxXRoou7idyWaoZ8cv3ZQWmSXl1GoKqBAafVqDyDzPpUkQUKA==
X-Received: by 2002:a17:903:1acc:b0:243:47:f61b with SMTP id d9443c01a7336-2446d8ec74bmr13143265ad.45.1755235095854;
        Thu, 14 Aug 2025 22:18:15 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:18:15 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:28 +0800
Subject: [PATCH v4 6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-6-62145ab6ea30@riscstar.com>
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

Add PDMA dma-controller node under dma_bus for SpacemiT K1 SoC.

The PDMA node is marked as disabled by default, allowing board-specific
device trees to enable it as needed.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4:
- rename the node from pdma0 to pdma
- for consistnecy, put the "interrupts" after "clocks" and "resets"
v3:
- adjust pdma0 position, ordering by device address
- update properties according to the newly created schema binding
v2:
- Updated the compatible string.
- Rebased. Part of the changes in v1 is now in this patchset:
   - "riscv: dts: spacemit: Add DMA translation buses for K1"
   - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn/
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..861f0fe18083fa158da51bd3be2808609f6233f4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -660,6 +660,17 @@ dma-bus {
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
 				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
 
+			pdma: dma-controller@d4000000 {
+				compatible = "spacemit,k1-pdma";
+				reg = <0x0 0xd4000000 0x0 0x4000>;
+				clocks = <&syscon_apmu CLK_DMA>;
+				resets = <&syscon_apmu RESET_DMA>;
+				interrupts = <72>;
+				dma-channels = <16>;
+				#dma-cells= <1>;
+				status = "disabled";
+			};
+
 			uart0: serial@d4017000 {
 				compatible = "spacemit,k1-uart",
 					     "intel,xscale-uart";

-- 
2.43.0


