Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5DF72E2C
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jul 2019 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfGXLuD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jul 2019 07:50:03 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47920 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbfGXLuD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jul 2019 07:50:03 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 245C225BE09;
        Wed, 24 Jul 2019 21:50:01 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 04FCDE2209B; Wed, 24 Jul 2019 13:49:59 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] dt-bindings: shdma: Rename bindings documentation file
Date:   Wed, 24 Jul 2019 13:49:46 +0200
Message-Id: <20190724114946.14021-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rename the bindings documentation file for shdma
from shdma.txt to renesas,shdma.txt.

This is part of an ongoing effort to name bindings documentation files for
Renesas IP blocks consistently, in line with the compat strings they
document.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on v5.3-rc1
---
 Documentation/devicetree/bindings/dma/{shdma.txt => renesas,shdma.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/dma/{shdma.txt => renesas,shdma.txt} (100%)

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/renesas,shdma.txt
similarity index 100%
rename from Documentation/devicetree/bindings/dma/shdma.txt
rename to Documentation/devicetree/bindings/dma/renesas,shdma.txt
-- 
2.11.0

