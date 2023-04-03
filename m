Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2336D4B1F
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjDCOyv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjDCOyn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 10:54:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C028EBD
        for <dmaengine@vger.kernel.org>; Mon,  3 Apr 2023 07:54:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso20031665wms.1
        for <dmaengine@vger.kernel.org>; Mon, 03 Apr 2023 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680533656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zQ+D+rvKejqeMnWp70EKl6CxPWKKv8D5XFmi8cEhbpo=;
        b=19sjDoEWHn3qr/r+4w4MBgaavARXaINMpW7n0PSpX7v+T4dvwGSdoVh/HKyRReHWTm
         TMAo9mIPCOXH563paV8996QHd7zwtIZetRxP5j4CZLmhykrWSxEPWJ6sizuFUsLf3ox+
         M5JA+htRsFp4IFKV3XhlKH/u9xn+ywEhSY4PQ7mtpViYCU63l2XeVYgSuzHSXG4vgW2j
         /kvVVs0NMt64gqVpmpCNxJREDdMTyg7myayfYJCLWSJ9eXCfYQ2/HGHC+bh7WBiyflk5
         k1oqBHMT1BSJLU5UeR329Dai44m2FR8GEcubaPvs+iasGQYm4WDmbxuF3eWxo15T7sGA
         K88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ+D+rvKejqeMnWp70EKl6CxPWKKv8D5XFmi8cEhbpo=;
        b=aoNy0OXjktxT34Nsk3x2t2VYCOx/+/ZSrK1wDFVVhwxpexoM552Fu9VqESuA0TjqEu
         jZ9ccEqOesC1MevBQd22KgzIFkZNaqMyiv5744cIN8y82OlOdJanNyREeOErOZWCqb7p
         dzJglQxdcRMO4hhUppGg4kyn4UbzsWp4II3Qt9ieVuhHuK5S4Ns6z0bavo0eWE6aE0aF
         jl07gIzvkNIRjq9cwNjKj1hig8HoYAoSWO0Oe4AJAoLr5E4iDbJOYOVErbMV5Cg/4+EL
         FGdPNaqoceUWPw+hhSX8pypfPNx/oHBzGYDkMdXmayabNkyrXF4+Jp+L+gGqR0qcUXFg
         WlQA==
X-Gm-Message-State: AAQBX9ffZE7LrrfCMbMNCc34NTyD+5MJ0fk9n+bhqZa1dm+jLxBgliNb
        eXbcqSNezisYoN8jj4ruiTFufQ==
X-Google-Smtp-Source: AKy350YV721bPoxlptQMY+4EjEdRARLIo8tlWdaWA0MzyriXcpeXXrhtsduVC2tjei0esd0t3OUJPw==
X-Received: by 2002:a1c:c913:0:b0:3ef:acf6:f815 with SMTP id f19-20020a1cc913000000b003efacf6f815mr14033935wmb.32.1680533656505;
        Mon, 03 Apr 2023 07:54:16 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id u21-20020a05600c00d500b003ee4e99a8f6sm12299588wmm.33.2023.04.03.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:54:16 -0700 (PDT)
Date:   Mon, 3 Apr 2023 16:54:14 +0200
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org, dave.jiang@intel.com,
        tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, daniele.alessandrelli@intel.com,
        prabhjot.khurana@intel.com, mgross@linux.intel.com,
        declan.murphy@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: ixp4xx - Move driver to
 drivers/crypto/intel/ixp4xx
Message-ID: <ZCroljP+zzGVigFi@Red>
References: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
 <20230328153951.126564-3-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328153951.126564-3-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le Tue, Mar 28, 2023 at 10:39:50AM -0500, Tom Zanussi a écrit :
> With the growing number of Intel crypto drivers, it makes sense to
> group them all into a single drivers/crypto/intel/ directory.
> 
> Create a separate drivers/crypto/intel/ixp4xx directory and move
> drivers/crypto/ixp4xx_crypto.c to it, along with a new Kconfig and
> Makefile to contain the config and make bits.
> 
> Also add a COMPILE_TEST dependency to CRYPTO_DEV_IXP4XX so it can be
> more easily compile-tested.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Acked-by: Corentin LABBE <clabbe@baylibre.com>

Thanks
