Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9419114B1E9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 10:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgA1Jm1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 04:42:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1512 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgA1Jm0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 04:42:26 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S9XRJJ026097;
        Tue, 28 Jan 2020 10:42:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Kmmsnt0GP19LNEdrBchAyZ2FdgB00aCxXbF9RNsjpVY=;
 b=L75TFrdwxinDcyog/Ny+M12HWHDQn6p/hu+wpK++jUkFR3mHiXuSzx1jJUgXOLmowAly
 SbpW6ULAXjmvz8CVKMRvE5OmhJH5990xBQaD/dfxgKbksxwsm6MaALEd1S20HQeE5TES
 aEXQ9UL3jNu6m7zFcU7XvXRIcsyg7VoVviwEE3ky8D69BEiI1hUoqGNRb3owDfq2h9KE
 jsImpwzSBBEMEDDxr0Mb1NQQEh7MBOLYGeGmF/eolceW84EvpOkHIS4kvdn4e/5mHmlG
 38Cx7W3ogTGatTcYpMp8+qkOvs2KQzjeo9+YiXPIbpwDPeJrTlmyHTyIUx6k5j+lsITO sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpaw9xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:42:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C18FD100034;
        Tue, 28 Jan 2020 10:42:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B396921D3C0;
        Tue, 28 Jan 2020 10:42:07 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 10:42:07
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH 0/4] STM32 DMAMUX driver fixes and improvements
Date:   Tue, 28 Jan 2020 10:41:54 +0100
Message-ID: <20200128094158.20361-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series brings improvements to the DMAMUX driver with support of power
management and probe function gets a cleanup.

Etienne Carriere (3):
  dmaengine: stm32-dmamux: fix clock handling in probe sequence
  dmaengine: stm32-dmamux: use reset controller only at probe time
  dmaengine: stm32-dmamux: driver defers probe for clock and reset

Pierre-Yves MORDRET (1):
  dmaengine: stm32-dmamux: add suspend/resume power management support

 drivers/dma/stm32-dmamux.c | 93 +++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 16 deletions(-)

-- 
2.17.1

