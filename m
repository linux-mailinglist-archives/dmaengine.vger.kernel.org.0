Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9344A465972
	for <lists+dmaengine@lfdr.de>; Wed,  1 Dec 2021 23:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353687AbhLAWsS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Dec 2021 17:48:18 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43929 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhLAWsR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Dec 2021 17:48:17 -0500
Received: by mail-oi1-f173.google.com with SMTP id o4so51719853oia.10;
        Wed, 01 Dec 2021 14:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Dik/cNjd7dc7gLFF+HRwBT65imFDvL1Ud86HVBJD6E=;
        b=Z7xsjKYSuTuPZkzuW+Anc4T3O7ipBuruMH8V+zmDCMq8wSNJDUuP3AGZd/1aKfk+Jo
         mrFFe9VoSFWHGCxzylZE8COF+LysyjH+W8qhec3pO+WauTowq4wx2R2hTwodtUiYJdEH
         mudoP6UCeqaEv4ZBkjW2fmGm8auQhyAuMKgUaBHSA+Lrk45/x4WL4ZbN3isAB7xNvyXe
         Um6BQbASC2VfkZfPDHLRfugusr7itL3GySlXDnKT9CyjPoK6/Q8+APu4o+QgrNvVPcRt
         2a58Ofo9kOunRhDfcwHV+C3ZqbGrGnHYSl5PamKPuWbek6VMS4GMzVFaY3eFza9fjD5F
         6D2Q==
X-Gm-Message-State: AOAM530bhW8pUAnaQ+KGcdzp0WR20HdviSEmI9rU7LjUqZBiws4q4Pfd
        VNZipWPE/dfJ55B0XSZMRCpCn3WtwA==
X-Google-Smtp-Source: ABdhPJyLil+OfJfqBVs1n7CKHGfbsRXi0FhqLOQM/I7Swp00LprZjST9HaQCtsbrKbRr3xhicV2sEg==
X-Received: by 2002:aca:2103:: with SMTP id 3mr1231505oiz.48.1638398695949;
        Wed, 01 Dec 2021 14:44:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm543015oih.58.2021.12.01.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:44:55 -0800 (PST)
Received: (nullmailer pid 2968560 invoked by uid 1000);
        Wed, 01 Dec 2021 22:44:54 -0000
Date:   Wed, 1 Dec 2021 16:44:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, Heng Sia <jee.heng.sia@intel.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Document optional
 reset
Message-ID: <Yaf65gY4Qo9irkdB@robh.at.kernel.org>
References: <20211125152008.162571-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125152008.162571-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 25 Nov 2021 16:20:08 +0100, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>     arch/riscv/boot/dts/canaan/sipeed_maix_bit.dt.yaml: dma-controller@50000000: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	    From schema: Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> 
> The Synopsys DesignWare AXI DMA Controller on the Canaan K210 SoC
> exposes its reset signal.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
