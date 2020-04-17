Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172991AD4F3
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 05:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDQDzZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 23:55:25 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:34404 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgDQDzZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 23:55:25 -0400
X-IronPort-AV: E=Sophos;i="5.72,393,1580742000"; 
   d="scan'208";a="44965826"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2020 12:55:23 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 46BBC400C43C;
        Fri, 17 Apr 2020 12:55:23 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] dt-bindings: dma: renesas,{rcar,usb}-dmac: convert to json-schema
Date:   Fri, 17 Apr 2020 12:55:14 +0900
Message-Id: <1587095716-23468-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series converts rcar-dmac and usb-dmac documantation to
json-schema.

Changes from v1:
 - Add power-domains and resets to required.
 - Fix some properties about related dma channels on patch 2/2.
 - Add Reviewed-by on patch 1/2.
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=269169

Yoshihiro Shimoda (2):
  dt-bindings: dma: renesas,rcar-dmac: convert bindings to json-schema
  dt-bindings: dma: renesas,usb-dmac: convert bindings to json-schema

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  | 117 ----------------
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml | 150 +++++++++++++++++++++
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |  55 --------
 .../devicetree/bindings/dma/renesas,usb-dmac.yaml  | 101 ++++++++++++++
 4 files changed, 251 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml

-- 
2.7.4

