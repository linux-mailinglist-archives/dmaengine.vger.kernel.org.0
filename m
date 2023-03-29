Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D586CD7F7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjC2KzO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2KzO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 06:55:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D91FC3;
        Wed, 29 Mar 2023 03:55:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso11157720wms.1;
        Wed, 29 Mar 2023 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680087310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxWVSYNg3x9Lr51Q6bn5n72HMeWHBmcsrPZstVqCyrs=;
        b=VByNFV754kE/eZ25qMrcu38DuGFTX/xp6ub/tU5fe0hFGPJ1aemzBDNAEjfKi9vYcJ
         /nTqcFmhbNwmMDhoHAEPDVZbUcnAUU3NYchYF6spapngQYwqAUI+6qTIGOprLVBRcp/+
         QMmfzCEE0c4jKkwGX1Yzu2es6052pBefuK3fkYPndyOJxxWeKxD79y1ArMxF3wovBKEE
         wkRxDmDejC299H96F8ULKImKCv11Rd3iL139pvb6ey++pdb8w95pAmv4DuDKAgtQ+A6O
         aXLF8ukAMlAZBXbnFMSYGUE0BH79pHeLLXs9NYdtAxL83DPPOA46RvmQh+9RJGnAk0eo
         d0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680087310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxWVSYNg3x9Lr51Q6bn5n72HMeWHBmcsrPZstVqCyrs=;
        b=duMp7mkvutkkQU43/jjglL3Vh7Whm0mJ5ylt69gOm2eyRcm8jWsYuLFSpdMheFYVlC
         0Z9+R3/inlbuDxoO4XEfFC/hm2oeYhdhhVprkzW3pHdGxfmZN0evL+8pZ3RK68JHKwaY
         Ya3JQ2bsoMfqL9ltdqA1jLehkCALg0z+EUTQz1dq9Tr/32uouY5oJKPgz9fwL0U7JFgX
         cLfSFjSxyhBQWDaF7Gmf40PBLJ0UEuwMdQyez3eGDE7sxpHl3Hp8diAW2ssqYvTemIr7
         3i68x7AAnqZWhFogHDESMpeyv5kE+rLDkmB8+GxAlEQUjx8W1KryLUDIBfmOYu24NvKu
         G2Eg==
X-Gm-Message-State: AAQBX9dYSNuAu6iRpguD3sbGYOiCjEsLmifeG0L5JMsYxY+kLu6d+Np5
        bE0D7SPGapJ9EyekMNUFxTA=
X-Google-Smtp-Source: AKy350ZJu7jp4nxoNA3PBt3BQ1lskpGA2HTjnMYG3XSyNpuQ7wI1e+c6pBNkeN/aR69zppzW9k/gMQ==
X-Received: by 2002:a05:600c:3c94:b0:3ef:6989:19ef with SMTP id bg20-20020a05600c3c9400b003ef698919efmr1458736wmb.13.1680087310085;
        Wed, 29 Mar 2023 03:55:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003ee1e07a14asm1940538wmq.45.2023.03.29.03.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 03:55:09 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:55:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: mv_xor_v2: Fix an error code.
Message-ID: <73af278e-1fc7-43fb-87b9-f107ae533266@kili.mountain>
References: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
 <e53e6f9a-09a9-42e4-8e81-dfe2ad2813ad@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53e6f9a-09a9-42e4-8e81-dfe2ad2813ad@kili.mountain>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A bunch of false positives could be silenced by changing the assign
and return hooks to check for unsigned types:

static void match_assign(struct expression *expr)
{
        if (expr_unsigned(expr->left))
                return;
        warn_on_positive_error(expr->right);
}

static void match_return(struct expression *expr)
{
        struct symbol *type;

        type = cur_func_return_type();
        if (type_unsigned(type))
                return;

        warn_on_positive_error(expr);
}

regards,
dan carpenter
