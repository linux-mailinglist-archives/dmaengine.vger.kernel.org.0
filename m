Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B297A7928
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjITK2O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjITK2M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 06:28:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0AAAF
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 03:28:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD2806607084;
        Wed, 20 Sep 2023 11:28:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695205685;
        bh=/Wl9oF5OBPQIjlHo6jdFXz5jq044BfPBrLxmHu73RDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fXD6vdSB6klZZA2par8cbO1h1upB4+ZKVAjdvwUDwn4czOoScM/Jl/eGSdl1lusSV
         cBIrdu2XyZRIiz6AtkjbpvQqWrxbsLBjvHxxs+9X/dxOx6qn84jT3Hi//A41Uo3k7k
         iLjF4rpzgnytIj/Ap7E/C1+MJi3if332Dl7ky1pfbmaTZDpjcrLhEbaMuPuu0BBmgz
         cqzcF0AEf8i6ti4OXEuzd56dqfqS4z0c5wAg42fW/SjAY/kyQJSuiIT4SsL9bxIXEM
         So/QRGvzh29/DjdlhNn5BEIlGGx7+Ot0KUudG6JVOlyIS3woemw4SRpARDioUe5LFR
         CSwmC9Sau++9g==
Message-ID: <3f78fbed-257d-7a51-f6ef-813d665d91a5@collabora.com>
Date:   Wed, 20 Sep 2023 12:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 23/59] dma: mediatek: mtk-hsdma: Convert to platform
 remove callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-24-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919133207.1400430-24-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Il 19/09/23 15:31, Uwe Kleine-König ha scritto:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

