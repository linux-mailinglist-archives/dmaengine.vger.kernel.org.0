Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48E7A1650
	for <lists+dmaengine@lfdr.de>; Fri, 15 Sep 2023 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjIOGpj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Sep 2023 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjIOGpi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Sep 2023 02:45:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92808268F
        for <dmaengine@vger.kernel.org>; Thu, 14 Sep 2023 23:45:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c65820134so1543110f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 14 Sep 2023 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694760331; x=1695365131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iid8k6i/7ugCP4LiXGAP3iTfZTR6oaJGyaJr18W15M=;
        b=WplxrfYqiyDMLZnf4oX7fZ3fZzfBoLKt30zp59n8Lx+0HOi2R8ijtlXsjv47SIKYlD
         HRbOEJ+PQK8WbR2AlsEIhXk3qjAlQZbZ1/vQBCj++QatQiHZMo4T4uZsNtLCOAs6EFSo
         xkzPjfhZHVNM23mR0r8HmFZbwrvjeNFyvXnIkG6g1g46NhGVgB8ox5dZCZSYt9gtxx1l
         SPtWwZK2T0PrwZTMoy904j9Ig12K9OFth2JShV2utcjhuovXG/Z9GLGondC237x7YJOP
         AhhzrSMoNuT/6xRfVee6vP+6D/yvFPMfe9Ytz7EWqUKlcZ9lMEp4KeOl/OL/74aQo3fP
         v2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760331; x=1695365131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iid8k6i/7ugCP4LiXGAP3iTfZTR6oaJGyaJr18W15M=;
        b=gImmWRvUoCKn94MsHJ01Xdhns1VKU9+rw71X7+mmPm0pASs7Jl7lFyxL0o+2/HpKFV
         X1OQJjaSV2jal/UdXKXi1UFv0Pr79hbU6mC81pge+f4FFc2MrUDdOyHZ62A1/f6iK6Am
         dbZYPqjTmzpdjgdbEG6kcKbVCyu9tt0deq/KPRW7GgQm0S6SyVHgQY4iZ8iiDMDpnQM/
         d9kLA67QJ437+71cTzP9rUkaWQusbQ3OU9adXx6W4US4lXjiXRlqghhPm7Mh509HBjaJ
         kkvVOjm919LOUnfJOKgL3noiCbCwHFY+wsqjfQlm4m7PenpI/neGL0eTIrSxgPsqSLdG
         yEBQ==
X-Gm-Message-State: AOJu0YwBO/H1ggeEQK06LuoQ867QIvkzp+NFsL1qofVXCmbm03FMhuxP
        RKqmVw6gaDECfHjFfbQ/bCb2fw==
X-Google-Smtp-Source: AGHT+IE8Thgq+Szgaiwj/ucohZyW9eDpZBH7Q1t53swPZGciT9VZ3dn2zP3CW2L86IyMPCp+kCVKWQ==
X-Received: by 2002:a5d:67cf:0:b0:31f:a62d:264 with SMTP id n15-20020a5d67cf000000b0031fa62d0264mr583580wrw.37.1694760330972;
        Thu, 14 Sep 2023 23:45:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003fe17901fcdsm6630449wmf.32.2023.09.14.23.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:45:30 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:45:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dmaengine: ti: k3-udma-glue: fix
 k3_udma_glue_tx_get_irq() error checking
Message-ID: <62125aa6-e279-474c-a0d5-c63d226c6c40@kadam.mountain>
References: <5b29881f-a11a-4230-a044-a60871d3d38c@kili.mountain>
 <20230915063324.GC758782@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915063324.GC758782@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 15, 2023 at 08:33:24AM +0200, Simon Horman wrote:
> On Wed, Sep 13, 2023 at 02:05:31PM +0300, Dan Carpenter wrote:
> > The problem is that xudma_pktdma_tflow_get_irq() returns zero on error
> > and k3_ringacc_get_ring_irq_num() returns negatives.  This complicates
> > the error handling.  Change it to always return negative errors.
> > 
> > Both callers have other bugs as well.  The am65_cpsw_nuss_init_tx_chns()
> > function doesn't preserve the error code but instead returns success.
> > In prueth_init_tx_chns() there is a signedness bug since "tx_chn->irq"
> > is unsigned so negative errors are not handled correctly.
> 
> Hi Dan,
> 
> I understand that the problems are related, but there are several of them.
> Could they be handled in separate patches (applied in a specific order) ?
> I suspect this would aid backporting, and, moreover, I think it is nice
> to try to work on a one-fix-per-patch basis.
> 
> The above notwithstanding, I do agree with the correctness of your changes.
> 

Sure.  Let me write it like:

patch 1: fix first caller
patch 2: fix second caller
patch 3: re-write both callers to cleaner API

And we can push everything to net because it's nice to have one version
of the API instead of a version for net and a different version in
net-next.  Or we could apply patch 3 to only net-next.

regards,
dan carpenter

