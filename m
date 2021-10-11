Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909414289E4
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 11:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhJKJpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 05:45:18 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58378 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235609AbhJKJpR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 05:45:17 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B7G35v020092;
        Mon, 11 Oct 2021 11:43:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=367os0WHYnfF0CXiyp3vc3QPyuTp0IJg33IruYBh7M0=;
 b=lLTvtFXL/pmi4Vkj4hvxkGOocS6DOFQfh/hDT3zZoRwPNSvcawqsteZx+4N4c125v1aI
 UvaAGX1HE3B3YtRHpKRnUlY+bhji7jaU0W0vG4LPurTZJsQY5qbmUD7rzzJ8a6T/61GI
 Tl8wxQ8cSkqeJHv/rXYQbMP9QOlg494LFi3ghp3wNp10FWNv/rCZLaEiCqxwS+OKyOQN
 RXX6wAMQFgKcJ2fpUcwJyj+kHWxEkAGowo6xvUwUeW6PNzXAnsv0rVWMJe+wnoB1aLsa
 1YSdSczG4WIkz4ie3xuEmeKHpRysteZznkNR4ZxQyQpN0NSsjp6dV5EbUcR992LWHW9k Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bmgqu8w58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 11:43:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEE7210002A;
        Mon, 11 Oct 2021 11:43:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A71F421B50C;
        Mon, 11 Oct 2021 11:43:05 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 11 Oct 2021 11:43:04
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 0/3] dmaengine: stm32-dma: some corner case fixes
Date:   Mon, 11 Oct 2021 11:42:56 +0200
Message-ID: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset brings some fixes to STM32 DMA driver.
It fixes undefined behaviour of STM32 DMA controller when an unaligned address
is used.
It also prevents accidental repeated completion using dma_cookie_complete() in
terminate_all().

Amelie Delaunay (3):
  dmaengine: stm32-dma: mark pending descriptor complete in
    terminate_all
  dmaengine: stm32-dma: fix stm32_dma_get_max_width
  dmaengine: stm32-dma: fix burst in case of unaligned memory address

 drivers/dma/stm32-dma.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.25.1

