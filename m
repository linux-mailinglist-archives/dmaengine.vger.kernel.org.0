Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98E713B49D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 22:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgANVsV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 16:48:21 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54814 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVsV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jan 2020 16:48:21 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC927200507;
        Tue, 14 Jan 2020 22:48:19 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED0012000EA;
        Tue, 14 Jan 2020 22:48:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B31A40285;
        Wed, 15 Jan 2020 05:48:06 +0800 (SGT)
From:   Han Xu <han.xu@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        esben@geanix.com, boris.brezillon@collabora.com
Cc:     festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] gpmi/mxs-dma runtime pm patch set
Date:   Wed, 15 Jan 2020 05:43:57 +0800
Message-Id: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

enable the system pm and runtime pm for mxs-dma and refine the gpmi
runtime pm code

Han Xu (6):
  dmaengine: mxs: change the way to register probe function
  dmaengine: mxs: add the remove function
  dmaengine: mxs: add the power management functions
  dmaengine: mxs: switch from dma_coherent to dma_pool
  mtd: rawnand: gpmi: refine the runtime pm ops
  mtd: rawnand: gpmi: set the pinctrl state for suspend/reusme

 drivers/dma/mxs-dma.c                      | 155 ++++++++++++++++++---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  60 ++++----
 2 files changed, 167 insertions(+), 48 deletions(-)

-- 
2.17.1

