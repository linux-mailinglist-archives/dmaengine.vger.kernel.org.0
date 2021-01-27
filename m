Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10B73059D2
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhA0LcQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 06:32:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49440 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234561AbhA0L35 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 06:29:57 -0500
X-UUID: b5bb2622af81498fbaea7ba78d78c70a-20210127
X-UUID: b5bb2622af81498fbaea7ba78d78c70a-20210127
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 566658098; Wed, 27 Jan 2021 19:29:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Jan 2021 19:28:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 19:28:48 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        <joane.wang@mediatek.com>, <adrian-cj.hung@mediatek.com>
Subject: [PATCH v1] memory: mediatek emi: add MediaTek EMI driver
Date:   Wed, 27 Jan 2021 19:28:41 +0800
Message-ID: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch set adds MediaTek EMI drivers.
MediaTek External Memory Interface(emi) on MT6779 SoC controls all the
transitions from master to dram, there are emi-cen & emi-mpu drivers.

