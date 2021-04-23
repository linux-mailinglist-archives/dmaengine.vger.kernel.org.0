Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20351368A64
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 03:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhDWBbO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 21:31:14 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:62180 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240007AbhDWBbN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Apr 2021 21:31:13 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N0xc88008391;
        Fri, 23 Apr 2021 02:19:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=dk201812;
 bh=oGRvjcTRHLMP6HMPh/SgFsNf2QI8fCUxof5y2p/CVIw=;
 b=klRlGaGSPtviAo/aeTl3vm9s5MVS9ImQOIRVXivkkKZGjE9ZiyIW9XZsZi3ROK9r/5Ui
 9SiAcQtAKzuEBQtmQQZEv3YYkql2+o/EGLI5u0npCnWqG09Ln4LoXh8ELUiNgnpDGc2p
 wF/0Omso0AwzeSLnPnkidZjihrFpPLC2UyWRFDLqn0z7Jp0GDGGmCkmMhFJ4slyoQmoH
 69h64zEd1/aLHCMehmlTUbAZEJyw5OKI+JFPo21NB2kTCA36tpJkltCw7GlGSgo3bjCP
 IpeOd8reoFk4RUIdtSaDB7IpPmzz3cH0EfnLGjAtAfbNGlt41YpGkHxVV37YHMbtfowp Og== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 382p9395yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 02:19:26 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 02:19:25 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 0/4] Expand Xilinx CDMA functions
Date:   Fri, 23 Apr 2021 02:19:09 +0100
Message-ID: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: K4xd7uJXluB4emH18StVvzK61Bk8ZGTc
X-Proofpoint-ORIG-GUID: K4xd7uJXluB4emH18StVvzK61Bk8ZGTc
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Recently at Imgtec we had to provide GLES API buffers with DMA transfer
capabilities to device memory. We had access to a Xilinx CDMA IP module,
but even though the hardware supports scatter-gather operations,
the driver did not. This patch series' goal is to extend the driver
to support SG transfers on CDMA devices.

It also fixes a couple of issues I found in the driver: lack of support
for HW descriptors allocated in an extended address space (above 32 bits)
and an unusual race condition when closing a DMA channel.

Adrian Larumbe (4):
  dmaengine: xilinx_dma: Add extended address support in CDMA
  dmaengine: xilinx_dma: Add channel configuration setting callback
  dmaengine: xilinx_dma: Add CDMA SG transfer support
  dmaengine: xilinx_dma: Add device synchronisation callback

 drivers/dma/xilinx/xilinx_dma.c | 186 ++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 9 deletions(-)

-- 
2.17.1

