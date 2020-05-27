Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23F1E39D4
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgE0HFh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 03:05:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54886 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgE0HFh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 03:05:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04R75Whg119008;
        Wed, 27 May 2020 02:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590563132;
        bh=hSAacH1oEtaDr7QkGQnzb6d551jntUqFz6ToF0+BYHs=;
        h=From:To:CC:Subject:Date;
        b=mnIXT+jxVlEmtjfauVd+sf/BH/nyWtas14GPM/TKhSWE7zfQWuHp2BsxPNVJBMLxD
         quTdgIV3DoA5mjR1FZv0CQ3d1HJrDY40hGhR5OVmT7iOYH/vYfBPVgcKhqlTqcXrvj
         O7KcjmjeZ8/IGIMnzQUEFZbkMCXAyuhJnxMIXQJU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04R75WIe115795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 02:05:32 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 02:05:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 02:05:31 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04R75UF4065430;
        Wed, 27 May 2020 02:05:30 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH 0/2] dmaengine: ti: k3-udma: Fixes for alloc_chan_resources
Date:   Wed, 27 May 2020 10:06:10 +0300
Message-ID: <20200527070612.636-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

It turned out that udma_stop() can not be used to stop the channel which was
left enabled during boot (missing cleanup in early boot) since it would initiate
teardown. This is not supported on non configured channels.
Simply reset the running channel instead fixes the issue.

While looking at this issue I have noticed that the cleanup path misses
resources if the error happens early.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: ti: k3-udma: Fix cleanup code for alloc_chan_resources
  dmaengine: ti: k3-udma: Fix the running channel handling in
    alloc_chan_resources

 drivers/dma/ti/k3-udma.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

