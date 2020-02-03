Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFAB15040B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 11:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBCKSO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 05:18:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50474 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBCKSO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 05:18:14 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013AIAVW110563;
        Mon, 3 Feb 2020 04:18:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580725090;
        bh=yJ6wTZzEMM7o4cu5XQIF0bGLFzSyxsdTLmhvXICYwxs=;
        h=From:To:CC:Subject:Date;
        b=SI98XHDGSv5/qxEJoGOcEp/bi4zyYDorEvjRTcb+ni9KJOK4hJvHMGdHLwh7ZRqmx
         iL1s2v6Y2U7pXWWez4pMva29sSCjCfCvfaJjkUcWwXs0Zhj29tNxyuCOOy+vrP8GSL
         T8mG47be1a6jwSMBFSt5wAhcQQoZ1Dr0FuyLP/7Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 013AIAbx039721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 04:18:10 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 04:18:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 04:18:09 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013AI7mS040513;
        Mon, 3 Feb 2020 04:18:07 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
Date:   Mon, 3 Feb 2020 12:18:03 +0200
Message-ID: <20200203101806.2441-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

dma_request_slave_channel_reason() no longer have user in mainline, it
can be removed.

Advise users of dma_request_slave_channel() and
dma_request_slave_channel_compat() to move to dma_request_slave_chan()

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: Remove unused define for (dma_request_slave_channel_reason)()
  dmaengine: Mark dma_request_slave_channel() deprecated
  dmaengine: Encourage dma_request_slave_channel_compat() users to
    migrate

 drivers/dma/dmaengine.c   | 18 ------------------
 include/linux/dmaengine.h | 28 ++++++++++++++++++----------
 2 files changed, 18 insertions(+), 28 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

