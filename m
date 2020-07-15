Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B186B220288
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 04:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgGOCyc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Tue, 14 Jul 2020 22:54:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45493 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgGOCyc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 22:54:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id s16so229535lfp.12;
        Tue, 14 Jul 2020 19:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ViMoiRYbnye9Bhm7FBkCgDKaz65TFLMn2cnFe8DTw7g=;
        b=eqliB1+W5FFbnBIcIJWsbJ0nTXSAi6LMOZO7drDgv0RJlEb1PSKh4j+DzEHenWEtdu
         AX/rTJkYWhtmY8ukF9JfVCAydO2mLmkhcvWXxiMPI5MOOck4xv090vZn8ahQ5QfAz86Z
         DeBvhvxSnsDzYvzbwX2QBecSG2OW9WDBWnDHOvRspQuQGtW5nAtIsV1V5LTf2pO3sNVh
         Pck13qLbLqBmXuhroIXiOaLdJh1awGLGqmdM1UBOqx6NPG6eOZcHxkjg++fPxd9uBpvS
         G7rGXu/XjCY9DBziQe7fNpd7eGc0DpDzf5Y/Neo99gBpCI5X1aJDEfuaUeSRC5NRMKCU
         /kXA==
X-Gm-Message-State: AOAM532InGl6nnHmBm30WN3DLoBWrgxtiqiMI135evJZPzHeURyudTCJ
        XzfeFhVmhtAuZf9z5vaWikCEK2lm9j0=
X-Google-Smtp-Source: ABdhPJzaOHutYV9oPPssrwvpfcW11L408zPrEMSDLeH4LFWmt7qiNeyRjvaNg5izXfA2HLA8WQ9vgg==
X-Received: by 2002:ac2:5619:: with SMTP id v25mr3630383lfd.117.1594781669485;
        Tue, 14 Jul 2020 19:54:29 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f13sm184059lfs.29.2020.07.14.19.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:54:29 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b25so866467ljp.6;
        Tue, 14 Jul 2020 19:54:29 -0700 (PDT)
X-Received: by 2002:a2e:99cf:: with SMTP id l15mr3740000ljj.294.1594781669067;
 Tue, 14 Jul 2020 19:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200714111546.1755231-1-lee.jones@linaro.org> <20200714111546.1755231-10-lee.jones@linaro.org>
In-Reply-To: <20200714111546.1755231-10-lee.jones@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 15 Jul 2020 10:54:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v64s3sHzmcWD34UxyuU4pJmVPVxmXpJsXCffj0nrvg98Vg@mail.gmail.com>
Message-ID: <CAGb2v64s3sHzmcWD34UxyuU4pJmVPVxmXpJsXCffj0nrvg98Vg@mail.gmail.com>
Subject: Re: [PATCH 09/17] dma: sun4i-dma: Demote obvious misuse of kerneldoc
 to standard comment blocks
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 14, 2020 at 7:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> No attempt has been made to document any of the demoted functions here.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/dma/sun4i-dma.c:321: warning: Function parameter or member 'priv' not described in '__execute_vchan_pending'
>  drivers/dma/sun4i-dma.c:321: warning: Function parameter or member 'vchan' not described in '__execute_vchan_pending'
>  drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'chan' not described in 'generate_ndma_promise'
>  drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'src' not described in 'generate_ndma_promise'
>  drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'dest' not described in 'generate_ndma_promise'
>  drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'len' not described in 'generate_ndma_promise'
>  drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'sconfig' not described in 'generate_ndma_promise'
>  drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'direction' not described in 'generate_ndma_promise'
>  drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'chan' not described in 'generate_ddma_promise'
>  drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'src' not described in 'generate_ddma_promise'
>  drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'dest' not described in 'generate_ddma_promise'
>  drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'len' not described in 'generate_ddma_promise'
>  drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'sconfig' not described in 'generate_ddma_promise'
>  drivers/dma/sun4i-dma.c:577: warning: Function parameter or member 'contract' not described in 'get_next_cyclic_promise'
>  drivers/dma/sun4i-dma.c:596: warning: Function parameter or member 'vd' not described in 'sun4i_dma_free_contract'
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: "Emilio López" <emilio@elopez.com.ar>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
