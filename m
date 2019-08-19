Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8C9258B
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2019 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfHSNwx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Aug 2019 09:52:53 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:41338 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfHSNww (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Aug 2019 09:52:52 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 3A9EF25AF04;
        Mon, 19 Aug 2019 23:52:50 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 1C9309406ED; Mon, 19 Aug 2019 15:52:48 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] dt-bindings: dmaengine: nbpfaxi: Rename bindings documentation file
Date:   Mon, 19 Aug 2019 15:52:44 +0200
Message-Id: <20190819135244.18183-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rename the device tree bindings for renesas "Type-AXI" NBPFAXI* DMA
controllers from nbpfaxi.txt to renesas,nbpfaxi.txt.

This is part of an ongoing effort to name bindings documentation files for
Renesas IP blocks consistently, in line with the compat strings they
document.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on v5.3-rc1
---
 .../devicetree/bindings/dma/{nbpfaxi.txt => renesas,nbpfaxi.txt}          | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/dma/{nbpfaxi.txt => renesas,nbpfaxi.txt} (100%)

diff --git a/Documentation/devicetree/bindings/dma/nbpfaxi.txt b/Documentation/devicetree/bindings/dma/renesas,nbpfaxi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/dma/nbpfaxi.txt
rename to Documentation/devicetree/bindings/dma/renesas,nbpfaxi.txt
-- 
2.11.0

