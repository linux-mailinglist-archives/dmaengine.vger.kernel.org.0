Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08846C3CBB
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 22:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCUVcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUVcn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 17:32:43 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32BF979;
        Tue, 21 Mar 2023 14:32:42 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17997ccf711so17689772fac.0;
        Tue, 21 Mar 2023 14:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/SrNI7Im7OQzPMwgFxuqdWvT+8hAcxHPUJhevfOoDk=;
        b=ea1W35IywqqLc9uNP5X7MlLeAmIh0MLu1Ax4b1RPs1MQyJReLNg27NrLgZGqZVB+dj
         33xtDtcqTsbti9d4pXptbDG22+0tlYI6uWFCff9kHh1u/9JHvAhhqAHK5qU0ehRPEhrC
         f4xB1RTTzMSyVsSOjRwgObOkUA9zfj3+IdLVvfC9XR7ZLhS4RZQnQxYGwEEp9iXL5hgj
         fz2sCCoe/mGsWEdW/x5AGmz34rN7ZbpAFq86ckJSMW0Xi4/RFI4rLKQ6twEM1Ab3+uuT
         PB9AfMyZtvvqKfqB8KL19gNv1kqt8A95d71GKShKnYd/TCYEMAJ2YR+4fP6F/OJ28OzD
         ELUQ==
X-Gm-Message-State: AO0yUKVmccYPjuQ0V8gT2nhXzEveVYG2zbZojKg4rTyUdQ6acjuER8Vl
        puTRUeL27qgzBA6Z36kOCuSw4w04MA==
X-Google-Smtp-Source: AK7set+sV/jKtfFsliyuVdroKJyTtvegHA63GNPGyroahiRTLam+vd+reVQMt4XQK0cSjZ/4FRQ6ow==
X-Received: by 2002:a05:6870:8888:b0:172:4748:32d9 with SMTP id m8-20020a056870888800b00172474832d9mr300895oam.3.1679434361552;
        Tue, 21 Mar 2023 14:32:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tk6-20020a05687189c600b0017703cd8ff6sm4604096oab.7.2023.03.21.14.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:32:41 -0700 (PDT)
Received: (nullmailer pid 1648942 invoked by uid 1000);
        Tue, 21 Mar 2023 21:32:40 -0000
Date:   Tue, 21 Mar 2023 16:32:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, pmenzel@molgen.mpg.de, dmaengine@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, vkoul@kernel.org, hdanton@sina.com,
        ilpo.jarvinen@linux.intel.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
Message-ID: <167943435989.1648881.16454367602496486662.robh@kernel.org>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
 <20230320081133.23655-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320081133.23655-3-chiawei_wang@aspeedtech.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 20 Mar 2023 16:11:30 +0800, Chia-Wei Wang wrote:
> Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600 SoC.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../bindings/dma/aspeed,ast2600-udma.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

