Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A135AC5BF
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiIDR0T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDR0S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 13:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D4C33367;
        Sun,  4 Sep 2022 10:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DECE60F9E;
        Sun,  4 Sep 2022 17:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC08CC433C1;
        Sun,  4 Sep 2022 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662312376;
        bh=R5gWxWKYx8VItI88Agd++HUcExaO5prF6Vu0sO1trTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNTKxqSPyZkp/kuGSF6u/gx89TsnNB8ulCRyZcbdl0n279YMp1YgrwKR/Y1F8qTUX
         5lr166D6Ss07JJaGg+NqWAm1ARI3fOlUHOM7Mixreix7k/5vhSMo2T2q+D7P1h6Mib
         hELOuEVSNHXUUxIc6CwlXaAqIptUJqMjdbL/JeHl5NB6Gz5C0SheJwg8DU2LzUGec7
         Ag3VCe+zHcQziNAefNRBAEP6irr2yQ1Z32U/7NWh9b8REE1fBN+FG2/YaWatex1swQ
         ozIMBwivWEwr/mCJXmyhwN8z82jJY90/H9uO2KFZbI1Tz/MDAOGl0lyAtb67UGDArr
         yB5grrR70VaVg==
Date:   Sun, 4 Sep 2022 22:56:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        fparent@baylibre.com, sam.shih@mediatek.com,
        sean.wang@mediatek.com, long.cheng@mediatek.com,
        wenbin.mei@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/8] dt-bindings: dma: mediatek,uart-dma: Add binding for
 MT6795 SoC
Message-ID: <YxTftFYUAAujw90V@matsya>
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729104441.39177-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-07-22, 12:44, AngeloGioacchino Del Regno wrote:
> Add mediatek,mt6795-uart-dma to the compatibles list to support
> the MT6795 Helio X10 SoC's UART APDMA.

Applied, thanks

-- 
~Vinod
