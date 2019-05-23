Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9D27712
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfEWHfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 03:35:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727232AbfEWHfX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 May 2019 03:35:23 -0400
X-UUID: 864bf361aa5b4a52b11e6e1b6f7e7682-20190523
X-UUID: 864bf361aa5b4a52b11e6e1b6f7e7682-20190523
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 802912487; Thu, 23 May 2019 15:35:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 23 May 2019 15:35:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 23 May 2019 15:35:11 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v13 0/2] add uart DMA function 
Date:   Thu, 23 May 2019 15:35:07 +0800
Message-ID: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma/mediatek.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DMA

Changes compared to v12
-rename parameters
-remove direction
Changes compared to v11
-modify TX/RX
-pause function by software
Changes compared to v10
-modify DMA tx status function
-modify 8250_mtk for DMA rx
-add notes to binding Document.
Changes compared to v9
-rename dt-bindings file
-remove direction from device_config
-simplified code
Changes compared to v8
-revise missing items
Changes compared to v7:
-modify apdma uart tx
Changes compared to v6:
-Correct spelling
Changes compared to v5:
-move 'requst irqs' to alloc channel
-remove tasklet.
Changes compared to v4:
-modify Kconfig depends on.
Changes compared to v3:
-fix CONFIG_PM, will cause build fail
Changes compared to v2:
-remove unimportant parameters
-instead of cookie, use APIs of virtual channel.
-use of_dma_xlate_by_chan_id.
Changes compared to v1:
-mian revised file, 8250_mtk_dma.c
--parameters renamed for standard
--remove atomic operation

Long Cheng (2):
  arm: dts: mt2712: add uart APDMA to device tree
  serial: 8250-mtk: modify uart DMA rx

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   51 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_mtk.c        |   49 +++++++++++----------------
 2 files changed, 71 insertions(+), 29 deletions(-)

-- 
1.7.9.5

