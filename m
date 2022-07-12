Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F257201A
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jul 2022 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiGLP7b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jul 2022 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGLP73 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jul 2022 11:59:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B01BFADF
        for <dmaengine@vger.kernel.org>; Tue, 12 Jul 2022 08:59:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp17so6839387lfb.3
        for <dmaengine@vger.kernel.org>; Tue, 12 Jul 2022 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j6+PXk8lV1TXVHUADsHXPNfDWOMk0hNuY2THqh6dtzw=;
        b=WCaWesZaI9ZooJ3Eti+u5meFenVeVAykhce3G/w/pyzUZuu3XyOH943ZxO27OBSzUN
         L7aEBgK/W8Alrcw+AuHvhvJBl/OC/H4k6kdNlZbo6jhkCaJqTK7hCmTzkHNzbvzYVtcn
         PN106bKvlQlzPhQaDqC7MtCmYYnBIOgtrXHj45OyCn88zBWfUzQQAAacAqajTCQ28ew4
         6fwJ2xPHLOFs4Di4yVIYOc9g5wL7+O6L/QiKIsT7ZeLmoKrbxkwuTxUMvsfpVAGyIMTa
         m6XQCiDHwOTuem6TGtmHq/lZwIMgrfUaLTR6wfTib7UNU9mNmTho1uTwhI+yBXQ628nu
         r64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j6+PXk8lV1TXVHUADsHXPNfDWOMk0hNuY2THqh6dtzw=;
        b=CjpXNphki1pbUWlsLpjkX+fV8qGWEL+KzbqpEtYqzo4ah1Kqd6m72qsV9JT7Ku0IgZ
         z29dQouBZPwTDVOojSBN4P7ala4O65jtLV9q2ESYdOo2MWc792vUlyI61yOTfBITD4ry
         NEI1U/Rm90do+PSe1pGz5zvr6RA03CXSpNap3qu/Jz0Aa4O7i08sg86wmyJzs9PEq/Xm
         7o+Oxp5PTGa00Lx+icQmmUwY3+SrrZgPXO/7OArfN/YrmwB7b8O8/cemSj19A6HdeVDf
         ejQhJsxVoEEgH0WILpMwdbAksR4Ad6dr/HISIQjMSmN5/qxUc0sL2smx9U5TrQE/nRvr
         e+iA==
X-Gm-Message-State: AJIora9IuHop3ibgK7yz/XiEMxx6J4A23Wo+Lz5nOggJWd2rPZik/3Rr
        Gnh946Zkg42KuggDDXi1b+egAA==
X-Google-Smtp-Source: AGRyM1sXKSwY2kqCkXvSTvsJkmso8Nd0IefLuqwg19gmixZGRWhA3P4R74SYwesubgb1pAJocgzMAA==
X-Received: by 2002:ac2:4e03:0:b0:485:74c4:97ce with SMTP id e3-20020ac24e03000000b0048574c497cemr15199250lfr.13.1657641566787;
        Tue, 12 Jul 2022 08:59:26 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id t21-20020a056512209500b0047f84ecae2esm2235047lfr.236.2022.07.12.08.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:59:26 -0700 (PDT)
Message-ID: <eeed43cf-7bd6-9d77-9e1f-e018a236a058@linaro.org>
Date:   Tue, 12 Jul 2022 17:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 04/13] dt-bindings: memory-controllers: add canaan k210
 sram controller
Content-Language: en-US
To:     Conor.Dooley@microchip.com, damien.lemoal@opensource.wdc.com
Cc:     daniel.lezcano@linaro.org, Eugeniy.Paltsev@synopsys.com,
        sam@ravnborg.org, daniel@ffwll.ch, paul.walmsley@sifive.com,
        vkoul@kernel.org, palmer@rivosinc.com, airlied@linux.ie,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org,
        masahiroy@kernel.org, geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org,
        fancer.lancer@gmail.com, thierry.reding@gmail.com
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <20220705215213.1802496-5-mail@conchuod.ie>
 <a516943f-3dac-70a0-3ebd-9f53fd307f25@microchip.com>
 <b8b015f0-d16f-8528-719a-1a3f74d9f176@opensource.wdc.com>
 <969567fa-77ec-48da-ef63-c5d18de4b213@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <969567fa-77ec-48da-ef63-c5d18de4b213@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/07/2022 17:54, Conor.Dooley@microchip.com wrote:
> On 11/07/2022 00:21, Damien Le Moal wrote:
>> On 7/11/22 04:39, Conor.Dooley@microchip.com wrote:
>>> Damien, Krzysztof,
>>>
>>> I know this particular version has not been posted for all that
>>> long, but this binding is (functionally) unchanged for a few
>>> versions now. Are you happy with this approach Damien?
>>> U-Boot only cares about the compatible & the clocks property,
>>> not the regs etc.
>>>
>>> I (lazily) tested it in U-Boot with the following diff:
>>
>> If both the kernel and u-boot still work as expected with this change, I
>> am OK with it.
> 
> It's all yours so Krzysztof :)

It's too late in the cycle for me to pick it up. If you have alternate
tree to take it through, go ahead with:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Otherwise, I'll take it after the merge window of v5.20, so in ~1 month
according to crystal ball.

Best regards,
Krzysztof
