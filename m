Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071764BF5AE
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 11:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiBVKZN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 05:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiBVKZJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 05:25:09 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88A159E80;
        Tue, 22 Feb 2022 02:24:44 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 8so4277855qvf.2;
        Tue, 22 Feb 2022 02:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZwVsXW12gm3VwwhPmVGdM4QmytARwditCmcefz+2r74=;
        b=Z1mQiaGgxCb9cd9lkH/PWqaC7V+yMwbi8iDmq2TQ4kPMn+Dhm9OXlqeFFF+rMvgQZE
         8/b7D5EtYdkfjwwtrUAf7pUFKB2+NgTSsiVs2WbKyMoYVQ69FLQdzDOFEa2MghOF06jO
         M/JBE0U0abxWVXw8mRF0MX4CV6fcS3JfA+R6qMUqmkOKLT+v+N2kt2nlDEYeaIJuu+jR
         xJ02RjQCyzFBjewl4i3R6pRfjFHD09KEOHWd+wDAjMiBe/kvBX4tRYIMhNuHZdRCXRIm
         703qF9SZZX+aDIspAJafIAXDPQca+8eflHkw3Uve9aGUzOgMh6foCNCgOAn9M5JKmznP
         Y1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZwVsXW12gm3VwwhPmVGdM4QmytARwditCmcefz+2r74=;
        b=b4DExrUS1MUbJiuB4G+axJ022v8Iw2xk4dbgJalgN7tI8EUNAL9PcoUHWk3w2Gdw5c
         ziIxCOfFZKsvh3+cju+w7DOh7hm6n8hFGFaGFj41HcsEqkZHFqi0b6NTrmI7iOIoOxZT
         9atS/DzJooPTHAZnJ4BRCTMgk3GkeYRFC3rJVsC3wiMBv09GwAPluopTwCcIqZnSkq5U
         VQtrj1zC7kHjOW4ksvnAg3pPL3A+eDx+E9sV+CR8pwmajPBoM8q2lsGyX6xxbudDNVFo
         yhrNc8cfdFpJAP72CTVx7oRcSNT3FG1tDULzf2XPEn1vrln5SMWq6zIwJgDfDyQ/ZFml
         XCSg==
X-Gm-Message-State: AOAM532u/rlF+L4lF92a+QBONRyk94bPwQT+GxqvmjbvUwiD+CFHROBq
        tovKTdX+/fkML4MDumIKhiI=
X-Google-Smtp-Source: ABdhPJwY72MpP1R5Ah7WW2R4pXSYtRWIGk0/fr7S/30d7VWzLmNB/IjZkS1+K5fOokHdqM4wX5Slow==
X-Received: by 2002:a05:6214:4a1:b0:432:3676:f227 with SMTP id w1-20020a05621404a100b004323676f227mr2877021qvz.25.1645525483968;
        Tue, 22 Feb 2022 02:24:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y18sm32215141qtj.33.2022.02.22.02.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 02:24:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6534b889-41c5-dd7a-578b-27dc6668064a@roeck-us.net>
Date:   Tue, 22 Feb 2022 02:24:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MIPS: Remove TX39XX support
Content-Language: en-US
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20220222090435.62571-1-tsbogend@alpha.franken.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220222090435.62571-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/22/22 01:04, Thomas Bogendoerfer wrote:
> No (active) developer owns this hardware, so let's remove Linux support.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
[ ... ]

>   drivers/watchdog/Kconfig                      |   2 +-

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>
