Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E852D93D7
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 09:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439074AbgLNINN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 03:13:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57602 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439076AbgLNINC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Dec 2020 03:13:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BE8C9Nb096441;
        Mon, 14 Dec 2020 02:12:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607933529;
        bh=/3MX+droXVG/tcWv1YqLgU4fCbmRjApeWc3AiR53uxo=;
        h=From:To:CC:Subject:Date;
        b=zB4zO4b2kVRuz84ujkelt0HiAR+h+3mTJZzrb6QcNOuw2WF+m8uWSBmlBK6eJf4ZU
         sfZqLtP1gs15NDm8P7kfd+IVZdP8lDRuUaQzf/i4MtqtI6abiEcwSrBE2hwtdkzpF3
         Z+HRUGNNQiBqdkkAWn2PuejiN7EtuEHoDV4CLS0U=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BE8C9Vm008369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 02:12:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 02:12:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 02:12:08 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BE8C6DJ065906;
        Mon, 14 Dec 2020 02:12:07 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <kishon@ti.com>
Subject: [PATCH 0/2] dmaengine: ti: k3-udma: memcpy throughput improvement
Date:   Mon, 14 Dec 2020 10:13:08 +0200
Message-ID: <20201214081310.10746-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Newer members of the KS3 family (after AM654) have support for burst_size
configuration for each DMA channel.

The HW default value is 64 bytes but on higher throughput channels it can be
increased to 256 bytes (UCHANs) or 128 byes (HCHANs).

Aligning the buffers and length of the transfer to the burst size also increases
the throughput.

Numbers gathered on j721e (UCHAN pair):
echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 50 > /sys/module/dmatest/parameters/iterations
echo 1 > /sys/module/dmatest/parameters/max_channels

Prior to  this patch:   ~1.3 GB/s
After this patch:       ~1.8 GB/s
 with 1 byte alignment: ~1.7 GB/s

The patches are on top of the AM64 support series:
https://lore.kernel.org/lkml/20201208090440.31792-1-peter.ujfalusi@ti.com/

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: Extend the dmaengine_alignment for 128 and 256 bytes
  dmaengine: ti: k3-udma: Add support for burst_size configuration for
    mem2mem

 drivers/dma/ti/k3-udma.c  | 115 ++++++++++++++++++++++++++++++++++++--
 include/linux/dmaengine.h |   2 +
 2 files changed, 112 insertions(+), 5 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

