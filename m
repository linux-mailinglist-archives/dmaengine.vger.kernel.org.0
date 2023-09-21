Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F87AA2FF
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIUVpt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIUVpb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 17:45:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B236299;
        Thu, 21 Sep 2023 11:55:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27474f0f483so162030a91.0;
        Thu, 21 Sep 2023 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695322558; x=1695927358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJY3H9JUg5HCRlzrOpFfJyHgKCn0efjBc0Xf3TmUsH8=;
        b=nLAAlExbuDQcxWGodyxC0FXHIKjSgk2QXk1naYZZ6bTPK55eb3d0xOGXydSzVF9NHJ
         11pxm7OFgECx19M6Bah0P7P3Hz8o0+SfrGWxao6VUkPi41BIqjBk/wK134nj33xz2CU5
         SbLUnItgMJyk1UgIitiU2L/p2Fr/dg2xOraMY2O+rwTs10Xw/HHkxXJAIxZ1d3YDHQJ/
         J62DlUovpnyhUSHRwH7yvPTnPwYVYocZXhUVEDd24Q8iq/73m1ZITVc4F0lGxHR+aQXT
         2icV78Mf0rq7aMSYKn4FkmYPvUYUMR2HhYFVXvBBkL0TWIXd2BeP50qo4K1IoDTIvqmM
         j3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322558; x=1695927358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJY3H9JUg5HCRlzrOpFfJyHgKCn0efjBc0Xf3TmUsH8=;
        b=sGYBEOAx022YUn/1ISovMULylkAiOC/COrwyJuxdJ/gDEf5fypHiOacIxiNvCceSA3
         XHLFh/ft2atIOp6Rsa8YwGKY20hvWCGAAB8KK7PZCGQFXKCCXx6/eko0JUAFN3GGEJZH
         vEz3X+JU/iGq+Kd9U7jTfmRSo3ItIWnSS5dP5zxlXS/uQpwNSE1Yn7WJeDmhKwolF30V
         jZcnme32vSoILbsvUwkCB+BZpjAZvpu8zDUwBoPUucbk4NFtSvuBB/xL0niE+3hHBGW0
         F1v8ZkY860PGfOralUc1Wrvyyf6erYsibIJD+TcJocEGCgc+7PGNX1fh/KjaCHBfhtyL
         0BBA==
X-Gm-Message-State: AOJu0YxJ4kgM/Vl7I0eECuZItXpp3xSoInnMqkMfP1CStYUmHIf6Z8xl
        fGxoigVOhckZ5Zy816Xz5G0MokLGpVVkYqL0rvY=
X-Google-Smtp-Source: AGHT+IFsINLVD38hImAxY6xxT6qn50qxZWrM/OVFjIHYWEv/oavY7WC8E+MPS+69BTrMKyXMALyrv9Qtxi83B8vlxCw=
X-Received: by 2002:a05:6a20:440d:b0:134:d4d3:f0a5 with SMTP id
 ce13-20020a056a20440d00b00134d4d3f0a5mr6159466pzb.2.1695322558187; Thu, 21
 Sep 2023 11:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
In-Reply-To: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Sep 2023 15:55:46 -0300
Message-ID: <CAOMZO5AwD0VUxxi-z8nWuNF=Sx_K+VSjwQHA42=n34+WKsKzCw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
To:     "Tim van der Staaij | Zign" <Tim.vanderstaaij@zigngroup.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tim,

On Thu, Sep 21, 2023 at 6:57=E2=80=AFAM Tim van der Staaij | Zign
<Tim.vanderstaaij@zigngroup.com> wrote:
>
> dev_warn internally acquires the lock that is already held when
> sdma_update_channel_loop is called. Therefore it is acquired twice and
> this is detected as a deadlock. Temporarily release the lock while
> logging to avoid this.
>
> Signed-off-by: Tim van der Staaij <tim.vanderstaaij@zigngroup.com>
> Link: https://lore.kernel.org/all/AM0PR08MB308979EC3A8A53AE6E2D3408802CA@=
AM0PR08MB3089.eurprd08.prod.outlook.com/

checkpatch gives a warning on this patch:

WARNING: From:/Signed-off-by: email name mismatch: 'From: "Tim van der
Staaij | Zign" <Tim.vanderstaaij@zigngroup.com>' !=3D 'Signed-off-by:
Tim van der Staaij <tim.vanderstaaij@zigngroup.com>'

Should it contain a Fixes tag so that it can be backported to older
stable-kernels?

Reviewed-by: Fabio Estevam <festevam@gmail.com>
