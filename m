Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEF52A5C3
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbiEQPNQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbiEQPNP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:13:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0E43491
        for <dmaengine@vger.kernel.org>; Tue, 17 May 2022 08:13:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h8so1439602ljb.6
        for <dmaengine@vger.kernel.org>; Tue, 17 May 2022 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BBebJTiHodUV9ldblV55ft742UQ2rJkdufcTm5gvCtQ=;
        b=hxn7iaw4tq1xquaVPp0wxTjPeUgyEjfBAuck6J2NXlhakNKBfax9mn1vWTz3pwIIFf
         BdZzItsrBjAP9KNSFu6ndW5TMq5YBKZ/H0Dm0l/hhDk/qTwDwUpfnaMClKpDboIpBl5m
         fJP1wK1ceEuDB1btr5FDLLm1q/UWCDO2Mm6II78Vsa3EnfYmXPShujbHI6HvFjDD0Fsi
         dvIuEtg78RaO2LdZoOAc4RVGzvfLQ94CBi607FpbvTda2+4L0K0QMwUWZYMzgux+P/4f
         OEafD68znM0NFnN0paWta3ykmhAUhtPbomvzEZxzCmwKuEaNuI2qNipxoIX6/7bhVLUX
         Wsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BBebJTiHodUV9ldblV55ft742UQ2rJkdufcTm5gvCtQ=;
        b=sDloSl/2Ere9kNuVjWZ4wuCZDWieDR2NUcCBeBKK5R7ocn1jeDFnDhAdTo7ct9fcI/
         zpp95WUUzK8RPkdQRb6bq1ov+31akr0WX1XTKyr3trXQLjKl55PWwegyJuwe7vOvfp9r
         1OY7nfN+hIkmrFsVq3DT9aNu9aUKG7HTR+ZRDDUbeehOGux2GkRx6XLlP1bd8PZOQKBt
         sTIWXVdRdQWXqRpxMoHx7X/gFwZ6PSlWFxL+3SUQHozw3BvWv9UyLQbX1dkg6gQJhozf
         aydd+EeqgU7vroiYh05XaOElVkaOkhylUdSpOGYGReJrQVgArdOVTpGJQVBDPaKbhvNs
         piOg==
X-Gm-Message-State: AOAM5318q/QzO5EILowtQZt8ChAgV3GTLPB3J7xB6AwubUiBv/vLqVQT
        KGr/hoDhMpMI62Lo+SDUqO+hYA==
X-Google-Smtp-Source: ABdhPJzOLuMhp4MaQ12VNGb4UETImwpwiY6962rbziwYorAUl57YU9brLcb2V6S9vS2EmzYb5gBFKQ==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id d19-20020a05651c089300b0024940233818mr15205604ljq.44.1652800392596;
        Tue, 17 May 2022 08:13:12 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a2e9114000000b0024f3d1daeb5sm1851049ljg.61.2022.05.17.08.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:13:12 -0700 (PDT)
Message-ID: <214de163-d576-d9be-76f2-3b70eefd6e68@linaro.org>
Date:   Tue, 17 May 2022 17:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check
 before clk_disable_unprepare
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-3-wanjiabing@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516084139.8864-3-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16/05/2022 10:41, Wan Jiabing wrote:
> clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.

Hmm, maybe I am looking at different sources, but which commit
introduced IS_ERR_OR_NULL() check? Where is it in the sources?



Best regards,
Krzysztof
