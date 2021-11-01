Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C444200D
	for <lists+dmaengine@lfdr.de>; Mon,  1 Nov 2021 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhKASdp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Nov 2021 14:33:45 -0400
Received: from neon-v2.ccupm.upm.es ([138.100.198.70]:44713 "EHLO
        neon-v2.ccupm.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhKASdn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Nov 2021 14:33:43 -0400
X-Greylist: delayed 828 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 14:33:43 EDT
Received: from localhost.localdomain (62-3-70-206.dsl.in-addr.zen.co.uk [62.3.70.206] (may be forged))
        (user=adrianml@alumnos.upm.es mech=LOGIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 1A1I8fSN016585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Nov 2021 18:08:53 GMT
From:   Adrian Larumbe <adrianml@alumnos.upm.es>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Adrian Larumbe <adrianml@alumnos.upm.es>
Subject: [PATCH 0/3] Add support for MEMCPY_SG transfers
Date:   Mon,  1 Nov 2021 18:08:22 +0000
Message-Id: <20211101180825.241048-1-adrianml@alumnos.upm.es>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Bring back dmaengine API support for scatter-gather memcpy's.

Changes in patch v2:
  * Expanded API function documentation to elaborate on its semantics,
    limitations and corner case behaviour.
  * Broke the patch series into three different ones: documentation, core
    API change and consumer driver

v1 - https://lore.kernel.org/dmaengine/20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com

Adrian Larumbe (3):
  dmaengine: Add documentation for new memcpy scatter-gather function
  dmaengine: Add core function and capability check for DMA_MEMCPY_SG
  dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.

 .../driver-api/dmaengine/provider.rst         |  23 ++++
 drivers/dma/dmaengine.c                       |   7 +
 drivers/dma/xilinx/xilinx_dma.c               | 122 ++++++++++++++++++
 include/linux/dmaengine.h                     |  20 +++
 4 files changed, 172 insertions(+)


base-commit: e0674853943287669a82d1ffe09a700944615978
-- 
2.33.1

