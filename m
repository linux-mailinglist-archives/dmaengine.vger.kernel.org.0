Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C859B6BF34B
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCQU6P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 16:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCQU6M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 16:58:12 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FAB410A9;
        Fri, 17 Mar 2023 13:58:03 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id s4so2851561ioj.11;
        Fri, 17 Mar 2023 13:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODtKQbFPksFs46vhcZADgTeYdUWvuTaUcZXqR29mSnE=;
        b=61x4ZM4Ax6E7hd8xFO9fSwX2ycXKxJlQEYuw54KgkuRER/8stGfuZC8LNeX3k3ivfI
         /lFI8G9CwwnfQUvR3wgu46yUMOMjaUbfcga9AYgADSzG+7QOCR8gvnwovTiBRrwT/047
         4euzvKOLMR8D0qNrDzmzo267wXr33qmEEZ3H1M8jyYesVKME04d/yiYuQfVDFzyyDTZh
         Xj6S/pRrWfhtcmVIZfeVRRMJoCHKmJirah5Tqzd564DitZfdGPYVviAm9Mq7enHQqWvR
         nmIcLr8cIS2axb0sLVQeVPNlfzd/M009Z2yLP3g5lY0XkrBiz8qXoGE+7WgqeqUzkE8k
         80IQ==
X-Gm-Message-State: AO0yUKX/ghdSCmw+2aH8tP0tgU6B0vzXbCvsHy5Fxb37U5Hn6tnUq8ls
        0lMuHsxnLCIdZJoG5DFwiw==
X-Google-Smtp-Source: AK7set8N9zYRYrpZyLblDS4PEDFDQUupo0tfdX2hbjpkS+GnTDcVDX7P3ZHEX2vzinq+JYrFy5IMEQ==
X-Received: by 2002:a5e:a708:0:b0:74c:8a51:ecf7 with SMTP id b8-20020a5ea708000000b0074c8a51ecf7mr3747iod.11.1679086682392;
        Fri, 17 Mar 2023 13:58:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s127-20020a025185000000b0040626f5b56csm998256jaa.40.2023.03.17.13.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 13:58:01 -0700 (PDT)
Received: (nullmailer pid 2790050 invoked by uid 1000);
        Fri, 17 Mar 2023 20:58:00 -0000
Date:   Fri, 17 Mar 2023 15:58:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, andrew@aj.id.au, dmaengine@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, pmenzel@molgen.mpg.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: serial: 8250: Add aspeed,ast2600-uart
Message-ID: <167908667961.2789991.1539212131187994719.robh@kernel.org>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230314021817.30446-2-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314021817.30446-2-chiawei_wang@aspeedtech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 14 Mar 2023 10:18:13 +0800, Chia-Wei Wang wrote:
> Add a compatible string for the NS16550A-compatible UARTs
> of Aspeed AST2600 SoCs.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

