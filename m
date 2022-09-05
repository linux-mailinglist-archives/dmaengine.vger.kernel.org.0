Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB16E5ACE3E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiIEIyW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiIEIyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 04:54:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9A43E40
        for <dmaengine@vger.kernel.org>; Mon,  5 Sep 2022 01:54:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bn9so8523936ljb.6
        for <dmaengine@vger.kernel.org>; Mon, 05 Sep 2022 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GOZXSDgSS6XVNIuSP6172uHE9FFSP1ygKgT21xJv4Pw=;
        b=y28Ow2gncnAb/WStbDPAzIRSfBO1sJIG6c/hL4IZsqFQkw8DiiGt+/1+8r/Sar73DW
         GwrA6BZftRN7uGAeZkSt037gMcsCPPNJayjXHDGLYelvbH63ilWTVdF7lJlXWk27tGZa
         Y2OScSdaV41kWaytvyOq6O634tWFvNft9qrEtafx0reImK3dlGEnOM2K7JfvylEut6Lz
         lA2VEKeuqRarXskEud8wNggns9EHnQ3pWgJbZ0s/NdOYBhpMZ9YZeqi4Tl4VEevdtOX0
         MvYwlvnxeYiG0pu66vl+ZJ+yCgqcYcvWp/d0MTAhqMEgHL0Y9XDWKJz1YN+UTCm6pVSO
         OHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GOZXSDgSS6XVNIuSP6172uHE9FFSP1ygKgT21xJv4Pw=;
        b=mI30ohosHnaCyK4y0EGN+VNIngSNtmvTLCdB8TCBsCEE4eRPt8n1IQ8Ez/nmfmnGCy
         fjo/ie759gPFNLeLMW5BWDp2GFBC6RMmRarZMmNuZ6BhfO4SQ/uozs2CowSXAO2PtyTx
         eoOqCRN0LLqJpuyKoqRnZgEkfzWneaZOitRtXk5xpacPa7xPyj9+hY4V8EclwFHOCt2T
         u/6o0yTvwZlaWTJIvWz8vuh7t/jkDFiYBfAzZ1rkBT7DhjvElxTKclIitypSz36ITHVU
         GmJP6zgk72Vuxo/ld0ueCE2MAtKfsOe8KUpbY8651wYhDr8Hsj77zTmPbxc6+SA/05Db
         vaeg==
X-Gm-Message-State: ACgBeo3dnGfoycTTn+sDRXhb36d3053BwXUpidauIR2dq41rWKPROknK
        jxMPlr8wkiIKj6tBBB2PMe8xAA==
X-Google-Smtp-Source: AA6agR4idNGK5YJuqnmH0xwk36aAANdU7yZpSyEgTcEYlRhbOPGO+Rg04B+ZQ0Nt9T0pCqdTNfrGLQ==
X-Received: by 2002:a2e:b894:0:b0:25e:cb1f:365d with SMTP id r20-20020a2eb894000000b0025ecb1f365dmr13835706ljp.285.1662368057594;
        Mon, 05 Sep 2022 01:54:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24350000000b0048fdb3efa20sm1121336lfl.185.2022.09.05.01.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:54:17 -0700 (PDT)
Message-ID: <0d523880-9214-7b9b-ce1a-d06d4d5fbdf1@linaro.org>
Date:   Mon, 5 Sep 2022 10:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220901020059.50099-1-joy.zou@nxp.com> <YxTPTnrJst9aNpsl@matsya>
 <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/09/2022 09:01, Joy Zou wrote:
> 
>> -----Original Message-----
>> From: Vinod Koul <vkoul@kernel.org>
>> Sent: 2022年9月5日 0:16
>> To: Joy Zou <joy.zou@nxp.com>
>> Cc: krzysztof.kozlowski@linaro.org; S.J. Wang <shengjiu.wang@nxp.com>;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
>>
>> Caution: EXT Email
>>
>> On 01-09-22, 10:00, Joy Zou wrote:
>>> Add hdmi audio support in sdma.
>>
>> Pls make sure you thread your patches properly! They are broken threads!
> I am trying to support for hdmi audio feature on community driver drivers/gpu/drm/bridge/synopsys/.

This does not answer to the problem you patches do not compose proper
thread. v5 which you sent now is also broken. Supporting HDMI audio
feature does not prevent you to send patches correctly, right?

Best regards,
Krzysztof
