Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90114D9FC
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgA3Llv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 06:41:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58478 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Llp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 06:41:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfYAq040398;
        Thu, 30 Jan 2020 05:41:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580384495;
        bh=MgMgxrY4r0pbPJYk9YGQY7AwMzFYv2Fq/3K2ab3HHT0=;
        h=From:To:CC:Subject:Date;
        b=cCK+MwDnWoHsMgJsdb7I0D8fWDIPyIiIV9hmI/qs7ylA0RU6XLiOYh2Elnyc/uPsx
         2B1bv7OE3HorJ6rmQcugfhIke/+GzjlJLH8fU/vTz6/ZuPU8lNV5K2z8mzjQ1d3nF6
         qUoXNEuR563qzw2P5DntFX+7Yelcr5osP7QpLO6g=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00UBfY9U015549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jan 2020 05:41:34 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 05:41:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 05:41:34 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfW7W104655;
        Thu, 30 Jan 2020 05:41:33 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH 0/2] dmaengine: Cleanups for symlink handling and debugfs support
Date:   Thu, 30 Jan 2020 13:42:18 +0200
Message-ID: <20200130114220.23538-1-peter.ujfalusi@ti.com>
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

As I have mentioned on the symlink patch earlier I like how the gpio's debugfs
shows in one place information.

These patches are on top of Vinod's next (with the v2 fix for the symlink
support).

The first patch fixes and cleans up the symlink handling code a bit and the
second adds support for debugfs file:

On my board with audio and after a run with dmatest on 6 channels this is how
the information is presented about the DMA drivers:

 # cat /sys/kernel/debug/dmaengine 
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0:             2b00000.mcasp:tx
 dma1chan1:             2b00000.mcasp:rx
 dma1chan2:             in-use
 dma1chan3:             in-use
 dma1chan4:             in-use
 dma1chan5:             in-use
 dma1chan6:             in-use
 dma1chan7:             in-use

It shows the users (device name + channel name) of the channels. If it is not a
slave channel, then it only prints 'in-use' as no other information is
available for non save channels.

DMA drivers can implement the dbg_show callback to provide custom information
for their channels if needed.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: Cleanups for the slave <-> channel symlink support
  dmaengine: Add basic debugfs support

 drivers/dma/dmaengine.c   | 143 +++++++++++++++++++++++++++++++++++---
 include/linux/dmaengine.h |  12 +++-
 2 files changed, 144 insertions(+), 11 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

