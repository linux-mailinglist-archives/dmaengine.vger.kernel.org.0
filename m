Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF78D4C4DC2
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 19:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiBYSd1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 13:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiBYSd0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 13:33:26 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CC8CDB0;
        Fri, 25 Feb 2022 10:32:54 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so4206203oti.5;
        Fri, 25 Feb 2022 10:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGUUDlQkTuFaoYwHC76OGb6XCKxXWsby1E+K2fO0aZY=;
        b=OrhRl52+Od0l5EDiYA41u7hnNCT6B1fqixqw8z6BIzcJmRy9LWITtabBgGNmfhy5zw
         /vPVTx3UvGGXFkZg+ikm3rNAP54q6dZEa7V2btvFm68Q2Koqk7/uZvMEDWon9Dr1F6LT
         338TEMblj5KYTf7zJGlQKXznfg+Qkv2hJTVV6ZmUx3xgqOTkxajiIjuJMOF5yKU7Rqqu
         31FWlP+PWIEv88C/EPfkW+FbM0kL3feAYLH9yM7a/BM5cHdiYY5JiqDFOw++sRlPj0XL
         mkr4tKST8t/3jx3/eZJ8+3An4A7zS1OFC4mqUThN1N5jq0Tn9UbQSBGV2u89a0DxQKM8
         w6Iw==
X-Gm-Message-State: AOAM5318jTKQo16RSuqgxl7xP0T8g/mnJe1DTka6ccr4nuplyzbHZdEl
        uDs95mArwqFRjTIrjQYWsA==
X-Google-Smtp-Source: ABdhPJx5ubmC03SN66sYzWE2d2kPJaaGGSRFOpiH8DcCFhFHijS4lcJ5s1Mv92tT+C9asqOGDr8j3A==
X-Received: by 2002:a9d:65d2:0:b0:5af:3e05:680b with SMTP id z18-20020a9d65d2000000b005af3e05680bmr3335874oth.68.1645813973675;
        Fri, 25 Feb 2022 10:32:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm1773914oao.3.2022.02.25.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:32:53 -0800 (PST)
Received: (nullmailer pid 1211584 invoked by uid 1000);
        Fri, 25 Feb 2022 18:32:51 -0000
Date:   Fri, 25 Feb 2022 12:32:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <Yhkg06bqnU8bpaxe@robh.at.kernel.org>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218181226.431098-4-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Feb 18, 2022 at 07:12:21PM +0100, Miquel Raynal wrote:
> The dmamux register is located within the system controller.
> 
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/renesas/r9a06g032-clocks.c        | 27 +++++++++++++++++++
>  include/dt-bindings/clock/r9a06g032-sysctrl.h |  2 ++
>  include/linux/soc/renesas/r9a06g032-syscon.h  | 11 ++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 include/linux/soc/renesas/r9a06g032-syscon.h

> diff --git a/include/dt-bindings/clock/r9a06g032-sysctrl.h b/include/dt-bindings/clock/r9a06g032-sysctrl.h
> index 90c0f3dc1ba1..609e7fe8fcb1 100644
> --- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
> +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
> @@ -145,4 +145,6 @@
>  #define R9A06G032_CLK_UART6		152
>  #define R9A06G032_CLK_UART7		153
>  
> +#define R9A06G032_SYSCON_DMAMUX		0xA0

That looks like a register offset? We generally don't put register 
offsets in DT.

> +
>  #endif /* __DT_BINDINGS_R9A06G032_SYSCTRL_H__ */
