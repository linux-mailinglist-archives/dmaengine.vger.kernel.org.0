Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9446F52B2
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 10:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjECIHl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjECIHY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 04:07:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493124C2C
        for <dmaengine@vger.kernel.org>; Wed,  3 May 2023 01:06:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso6140816a12.0
        for <dmaengine@vger.kernel.org>; Wed, 03 May 2023 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683101194; x=1685693194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gyjgzcHcuTrzimRBAkbhhP17s7Un7s4JuKZjLwsSKs=;
        b=omp7zO5bpP24t1xIfbqQvlh1zCOeeoFQxGPlT9aytRPE68zpBDg+OmVumdJiGQ5kxd
         Zta4TtRDdEaPVsm3VdmgrAF5jp6J+rD2LIqaQ7wd7p4Z/aSg3KOBMR8a0W/tiZ6NwndT
         hnbhTyP+A4PIo0XkKQPc9BFFil5wE+cENYcIRbVepRQ7+u7ehKKH4oO4XXU9Ui7QK2f9
         1odyFjKhu2xPMHd9UOFkK6jY+ycso7nqtGQz0J4lDBrlf1ezPY2jsaJI2oPAVFHwAV3k
         RU+DnGrKqzOd/i32XNRx0O9cCl62bvp/bWx2t/ebwzXLVt9RISrJUR4E+1B5qL72lktr
         U5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101194; x=1685693194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gyjgzcHcuTrzimRBAkbhhP17s7Un7s4JuKZjLwsSKs=;
        b=Jqgv1X1itn2rzkv68+EWe24idDEpMk9TRKOI6ipAODnc0QUxlgS0QHDXCuwVLznbE6
         Hnhws5bsI51vHNeFhxcvN+gQb2LZO8Gpa3GqscSRJ3Hn2f7nf6O6lJKCL0X+ZfWc0+64
         nvY4bn2Reo6YuGExjYmtOpKwpZYmWw/Q7XwFPz7i1wNS+8E+9QyIHq6fIY5NTfLfhyqA
         DD5H2/W6q/Y9Kqq96VLeZSxntmVLz+ZlNdMeTdPGW9Wjv/XVgJvqyyQx2n6MJfnIX7lH
         Hhp06/VN/WSi8p4mYpGqMHXY34OOTd21xULulN30/p9gswD0v4XXhtpdTlupAnRstwQL
         y3TA==
X-Gm-Message-State: AC+VfDxG5ud/6PAiL+8ZY7SQOK36QLPIbMHqRwJoPbiu8XAXC6aBalBO
        cJSSxTQPGanDYWgcDpf58EvXrg==
X-Google-Smtp-Source: ACHHUZ4Y6tbZwaffBq/rtJsqI28bLStGSLV0TK8GiKpzA04A/O553szr/NkYO6n9nsTQE2JgKF2qpg==
X-Received: by 2002:a50:fe85:0:b0:50b:f999:9dee with SMTP id d5-20020a50fe85000000b0050bf9999deemr299275edt.8.1683101193817;
        Wed, 03 May 2023 01:06:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5? ([2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5])
        by smtp.gmail.com with ESMTPSA id y25-20020aa7d519000000b0050b57848b01sm414202edq.82.2023.05.03.01.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:06:33 -0700 (PDT)
Message-ID: <029ba923-d13e-ea7c-018d-95e179dda2e5@linaro.org>
Date:   Wed, 3 May 2023 10:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <30424f5886ef42419f65c2d5131ad30881c727a4.1683100816.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <30424f5886ef42419f65c2d5131ad30881c727a4.1683100816.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03/05/2023 10:00, Michal Simek wrote:
> DP DMA has own power domain that's why describe optional power-domain
> property.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - rewrite commit message - requested by Krzysztof
> 
> The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
> DisplayPort DMA controller") added this property already in Linux that's
> why the patch is also fixing dts_check warnings.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

