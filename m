Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045A64EDD5
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiLPP0M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 10:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiLPP0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 10:26:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D91058BCD
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 07:26:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so6856386ejb.13
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKpnCX1We6Wd+jFghY+6E3YYWeYuw8xu63PLFG+p7NQ=;
        b=mUCc71x2gfj8zWHkucpemaG9ceX9LG3EweMQXIAWBlZTy3Y9h+Ho2Ln0ho92leTzUC
         z6jTiXF32YnMtX/Fq2VsEVuabr3WksUq745MBuT00/4zwoe5k0rP9XXrRzeTufO4yNe1
         pJgodK/x+6zCI3Wvpzl7KjyHuka22cQpmupeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKpnCX1We6Wd+jFghY+6E3YYWeYuw8xu63PLFG+p7NQ=;
        b=47kGShheoq8rctwVppumHUT3xrbQPilrvcbL+GK2g2o5WmxBO4psu/yYngo0YRNhcu
         r7sO3V0quu4WcRmjGSqslJ2dbuYCYdostqBbTw1WLHIwgF+tjqdkl69JMXPL9GfeWhqA
         LseH3GsIk0w1O2dGhbDOpmr1vmVzbWP54joBLS1wA1s7W+007yv/mJSfOTrLiaGrCppO
         AEIXQobWKWl0W4fBiTcdjb5BG7E6CgcE83z+YJiyYBiQXa5A4TfQptDXcYqlnfzTmhs9
         cm9pcYYCAyFENXB/v3SyeVhw4YDpI5aJPUXRHQsMEKDQc0+rzBKRnSfnrShKUXXiemm7
         SgBA==
X-Gm-Message-State: ANoB5plpUia8qnb84+xOW215Mwc32A2oKBn2OFcunVLZQwSDVQ5rHrN5
        xCzBS6gJzpicOSJc4AHK2rxIQb4h7d/iEJlloO8=
X-Google-Smtp-Source: AA0mqf5Q+aBaiuuovJfZ0UQHEX8w08vbz0ri7breb8kk06/wmBl6t8vJY0yoqXs4x+AIuwSxn05AHw==
X-Received: by 2002:a17:906:80c2:b0:7c1:5019:50c6 with SMTP id a2-20020a17090680c200b007c1501950c6mr35890618ejx.72.1671204366825;
        Fri, 16 Dec 2022 07:26:06 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id la15-20020a170907780f00b007a8de84ce36sm925516ejc.206.2022.12.16.07.26.05
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:26:05 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id a17so1682077wrt.11
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 07:26:05 -0800 (PST)
X-Received: by 2002:adf:fd89:0:b0:242:1f81:7034 with SMTP id
 d9-20020adffd89000000b002421f817034mr27601714wrr.617.1671204364781; Fri, 16
 Dec 2022 07:26:04 -0800 (PST)
MIME-Version: 1.0
References: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com> <82ec225f-64e2-40a1-aa3e-58480f293d17@quicinc.com>
In-Reply-To: <82ec225f-64e2-40a1-aa3e-58480f293d17@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Dec 2022 07:25:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+XG9ZBFZOjnVVXfCQnPSCjdAwB095tiomhE9DNbW1Ag@mail.gmail.com>
Message-ID: <CAD=FV=V+XG9ZBFZOjnVVXfCQnPSCjdAwB095tiomhE9DNbW1Ag@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Fri, Dec 16, 2022 at 4:15 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Gentle reminder to review/approve please.
>
> Thank you...

I was expecting you to send a v2 where you beefed up the patch
description to add the "why". Maybe others are as well? I suppose with
that I could add a weak Reviewed-by to the patch.

This is also a bad time for patches to be applied--it's right in the
middle of the merge window. Usually the best time to send reminders is
between -rc1 and -rc5. Officially "Fixes" could be applied at any time
(even during the merge window), but unless it's urgent that usually
doesn't happen.

Speaking of which, given your updated description, I'd say that this
_is_ a fix. Perhaps you should add a "Fixes" tag? That might actually
help it get applied sooner. ;-)

-Doug
