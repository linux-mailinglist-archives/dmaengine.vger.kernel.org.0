Return-Path: <dmaengine+bounces-5799-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD383B03B1A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 11:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0104517D9E1
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB355246BA8;
	Mon, 14 Jul 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="16kThx4o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E282417F9
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486061; cv=none; b=rRMtpcbygMSWkw2ZBMJUpsn8zXtdDIg9VwClVPJf9l3cWehlGFTxFcdvk87DuwQ7p9+fbWkppBf9Nlq3u0nCjQCyj7+beVzelhp4GTJ389TdeQAcOaGIQNDxJ9HV6adpk+nyFvUAaAqOujQBe9L62mX6vS+vAVoLQxzoCJYOT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486061; c=relaxed/simple;
	bh=Kdry2gVbb8miTXmXd16rrT7u8YzjkAcFEZdjgAgPfA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwFZ2/HSO3wlXsPrKQUeUHF/HUjSxdHgKdZ4z/Ok6bUiBqlIyhZLoIZt3HZUw7brwbO3ip/xHZBt+ean2g5K7qZuueH0gjT+rtyaRHC/+CzrqqioIFYnPwAOfRygGZlsZQ45HNFQgtOogBa8OnN/Lkff0n9g9OED5R8eUf0+FT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=16kThx4o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso9657295e9.3
        for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752486058; x=1753090858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBgGdTksVfeSjCf4/icT/1ch7Jc0HArkGcJLo9ytMP4=;
        b=16kThx4oc14mDeeieiSvzRjQ89+o8CCI83t9QLL/FD3l4z/vCssXGL1k6xLRfdwE6S
         d8E5/oHcTpMgCXrkzBvHFznmP5g3jFveVA7nkgeMtzsTMh2hMcqKaeiZZUnj+XQ2Gxix
         C6hZiQ2Om6qReeW0Bwv9uoLTSAEFzV0I4bMEB++hD6MOK4LlhAlyCjrzsyQB2yEt12CN
         yoUtyNOp9VbQYqW9NBxTEtDdL25cBCSJskA4LyzIlDQkPQ/Fc15lG+jju+c4jMFQK85r
         oVQQXSeMmX0h896ATKReGbRfshP/+xpkGN3MNVaNCLqrAGw2qO0cxvq28hmP8ws560JV
         uKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486058; x=1753090858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBgGdTksVfeSjCf4/icT/1ch7Jc0HArkGcJLo9ytMP4=;
        b=fMiuytACfh63LbJYz2iCKdgBpKIU7Tm6I5T0k/UJh53deUuR1J99S4AYyT2MQTHcSE
         uE4kTf/m5ndmBJOA6Hw/9Im/p/sBg6smIXc45iaBt+OF0Ng5H8YirUBXJMctDRzDsD4t
         rNTArB6d2/Sfo/OLm0HaEn+5YXxthDWRiHiawGitorHqQhKacFWAjxSHonAwjFo/DWVX
         QcF7DYVS6ht9GOfG9ls5b/uIBnuDzCkQajWF2UCoiiiatQX8OhDU5dI42eInUVhu3AC+
         scZ0ebYWK6ZDHTC7lgJIEKBa5Klfd+VXT2lc1zxDHE3Akb2NLBM+/ZCZ12JWe9dkF8cP
         YIkA==
X-Forwarded-Encrypted: i=1; AJvYcCV1syT4y096G/WgRdnc5rc7kx1pOKeJOPApfIn1kR2G4V+4F+5uzrnXgder7dmTIvaiSECC5okv5G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlIVTeQSeElh8IlEmNpPE1e4KLVSt0H96T056E5Y6d7ixYSe9
	rkY+oYjtoUzyHPTjIybKZDPyjGJag6LOLaktcjlKt8H7BVmm2zVrtX44VUsdVVzyqxLLouXkQbZ
	402f9mRWoCXLd
X-Gm-Gg: ASbGncvzg1HV5Y/PrtnULRMb79LluqlfsMJouYVAnnVgFQDO5hQpUTkA/wTBZ46oHvi
	0KH7GLrv3tEkFpu38pmb9js4r2RxCuJk4QLNjUH4M0fLjk9u+vXt2VFbjhhpvx9EMsntGmAGb9h
	aoPumic+LdFcLZmqq1zF+tvba8Nit9Q05JTs76XCI0I2GqjFZt6/HHh2o3IHWNLzeNU33Ip3CpL
	cUZYuWjdP3DrVdDmvLGssZzC7pHFrbCoeOXjYPyaiXDVs2ELrKRIytVYcFs3GABpNyIM/nqFDw2
	K+oktDJzQfSam7wTMu1Cl5/wJ14woyyFXzWMM5O//zRbeac/pbaJHT25upFzogI80ftax3oa+w=
	=
X-Google-Smtp-Source: AGHT+IFZBd9BqIW4mTa6M2LIKLJ6VdBKVXcqNR4ZLAhmo9BpW6Qpf38x6Z4W0deTyL9Fnv8RWBe2kw==
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr36347635e9.18.1752486058120;
        Mon, 14 Jul 2025 02:40:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:0:1:2::3035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b25a948sm24989035e9.35.2025.07.14.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:40:57 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 14 Jul 2025 17:39:35 +0800
Subject: [PATCH v3 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-working_dma_0701_v2-v3-8-8b0f5cd71595@riscstar.com>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
In-Reply-To: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
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

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: Rebased. Part of the modification in v1 is now in this patch:
     - "riscv: defconfig: run savedefconfig to reorder it"
        , which has been merged into riscv/linux.git (for-next)
     - Link: https://git.kernel.org/riscv/c/d958097bdf88
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 37c98c0f98ffc0ee9d021e4d07aa37a27d342f7a..b6519fcc91c0bb56f71df336fd3793af3d64fe78 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -240,6 +240,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.43.0


