Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E24ACA36
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiBGUNS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 15:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiBGUJp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 15:09:45 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE51C0401EC;
        Mon,  7 Feb 2022 12:09:44 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so15052629oot.4;
        Mon, 07 Feb 2022 12:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ttZ5bEvqZjIQmVs2OzberAWTk47diq+NL3G4lhS0EoU=;
        b=cwoniscbbKRS+255VLoPVa4yTWCMwVOIzJCl0Kc2bekIbNkbYv6Eh3erz/D7dziORF
         PE3wqC4CXh7+XeXGZs6Pz12RGJY+cz9tqOTD/4TE/T/XGILWdQ200IfnMuSN3PTJ6hw8
         PXhnA/gadJQ3WnXXYNoddwAOsyNHb8AfACJvzICLrvCVvrG/HqGqgzBAPBpUC2CcftBg
         GMyZot6GGYmEetnw2CCcutpzdN9KkeCrK6t6Q5CBYi4ko+m79TCWJCZbBd/wsDh+q3pP
         3s2WSil6V7AYkDsycIV6cTmt2sZ+b4KMZb/qoiS+sfP3wNl+BA3PjDwtwWYEhZm5dyCD
         Ty9g==
X-Gm-Message-State: AOAM531b97JOiPVzbMCY2ugWw06PlmiROFfkxY0pzLq0ogmAu3w3aTEG
        0eAP2UEuHyqKWSj+z71oyw==
X-Google-Smtp-Source: ABdhPJxQvqoRhiuE4eZoltL7bwVfENjxLmaf/fmvJxmAzjJWBu2Pt3FTdl2kIbPQ5qyr6OxY2RuXcA==
X-Received: by 2002:a05:6870:13cd:: with SMTP id 13mr198485oat.344.1644264583555;
        Mon, 07 Feb 2022 12:09:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a19sm4404440otf.27.2022.02.07.12.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:09:42 -0800 (PST)
Received: (nullmailer pid 823748 invoked by uid 1000);
        Mon, 07 Feb 2022 20:09:41 -0000
Date:   Mon, 7 Feb 2022 14:09:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        geert@linux-m68k.org, green.wan@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        bin.meng@windriver.com, Palmer Dabbelt <palmer@rivosinc.com>,
        krzysztof.kozlowski@canonical.com, conor.dooley@microchip.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: Add dma-channels property and modify
 compatible
Message-ID: <YgF8hR7YO3B3QI+S@robh.at.kernel.org>
References: <cover.1644215230.git.zong.li@sifive.com>
 <30430019105af445d52b7a48331c106f8e6d6816.1644215230.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30430019105af445d52b7a48331c106f8e6d6816.1644215230.git.zong.li@sifive.com>
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

On Mon, 07 Feb 2022 14:30:38 +0800, Zong Li wrote:
> Add dma-channels property, then we can determine how many channels there
> by device tree, rather than statically defining it in PDMA driver.
> In addition, we also modify the compatible for PDMA versioning scheme.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
