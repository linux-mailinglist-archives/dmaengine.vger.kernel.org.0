Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1732248BD2
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHRQnz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 12:43:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34103 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgHRQnx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 12:43:53 -0400
Received: by mail-io1-f65.google.com with SMTP id q75so21902216iod.1;
        Tue, 18 Aug 2020 09:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdM+aoS31AuCOaARuG5YZn8l4KcZs8vVFfImA0Bqt/8=;
        b=YWDmpmd9rb7FvvTpwIgBSunL5eWwfka5Mb//awuKq/hnweWt+UCTT8nmDXzrF6FL+m
         sx+9B36SxVtFxbN67sKGd58rACk4nLKDnbOM3T+bRn2QeQamblMDMtc6zXVwQrdspS1z
         Pgo1UuZ5UlEtf4WNWqW1TcnTvTEU9/D5nui+/eObCEvOH+N0tugzsp6OaaF45a/tCQn5
         SIsq3ppVNPUrAP5QoyPZFmMdvf/PYnwZi9J7aht3B3PLWsiFkngU7FIPE6wevat/EM20
         DuZpwQUXPYberBkIs++nm8W4neqeIRC5htkrmCKixdTolmX71hItdi/EX21uXNlpWgjq
         AD7Q==
X-Gm-Message-State: AOAM533BMk7YmZ7SCNJ96UbhcC9ZD3KUS8JDwzPHwl0H2+9F3Fn1p3SY
        Mukk7sefGN4+ctH3vvHYjA==
X-Google-Smtp-Source: ABdhPJxBrekQSgwi7+gaUnJW2v97uftSBy1VBEmFaxjhiZ1mSG5EcUFvPmIpvOf70V3hce6cNnsrDg==
X-Received: by 2002:a5d:9ac5:: with SMTP id x5mr17597820ion.111.1597769032003;
        Tue, 18 Aug 2020 09:43:52 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id j10sm11949221ili.86.2020.08.18.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:43:51 -0700 (PDT)
Received: (nullmailer pid 3596901 invoked by uid 1000);
        Tue, 18 Aug 2020 16:43:50 -0000
Date:   Tue, 18 Aug 2020 10:43:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     EastL Lee <EastL.Lee@mediatek.com>
Cc:     matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        cc.hwang@mediatek.com, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20200818164350.GA3596085@bogus>
References: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
 <1597719834-6675-2-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597719834-6675-2-git-send-email-EastL.Lee@mediatek.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 18 Aug 2020 11:03:51 +0800, EastL Lee wrote:
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6779 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/mtk-cqdma.example.dt.yaml: dma-controller@10212000: '#dma-cells', 'dma-channel-mask' do not match any of the regexes: 'pinctrl-[0-9]+'


See https://patchwork.ozlabs.org/patch/1346576

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

