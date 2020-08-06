Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C523D750
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgHFHa5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 03:30:57 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19117 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgHFHah (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 03:30:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2bb12c0000>; Thu, 06 Aug 2020 00:28:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 00:30:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Aug 2020 00:30:24 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 07:30:20 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 6 Aug 2020 07:30:20 +0000
Received: from rgumasta-linux.nvidia.com (Not Verified[10.19.66.108]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2bb18a0000>; Thu, 06 Aug 2020 00:30:20 -0700
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, <rgumasta@nvidia.com>
Subject: [Patch v2 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Thu, 6 Aug 2020 13:00:02 +0530
Message-ID: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596698924; bh=u+0W6SZXb/LajUYA9wa7E3PiZkZWCN+UvtS0dN5ZjdE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=loTbWmRlrXOWgKq0pPbJxhNdkgBNYIll808WjD64C65nHl5r+fUPcSprZEHKoDFXB
         31wPOTsW3LQNwRsn2rWGhabI42i/zv5zE/nKrPGY0QmR0VTQhnqjZycbwZJEWF/g1j
         C6areVyVWTakcJCtKxm/GzcbvJGREQQpohtDSL4CN9jykR0AubXAjL9f4dF1ToGExG
         wh8haEd8u95Ga0wVdyOthjVDw9aH+Sav3rwjmFqFT/nhwHgPN7nSXo5Og0ELgIZmMT
         KNpnSTUBCDcGbVJ6jTh2y4F400YeG0kcObf5MhIl5wM1Cfg7i95ZYfj1tpnEUEe0YT
         Hftid7PoDmgsA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Changes in patch v2:
Addressed review comments in patch v1

v1 - https://lkml.org/lkml/2020/7/20/96

Rajesh Gumasta (4):
  dt-bindings: dma: Add DT binding document
  dmaengine: tegra: Add Tegra GPC DMA driver
  arm64: configs: enable tegra gpc dma
  arm64: tegra: Add GPCDMA node in dt

 .../bindings/dma/nvidia,tegra-gpc-dma.yaml         |   99 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   46 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra-gpc-dma.c                        | 1472 ++++++++++++++++++++
 8 files changed, 1679 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra-gpc-dma.c

-- 
2.7.4

