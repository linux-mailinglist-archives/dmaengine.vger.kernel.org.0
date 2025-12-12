Return-Path: <dmaengine+bounces-7577-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88679CB79B7
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 03:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4551F3014DA5
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1AD21D59B;
	Fri, 12 Dec 2025 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkCwf4MY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302F19309C
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505167; cv=none; b=pPc+/I+HIIq0tHc4XX6Y4oTgJCe9rQtvbBXrVAwKytiPfEWlbgwe3H5RtxXLIewnLKqedQe/DmQQpz3ummh3gQFeEZ6CHnbmKi/XGJGotrpHlc1QBSmWEb2SwAn2ZAcemgl3w7Xp9MhkGHE+Q4zPX157QJdN1hzvpXktWheE6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505167; c=relaxed/simple;
	bh=88+bNIzAlxYN1ci1rTDeBjW922J6fpEPqmB1ccuDPaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZZ9wclOrVGMe/SwF+1ZGrJNkLXNqfGt1KWOg6cPGAvz0Ta31wjM/S8dcHFml9E3TS7Vs0ZU9ojc9pktstv3KHWif+NUbDemzBd7Tt1h/bZZqCT9NexE/8VLKSLzHzX/rIupavTXhvUKpE9xejCBJZGix0Y0i4EyFdFSJs4aZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkCwf4MY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae0acso11726195ad.0
        for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 18:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765505164; x=1766109964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlgUDFgw3W20yRvzQZnPEu5u5tHChFQ6crwdHESAYTo=;
        b=VkCwf4MYNcYmReZYkAECM0pxPF2gtmpfdoQDpdPT5R949uMlqHNz5LbTlzXU6cAuf0
         4oUkAeRNfpca3pVYKbIXEJDl1PTMWkT5ZnrrsUh4o0VqDVe/PEgohY9HRFyuanJbWfSX
         i40rMFNdVQ9mTS/6AjgySqHHH3wdRbwk47aOF+E45jQmgzaO0EqH/UcfEnEA9ZfH+K10
         T4JayfHyCfImhSuEVUt2pz+CwM+qUkXxsrEgkFeTPUPjJ2/oM+ni5q3JO0zySqwfmLB9
         OhQwTCNZj6FCbgChOwPK4J/41P2UHGGjPThpm0Ncpo2usxMWGHtnNOfGPzBYBeqs8qVG
         1isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505164; x=1766109964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlgUDFgw3W20yRvzQZnPEu5u5tHChFQ6crwdHESAYTo=;
        b=VL9z7pld9cVs1BaqjJsFQM+7WCTgkN9hz3pUdbA1mMSVhlzgBrCaTxMRfa7tZ1dJpm
         mgQyMn2ctE37dZTrewcmENt2ilB+N3C5wNwOgleWiKAJEBidwi5wyWv2f2ygLzgpP9y7
         YViAysWwblp81SblGxYzDe1jnipbVEg93TmOWkY7TVf6kpeuuisRNCpxy6G+bX9M0ezM
         KyPqMODF/qeJsf4dDQyuNgN/CDHjIq/GhLb8W/bbLXiOD7tZyUotahmSU/dGl3zjwXu4
         WK2wPFArYJpmtOENocNkqHeapVwqQniCXSrtPVbn6VrIMY/kLwYKOOnVYIeI7/K2khho
         /irg==
X-Forwarded-Encrypted: i=1; AJvYcCXka8SQmXIB3XC2/KlA/IPwzdvoJ+9iIPiE3ri5nBcYFuVSLkhkHl9lOLkNKpjzRHIIHwGq6chc3Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/mSRVYVZjpdQqIsp+kmhOj646eumjmwUGsUlWPY8f41h+Wba
	balmi5ZQ0LwzxstwkIuLRFy2YCgCM+qhf4frzAJxpVKf4PkYsjzLEbdR
X-Gm-Gg: AY/fxX70DZBgH18J/OGdbIvQLJyc0/PRnR1yxarVY/vCHHkEKSQ06Nj9PGjwe/gKIIl
	GODy2v3UQXhGYaVeEwNGH0StHSpZtRG/eW3foVESi42l1/F68v0kAAqn06fjFVGLqpAtQfmuNWx
	EjBod13m+uQV3+0xIzzqv8bjbLZUMrpi1VYJuAEy6y9tJCfPDaEF6PXSpZzo7ss0hLqr/uWNIVI
	LVp0LGWXGB046jvhijXTh3djWEsserlSiXEWzsxXemRjO8TlC1XJMppihpelFHI4ZqtmzpSCDyC
	uLZI6EqZfL54Unxh3YRfN71zg6UMOPpe4xJiBkuJJP8P0cR8IOm7skOfZiAjQYWbJU94rhLfZTy
	0gdd6oZ+nnGiCr6ioH6ROAJgW2L8F5FqKijaBJThc1XLosM0ee5C4C5TlWsHyXMI0/2KbqTdM59
	S/LgZKuLgd5bOKnhF3zs1X
X-Google-Smtp-Source: AGHT+IH3Yw9NfBszzIXyVq9G5mI8Je1OQSv84u6vZsMXIzrC8EAZ85t54i22pt6sz/SEwSGENP30UQ==
X-Received: by 2002:a05:701b:2515:b0:119:e56b:c745 with SMTP id a92af1059eb24-11f34ac52a8mr455769c88.10.1765505164545;
        Thu, 11 Dec 2025 18:06:04 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff624sm13483678c88.12.2025.12.11.18.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:06:04 -0800 (PST)
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
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH 0/3] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Fri, 12 Dec 2025 10:05:00 +0800
Message-ID: <20251212020504.915616-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Inochi Amaoto (3):
  dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
  dmaengine: dw-axi-dmac: Add support for CV1800B DMA
  riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
    number for DMA controller

 .../bindings/dma/snps,dw-axi-dmac.yaml        |  1 +
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 23 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

--
2.52.0


