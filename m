Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9021322C996
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXP6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 11:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgGXP6i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 11:58:38 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 541A22064C;
        Fri, 24 Jul 2020 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595606318;
        bh=QJs6vpHpyZQjCIgvhgDF5S37Cf/01U0IZI6OQETb4XQ=;
        h=From:To:Cc:Subject:Date:From;
        b=s7TBrz82uhjo4sQcyRNsZLhBfeTLvfqrHy/sjlDHsH+WffGke2E2siSwMU7YC2o+m
         5PwJj34nZnAj2Sv/SZ/IVsrq3UfPhyQD9dXfwDxxn8budWjDnThlL0+26vOEuhhsf2
         +7xdt1TU6gMQ/b8KcE6NuX2sq9SwmL8jbpmhqb7M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MAINTAINERS: Add linux-mips mailing list to JZ47xx entries
Date:   Fri, 24 Jul 2020 17:58:16 +0200
Message-Id: <20200724155816.8125-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The entries for JZ47xx SoCs and its drivers lacked MIPS mailing list.
Only MTD NAND driver pointed linux-mtd.  Add linux-mips so the relevant
patches will get attention of MIPS developers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba0ed77775b..f41fc775a3c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8543,17 +8543,20 @@ F:	samples/bpf/ibumad_user.c
 
 INGENIC JZ4780 DMA Driver
 M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
+L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/dma-jz4780.c
 
 INGENIC JZ4780 NAND DRIVER
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mtd@lists.infradead.org
+L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/ingenic/
 
 INGENIC JZ47xx SoCs
 M:	Paul Cercueil <paul@crapouillou.net>
+L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/boot/dts/ingenic/
 F:	arch/mips/include/asm/mach-jz4740/
-- 
2.17.1

