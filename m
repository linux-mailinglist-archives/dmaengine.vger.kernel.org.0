Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0482F2A98B1
	for <lists+dmaengine@lfdr.de>; Fri,  6 Nov 2020 16:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKFPnm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 10:43:42 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12923 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFPnl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Nov 2020 10:43:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa56f300001>; Fri, 06 Nov 2020 07:43:44 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 15:43:41 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 15:43:38 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 0/4] Convert few Tegra docs to json-schema
Date:   Fri, 6 Nov 2020 21:13:29 +0530
Message-ID: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604677424; bh=dLi1qLGeX4zdQZJQEYnItaQWVbLbiHtlBhtlqi9j3mw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=CVZoubrJJjL0o3MrEtxz7NBONawc2Hm34uix8pCmPm/IEvuvORx9xnRrJiYv9yncu
         2EzVJRwKYCAKd2nCrlhFnlWR6H0STViVU1AXBjKXkD3JKWuAKhxqieA4hJoneTFj2R
         i4GsOyL/qYZHyKfeghgnxmitsim8NW9/jAGDliuGPjCjamf6ocybFvO1zTlb28EKbx
         5Owqnkq1PWL5YxWD6xQrZYLiKRe0SUB+l8NHgrwPVDorA5DK9Ix7sOb1eH18/rVtoQ
         iCDCG/tKz6BV3Cyy8i8GfzUhJSU44FCqolo1MqRU4nqCN1o5AVNfrf2XCdNdA6izjg
         zXQ3seNgsVw+A==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Following are the summary of changes.
* Update ADMA device node names for some of Tegra210 DT files.
* Convert ADMA, AGIC and ACONNECT docs to YAML.

Changelog
=========

v1 -> v2:
---------
* No change in DT patch.
* Add min/max items for interrupts and clocks in ADMA schema. Add
  required 'additionalProperty' and thus fix errors/warnings in
  the schema.
* Fix indentation warnings in arm,gic.yaml for AGIC documentation.
  With this fix add "Reviewed-by" tag from Rob.
* Drop individual child pattern properties for ACONNECT schema and
  instead use generic pattern property. 

Sameer Pujar (4):
  arm64: tegra: Rename ADMA device nodes for Tegra210
  dt-bindings: dma: Convert ADMA doc to json-schema
  dt-bindings: interrupt-controller: arm,gic: Update Tegra compatibles
  dt-bindings: bus: Convert ACONNECT doc to json-schema

 .../bindings/bus/nvidia,tegra210-aconnect.txt      | 44 ----------
 .../bindings/bus/nvidia,tegra210-aconnect.yaml     | 82 ++++++++++++++++++
 .../bindings/dma/nvidia,tegra210-adma.txt          | 56 ------------
 .../bindings/dma/nvidia,tegra210-adma.yaml         | 99 ++++++++++++++++++++++
 .../bindings/interrupt-controller/arm,gic.yaml     |  9 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |  2 +-
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |  2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +-
 9 files changed, 193 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml

-- 
2.7.4

