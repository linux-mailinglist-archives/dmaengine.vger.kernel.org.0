Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D22AA4FF
	for <lists+dmaengine@lfdr.de>; Sat,  7 Nov 2020 13:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKGMWH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Nov 2020 07:22:07 -0500
Received: from out28-219.mail.aliyun.com ([115.124.28.219]:53595 "EHLO
        out28-219.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgKGMVo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Nov 2020 07:21:44 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2194764|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0117215-0.00453429-0.983744;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.ItnhwiJ_1604751644;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.ItnhwiJ_1604751644)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sat, 07 Nov 2020 20:20:51 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     Zubair.Kakakhel@imgtec.com, vkoul@kernel.org, paul@crapouillou.net,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH RESEND 0/2] Add dmaengine bindings for the JZ4775 and the X2000 SoCs.
Date:   Sat,  7 Nov 2020 20:20:14 +0800
Message-Id: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dmaengine bindings for the JZ4775 SoC and the X2000 SoC from Ingenic.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: dmaengine: Add JZ4775 bindings.
  dt-bindings: dmaengine: Add X2000 bindings.

 include/dt-bindings/dma/jz4775-dma.h | 44 +++++++++++++++++++++++++++++
 include/dt-bindings/dma/x2000-dma.h  | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 include/dt-bindings/dma/jz4775-dma.h
 create mode 100644 include/dt-bindings/dma/x2000-dma.h

-- 
2.11.0

