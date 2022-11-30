Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410563E2AB
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK3V1M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 16:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3V1I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 16:27:08 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2DF91341;
        Wed, 30 Nov 2022 13:27:03 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id v82so3390oib.4;
        Wed, 30 Nov 2022 13:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZS3nW5gwB+kDtxcZdvYj1mJRKMxTby7eEaeoKFfJH4=;
        b=BbjEQdlXyn2La8RxmHJYGWt+zsVqU0itYBZbcfTfpx78GivhaRujA3MsG+QRwyv44/
         lShOqWEBxEWl+Z1kO+A9HKQEcmZ359m7bCb52bzNtIzDdapWWYtrWOpsxB1e8AouTHfj
         +kH79JZAxYmG7ed9pFPuejV/LoyU8PwSkPCu+gelnddIzRvDr05WShCiH1X0YUQVHmsz
         JmnOV/uxWQqWIqvtrKtBgmmBQa6QB3gCAWlrAlZJn3+f4s+0vAEcsYzwMYL7nlwBSMvq
         Lel0eBYKzFxnePCbHPeWODeZg2Nn7GGCtCOU+8UwmWIxsRCsfGk3u3MeyycXx0/d9CXV
         FxPw==
X-Gm-Message-State: ANoB5plxJIUaEIaBNoXbMHvnOhX7SzHhKzPpl/FlXCLUOJGtzI1Z8HBM
        IqOJJd6hzZd25/kUQjqpYA==
X-Google-Smtp-Source: AA0mqf5tD0y5NhxvmX/AZYkg5jWWDK8WrmeuZUTlYcxWlbrxtcuiS53IcZQ68Lca+OMW7sML6Qsptg==
X-Received: by 2002:a05:6808:2206:b0:345:d571:88c8 with SMTP id bd6-20020a056808220600b00345d57188c8mr30790197oib.133.1669843622495;
        Wed, 30 Nov 2022 13:27:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o25-20020a4ad159000000b0049f8801ed22sm1132433oor.30.2022.11.30.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:27:02 -0800 (PST)
Received: (nullmailer pid 2955889 invoked by uid 1000);
        Wed, 30 Nov 2022 21:27:01 -0000
Date:   Wed, 30 Nov 2022 15:27:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, adrianml@alumnos.upm.es,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, radhey.shyam.pandey@amd.com,
        anirudha.sarangi@amd.com, harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH V2 1/6] dt-bindings: dmaengine: xilinx_dma:Add
 xlnx,axistream-connected property
Message-ID: <20221130212701.GA2951108-robh@kernel.org>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-2-sarath.babu.naidu.gaddam@amd.com>
 <b3e80e53-16df-f6b5-bf1e-6f13ae93973e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e80e53-16df-f6b5-bf1e-6f13ae93973e@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 26, 2022 at 03:32:23PM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2022 11:27, Sarath Babu Naidu Gaddam wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > 
> > Add an optional AXI DMA property 'xlnx,axistream-connected'. This
> > can be specified to indicate that DMA is connected to a streaming IP
> > in the hardware design and dma driver needs to do some additional
> > handling i.e pass metadata and perform streaming IP specific
> > configuration.
> > 
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> > ---
> > Changes in V2:
> > 1) Moved xlnx,axistream-connected optional property to under AXI DMA.
> > 2) Removed Acked-by: Rob Herring.
> > ---
> 
> You already add two properties here. Convert to DT schema and then add.

That would be better, but I did ack it before. Though that was a year 
and half ago...

Rob
