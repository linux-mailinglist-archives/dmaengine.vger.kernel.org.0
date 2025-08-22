Return-Path: <dmaengine+bounces-6128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FEB30C55
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 05:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0D6AC81A0
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 03:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58029283C9D;
	Fri, 22 Aug 2025 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QP+P3Ho7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391728152B
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832035; cv=none; b=DmOJqd8hi0mR9ND0zQZ6pcZszyNE71KrKp86TLbbiTUDv+ERgRP4VsPm1KY75n0BGgFr4fA/+7FKW0v9KEGDFv/v8tYRYPmwST4tXMSVVMrWmRWwsMgXmt9LNzGeMN669XzpM9MTyiADsVdZWyAquPHwRsWfakSrU4PlJYY4V6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832035; c=relaxed/simple;
	bh=BCHnUU58o8kcbkrtBnovBDjIBR3GZtD2vocIDuWis4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGToWyh0sUBkTHNT2GPlhKCdJ81oZ/RbpwODgB1U4cTaU/iZwzQlHauAnuA9amhKo9Jcmyw4Q6C4s1wBgfwfubFWu6+gyx8Cr7rc8QDhqjPq/1kb7S+km9OgvfZSWzKKEnYdg4lL/RTwED5E5NmMuebSWRHnev5s0krko4z7wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QP+P3Ho7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49bc4e76b9so430587a12.2
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832033; x=1756436833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quTPMYj7s5QwSm0woBLSQz7z4VVYjT+IYu8GwKKHe24=;
        b=QP+P3Ho7hFeya4G8Rx7/0rmic6N+Qw9YOHrPmI+nuFu6OREE1k3zNjMiqky6AQZcmB
         Te56XtNuaYlEVY0SM8SemfgLpN71SUwucTaD7AXMUeZwgUgSeaR8AUGQJNAJGJA0NgZw
         kXxuVYEtCJZI96eyXmBsgv9FRKYo2JCTfRU0LS+egJV+cGTGUeoxiQzX853ANdaUKTil
         D3SWcNrv2J763LiszEB8TY5VoxJ4kaMtmucWUHHVOYh6yD0/P9e2+2t/DAUUzN8oTZX4
         7hvCXrQuYRv7UJ3Jfm4el993I53OV/C6quUtit6fHFubFTc2MGbsmI60c70wKQmICgMZ
         OUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832033; x=1756436833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quTPMYj7s5QwSm0woBLSQz7z4VVYjT+IYu8GwKKHe24=;
        b=qTt0H49mb03Pb/t3liHz4tAC6Os3uG5/VRFSpStAuYOQzQTDPXYIfDdHB/rNyXunKc
         /V0LXchc9wIDNV8WpraN7DrhgoXW/fsZ4jnB+Vips5U5UNxJtXnqJhaEKkb6FZuavilb
         xKRlcqiFpQW7Rxo8pnZIbab4BWu+AyFKvRgohYFvQUf3PaXwhlXab0JDdsnQ7EyNjUjE
         SWVgRWW/y3oYcYp4natfXqGI/gEaQYnyFLTbkjIDG8TAFVrX0EwjcdOd5tXp5mU2x1sT
         ul8GrwnzV6/aSwi5RI8JGPQd+sFA8FOX0C3xfAZXBbpXur50QgSt0j2JfsKq6yiA3YSh
         4Sig==
X-Forwarded-Encrypted: i=1; AJvYcCXVdt3J3hEqOl6n1VIvApBkFApufNMjSvWnW7+UzOYJ+mEAzXbr5dk9vbuxvt5G1Ej+ytMqMF/xUdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/TnNboFHIKbT1vafE15q+bkJDTPZyFg+JiLye9KlzvwFsYcV
	pThlMiYEhdfAHl5Lj04Tt9I2AOG4Snz8x1RZovFc9RozYSqciUIRYf01wqXzwPVdkLj8TwfNWYj
	/n3LTVlqjVEqy
X-Gm-Gg: ASbGncsipo/qkwky0v7/fDhBm1x/CBM63O/OVElBaXnV2Oy8P53DJZ5vYOvuidfIW+C
	F/PD9OCeS7Xmuhwu+CKuyU21iMe92SMi/d3znA7A0C6iz0gvleaiLjimi4C679OylLOINVGNkFI
	wby7/u1dB0zAGpTdr1Vw/WcVHUwWbPmkyalNIan0vQGOHUfuMYRI4OXF+0eP26f0pS+cPwH+9/1
	WJnNIv5v9aV/iKM2YaoQzfWxnummEte1Q89XJOuwjUiMIRK+TjXvkKfAeYvQMxXrpFSlD+VV03q
	MpQNxLLIBGeI/ttKsiBCjqcoIEowmuwiH55r95w4gSKt4Jyv7x5p9CMNYCy0YkTM+ANKW/quUfI
	R+lyprr4IMYm0uqKVrSa4/97cWlRflBwwPA==
X-Google-Smtp-Source: AGHT+IGxr6BvRlq9gDlCAE/XGtF9F2t4Uze1UvterPKqOgW+FIUz6fdAVotEWXje2mAfPXpMbJnhUA==
X-Received: by 2002:a17:902:ce91:b0:234:d292:be95 with SMTP id d9443c01a7336-2462eeea5f4mr23986195ad.42.1755832033132;
        Thu, 21 Aug 2025 20:07:13 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:07:12 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:34 +0800
Subject: [PATCH v5 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-8-f5c0eda734cc@riscstar.com>
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

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: No change.
v4: No change.
v3: No change.
v2: Rebased. Part of the modification in v1 is now in this patch:
     - "riscv: defconfig: run savedefconfig to reorder it"
        , which has been merged into riscv/linux.git (for-next)
     - Link: https://git.kernel.org/riscv/c/d958097bdf88
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f25394d088d0d3cbee41fa9fb553c71e495036fd..b9ef2da15fb22f08bdb5ee5d1bba9f6eed49ff97 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -241,6 +241,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.43.0


