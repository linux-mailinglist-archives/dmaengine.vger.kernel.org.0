Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2969ADD4
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBQOUz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBQOUy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 09:20:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656914224
        for <dmaengine@vger.kernel.org>; Fri, 17 Feb 2023 06:20:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i28so4344889eda.8
        for <dmaengine@vger.kernel.org>; Fri, 17 Feb 2023 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DepS95Xiv6tzBVf9W0DYPpboAHnjdejp3hM9TEZ9nSc=;
        b=Yp2ODLUktl1oQf6nksGQtZHVM8M5TW/tSP4Ywbb/s9ExrHvtB5Hb52c5I4gmsNRf7Z
         e5IZaQdDxc08Gai6InENBwbflRS5VqZLnuiEXDzvTGyg0vPfSqUEHg7ObsHuJVrlaKIB
         roiJvsk3GiuBxXfK7g9c2EGSPco1aWl1bqkkSK4k3iY7PVWkP3B2LkNuA0QbtKz2BJNz
         OwSaIWQ/5Zv0JB1O2F77QiLiGAdMnS6sD7iyIMsCd7CSa9Jv+nPzE0NreulSBacCPVCL
         AzjfSWDq4xOgtNFbVfKjqVoQYUCFoRqPX6R6LoABF9tG1HnAcPIG8CxCRvgxvlQuAyi8
         mFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DepS95Xiv6tzBVf9W0DYPpboAHnjdejp3hM9TEZ9nSc=;
        b=QQ6s7x1UV2r4GEqdcixE/20x5DQEc6q0aZ6zUkq8Vm5sFD+eyVCvpuvtFDxD1m5FtO
         sJBGhhXIDzyEIi6YeY9UBXqGCHMJjkZiQuGS1gkPGXFX6MU0Lo0OD/0ZlkJaVRX6VNZu
         NFx79t+M5T+/Gxp116kjfn/lvEWA6fUOyCQDHGwCouQ4eruJuKOZfOTdZT69ZzakQHr3
         NC71b9vKhru2ZlFBGy4Qdz8ZtXYlZFtZJ+p65CV3P3mnbnbJ6pDuXaVd+OUHAtnt+DBD
         ONuerthtfBgVQtI03+QzyOSL9xhCQMe+t1001Xg705VPfQeLfsydPtLbhcaoRbxb8FOb
         BIZA==
X-Gm-Message-State: AO0yUKUn+svEB3zZwxjN2NM4L4n2UuiAInJq5ld0J9FXkLOHqZblijNy
        ngfrL3fI2lRKd7nQuQKEwbzZJw==
X-Google-Smtp-Source: AK7set9rX7c55oN2r+fSDrfkxl+GHz0jcsU7INVi4Un1Ho2Dh46EQcbo0Bir57Bi89khR4O46oJc+Q==
X-Received: by 2002:a17:907:6b8a:b0:879:43d5:3832 with SMTP id rg10-20020a1709076b8a00b0087943d53832mr5075230ejc.14.1676643650875;
        Fri, 17 Feb 2023 06:20:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090616c100b008b13a1abadasm2162597ejd.75.2023.02.17.06.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 06:20:50 -0800 (PST)
Message-ID: <19c80f85-a1c5-3897-b592-6e9cd0579657@linaro.org>
Date:   Fri, 17 Feb 2023 15:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 22/24] kbuild, dmaengine: s3c24xx: remove MODULE_LICENSE
 in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-23-nick.alcock@oracle.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217141059.392471-23-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17/02/2023 15:10, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.

I think you need to base your tree-wide patches on next. The driver was
removed. Please drop the patch.


Best regards,
Krzysztof

