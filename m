Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9F1196C
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEBMz3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 08:55:29 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17095 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEBMz3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 08:55:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae8bd0000>; Thu, 02 May 2019 05:55:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:55:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 May 2019 05:55:28 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:55:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 12:55:28 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccae8bd0000>; Thu, 02 May 2019 05:55:28 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/6] Add support for Tegra186/Tegra194 and generic fixes
Date:   Thu, 2 May 2019 18:25:11 +0530
Message-ID: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556801725; bh=xyGsJZTzhujgVWu4NMnFenNqEk9EavZ+0dkdg0MyO7M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=FxhZsRMeolt75QngFCSxHZ2dckUMoYrFccMSsycY6kv/HQj5XUE/niiUYg1L+2c9g
         PLrIrjy4IwHHn3Bf3ogc6PnZ53s20gwM0XQJH+I+ZC/dTNMyUvyTd/TXQB/wmNzICW
         QTIOU52jckyPNvwCtJuAunSRDloOOTl9S6AnwL8cwFlLdlELQVEFBYuny8x2uJGxOq
         aXNpRXa+/gJWaNDBTP1B7fgjB+xP1HF6DCs7zIZZCpKjcd6qzSeJw+pQW8ihZRof4V
         tLdygaa8MAVT9uRPfXjx0rYsKyQAewlh56Us1b1ftFP8kaDcqDLG1PIagj/EhonxXo
         PWzFiGb/Eo0QA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Audio DMA(ADMA) interface is a gateway in the AHUB for facilitating DMA
transfers between memory and all of its clients. Currently the driver
supports Tegra210 based platforms. This series adds support for Tegra186
and Tegra194 based platforms and fixes few functional issues.

Patches in the series are classified into three categories,
  1. Add support for Tegra186 and Tegra194
  2. Add DMA pause/resume feature
  3. Fixes common to differernt Tegra generations

Below change log describes the patches in detail.

Change log:
=====================================
v1
----
The series can be classified into 3 categories,
  1. Add support for Tegra186 and Tegra194
     [Patch 1/6] dmaengine: tegra210-adma: prepare for supporting newer
     Tegra chips
       * The support was there only for Tegra210
       * This is a preparation for adding support for newer Tegra chips
       * chip_data is enhanced to support differences between Tegra210 and
         Tegra186/Tegra194
     [Patch 2/6] Documentation: DT: Add compatibility binding for Tegra186
       * New compatibility string is required for driver to work for
         Tegra186 and Tegra194. Hence new compatibility is introduced.
       * Tegra194 can use the same compatibility as Tegra186
     [Patch 3/6] dmaengine: tegra210-adma: add support for Tegra186/
     Tegra194
       * Populates chip specific information for Tegra186
       * There is a difference in the way ADMA CH_CONFIG registers are
         encoded for Tegra210 and Tegra186. Added helper fucntions to
         support different versions of burst size configuration

  2. Add DMA pause/resume feature
     [Patch 4/6] dmaengine: tegra210-adma: add pause/resume support
       * Adds support for ADMA pause/resume, otherwise audio loss was seen
         during continuous pause/resume of audio playback.

  3. Fixes common to differernt Tegra generations
     [Patch 5/6] dmaengine: tegra210-dma: free dma controller in remove()
       * Fixes kernel panic observed during driver reload. DMA controller
         needs to be freed when driver is unloaded
     [Patch 6/6] dmaengine: tegra210-adma: restore channel status
       * Fixes resume across system suspend. If the channel state is not
         restored, the transfers won't resume from the state from where it
         was left during suspend entry. In this case, audio playback did
         not resume properly once system exited from low power state.

===============================
Sameer Pujar (6):
  dmaengine: tegra210-adma: prepare for supporting newer Tegra chips
  Documentation: DT: Add compatibility binding for Tegra186
  dmaengine: tegra210-adma: add support for Tegra186/Tegra194
  dmaengine: tegra210-adma: add pause/resume support
  dmaengine: tegra210-dma: free dma controller in remove()
  dmaengine: tegra210-adma: restore channel status

 .../bindings/dma/nvidia,tegra210-adma.txt     |   4 +-
 drivers/dma/tegra210-adma.c                   | 232 +++++++++++++++++----
 2 files changed, 193 insertions(+), 43 deletions(-)

-- 
2.7.4

