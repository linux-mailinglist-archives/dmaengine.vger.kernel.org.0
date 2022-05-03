Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCD518620
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiECOKD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiECOKC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 10:10:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3638D80;
        Tue,  3 May 2022 07:06:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AD07F1F42D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651586789;
        bh=p6sOJ83Tcjg2H8v38ag3jKrs/9LDdbWTcZtSd7al2r0=;
        h=From:To:Cc:Subject:Date:From;
        b=NL4/a77cO4MrKh0BCkmaPyPmbsDe31uvwFFKPUt/yTBlMUAfSw87XYFHldNJ7OPxo
         ANIctnf/t4IabfvFX54W57WHYLzT8LhfFJQhr2Ph4kSZ31FqmrgSYYBTTxXUGyb2yr
         NoYB8f7wIZqwPdZLL7bONSQ6Xb0juk21Kh/t1qSLlZDLy7uoxFf5+0VdyNgEKdnKxU
         g59takH65pfAcjJkC1h54+WtGWXFiF8WFXfcOyickEXC9sr6l4AqkkDnI8QoiTKwKT
         dgm5dkgjd1M4pY8YWzlMoqRXPcxLit55mWoqTuIArvzvr6Z9r9I69eQCjQPlKN6cCP
         2lXBhl1H5aBNQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/2] MediaTek Helio X10 MT6795 - CQDMA driver
Date:   Tue,  3 May 2022 16:06:22 +0200
Message-Id: <20220503140624.117213-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support for CQDMA on the Helio X10 SoC.

Tested on a Sony Xperia M5 (codename "Holly") smartphone.

Changes in v2:
 - Fixed errors around (sorry, at v1 I've sent patches from the wrong folder)

AngeloGioacchino Del Regno (2):
  dmaengine: mediatek-cqdma: Add SoC-specific match data
  dmaengine: mediatek-cqdma: Add support for MediaTek MT6795

 drivers/dma/mediatek/mtk-cqdma.c | 41 ++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

-- 
2.35.1

