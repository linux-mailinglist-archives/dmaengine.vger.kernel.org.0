Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775C711979
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEBMzm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 08:55:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17111 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEBMzl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 08:55:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae8c90000>; Thu, 02 May 2019 05:55:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:55:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 05:55:40 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:55:40 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 12:55:40 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccae8c90000>; Thu, 02 May 2019 05:55:40 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/6] Documentation: DT: Add compatibility binding for Tegra186
Date:   Thu, 2 May 2019 18:25:13 +0530
Message-ID: <1556801717-31507-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556801737; bh=L0yrmYX9Yuz1r3hflXw6ZiWZWallxxnZWXwST9deuNs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=RHWBaOC+ZC8GVM+PZoBFjLz2ihALnwspZXlVha1hsgBWLoC5bMdU//+qdlUQdheNe
         2OrgQ/rF/UvmdjiOp54ywr9PDTiQbYC6CRCAG/urNSSsNWDKqAKlZAYmkX+NSVRI2Q
         myVQTDzccRgCBJ141+LZ4qukoWnNBrySpQ+eYD3AVvd6apCjUMJwJbowdpaw8du5uK
         t7wrgtisBGTZn6hPTl+/hnEGdw1/SH+wEPWpMO7vSzMV95ab8s0v/o+Q7dwybePr9Q
         54QPOXAWMICfMQxxKirodp0EF2NgnVmgmZ+Th+VLHWvbqN4m0K1U15AYEcsWjXsz2h
         vcX2Q8j3DBuQw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra186 Audio DMA controller has new updates from Tegra210 version.
Thus add new compatibility binding string and the same can be used
by Tegra194 as well.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
index 2f35b04..245d306 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
@@ -4,7 +4,9 @@ The Tegra Audio DMA controller that is used for transferring data
 between system memory and the Audio Processing Engine (APE).
 
 Required properties:
-- compatible: Must be "nvidia,tegra210-adma".
+- compatible: Should contain one of the following:
+  - "nvidia,tegra210-adma": for Tegra210
+  - "nvidia,tegra186-adma": for Tegra186 and Tegra194
 - reg: Should contain DMA registers location and length. This should be
   a single entry that includes all of the per-channel registers in one
   contiguous bank.
-- 
2.7.4

