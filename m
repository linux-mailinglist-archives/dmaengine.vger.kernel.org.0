Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B334C122DC3
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfLQN7j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 08:59:39 -0500
Received: from out28-147.mail.aliyun.com ([115.124.28.147]:48833 "EHLO
        out28-147.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfLQN7j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 08:59:39 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3930146|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.292543-0.0249997-0.682457;DS=CONTINUE|ham_system_inform|0.00638576-0.00125593-0.992358;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.GJ3eyQr_1576591147;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GJ3eyQr_1576591147)
          by smtp.aliyun-inc.com(10.147.41.137);
          Tue, 17 Dec 2019 21:59:32 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com,
        paul@crapouillou.net, vkoul@kernel.org, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 2374286503@qq.com
Subject: [PATCH 0/2] Add dmaengine driver for X1830.
Date:   Tue, 17 Dec 2019 21:58:58 +0800
Message-Id: <1576591140-125668-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1.Modify the documentation description to make it more relevant.
2.Add the dmaengine bindings for the X1830 SoC from Ingenic.
3.Add support for probing the dma-jz4780 driver on the
  X1830 SoC from Ingenic.
Notice:
The X1830's dma controller is very similar to the X1000, the
difference is that the X1830 has 32 dma channels and the
X1000 has only 8.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: dmaengine: Add X1830 bindings.
  dmaengine: JZ4780: Add support for the X1830.

 .../devicetree/bindings/dma/jz4780-dma.txt         |  6 ++--
 drivers/dma/dma-jz4780.c                           |  7 ++++
 include/dt-bindings/dma/x1830-dma.h                | 39 ++++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/dma/x1830-dma.h

-- 
2.7.4

