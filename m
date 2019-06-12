Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6642626
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408386AbfFLMnI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 08:43:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41076 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408385AbfFLMnI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 08:43:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so11967580lfa.8
        for <dmaengine@vger.kernel.org>; Wed, 12 Jun 2019 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6vkS5UR633RrFItkYoPggOLkHWdZUqhLnRcNcB2XtY=;
        b=DWxwBLkLxa7JT3I+1DgXWyreCPEz8X0Ha8jOv9NGq44hFVhu69D4kduMd/7uGxdh2B
         cIWRCPCq9jJl98wMSvk7YGohrJKFaa4PjW4Fvp5KM5MDKt+1PdvXIPoI1h4fZ95dVbD5
         TaGctVbxlPdhfCs4/YfxV6Yh9vakovpMQRAO+ShReg9Ik42y2oFyjfGBQwD8ecB8Mx9e
         KsV3DGPXKQnRi3XO26tvGXvahStPbVMpkwSPPBVvPQeeQqaFZ4WA11sLI2Sgc4bbOkal
         7zKsFLYwaJ1Odl/F1Puf5twxvAEC0IhjHtX4SrQulhoxhfrJpiA1XP+ZGVCT+3bexZAM
         SnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6vkS5UR633RrFItkYoPggOLkHWdZUqhLnRcNcB2XtY=;
        b=AveMpOE7hjrlfuyNEq1O1/7zVoedPEZyUJMydd3uxk6d/2X/0t1xbpC3W2EsgudhVL
         VTsaiyxUlpKqbnZIigaNqEvaYgrdk17ptZxNP4h+KvJz5erTy/Os7uJScmGVcGy6xFpj
         0n8RHVsA1toXQ7OxXBxSsxP85ON5hRCeerJsEHdVLtoimv4uvNnRsC4eUl0+x526hUC0
         cvfJZ8hJSQ/SNZ8sh6B2foc1vjrUyDCMmtOb0A8HCJCFs4smwfbgfy7gJl35k0GM986C
         CtU6Snd47CAizY2Gszpfz94MYsMDKO4xopF3RV02Bc89/wXMNFTKaNrMkaPXK3DUpWBS
         oJ+g==
X-Gm-Message-State: APjAAAVkbWVUl0XIAwQZ8DjMtVdDQDwRy94f9IQ/TQifkipEcBKxIYZO
        KNFegCJf70aRvdCw3dWCXIz2NirgJYKYrzX8ctNHqA==
X-Google-Smtp-Source: APXvYqzdmDZbWcjzXKF4+qJgAd8KclcnVSdd+i4vFNoSgCTrLDHUk6WwujykW+79sxKgM6urEsZlcpEXfTd0l81tX9Q=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr28043288lfm.61.1560343386199;
 Wed, 12 Jun 2019 05:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190612122557.24158-1-gregkh@linuxfoundation.org> <20190612122557.24158-3-gregkh@linuxfoundation.org>
In-Reply-To: <20190612122557.24158-3-gregkh@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:42:54 +0200
Message-ID: <CACRpkdYC0DJkasyLawUvLWuM4_hE7OWLxaXwwus11Ga8-2+Fdg@mail.gmail.com>
Subject: Re: [PATCH 3/6] dma: coh901318: no need to cast away call to debugfs_create_file()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 12, 2019 at 2:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> No need to check the return value of debugfs_create_file(), so no need
> to provide a fake "cast away" of the return value either.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
