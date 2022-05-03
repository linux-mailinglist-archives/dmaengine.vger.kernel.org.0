Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC755182A4
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiECK5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiECK5H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 06:57:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C4F3337B;
        Tue,  3 May 2022 03:53:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 869FF1F43E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575214;
        bh=vD1CX0oiP/NhStt+r5eRlNmVAcc80XzoQPqgY8PYNLI=;
        h=From:To:Cc:Subject:Date:From;
        b=Zcsfl8bf4NgCjl/eU91EUz+RDKJp8JCDdajucFkR6/BpY8mqDKnsShBs0hE5mQJ7p
         GAQXfdY+/3B0t5yCPMYzjDy5sdhNxO6ki9DtVe1XbqEzgxmykn/pzMrdKgOa4BxELK
         nCLwGrdwZGWIkX7Nl2/OxprDG7XOtyLFPgsZ84w8dM6+hjrvZKuuIOSl5FY8+7hCvz
         h+Bu7nWTWWtIwcxSBv6Wv1yacjGTtrXALMfNFSfzR4sGsde+4yy9McYsx4v7bIK63k
         4oJ1s9zGCtiYwmXiCPDjUjl8oXjUeYlQWvdda4+4iCTxQ+X5sJkfKHTHTnXjECrfAI
         bzjXNI8dT74Uw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - CQDMA driver
Date:   Tue,  3 May 2022 12:53:26 +0200
Message-Id: <20220503105328.54755-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (2):
  dmaengine: mediatek-cqdma: Add SoC-specific match data
  dmaengine: mediatek-cqdma: Add support for MediaTek MT6795

 drivers/dma/mediatek/mtk-cqdma.c | 40 ++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
2.35.1

