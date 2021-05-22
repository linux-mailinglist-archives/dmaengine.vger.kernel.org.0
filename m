Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6038D2ED
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhEVCOo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhEVCOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 22:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E4C06138A;
        Fri, 21 May 2021 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8yyvZSyaBPFumaiPcWW1BjhsGS7WM1RNusn1RJNc8rc=; b=yk4Vuq038VXor6d5ScVj9TcXsc
        /zTB48ViAHLhOQQhIl0QEBfkTIxtmJhNFklfRF4cAYpsLJKSYKYrMvduU/ygGUp9c57SNBoHme/SL
        lBUW/wwLLVDeFYgHNKM8SftKFHMjk28jUPEXk8JBIhWFAdgesRm3D9o09ZalZJQtCoWzdwZapOg+a
        vOXItpsUxuZ84IjHyVRlObo0JmrPyVJ3M54lkfF8SCvZOQTfdXboUC1/rbWqpsL8vA+dQlJ1hJjpD
        NwyDjMBKyqYQTAaSLWv5QcT446j+SUJqZsULXPPj4RGmv8/YrotHXdWki53OtmHVUsXSFrCV2ORxM
        Z003oYQw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkH8d-00HX9I-Gf; Sat, 22 May 2021 02:13:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Stefan Roese <sr@denx.de>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/4] DMA: several drivers depend on HAS_IOMEM
Date:   Fri, 21 May 2021 19:13:09 -0700
Message-Id: <20210522021313.16405-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A few drivers in drivers/dma/ use iomap(), ioremap(), devm_ioremap(),
etc. Building these drivers when CONFIG_HAS_IOMEM is not set results
in build errors, so make these drivers depend on HAS_IOMEM.

Cc: Stefan Roese <sr@denx.de>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Green Wan <green.wan@sifive.com>
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Tejas Upadhyay <tejasu@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[PATCH 1/4] DMA: ALTERA_MSGDMA depends on HAS_IOMEM
[PATCH 2/4] DMA: QCOM_HIDMA_MGMT depends on HAS_IOMEM
[PATCH 3/4] DMA: SF_PDMA depends on HAS_IOMEM
[PATCH 4/4] DMA: XILINX_ZYNQMP_DPDMA depends on HAS_IOMEM

 Kconfig |    4 ++++
 1 file changed, 4 insertions(+)
