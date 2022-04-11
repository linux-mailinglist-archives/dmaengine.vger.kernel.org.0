Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9764FB362
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 07:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiDKGBp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiDKGBo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 02:01:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E033E0A;
        Sun, 10 Apr 2022 22:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97AE4B810AF;
        Mon, 11 Apr 2022 05:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A5EC385A4;
        Mon, 11 Apr 2022 05:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649656768;
        bh=posnk2MGL5jSyg7ws/UMg2E9iKZJKC+HBbNrKFgg1UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjm2AlD8pIoZcZeI4wyth8x8a1dw5xZnHN55R9f33a9cw2nPquHAYoSPPEZ3A1T0a
         2ENybh9Wp6sM72i1dODZKFSnKZM7faKo1v+GE5GFUkobec/8BCyLIUKiidexKiS5E2
         1bZaDZ9vMaAhbMfq5k+Q2kkJqX+mkbo0rjQ+B4kqbs32S6FMRsf4EJD8vqcaY6XUVR
         ssa7TWRYIVc8tKjujvPFnUNA0DfW6JJoYGgIO6xz6wTlPbOoAliZoyV8ampna3Gk9W
         4tunNYVu+sUZ0RLRKWcBsukl8rNxAYsgGVMmBisXLUH30SPKOlNBNReI8kmGZPyIhG
         jfQqwpzi9MbbQ==
Date:   Mon, 11 Apr 2022 11:29:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
Message-ID: <YlPDu3lu0rHJztNQ@matsya>
References: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
 <YlBzQpWEqMHz/HsU@matsya>
 <3b26a4e2-93a8-8b3f-20c3-c1593ea0d48b@lenbrook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b26a4e2-93a8-8b3f-20c3-c1593ea0d48b@lenbrook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On 10-04-22, 18:28, Kevin Groeneveld wrote:
> On 2022-04-08 13:39, Vinod Koul wrote:
> > 1. Patch title should reflect the change introduced, so the title is not
> > apt, pls revise
> 
> In hindsight the title was not very descriptive. I will update and send a
> v2. Maybe something like:
> 
> dmaengine: imx-sdma: fix init of uart scripts
> 
> > 2. Is this in response to rmk's report, if so, please add reported-by
> 
> No. I am not even aware of any report on this issue. I discovered the issue
> on my own and found the problem commit by doing a bisect.

Okay I am adding Russell here to see if this fixes his issue as well..

> > 3. Lastly, I would like to see some tested by for this patch..
> 
> I have tested on imx5, imx6 and imx8 systems. I will add some brief details
> of this to the commit message in the v2 patch. I am not sure if I as the
> author should include a Tested-by tag.
> 
> > > Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")
> > 
> > cc: stable ?
> 
> That sounds reasonable. I am relatively new to submitting kernel patches and
> that thought never crossed by mind.

No worries, fixes should be backport to stable kernels, refer Documentation/process/stable-kernel-rules.rst

Thanks
-- 
~Vinod
