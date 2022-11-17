Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1C62D5DD
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiKQJHg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 04:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiKQJHf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 04:07:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7383558BCB
        for <dmaengine@vger.kernel.org>; Thu, 17 Nov 2022 01:07:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i21so1574331edj.10
        for <dmaengine@vger.kernel.org>; Thu, 17 Nov 2022 01:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yjNlU8q2y36L4sRDz7WyozzVBMIW4wTXmXo+aeTQepE=;
        b=E+E1YRgkWSrVP3uIhxnrmYo8avbWBja+WVFLPxfsB4qF/MRGDZgBu2Myai5WjF6nwB
         v4d7POJpuGIYcYANWoKza7uSRiqPEfIItpKIJVzN6v7LDFeWVUu89k1k/RObMO7xMS6G
         NAyJ8r8rL14ueqzH5/ZMEqb0xIY/bTZ9TrNE+IjdaBeEbHQ/bWeog5L2bDDN1Ote2bHU
         3VJfqbysVXQH0X8I5B0sOiY4rL4jrJ3sflrhM8YnJcmOQSa6xdKGP/wKSVUXES60SLbX
         b0MxpY5z4CwuUWq6U6/XGB5k0mMLf4yrMdmHsfsBGI12e+MSfi/chx/MwEPWLQ/ukdZJ
         hftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjNlU8q2y36L4sRDz7WyozzVBMIW4wTXmXo+aeTQepE=;
        b=1Csj+kZi8+Y8iXYCxwS8wKTA+pj2Of8d1up7x8VWQiICZhl3/7FrdmaMip1bfFKEvp
         SHi7XVkjGSCCsltUAY4rYt4JSpH3uQsE0SSyt4oM1WHiCFWAUGECga5S6McKhwIaef8I
         Sdh8PRGXYEg8KJAtv2Sapod43bWaa+bMKySUoNgqCp3lgp6ARv/osd/pjXpmJZHKFHx8
         +tr6YyZ91aY70c1om3DJZIO2OY85t2ns8gQiKHC2klyAt0ZvaPYN1xm2A1YxyNpOkmj8
         PO5TyVVSaS2IcXoo1fSsG5aUrzGUebATT9/HufjZrSjBoKYf0oxzm7HTgxZrpbAZoeg/
         d5Qw==
X-Gm-Message-State: ANoB5pnyniI0xyI27BQNpsxtOP1Hs9a508+S7i+QSaFWcHy0dYCvsq39
        rlkeja0O/AZCVNTZeEswcvS3yuU64m1L8UGYT2CAQcdIaB8=
X-Google-Smtp-Source: AA0mqf4eW2j5xeUD3XT6l4PcGb3bqpIe7DMA8nLtU3wrTQp86Z8ebjhL0qefUE1DLcnpS0Vru26vexv7J82nnBZVc2U=
X-Received: by 2002:a05:6402:2948:b0:463:bc31:2604 with SMTP id
 ed8-20020a056402294800b00463bc312604mr284934edb.32.1668676053056; Thu, 17 Nov
 2022 01:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20221116065717.3069712-1-ruanjinjie@huawei.com>
In-Reply-To: <20221116065717.3069712-1-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 10:07:21 +0100
Message-ID: <CACRpkdZCwDvJkOr+7_3ua_sb1p70pMDcx7UTcH=VTKQBvX9iLA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: ste_dma40: use devm_request_irq to avoid
 missing free_irq() in error path
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 16, 2022 at 8:01 AM ruanjinjie <ruanjinjie@huawei.com> wrote:

> free_irq() is missing in some cases of error in d40_probe(), use
> devm_request_irq to fix that.
>
> Fixes: d7b7ecce4bcb ("ste_dma40: Rename a jump label in d40_probe()")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - use devm_request_irq instead of adding free_irq() to fix the problem.

Thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
