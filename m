Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8175764F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jul 2023 10:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGRIM2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jul 2023 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRIM1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jul 2023 04:12:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821095;
        Tue, 18 Jul 2023 01:12:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3143b88faebso5751336f8f.3;
        Tue, 18 Jul 2023 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689667945; x=1692259945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCUDL1/u3mCyL3fGovIg+T0/y0vvq0Eia4n2zK2lnk=;
        b=mrvtzP7y++IAJhXNObvpvgH+Bj7GBGTnOVzezoX0XUaZb7wY5J26L2LGnLUfgUpeJq
         U0Vbh79pvI49N3K4VDPiw100DuDTtwzL8XCIcJ/6yULsnEiF4vVQMEjyZJxlollOB0y6
         e6dSGnc6Yn+fq7tQLCqQmsokAt5GcCdzfjEREES9GoN1kfZGnHTFSG132fl/OnzQhSQm
         eFajZStYK8OfjFSuDecABBEmypW9ybTmxj8NDIWgGAQI8MaKlfCB1eYlwmc8292WulaD
         QYhe/ddLsrltdQG5GsPPI1dY0pu66rCe3EGo39cCGBfVNmRaD/fCOt1AzWV0W9/+/5e3
         wjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667945; x=1692259945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrCUDL1/u3mCyL3fGovIg+T0/y0vvq0Eia4n2zK2lnk=;
        b=cCh6JBW0tY63mD7whljXieF7NRhQXkzU2FdpsBLoHISeSlvp5huHEi2J9xrw/v/MFM
         /IEv/zc5mMyjE6b9xN2Dmqm6H078kHHucJhW3MbUMncaSyDWScvEQ15vGFVnvK3J3nzi
         8t1gXX9X/0kQHoOBggVYrYOL7UdXUXllhS045qKafY3vznaaejfdjrvmMWx/6wn6GxT+
         XR7nC9Eb7KMDfyImVfDZ0UejtVpZYQqMjpagt62iFJz9RgVxDVSf5vJkFpMwyHe5a5I6
         c+H848AvhsVxPblw+B47S7ZwQRDCUqb8rNBOif6zZ3kvi37F/YVkkkrt9SnckhJ2tNc1
         SvqQ==
X-Gm-Message-State: ABy/qLaLr7ZFvYMrw/k7Rs2D2+JRhGluXKI65X0hXrjNzDNlFIjFmDq7
        ZRp70ARheb0CVnNIL213Zq5Q6cAa50cpufCsH36FlErVyJoLEQ==
X-Google-Smtp-Source: APBJJlErHmWgmXD8tMAdDqQ+40pbtQTCSP9J2HZonySWv0bfi4lfmf0Y2PO9DFS0cASf66YAAw8zXEFcMb4AHgbpaVA=
X-Received: by 2002:adf:cd87:0:b0:313:fa0f:3a05 with SMTP id
 q7-20020adfcd87000000b00313fa0f3a05mr12263634wrj.14.1689667945314; Tue, 18
 Jul 2023 01:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230627160817.47353-1-dg573847474@gmail.com>
In-Reply-To: <20230627160817.47353-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 18 Jul 2023 16:12:14 +0800
Message-ID: <CAAo+4rUnXwto6CLNDz79DJCFn5OMdE+BOFSxJsf3rsh9vraetA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: k3dma: fix potential deadlock on &d->lock
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
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
