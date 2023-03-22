Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9A6C4FB7
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCVPvt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVPvs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 11:51:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C71EFF4
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 08:51:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y14so17595296wrq.4
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679500306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5Eifdopw31mjfKmNF1NMYE89orTEit7qkJMshxV+uw=;
        b=dbT4LveGU1bLON7XsTtGelepOrg4v4dLGAwXKqrR7fj53K7GbBBUml9XAJHdQkSOHd
         18DO/l7qXakDMRX7UUvVbZxXnzQIdQYPKoYl7l0q0D6JJUKRR4NIgDhgVqOLLe+yZGNP
         icG0yfPdcW1NhtIxSrzK0ig7Yifth5vja0UNXSiFO++ylwOYBSnbEtB2FOk6cOfNGghK
         rb/vhVAiSo0myvDlN+HTesYoefKzT7BYFLeudEZasov5NjWxqw1lPlTtD96vmkHO3nbH
         4h5MzA5n/8cJEFd3BCcdlGpfxucU3FGKjxsVifIzwRaiTm9MRwnrl9h4trI9gp3Ayz+n
         2kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Eifdopw31mjfKmNF1NMYE89orTEit7qkJMshxV+uw=;
        b=6g+Wib9zJQGIBUyvN9K57ye2jElxzWbbmI7+6Fhn4M+XALWTg9ni+JoQ+SO8fSFpNw
         1mQwu9daiuldcKs9/bXK91RdLjtuOCpwkugC8dDv/UDESEsE7dIMAs7VjydFVls9Ff+/
         WEPz9qZbjidRePmDIcNpJwh6d3JklDZOglm212sbhIUR85wNSBchJ409vCvCTKCwJ0D5
         U9pVqpOQlM/w8jUWOSrXunbRslZNn7PSZ4pCGwug1GISc75cU3iRufI2QWlUGELSP0da
         +2QuMUB3XZT604G+AukvdQAw0uZ5xwrsknXblN/HQKT93GQPcM6jH7uUDbZLRGYCMt3M
         RzDA==
X-Gm-Message-State: AAQBX9eA2zu5PqVz6Mbgk/g4ttaZqvQuirfZ2w/sNayC4TPrzq5uIjT9
        cZvPE0f0o3YHyGH3rI1vzx6j0cF59Vi/LZfHocBYNg==
X-Google-Smtp-Source: AKy350Z8MX5a3aiUvzxaVIYlRVTlRp5zcr4AR3+hu+yYqzrTYE34UO5bdIIAe9nmPE5Mp9qxgFIcCQ==
X-Received: by 2002:adf:f552:0:b0:2cf:f0c3:79ba with SMTP id j18-20020adff552000000b002cff0c379bamr176772wrp.67.1679500306203;
        Wed, 22 Mar 2023 08:51:46 -0700 (PDT)
Received: from [192.168.1.166] ([90.243.20.231])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d60c2000000b002cfe71153b4sm14112893wrt.60.2023.03.22.08.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 08:51:45 -0700 (PDT)
Message-ID: <635f5ad4-9360-eb22-3780-d91a04cc0768@linaro.org>
Date:   Wed, 22 Mar 2023 15:51:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
 <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
 <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
 <7ecf4fbf-392e-7c55-b731-2d61f962ddeb@linaro.org>
 <ZBsRlJ0o9Amf402f@smile.fi.intel.com>
From:   Niyas Sait <niyas.sait@linaro.org>
In-Reply-To: <ZBsRlJ0o9Amf402f@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 22/03/2023 14:32, Andy Shevchenko wrote:
> SPCR is not standard either. So, that's to show that this is not an argument.
> 
> Are those firmwares already in the wild? Why they can't be fixed and why
> existing CSRT shared info data structure can't be used.

Few arm platform ACPI tables without shared info

NXP I.MX8 EVK:

https://github.com/ms-iot/MU_SILICON_NXP/blob/master/iMX8Pkg/AcpiTables/Csrt.aslc

Raspberry Pi:

https://github.com/tianocore/edk2-platforms/blob/master/Platform/RaspberryPi/AcpiTables/Csrt.aslc

Windows Dev Kit (Qualcomm 8cx Gen 3)

https://github.com/linux-surface/acpidumps/blob/master/windows_dev_kit_2023/csrt.dsl


Do you know where is the shared info data structure defined ?
I couldn't find any reference to it.


-- 
Niyas
