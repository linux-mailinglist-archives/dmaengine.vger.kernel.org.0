Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42D2757681
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jul 2023 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGRIZz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jul 2023 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGRIZy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jul 2023 04:25:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084A188;
        Tue, 18 Jul 2023 01:25:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5076480f8f.0;
        Tue, 18 Jul 2023 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689668752; x=1692260752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCUDL1/u3mCyL3fGovIg+T0/y0vvq0Eia4n2zK2lnk=;
        b=Xh1x7hUKw28NMEYrDzAaVRcudSvnpr6lasTNRdoaWUAXgwI7KB5bT+Wxva/xMdid1S
         HhYAD5Oz1YtyuXF1BEKl8jR08NqP9pd9ewCvW0UHgOakDTWZDGjl8KWwRXNnyO7FJyNt
         eGPX5Rai+9fifzuMRctpSvXoy4T6CvdZDHyF7/ltGTMyQBZNRTZ5t+VXLYZmpnAp65UH
         VQbnx33fQ41PK2HNoVLn84XhsGwvxwt8TlSwsPjxmcu63jFaBIP/YYyq3PrOk2pKUvTC
         QA4xTFHe3tUP7sqsMRujqv3NPQ0JYhX7c1zDrcVgHvtHVEg9YzCjEyEsNds4oL68chfd
         3GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689668752; x=1692260752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrCUDL1/u3mCyL3fGovIg+T0/y0vvq0Eia4n2zK2lnk=;
        b=P8M4jDrZQPZAFuECwgrMRr9DIxG/xwmEK6zRbmzlFNcUI0b3cBy1gakPBZnXmFvlBy
         P0ynP0JlIUmOn0+z3v+ro/QN6f/yTlFiIxEyjxAbtdQvPXjqBMOLBq2rK7w/HU4JF3Jb
         C7TGPsQ0jYGTCJqu0Ky6Yi7/rKP8YdewQx8cXxnFSaa/UQvwH3Sc9kMR84s6AuZb2+O+
         kMQe+H8CI3uHXB6JDMf4w//+PUtwZJwVDKbq8uyQuVaEQD3wFupMc8crEWxeX1UOpbd/
         c5WJoJdk+Cgem4bNotgvGAALQfLPYsXAHsqlC7AzdJZS8xwbyJJE0vt+NdICuZ7lYtGS
         Epqg==
X-Gm-Message-State: ABy/qLbSPnu595m+09iSZMstANlY3ffW4w+5IB0QsiSF8xBNbVMPZwGb
        CMI6/YlUz/4COB3lkyMV1/YsCXT195wGhnXJqA0=
X-Google-Smtp-Source: APBJJlFrmOa88kLbgpl12aGV9qZXGESdZ3ZjCYW1DiB7+DnP2V0y3QdQ7oGC/9IjpKPSFscpa9E1s+3h0rarAqnNxiQ=
X-Received: by 2002:a5d:4c41:0:b0:316:d887:624a with SMTP id
 n1-20020a5d4c41000000b00316d887624amr11762324wrt.15.1689668752364; Tue, 18
 Jul 2023 01:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230627164309.59922-1-dg573847474@gmail.com>
In-Reply-To: <20230627164309.59922-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 18 Jul 2023 16:25:41 +0800
Message-ID: <CAAo+4rXa08bRHtmwf9xumHdG=vhEFGmpT4mNycKcwDu_ewLYtg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: fix potential deadlock on &vc->lock
To:     sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear Maintainers,

I hope this message finds you well.

The patch was submitted during last merged windows and
I think maybe it is buried under other patches. If you've had
a chance to look at it and have any feedback, I would be
very appreciative.

Best regards,
Chengfeng
