Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411F12E1A80
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgLWJbg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 04:31:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48052 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727678AbgLWJbg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Dec 2020 04:31:36 -0500
X-UUID: c36759556753491589d5ea0fefff35d2-20201223
X-UUID: c36759556753491589d5ea0fefff35d2-20201223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906518736; Wed, 23 Dec 2020 17:30:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 17:30:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 17:30:49 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>
Subject: [PATCH v8] dmaengine: mediatek-cqdma: add dt-bindings and remove redundant queue
Date:   Wed, 23 Dec 2020 17:30:43 +0800
Message-ID: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch set adds document the devicetree bindings for MediaTek Command-Queue DMA controller,
and remove redundant queue structure.

hanges since v6:
- fix dt binding format

hanges since v5:
- fix full name

hanges since v4:
- fix yaml & dma-mask code flow

hanges since v3:
- fix dt_binding_check errors

Changes since v2:
- add devicetree bindings for MediaTek Command-Queue DMA controller

Changes since v1:
- remove redundant queue structure
- fix wrong description and tags in the earlier patch
- add dma-channel-mask for DMA capability
- fix compatible for common

