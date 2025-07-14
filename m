Return-Path: <dmaengine+bounces-5791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5EB03AFE
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BBF189FDDC
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7024169E;
	Mon, 14 Jul 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ol12X3kn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4923DEB6
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486017; cv=none; b=JfKfmcIJwiPFyPJwLwv7c76fs/SjGjAZv0aQZTPR/fzoidRND6DyAJH0WAnu1hJDkAuDiykIjXrYG9dG0BZ8WoEIC0wYK7RDEoI6k6sHwjL75xVAzWU+PRb4FIb0/z0Jq8zy+NDn0EXst3/LzKNvzT0VwPTl4uXxjA6L0N8qcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486017; c=relaxed/simple;
	bh=O4w3Ehn7wPYZ4PXDL2LCv0D87qdMNkqeuamD43rkcEU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CamXK4VFqIcgGv0tJK79ZShoSeKr6Ue7hRw5Vt2cOOCOPRTg1b+0q329zF/aYmQpKgHJb1WhX/5V+Tj40lcjgN9VYbSnlwTuU22w1uzOQD0YRIohqm4iFyR6xh1BiyNdzDrzNv142cqzdJUrXyN/Mxu6ckFKieuWYwr8EQyuu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ol12X3kn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45617887276so7077025e9.2
        for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752486013; x=1753090813; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NW/McQJ6Sd6lpl1yvr5wt77YD+qYB1cLv1xJk7Xbx/U=;
        b=ol12X3kn4FRT552Y1z4PFhRLvxY5xlvw+WObsFOmNPKuLpf7K9X0OxQzgjL8afolrZ
         N3NDbYm7TwpeXaiFTO3pLcnMjmbSaACN/FC3P2kGQKEqLheNcQbNYHzDFB1QvzgPDVo6
         cdMjqS+gGa1d6QCyp5pirxCXT0QKikJmsfzt0sJtzGRpUQHI8b+CotwwCLuvEcmwyDED
         VzlPezO2r0esbc/rPo1AXcL4+AR4/j0t1VIhEjV1u1SUH7uKaub+Qm+09Nj2qQGhWMdm
         mxDo3tal0/2iZWefKVEJ1yOySwyuSZ7z2tMjS5YF+Z+yy1v9felfuLt2ZyLOOiN1CJwn
         W4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486013; x=1753090813;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW/McQJ6Sd6lpl1yvr5wt77YD+qYB1cLv1xJk7Xbx/U=;
        b=IpPH2Wwb+CvP1/gvyv4CslPagvdVn9MBPblAIMalpYNxR94fdcKUIjd7Ioyo5KJXHW
         /kAWGPgmysMKGBqN9oWuPJWY4UIWzmyIXAQ4rPk22JVas2UCpBb6IlaM05KHqI3iV6TL
         ULbr2P/0kZeRBoRBt5uWyEzJvcdX1wHdOmJjXWyxhN6hwlC3nttqld2UBPSFkZiJhY69
         6ptx61uK0t3qDs2iHLHoeomRTbo6wUa6Qj1GzkQgrPouRXCIBGN6cXAwGVCqOtsMzvi+
         byX5NA0zlNcxRZAl/nDwELiB+rsumxsydbFwSdKwoUJSn7uqyQ2IUA6kZ/f9/+04OtFS
         nIqg==
X-Forwarded-Encrypted: i=1; AJvYcCULDQicIYIf4xqXrdz2cWx3sn8g5+NvKZscR+OOr5GWQgKeMejlWHB7IXPH00HlljINaupSdfU/uIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkWpeXysuS7qLofwpU9iamtQc/egZhbc+50aUUzOCJS/l/BGx
	cs4y0lv+kZj2krkXPGN+4XPpkxQzyD6oNdy3fqem86Mistc4uZ+wTn08y20578Yobll9f07LZ57
	9+W3BemcvhNFv
X-Gm-Gg: ASbGncvbx4HRVyUnSazLF0DB9LZlVQe2MDcYuMT2WSwBKU1RR/3Y7hoC9foI9slqyjD
	UENkm6/eJ6T/FrQpyaCgsE7jdFqe5dGrpg2gCA+d0QhRV/do9C1C6WIAZRrv5rY4UQZ1U/2lcQ/
	dPkbToeOcFuZIFDIhvKPLnHrhAV2WKKxTeRLTPzsG5sUfLD8z5RwAuTNedTtfKZu13aFffBb1Oi
	PVwZwar+UO5BYyDvG/95yUgFSfZTOb0Ww++CnSZY9bmZ36q3LvaRveae9PkaYOCYQOg4BaTv9X8
	ioPH0NkbALk3DC2m/tvJQSSaNP3eTwWsRj9LIiVSZYmGVSMNxxsuhNen4ZvpQ/XIVQrJgqvChw=
	=
