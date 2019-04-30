Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DEF59F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfD3Lak (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 07:30:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15611 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3Lak (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Apr 2019 07:30:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc831c10000>; Tue, 30 Apr 2019 04:30:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Apr 2019 04:30:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Apr 2019 04:30:39 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Apr
 2019 11:30:38 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Apr
 2019 11:30:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Apr 2019 11:30:38 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc831dc0003>; Tue, 30 Apr 2019 04:30:38 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] [RFC] dmaengine: add fifo_size member
Date:   Tue, 30 Apr 2019 17:00:28 +0530
Message-ID: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556623809; bh=AH+q4xpuhOjvbuUu+/2uIx5A6NBKPe1QLxkPOVg1H7g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=EkDUb7qA27dFZrFmJITvZIkKP9+U7Zf2yP0qu14TcCUS8apyFLBShJ42wst5bN7C2
         RGTut2NU6SczZwm6DP5TDswAOXF/VFb+4WAFQXdWqofziwlRNsJfVXbsJKUHEQka0x
         K07H4Ue4ZJfImQc6KKe/y3LXLxzhT5Bw9AgGxrT8YYtHPwmDalNx/XV7d448Ff1hCe
         YIMExb31Z1MFQUeSlz/Zyj4aBeocylldTZOwNr0wdve/ec6ZuilyPqNaijZqx0UQ97
         0q0QMEB9X9o5azZ9qcXLkyoPmqNMATZcZ30SLMQMSyxhuZvxmEuWfRECB5wcT3ZkY0
         l5WmtAYwesiEw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

During the DMA transfers from memory to I/O, it was observed that transfers
were inconsistent and resulted in glitches for audio playback. It happened
because fifo size on DMA did not match with slave channel configuration.

currently 'dma_slave_config' structure does not have a field for fifo size.
Hence the platform pcm driver cannot pass the fifo size as a slave_config.
Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size field which
cannot be used to pass the size info. This patch introduces fifo_size field
and the same can be populated on slave side. Users can set required size
for slave peripheral (multiple channels can be independently running with
different fifo sizes) and the corresponding sizes are programmed through
dma_slave_config on DMA side.

Request for feedback/suggestions.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/linux/dmaengine.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index d49ec5c..9ec198b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -351,6 +351,8 @@ enum dma_slave_buswidth {
  * @slave_id: Slave requester id. Only valid for slave channels. The dma
  * slave peripheral will have unique id as dma requester which need to be
  * pass as slave config.
+ * @fifo_size: Fifo size value. The dma slave peripheral can configure required
+ * fifo size and the same needs to be passed as slave config.
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -376,6 +378,7 @@ struct dma_slave_config {
 	u32 dst_port_window_size;
 	bool device_fc;
 	unsigned int slave_id;
+	u32 fifo_size;
 };
 
 /**
-- 
2.7.4

