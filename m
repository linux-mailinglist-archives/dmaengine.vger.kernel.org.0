Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB05464F5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbiFJK7T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348008AbiFJK5Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 06:57:24 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7E4CD74
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 03:55:13 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C763820002;
        Fri, 10 Jun 2022 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654858510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=218gq8o+bSMb9wthJSJg5a2qZ4bEa7Gx4EC3mWU3Gos=;
        b=Gbw+iA6UxmbFkiTXINeHfXihcVUJOpvl2XA7ONmF/hrJuQZYpJHo4sD/FYA+fCT1wBeVpm
        YSXOqYSbRvSAGEvR8ddzOllDPcr1QrIvsB+v4TGKcyHWZwspNSf6SbzVjffs/eN4gZ0bJ6
        DSAuugnTfX7FTVZQu6+KHi/Ujv/GMPhRQCZLCUptJggA260/tzWpBuBdf8vzVOIKLIoG31
        +/5w9Vv4Cv8AuSy5ss1XPyKlTBcUGFCJAHQdSu1gMYKyW3PFTiVSo5v4IKSRUEZuxVbD0m
        jXaH7zNcrn8mDAscqXYEoHYrdqlyzZOVLeqiP2jLdbK/oKOxrA2QirzYfd98cw==
Date:   Fri, 10 Jun 2022 12:55:02 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: remove a macro conditional with
 similar branches
Message-ID: <20220610125502.103d1258@bootlin.com>
In-Reply-To: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
References: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 10 Jun 2022 13:07:00 +0300
Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org> wrote:

> After adding commit 8fc5133d6d4d ("dmaengine: dw-edma: Fix unaligned
> 64bit access") two branches under macro conditional become identical,
> thus the code can be simplified without any functional change.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 8 --------
>  1 file changed, 8 deletions(-)

Sure,
My first thought was to clearly identify the 64bit case but
I am fully agree, on this simple piece of code, it is not
necessary.

Acked-by: Herve Codina <herve.codina@bootlin.com>

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