X-Google-Smtp-Source: AGHT+IHsiHi2b9XLYJ9fg0Rc9OaPeZG511Kxf8f41m3lSbmqbwnEUrPybpGRc4WW5jMeqOb06dRxYg==
X-Received: by 2002:a05:600c:1c8f:b0:456:2212:46b8 with SMTP id 5b1f17b1804b1-45622124965mr5783115e9.28.1752486013224;
        Mon, 14 Jul 2025 02:40:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:0:1:2::3035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b25a948sm24989035e9.35.2025.07.14.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:40:12 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 0/8] dmaengine: mmp_pdma: Add SpacemiT K1 SoC support
 with 64-bit addressing
Date: Mon, 14 Jul 2025 17:39:27 +0800
Message-Id: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/QdGgC/32Qz24CIRDGX4VwLhVYBeXU9AV66a0xZoBhl1hZC
 7i1Mb572fXSU5M5zDd/vslvbrRgjlioITeacYoljqmJ7olQN0DqkUXfNJVcbrjmgn2P+RhTf/A
 nOMyFwySZ9tKFDVcAXtO2ec4Y4nVx/dg/dMavSzOvjyJ9hYKevSVD3g3pYyVDrediVquWDxf77
 MbTqpzB4SlWNovPmC5XEsbMEl7rfMQ2i7nVJgxRFjVsQKstQHCWay+0tl4Cdgrsdo1r5OA80r9
 chixUSgjWwHIsbmIegxtTiD3TYceD7rzcdt5Mgs4gQyx1zD/Ltya5kPz7mBacgVWIO6GFl+plv
 lIq5JmQ7u/3+y8XDclTggEAAA==
X-Change-ID: 20250701-working_dma_0701_v2-7d2cf506aad7
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

This patchset adds support for SpacemiT K1 PDMA controller to the existing
mmp_pdma driver. The K1 PDMA controller is compatible with Marvell MMP PDMA
but extends it with 64-bit addressing capabilities through LPAE (Long
Physical Address Extension) bit and higher 32-bit address registers (DDADRH,
DSADRH and DTADRH).

In v3, the major change is creating a separate yaml binding schema for
SpacemiT K1 PDMA, per Krzysztof's suggestion. By doing this, the binding
schema got simplified a lot. Deprecated property (ie. #dma-channels) and
unused values for backward compatibility (#dma-cells const 2) can be
removed.

Other changes involve placing pdma0 node in k1.dtsi and in board specific
dts files with proper ordering.

The patchset has been tested on BananaPi F3 board.

This patchset is based on SpacemiT linux (for-next) [1] with Patch 8
depending on:
- riscv: defconfig: run savedefconfig to reorder it
    It has been merged into riscv/linux.git (for-next)
    Link: https://git.kernel.org/riscv/c/d958097bdf88

[1] https://github.com/spacemit-com/linux.git (for-next)

All of these patches are available here:
https://github.com/docularxu/linux/tree/working_dma_0714_v3

Changes in v3:
- Created separated yaml binding for Spacemit K1 PDMA controller
- Updated pdma0 node properties according to the new yaml binding
- Put pdma0 node in k1.dtsi according to its device address
- Put pdma0 node in board dts files according to alphabetic order

Link to v2:
https://lore.kernel.org/r/20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com

Changes in v2:
- Tag the series as "damengine".
- Used more specific compatible string "spacemit,k1-pdma"
- Enhanced DT bindings with conditional constraints:
   - clocks/resets properties only required for SpacemiT K1
   - #dma-cells set to 2 for marvell,pdma-1.0 and spacemit,k1-pdma
   - #dma-cells set to 1 for other variants
- Split mmp_pdma driver changes per maintainer feedback:
   - First patch (4/8) adds ops abstraction layer and 32-bit support
   - Second patch (5/8) adds K1-specific 64-bit support
- Merged Kconfig changes into the dmaengine: mmp_pdma driver patch (5/8)
- Enabled pdma0 on both BPI-F3 and Milk-V Jupiter

Link to v1:
https://lore.kernel.org/all/20250611125723.181711-1-guodong@riscstar.com/

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Guodong Xu (8):
      dt-bindings: dma: Add SpacemiT K1 PDMA controller
      dmaengine: mmp_pdma: Add optional clock support
      dmaengine: mmp_pdma: Add optional reset controller support
      dmaengine: mmp_pdma: Add operations structure for controller abstraction
      dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing
      riscv: dts: spacemit: Add PDMA0 node for K1 SoC
      riscv: dts: spacemit: Enable PDMA0 on Banana Pi F3 and Milkv Jupiter
      riscv: defconfig: Enable MMP_PDMA support for SpacemiT K1 SoC

 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  68 +++++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   4 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   4 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  11 +
 arch/riscv/configs/defconfig                       |   1 +
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/mmp_pdma.c                             | 281 ++++++++++++++++++---
 7 files changed, 339 insertions(+), 32 deletions(-)
---
base-commit: 6be7a5a768aafcb07d177bd2ae36ab84e4e0acde
change-id: 20250701-working_dma_0701_v2-7d2cf506aad7
prerequisite-change-id: 20250611-01-riscv-defconfig-7f90f73d283d:v1
prerequisite-patch-id: 53bda77e089023a09152a7d5403e1a738355c5d3

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>


