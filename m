Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6B4D648C
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbiCKP3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 10:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiCKP3f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 10:29:35 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24618FFF8F;
        Fri, 11 Mar 2022 07:28:31 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so6488790oti.5;
        Fri, 11 Mar 2022 07:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVQbBvLLXqH/Q9m03XHQmvLHErefNOtNz6jtQubmBRk=;
        b=aouCdMh2zaHj5YEYirDzSSza+NEawXDEbzQ1aET1JYZw61an23SaCuquHc02SSUtdk
         e61OpsVphEyHipw8lJ4tq6ZurDeq52owCdWbGkXwHZrkTvwyPgEqFQ+UjSdiEgg4QGdX
         TSf+ZC2GPU7E2fFoNGVZ48H7QkL4Z65gvV3f3f1369aNGfLMw8OlkTGAfEcQ0JbsZaLR
         ty5q5YtP73h/Dz3FgFAWyRzr3xGt94AsUWDFvkLPtK0OoF9ZVrAWSBSMmRZFGry7SaaT
         5fzSYe9Xihwy0zTwy8wgON1hGbmuxrWnEa/CtGoKePaIRQ/oIK7k3SegdK+j8KUSETa1
         PsEw==
X-Gm-Message-State: AOAM5317fEVZcN9l/FIJ+E4//sh1La2wdw821+czH47I9b/DLTPUejpw
        UofqUD0bCdsghppqvMaEwA==
X-Google-Smtp-Source: ABdhPJyfKLnc1dGeGbKzyhR0XfjTaXl8qlcPkbj/arGQoP6ETWvk7fWctcNmtdOf1yMHtXIf3/aN/g==
X-Received: by 2002:a05:6830:20cc:b0:5ad:95:66e3 with SMTP id z12-20020a05683020cc00b005ad009566e3mr5034633otq.347.1647012510443;
        Fri, 11 Mar 2022 07:28:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6c52000000b005af7c7cb702sm3551979otq.34.2022.03.11.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:28:29 -0800 (PST)
Received: (nullmailer pid 3831009 invoked by uid 1000);
        Fri, 11 Mar 2022 15:28:28 -0000
Date:   Fri, 11 Mar 2022 09:28:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        devicetree@vger.kernel.org,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: clock: r9a06g032-sysctrl: Reference
 the DMAMUX subnode
Message-ID: <YitqnBkwEorn2dGk@robh.at.kernel.org>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
 <20220310155755.287294-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310155755.287294-3-miquel.raynal@bootlin.com>
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

On Thu, 10 Mar 2022 16:57:48 +0100, Miquel Raynal wrote:
> This system controller contains several registers that have nothing to
> do with the clock handling, like the DMA mux register. Describe this
> part of the system controller as a subnode.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
