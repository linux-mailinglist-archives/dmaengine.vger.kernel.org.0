Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A525F6A8A71
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 21:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCBUbu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 15:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCBUbg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 15:31:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA170426;
        Thu,  2 Mar 2023 12:30:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so822822lfe.10;
        Thu, 02 Mar 2023 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677789020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5c77amVuDeF3J9ukHDIDYrbPmk4xb3iHn1ZAe1oeck0=;
        b=dDiDCFyzj5Yh/UaRQ4Y5xUDW3ZlN54WyHcJQE2ZgP+klfpO18xdix8EwEjo+h7amp9
         pZ7iobVYiy3CX4uNvaBuHZDNOuFRAehtFXRGVi1+aLHpU2wDbtEAvny/RVThbQu1bw33
         q5XEJbMdanvSUm5DrF8ySMo9kyvRiykYLBJun4bNng2Uio6K7Rd0Of+buJ7FunAgmFHF
         TqD12LF6fCPpYR5cnDRMcNSkVGrmbiuYY1X30lEsSQ9ewzOk1w56lfoW16Pa3SwBlffJ
         Ou065dkF6Pr/6aNJTedexTKhrhC+LtkW8wr383UNHYteSqOypXcOxI+C9hyfsF2K1kCg
         UgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677789020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c77amVuDeF3J9ukHDIDYrbPmk4xb3iHn1ZAe1oeck0=;
        b=oL/0zu6VnCZ8WF5Y/nfQrMOz1pVMVTjXseTEfK4dP6782iCq6hY6MsbMmCCCGb7Im4
         5qbr41xhia8e1yb6/+RHdR4/gC47fvRuKrOQbAq63GH5b+Xy4CEmmaqJMkmJfIvwHoFN
         GnsDctPBZcK3lSk8HIANx1Zn8pBMWLXycB53dxGcNyQR4zCjZTdnLSUgz0tovB3a8ZFV
         oE/20b4Jyfcnrss951+i8trhHHsmiXz3Kpp5f/HGZ5lmrcSH6vK306DTtcMCjbsN0OXg
         ehHFjfUvprozIgAqQU1Y07mZxvpDZT+QnaFDU/jaKGpusDqnqjxPr64/dkva5Ix/nXJ/
         SbUw==
X-Gm-Message-State: AO0yUKWH75ZSm/u8QVLxMrUePnzkIpaP8ZB9rEaSD4loPnNSk9zyIY4w
        L0QPltM1cZNS7Y914i8/6/Q=
X-Google-Smtp-Source: AK7set8I9fpAokjadyS/83CkUpsib7UvL3odnSN5Rm7i/srOUxTh76zAJjFIk9moypPHx+JFc5bvRQ==
X-Received: by 2002:ac2:523c:0:b0:4dd:ab39:86e0 with SMTP id i28-20020ac2523c000000b004ddab3986e0mr3320781lfl.27.1677789019997;
        Thu, 02 Mar 2023 12:30:19 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e9ac8000000b0029353201fddsm14102ljj.129.2023.03.02.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:30:19 -0800 (PST)
Date:   Thu, 2 Mar 2023 23:30:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230302203017.jdqsfu5iauw2pp22@mobilestation>
References: <20230221034656.14476-1-cai.huoqing@linux.dev>
 <20230221034656.14476-4-cai.huoqing@linux.dev>
 <b108f61d-e812-a500-0c8f-4fb1acd44ca2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b108f61d-e812-a500-0c8f-4fb1acd44ca2@metafoo.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lars

On Thu, Mar 02, 2023 at 09:26:51AM -0800, Lars-Peter Clausen wrote:
> On 2/20/23 19:46, Cai Huoqing wrote:
> > +void dw_hdma_v0_core_register(struct dw_edma *dw)
> > +{
> > +	dw->core = &dw_hdma_v0_core;
> > +}
> 
> Where is dw_hdma_v0_core_register() called?

Indeed. Good catch! The respective change has been missing since v2:
@@ -952,7 +953,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	dw->chip = chip;
 
-	dw_edma_v0_core_register(dw);
+	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+		dw_hdma_v0_core_register(dw);
+	else
+		dw_edma_v0_core_register(dw);

@Cai, please fix that.

-Serge(y)

> 
> 
