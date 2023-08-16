Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3D77E72A
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjHPRCl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbjHPRCc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 13:02:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37511FC3;
        Wed, 16 Aug 2023 10:02:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40ff45065c9so43500161cf.0;
        Wed, 16 Aug 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692205351; x=1692810151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PdAgqwIs/VGfOupDO23C6dNgP/OHW6B0MhZ1Oxj+X5Y=;
        b=GQuA2rmOZj6QrMftACG2sgHrso5fTH4m1FPF5fB1h+D2TVdAMhVnI9tnRZJTBKLuDr
         r6OsIe1uU0EPyYgDf0SRLbBY2UK8QPIjXtjGfG4XliRpoYbHEddPlLA7REe3j1HvaNVA
         U5acpMDHZHm50YiL91XyNmT4ovohwy8pOy5Z6afTkOI2pQN6suhiIKZFkgQPYSfto00x
         vbT5baXZKMVC/spGIYrVRuWPVBoZug5X3P0OuXu47dleGvMIJ78R+F+eMAip2pWbxIzC
         Md0LZdavcTA2d5FATLmYGY4U6uR+kWrxAYB0yc6/xUtOAlL9jk62v0ltoJjKEXtPwBM0
         TK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205351; x=1692810151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdAgqwIs/VGfOupDO23C6dNgP/OHW6B0MhZ1Oxj+X5Y=;
        b=TOUfLyve2ZF+VmAedePKI1p2d3oD1GW+/htlcQx75qt4sEwaVm8zBM+UPHZ/+lKrqR
         W05geR+6UNjGqr+hKzLsoSixs2Hmhaym9730TtKI7mo4HZzNHVFHv//96CxWZbY3VbEc
         RuyW9XDAPewPG2f+nDc4TVt2azdXzVaRrS2XzZdWkkLspGoD2af6xbIktC2mZKeCVbkt
         x8+Q8Ug3uv7PTBPdU0dV9BB/F51bzpMbzn7mEc6i3rWurg5+wWeBXDBj2+9qqgr1FiZ/
         NSABjGAc3S9lb/B8ZB8CjgkBypZoS4zXPFeP/IvNsGMK5ZhUEghIvJmFv8lTWP6SgmHj
         3FZg==
X-Gm-Message-State: AOJu0Yx7QMQOrrzLXB3hnZt3xsRf62b8A7F46OnWW2oWjVIisMQCipOE
        I32H7kQ2s/lqWFcvT6tDAZORA8leaB32zDj9xcETwv9Ia76YVg==
X-Google-Smtp-Source: AGHT+IGjN9tq2Vz/+k/ni08nnKTEeDQJaqNC/9k6hyCnw3Qdp8KGJtGfyBEFdYlIJhdn17tbB60r6F6a+hALlnBSJiA=
X-Received: by 2002:a05:622a:1052:b0:400:95e4:a311 with SMTP id
 f18-20020a05622a105200b0040095e4a311mr3428306qte.24.1692205350947; Wed, 16
 Aug 2023 10:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230726090628.1784-1-dg573847474@gmail.com> <CAJe_ZhcN7P7z_W9r5RZ6qA5qLRkXzC3cw7+Vj3GXGyw5HuFxgw@mail.gmail.com>
In-Reply-To: <CAJe_ZhcN7P7z_W9r5RZ6qA5qLRkXzC3cw7+Vj3GXGyw5HuFxgw@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 17 Aug 2023 01:02:18 +0800
Message-ID: <CAAo+4rUbqMtDRoVpUBy_oUTJPC-A_o5AGp5PHebwoBjxWs3BRQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] dmaengine: milbeaut-hdmac: Fix potential deadlock
 on &mc->vc.lock
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     vkoul@kernel.org, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, len.baker@gmx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> while at it, maybe also use vc->lock, instead of mc->vc.lock here and
> in other two places, just like the rest of driver.

Thanks for the review, v2 patch is just sent to address the problem.

Thanks,
Chengfeng
