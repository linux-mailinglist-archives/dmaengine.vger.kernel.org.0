Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F464EABB7
	for <lists+dmaengine@lfdr.de>; Tue, 29 Mar 2022 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiC2K5m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Mar 2022 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiC2K5l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Mar 2022 06:57:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC251B78B
        for <dmaengine@vger.kernel.org>; Tue, 29 Mar 2022 03:55:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r23so20255778edb.0
        for <dmaengine@vger.kernel.org>; Tue, 29 Mar 2022 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vanfv+C3aqbPnrDC0qF+JurcUHu2Jv83zt5/MrYkOx0=;
        b=a78onrOfV/1JQF+FKcVBb3s6X3GVh02eT+3PcNerfq0vv0Uk4qy9EkcfkB4CWwCnaY
         So15LZztMsMwzgfj0ygqpaEqwm7lU9drdV8ONqYHUozRv8nh6yqrCH46wgFicgS1Xopr
         z8E/F3Q0Ew+/zbSiuuVu5P1Y0KE9RZjHElqmq5et/1XpmkYni5IFsjrsYM1H2fjkbaeI
         9vrcuEF1XED+W1WjN1AGrUqpAiowQTPI3gUJWDjqT8YjccjuufhdooF/YzVNDPcClAKS
         VdkzSAjgzI7MtCipTfo6wINFpRZy4RppNbSI8Zwa8vEzvpyEWVpRK2YSmiJB+rmJr3r9
         +PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vanfv+C3aqbPnrDC0qF+JurcUHu2Jv83zt5/MrYkOx0=;
        b=H7ly/OMDSskdYFijrrGamn/4uwohcL5MimfMYUqExqq6CcCrhX352hrgHqwu1hmbWv
         N2LloEnhfx7aA1sQ/qXM4+IP0X8K6tj9GxJ20f8pGoVzyQtyKqgiyJY7Trm/czhxleQc
         Uhj7kVdaU43CNYTk6rpgKdhAyNYexmeHjSTdjFhpWc8UO+RfH0/6lbHVBlCyU+2GocdF
         PexfNret3L+lDTUgL8aDybq3j5ZAVz4MMCAjxJhMtKSHH36Pt+TAiUgPACLgG/wMj97l
         VS5/emJqfvRsznBRcvUJmpTJW2d13XsrwJE15cyYVTpZs6ko7Icf1qwVhyUhjsBT5jEc
         HxEQ==
X-Gm-Message-State: AOAM532LHEuwDSW2XP6JAIJK6XF4Scqxa8rzVGPHyOvBXJZ8TcJ7wJeV
        dawVRkQU1ZzEAVsdbWHddVmNcav3bBxNW/lNrUiDa0zV
X-Google-Smtp-Source: ABdhPJywFt6RYNTgOD3XCMsZrq6YuZNaPg7SZt/ag1gmDG70iXx7hrXsHHaBoSph8DuZZ9/byyxkHqp6kO8GgcG4zqo=
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id
 f11-20020a0564021e8b00b003da58e69a09mr3712913edf.155.1648551357686; Tue, 29
 Mar 2022 03:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220328112744.1575631-1-s.hauer@pengutronix.de> <20220328112744.1575631-11-s.hauer@pengutronix.de>
In-Reply-To: <20220328112744.1575631-11-s.hauer@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 29 Mar 2022 07:55:45 -0300
Message-ID: <CAOMZO5B3TdYMhvYX55H5c+tSgaR8mgUKPo=hOw2xKvd+b+X8=g@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha,

On Mon, Mar 28, 2022 at 8:28 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Please add a commit log, thanks.
