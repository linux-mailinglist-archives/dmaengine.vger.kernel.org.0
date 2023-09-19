Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021F7A6CA6
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjISVDG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjISVDG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 17:03:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CBEBD
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 14:03:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500cfb168c6so10300480e87.2
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695157378; x=1695762178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkfWxT6lfF9Ia8taCV57X5Sx4DgFIC2eOwDKvIcY1ZQ=;
        b=PX3EXe9v/Y+TABtDVf31UsjX7uSLGYyl+PrMBN2RBhetQ4ZaLMjITGso4eoL6mtOQ3
         +3hEqoICdlX9+LImtnSlMw+aOGLwk3+5IJMGhH9k40GJleOhLJS203I8m1Had4M/fzjP
         rJlrktQkiTT06S5F0a2P+lwvyB1qjDvsKn5ri5HiDk7TUJ/P3jCdwbvNDbmW/J3aRj/f
         6gTIVlI/OJZcdzLRCrAcXsOAvNdGgOwBhHV629Y+ojH4TbKFdVk3tlCoO9f4JtntHXMe
         DO1PDFOBx3xN83EWqU6Bs9igsJ6W81++Gb7cpSaslAxu0Mtzr6M+TVNYi08d7/9g6e+V
         S3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695157378; x=1695762178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkfWxT6lfF9Ia8taCV57X5Sx4DgFIC2eOwDKvIcY1ZQ=;
        b=YYzRPmrsn6I/1JEk+9wcPEC17qe/rOZVpYxv/I4u/fmX21lGjq6nRmWPmFSE2FiG3h
         BnDz/AlLI9YlbKCK5GJluz2JqeUye50bzamvWQRBpEHjiBLye/S2kMkORG2EpsdXM8G5
         aB3cmvoBerSrRz4Lwtn4vWWsxGWdtwOK429YuAmxfm5Z29pGxOwD6lVuomVQbET/DBb0
         O8qoPKZRfyoeukmMyt55ouJIFfCnbOSY1gN7G+tpjoVDDNvSEB7LBjpW3RMklkWQPeNo
         MTFwKMI4vPEbG2betoMLkuECYO8DgTovoR4sdhxcR2SDbzgU9Q0t61ucHkm7vemO11fB
         I6fA==
X-Gm-Message-State: AOJu0Yx6NkZYzdDP8capcIIe5Al+xxdJiQvS7WK0him+/fU+0CEbq6Ye
        l62vq+6Dpb8u8aaySOd8TYAX2IHNkWL9dmrs2rL9zfZu
X-Google-Smtp-Source: AGHT+IHe+WAuxmq7/z2dNqLJ2lJwsnpQ9WIa0o31Rv1Kgj2hU/G9drguSW4AcBUqIPtCxizw88o1rg==
X-Received: by 2002:a05:6512:470:b0:4fd:d08c:fa3e with SMTP id x16-20020a056512047000b004fdd08cfa3emr606762lfd.42.1695157378512;
        Tue, 19 Sep 2023 14:02:58 -0700 (PDT)
Received: from [172.25.80.155] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b005232c051605sm7848240edw.19.2023.09.19.14.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 14:02:58 -0700 (PDT)
Message-ID: <36a51519-2755-20ff-c2af-770d87d7cdf1@linaro.org>
Date:   Tue, 19 Sep 2023 23:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 36/59] dma: qcom: qcom_adm: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel@pengutronix.de
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-37-u.kleine-koenig@pengutronix.de>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230919133207.1400430-37-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/19/23 15:31, Uwe Kleine-König wrote:
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
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
