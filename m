Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4113A983F
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFPK7G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFPK7G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 06:59:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE501C061574;
        Wed, 16 Jun 2021 03:57:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s14so1882173pfd.9;
        Wed, 16 Jun 2021 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w//y6HzGeeu412j7fzF2nhyN+nMt8aXOPDkXjgQ3ZQ4=;
        b=ggC5cbKP9AXBEs+Pe/HLwWnonWnqW2xwpIQ8gk0G3pZhNbt7revm3ityNfh5mYTpVa
         5PzB5Jia2GKpBE50y6Y9TLzxqjlUZ5K18XK/yZcsvZACiuxGAsxysMP1VJDvZDt9+lcI
         kfoAdrgutRyPbtwYqjTm3FR2rx+G7iN/pBs6d+Bgpq8UIbLNd2Aw45IwKCfAYLLhjzoF
         gRIIjoTX04dG38MQtSW/rmOoRijB5VOIFpqkGKZ1byhxYgv9L9DZU1NA3riaE3pYtTe1
         fvG4F2I95ZNXWDDv2gTf1ZVEpmZ47xe/YkxvJ57AuLrLqJ7wmR8fZWqX2C++E2gAtaF/
         HY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w//y6HzGeeu412j7fzF2nhyN+nMt8aXOPDkXjgQ3ZQ4=;
        b=O2gsRkVcIfTRIE/UX8RQxVvbga3bGZUBg/yHKCEZKX85Q2ypChLoKbU2Mqghm7L1eT
         3sm2QCJnTnfuQ+gZFt/76j/SmVCPXyAw/H7dMd6owsMmF1EseqxmW5AVt9muPHZ6rTYr
         CcThiGjinwr7yDIX1XpSmeuNLSADMlJXa1WhgOPg2JSED7R7V6wf3yiB9V7v1V5dtdko
         QLDOESpLAE1QOAW0KqQQvKL6DFD2Wn/Ifsy7/Yw3YbjeYa2shcFf6wWA/TXDaUVtYVk8
         vNialNwo4d39MamGMfFBAmv4O0X8wXRrjdsY84m+7jNgAYbUKFzNbyWMch5cMhhRHL2s
         VWSA==
X-Gm-Message-State: AOAM532A50VaiBZ15yUVjUfa2L0iH04DqaH1vN1HUDf1f897TdMPs/5f
        CViKwKTZNtls978N+GM31PdXs+70XNgxFTXU8dfguyk19no=
X-Google-Smtp-Source: ABdhPJw9ZB0RRBljpr8xPQLiyZo07M8XF6ka9SVkEaB9dd2kKY4DiCFI0y068zjUDmdnnDeMBX2V7d+ReaaRG4gcfII=
X-Received: by 2002:a63:4b16:: with SMTP id y22mr4338230pga.410.1623841020315;
 Wed, 16 Jun 2021 03:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210611065336.GA1121@raspberrypi> <YMnVDJM8foWIZTGk@vkoul-mobl>
In-Reply-To: <YMnVDJM8foWIZTGk@vkoul-mobl>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 16 Jun 2021 19:56:53 +0900
Message-ID: <CADLLry7tv4xG2d0Pivq86F-Lr1-nBbmgYxEoJGyFx4SNTsUNYA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sf-pdma: apply proper spinlock flags in sf_pdma_prep_dma_memcpy()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     green.wan@sifive.com, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

2021=EB=85=84 6=EC=9B=94 16=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:40, V=
inod Koul <vkoul@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 11-06-21, 07:53, Austin Kim wrote:
> > From: Austin Kim <austin.kim@lge.com>
> >
> > The second parameter of spinlock_irq[save/restore] function is flags,
> > which is the last input parameter of sf_pdma_prep_dma_memcpy().
> >
> > So declare local variable 'iflags' to be used as the second parameter o=
f
> > spinlock_irq[save/restore] function.
>
> Applied, thanks

Great, thanks!

>
> --
> ~Vinod
