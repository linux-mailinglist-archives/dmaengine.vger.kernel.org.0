Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CC3BDFF3
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jul 2021 01:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFX73 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Jul 2021 19:59:29 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:56794 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbhGFX72 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Jul 2021 19:59:28 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 166NVXxE032557;
        Wed, 7 Jul 2021 00:43:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=dk201812;
 bh=0CcqS8UaEMBwBpDb+grv+a+jefvRJ7VM2L0l9L2Oxs4=;
 b=U6d6ZjkMvjpisZww1Y7uyuRN0vBuBKQZrgQ7mPNzHuziXwLX9mHivPwCmO3VcEpqQLTc
 mmc5O7HQMmKlqdt177S8UR0AGMysx/bs6WOFrXrqpT5h1wVkcriVCyT4XhpG8Ef1SoE6
 TSVycMTUKvrp2d3zX7Y/EFPbYLXT5kB9xlTkFADASvhpyI8qIz3C/OmPDNCk5hZQgl2w
 vp4L45jX2N6+f9jXGd+rL8YVjD3IvdiQFYAubKhjQ2605Fy4dUZ1O/uHaFztEJn7nP2v
 MKqzF9UhcR/oUqpYx+5gNPKhH2dTFyZasS/UnRESVoUXMInbmexo8ohC3utjszkOm+F1 dA== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 39ms1j08cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Jul 2021 00:43:50 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 7 Jul 2021 00:43:48 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 0/2] Add support for MEMCPY_SG transfers
Date:   Wed, 7 Jul 2021 00:43:36 +0100
Message-ID: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: jbaluKoRzLPiI3Nmq0V0BCj7AVrSJbXN
X-Proofpoint-GUID: jbaluKoRzLPiI3Nmq0V0BCj7AVrSJbXN
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Bring back dmaengine API support for scatter-gather memcpy's, which is a
follow-up from a previous patch series in which I wrongly tried to
implement the semantics of a MEMCPY_SG through the Slave SG interface.

The second patch fixes a race condition that I observed when calling
dmaengine_terminate_sync in the Xilinx DMA driver.

Adrian Larumbe (2):
  dmaengine: xilinx_dma: Restore support for memcpy SG transfers
  xilinx_dma: Fix read-after-free bug when terminating transfers

 .../driver-api/dmaengine/provider.rst         |  11 ++
 drivers/dma/dmaengine.c                       |   7 +
 drivers/dma/xilinx/xilinx_dma.c               | 134 ++++++++++++++++++
 include/linux/dmaengine.h                     |  20 +++
 4 files changed, 172 insertions(+)

-- 
2.17.1

