Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6432E2B4943
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgKPP12 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 10:27:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44170 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgKPP11 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Nov 2020 10:27:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id f16so16322840otl.11;
        Mon, 16 Nov 2020 07:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+NYo5QYpZrIBGJFW42G9GmwZgVUFgsWRqlDFpKPQoGA=;
        b=F1DH3YbRlofWP+foUnKPzZHfZxsVMVlITXXj3I/GU7+bgdj4vjDGlbLakS+0KhBTc4
         rakzA8du4RpAv1ipxiXVbHArBfhqqcKCly8/wsiYjnCStndWJwuX1f9tv6OZ/+eQRElv
         liONqptZfZXKaMluZGqMdHdSGROVjmTgBQc1eJ42Zjg4WJiJdPQgdhsaX8e2qYaNgr8I
         T+mS5mq+qAdmm36y6j7yBUervLPPFMYUzPwGI9hs2Lk0BPauQWdFqZcrvatVVoXoLllG
         9Rs9PeLuuBfykgW5S3pFrvju+LBysqyfwJRNoIsR5Fh0sBQMR8iereZQhdkEFLhYRAqC
         oPwg==
X-Gm-Message-State: AOAM531QLFxCA9VdJ0/eNvLHjQKSOyuAOtwxRFXqV0MUtmVk21SNuf8v
        757U4APiZAJx7OKQhCuxCw==
X-Google-Smtp-Source: ABdhPJxvKsbSONDKVVi86SlEdo9ITf3ilNTFJpW5UrKVuSu084tjxD2WVZ4DHNsdMJh133o8QxNHQQ==
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr10872092otb.117.1605540447253;
        Mon, 16 Nov 2020 07:27:27 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q132sm1945010oia.46.2020.11.16.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:27:26 -0800 (PST)
Received: (nullmailer pid 1678818 invoked by uid 1000);
        Mon, 16 Nov 2020 15:27:25 -0000
Date:   Mon, 16 Nov 2020 09:27:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     dmaengine@vger.kernel.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: dma: Add DT bindings for HiSilicon
 Hiedma Controller
Message-ID: <20201116152725.GB1646380@bogus>
References: <20201114003440.36458-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114003440.36458-1-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 14 Nov 2020 00:34:39 +0000, Dongjiu Geng wrote:
> The Hiedma Controller v310 Provides eight DMA channels, each
> channel can be configured for one-way transfer. The data can
> be transferred in 8-bit, 16-bit, 32-bit, or 64-bit mode. This
> documentation describes DT bindings of this controller.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  .../bindings/dma/hisilicon,hiedmacv310.yaml   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.example.dts:20:18: fatal error: dt-bindings/clock/hi3559av100-clock.h: No such file or directory
   20 |         #include <dt-bindings/clock/hi3559av100-clock.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1399915

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

