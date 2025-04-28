Return-Path: <dmaengine+bounces-5031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F48A9E93D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 09:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D458C18993DB
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 07:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556C15A87C;
	Mon, 28 Apr 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i3mVEHrA"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA431D514E;
	Mon, 28 Apr 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825117; cv=none; b=UntrRbAvbeMHmtsLB5STptfk/xGuaLQT8WhfyAUGyaDt/A6I3SfT+jIUXAYzMLYklxnH3xuZxwqItYu26NLxUE6t1QqLX6eZ2hPruulUfoeeO4y2LuKlaYJDUfBKk02FJZxMq4EMfctKkSiwl6JKh1yg8DQ0jvwX36vh3iBYasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825117; c=relaxed/simple;
	bh=1XfRHpMN7FdDWOn92sRc2bykGert03rj8/SmnH9bqWo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUezx4+xbDVoDd+ZEaQD1E7JpiOGRcRPPhIyAzxdpsMIXo8zmO7RtR58l0DHHvjDhJR8JEAmzYZ3TR0HXxkQu8vxROFUJcWs8h7NJNISeJF8bcTIRCL9jRxUiTkCcBgHCNFzj+geaeDgEfRmjZ3/d6SdGpr49oej+G1qoMgeLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i3mVEHrA; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7Ki9O3334061
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 02:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745824844;
	bh=j3ziubjMM4iDinkRWPpqOq279fOOole6d1gFV+rphZk=;
	h=From:To:Subject:Date;
	b=i3mVEHrAl64u6xIjvnBtDnJ+JjrjhuXGnPUCo7pVPv03G9yjJTIsQW2bfWUFEFOTz
	 7MRUPA1U7mjppe5IllSWrJB0FIJeBtcNpWaSlxbB9VDw9T5rgF9wc7glZ+ZceRYloH
	 SP9oRM3LS9hybOrIxaGB6bxawHDfy9GumJv+Re2g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7KiCC003072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 02:20:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 02:20:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 02:20:44 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S7KdMZ068873;
	Mon, 28 Apr 2025 02:20:40 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
Subject: [PATCH 0/8] dmaengine: ti: Add support for BCDMA v2 and PKTDMA v2
Date: Mon, 28 Apr 2025 12:50:24 +0530
Message-ID: <20250428072032.946008-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds support for the BCDMA_V2 and PKTDMA_V2 which is
introduced in AM62L.

The key differences between the existing DMA and DMA V2 are:
- Absence of TISCI: Instead of configuring via TISCI calls, direct
  register writes are required.
- Autopair: There is no longer a need for PSIL pair and instead AUTOPAIR
  bit needs to set in the RT_CTL register.
- Static channel mapping: Each channel is mapped to a single peripheral.
- Direct IRQs: There is no INT-A and interrupt lines from DMA are
  directly connected to GIC.
- Remote side configuration handled by DMA. So no need to write to PEER
  registers to START / STOP / PAUSE / TEARDOWN.

Sai Sree Kartheek Adivi (8):
  dt-bindings: dma: ti: Add document for K3 BCDMA V2
  dt-bindings: dma: ti: Add document for K3 PKTDMA V2
  drivers: dma: ti: Refactor TI K3 UDMA driver
  dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
  drivers: soc: ti: k3-ringacc: handle absence of tisci
  dmaengine: ti: New driver for K3 BCDMA_V2
  dmaengine: ti: k3-udma-v2: Add support for PKTDMA V2
  dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2

 .../bindings/dma/ti/k3-bcdma-v2.yaml          |   97 +
 .../bindings/dma/ti/k3-pktdma-v2.yaml         |   73 +
 drivers/dma/ti/Kconfig                        |   14 +-
 drivers/dma/ti/Makefile                       |    4 +-
 drivers/dma/ti/k3-psil-am62l.c                |  132 +
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    1 +
 drivers/dma/ti/k3-udma-common.c               | 2974 +++++++++++++
 drivers/dma/ti/k3-udma-glue.c                 |   91 +-
 drivers/dma/ti/k3-udma-private.c              |   48 +-
 drivers/dma/ti/k3-udma-v2.c                   | 1513 +++++++
 drivers/dma/ti/k3-udma.c                      | 3751 ++---------------
 drivers/dma/ti/k3-udma.h                      |  571 ++-
 drivers/soc/ti/k3-ringacc.c                   |  162 +-
 include/linux/soc/ti/k3-ringacc.h             |    7 +
 15 files changed, 5873 insertions(+), 3566 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.yaml
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c
 create mode 100644 drivers/dma/ti/k3-udma-common.c
 create mode 100644 drivers/dma/ti/k3-udma-v2.c

-- 
2.34.1


