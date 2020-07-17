Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F72223B1F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQMIA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 08:08:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37132 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgGQMIA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 08:08:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HC7vpR088571;
        Fri, 17 Jul 2020 07:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594987677;
        bh=s/CqqadQC3cos7ZmS24Ff7/EgtuKJqGwWjVwjQC1oF4=;
        h=From:To:CC:Subject:Date;
        b=lwosgk7DBhf56hJ97WYsK/0/rFzbVNYNG/3RAyrGtdYNraK5j6UmXf9CvWGeq1IyY
         1V2EXiY1ygqCNVajCJxCvOYW53DOKOYPqkdXz4KRGCEQrtq+dIKrLPlEQ/rktiFG/5
         Sgk2+AEZO8JsqAoSDTGW2mFaeZHCv9UpG3WQwbWc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HC7vdf012855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 07:07:57 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 07:07:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 07:07:56 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HC7t1W043751;
        Fri, 17 Jul 2020 07:07:55 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH 0/2] dmaengine: ti: k3-udma: Get supported throughput levels from hardware
Date:   Fri, 17 Jul 2020 15:09:01 +0300
Message-ID: <20200717120903.8774-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Newer versions of UDMAP have information on the number of different throughput
channels in it's CAP registers.

The driver can auto configure based on the information from the hardware isntead
a table within the match_data.

With this change we can use the same compatible string for identical versions of
UDMAP when only the number of UHCHAN and HCHAN is different.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: ti: k3-udma: Use defines for capabilities register parsing
  dmaengine: ti: k3-udma: Query throughput level information from
    hardware

 drivers/dma/ti/k3-udma.c | 69 ++++++++++++++++++++--------------------
 drivers/dma/ti/k3-udma.h |  8 +++++
 2 files changed, 42 insertions(+), 35 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

