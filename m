Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C365EDF6C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiI1PAX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiI1PAF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:00:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1412BE2E;
        Wed, 28 Sep 2022 08:00:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so8691854wmq.3;
        Wed, 28 Sep 2022 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=fFiLND83FCjvj8QwqbyEssDIGtRuYehgQzyyJqOIdyc=;
        b=UQ3q/e1ke5sijr2KhSsWJYHOGV0H+c97fEYqLx2EepdISeaRTbn66VWqkWHMsT5aPv
         frhEcMl4SIyG5IbklWvidgmPSFFWZZLWxLstHaeON/YLji3GVTkAVaSdAsiJVBCGTAHX
         nsri/LyBsmour2b96MFsXtebmyN/+Yjz/XWNzbqK5HSHy5vuHEVnU3pSMvbykqqweDpF
         mrLCM7WJkqZ5/qtHpAnU2JdxEycaDKXpxU/F1sWNKgX7pkOPzLAz42fDCuwNkLD6Vb+9
         qTWE+0tt9IkVQWUT+EqkCW4QRW5NtQ+cWVb18bhYVKLbgTwyl6fMeXeeTtdHPXHdjoZ4
         k/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fFiLND83FCjvj8QwqbyEssDIGtRuYehgQzyyJqOIdyc=;
        b=zQCVz6XOS748eShP4CPR+AZPm6K7Z5u8fEJOmAQCzFjIE/8acEl2OMm4Ou+d4BmkvU
         lX0RyeUm79QdMv68ETVwPYkaygE+LUayr0qz4r4NK3cw3egq9iqFC9ywOV1mDG0BH24J
         9LpmSS/Z/n15VVVNIvGEBZCKWnKuW/1cXASTf95u37z1i7Cssig6+NSOyfm7NYj8SBrB
         bU8kPL2IS+VVNf3MHMaC+/qMwM/zZ3LAWWIZAJL2+ywnVD972li19TOlnegHG/SLkUlj
         4FM576H0qgoXeb8fhwYoLLydIdPSNscgC1Ajk5ITj9D7A2SFL5+oK7PhvKkqZ7i2rdOR
         v15Q==
X-Gm-Message-State: ACrzQf282mBO/zwnrU5WwUvpeDybP/Ndrp1Cpf03yHnY4rL8u2dq+DS6
        rAM2gScT+rk02IYGC4m2ts8=
X-Google-Smtp-Source: AMsMyM7lrfFC0VKPitQtgOmDtxRV+EymVgDdvtALG/htkm0zTcSAR6tU3+XXNjhkGB8g3q/eEEnlBw==
X-Received: by 2002:a05:600c:3b12:b0:3b4:a6ea:1399 with SMTP id m18-20020a05600c3b1200b003b4a6ea1399mr7157848wms.49.1664377199052;
        Wed, 28 Sep 2022 07:59:59 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id x14-20020adfec0e000000b0022a297950cesm4547101wrn.23.2022.09.28.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:59:58 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:59:56 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH v2 2/3] dma/ti: convert k3-udma to module
Message-ID: <YzRhbNd4Dse+zLSb@Red>
References: <20220927230804.4085579-1-khilman@baylibre.com>
 <20220927230804.4085579-3-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927230804.4085579-3-khilman@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le Tue, Sep 27, 2022 at 04:08:03PM -0700, Kevin Hilman a écrit :
> Currently k3-udma driver is built as separate platform drivers with a
> shared probe and identical code path, just differnet platform data.
> 
> To enable to build as module, convert the separate platform driver
> into a single module_platform_driver with the data selection done via
> compatible string and of_match.  The separate of_match tables are also
> combined into a single table to avoid the multiple calls to
> of_match_node()
> 
> Since all modern TI platforms using this are DT enabled, the removal
> of separate platform_drivers shoul should nave no functional change.
> 
Hello

You have some typo in last sentence. (extra shoul, nave->have)

Regards
