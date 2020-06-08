Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC51F13E3
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2020 09:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgFHHtp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jun 2020 03:49:45 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:60566 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgFHHto (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 Jun 2020 03:49:44 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C5AF1C9595;
        Mon,  8 Jun 2020 15:49:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P760T139944219621120S1591602577688290_;
        Mon, 08 Jun 2020 15:49:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e10282be9cd3eae483e94464a5236c88>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: vkoul@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        devicetree@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carlos de Paula <me@carlosedp.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 0/13] Patches to improve dma transfer efficiency for Rockchip SoCs.
Date:   Mon,  8 Jun 2020 15:49:14 +0800
Message-Id: <1591602567-43788-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org




Sugar Zhang (13):
  dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
  dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'
  dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
  ARM: dts: rk3036: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rk322x: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rk3288: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rk3xxx: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rv1108: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: px30: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3308: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3328: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3368: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3399: Add 'arm,pl330-periph-burst' for dmac

 .../devicetree/bindings/dma/arm-pl330.txt          |  1 +
 arch/arm/boot/dts/rk3036.dtsi                      |  1 +
 arch/arm/boot/dts/rk322x.dtsi                      |  1 +
 arch/arm/boot/dts/rk3288.dtsi                      |  3 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  3 ++
 arch/arm/boot/dts/rv1108.dtsi                      |  1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  1 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  1 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  2 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  2 +
 drivers/dma/pl330.c                                | 44 +++++++++++++++-------
 12 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.7.4



