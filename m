Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51545F13C
	for <lists+dmaengine@lfdr.de>; Fri, 26 Nov 2021 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354559AbhKZQFi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 11:05:38 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8170 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377982AbhKZQDi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 11:03:38 -0500
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AH2qK26AUMNytlKrlHem555DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXocdfUzSL38qynOpoV46faasl0ssR0b9OxoW5PwIk80l6QV3WB5B97LYOCBgg?=
 =?us-ascii?q?SVxepZg7cKrQeLJ8SHzI5g6Zs=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="400208539"
Received: from clt-128-93-176-202.vpn.inria.fr ([128.93.176.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 17:00:20 +0100
Date:   Fri, 26 Nov 2021 17:00:18 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Akhil R <akhilrajeev@nvidia.com>
cc:     kbuild-all@lists.01.org, Akhil R <akhilrajeev@nvidia.com>,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com
Subject: [PATCH] dmaengine: tegra: fix flexible_array.cocci warnings
Message-ID: <alpine.DEB.2.22.394.2111261659030.18994@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: kernel test robot <lkp@intel.com>

Zero-length and one-element arrays are deprecated, see
Documentation/process/deprecated.rst
Flexible-array members should be used instead.

Generated by: scripts/coccinelle/misc/flexible_array.cocci

CC: Akhil R <akhilrajeev@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>

---

url:    https://github.com/0day-ci/linux/commits/Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211122-173019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
:::::: branch date: 29 hours ago
:::::: commit date: 29 hours ago

Please take the patch only if it's a positive warning. Thanks!

 tegra186-gpc-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -238,7 +238,7 @@ struct tegra_dma {
 	unsigned long sid_m2d_reserved;
 	unsigned long sid_d2m_reserved;
 	unsigned long sid_m2m_reserved;
-	struct tegra_dma_channel channels[0];
+	struct tegra_dma_channel channels[];
 };

 static inline void tdc_write(struct tegra_dma_channel *tdc,
