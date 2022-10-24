Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1527760AB9C
	for <lists+dmaengine@lfdr.de>; Mon, 24 Oct 2022 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiJXNy6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Oct 2022 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiJXNyI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Oct 2022 09:54:08 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05002BD05D
        for <dmaengine@vger.kernel.org>; Mon, 24 Oct 2022 05:43:54 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id o2so5923321qkk.10
        for <dmaengine@vger.kernel.org>; Mon, 24 Oct 2022 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQzXqrwIC0QwRKejNt8LVE2JYI0YL7ErsUlEluRisec=;
        b=VfrgqMHPLBsQhMyfqIb+txPYc98Nb3UJm4VvRFohYHEeVwpx5tEBEq/qBfp6gx8Oot
         qqNONpCEVA9Y6PrzVNsO2cPI6ZrdGi3zbCUh1qRXfqKP2iVfZD41ff+/vmbWKvqgjkY0
         EQD1PbksJVU2r1r1LaSqfAx+hNjRbpxbNlW37LpNKNDBaXX3PWq5lOiDnarzKr1pIiUE
         tPUO5uNmIfe527jUdxGKP4d7ckN7lInohm+x/98bvtgDhmWbTvMHzebP0K1gcFSynduB
         mhNDJ9hXNk/va2Neh8DUz32F1PN/3vPSVmgoBzSGtszc77n498r4iRw/HkVj2xnWNJ+N
         53zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQzXqrwIC0QwRKejNt8LVE2JYI0YL7ErsUlEluRisec=;
        b=4k0Eo9W+yk4cHJCkRsbtIPEt7KG7JgMszREOTuYA6mGaEvCuj4pSyqJ0jroVrQojlo
         mX62EE1MOuP3pbBpjKCP0+fxJuBG0FjrzM+xm5kTDQOpZ5/zMqZWHByQOA4ppqPmGyS+
         Db6qmpEBnF8Wp3s2Hd+4hGhLQPKNngVyhsKLBbqNgDf3tmOI1/5JaeXmUs3vWvbSz1Fl
         nBEiOQZgZ728/DLOakh6zuMdpjBfu3TfqyaPPZYTxbiI3fvS+1Ai4M8NQbS8pQ74otZd
         ZD0cqB6uuFBXQuUOUtMIdOR8EJQO6RglxgG17PzXbh1sS5b+zBE+vchGY7pq9XFeM9lM
         lgUg==
X-Gm-Message-State: ACrzQf2JJTzwv08XAyqbQdGYy3eOkMoqPsIXpjjl2D5O+XLU58VcAgFu
        njIf4GHgdT/X0/l7Kiao7VIHJQ==
X-Google-Smtp-Source: AMsMyM5GJlopQSnchtqeAVaJKk0KkeZOI6RZXCaagWiqyRgE+7EghQIXyEkNJ8GlAlpcNHsw1akpBg==
X-Received: by 2002:a05:620a:1469:b0:6ee:d38a:7acc with SMTP id j9-20020a05620a146900b006eed38a7accmr22626676qkl.585.1666615202919;
        Mon, 24 Oct 2022 05:40:02 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006b9c9b7db8bsm15325374qkb.82.2022.10.24.05.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:40:02 -0700 (PDT)
Message-ID: <be51d813-f36c-61ac-88d4-8a18cc6507f8@linaro.org>
Date:   Mon, 24 Oct 2022 08:40:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 14/21] dmaengine: remove s3c24xx driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-14-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-14-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform was removed and this driver is no longer
> needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

