Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA6752A09
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jul 2023 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGMRwR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jul 2023 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjGMRwN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jul 2023 13:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FD2722;
        Thu, 13 Jul 2023 10:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9798161AD7;
        Thu, 13 Jul 2023 17:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D8AC433C9;
        Thu, 13 Jul 2023 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689270732;
        bh=clrj0QY3ZBhqFvGU0WyRdoEeXSfE6WZWhdiNMa9dGVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2tcf9cLZkX811gNZrYMxejiZRyjkv9Eiv1mEFOp6n5RRRI/Xn0wZ2GbO/dGPlWPV
         fBbwbC43+/sqKutwqQ01/Z8krGnbD0uykM5KXiCBBdBfhThn8CyGWtEeJrnTsylU1J
         976HK3nr6RP12nne6VKfRWWFTO9Ay3K2j1YBuuVmGiX79/Z2k1JTPxnLiKcHrU+lcU
         68Ha2PtU9JHioCadwOP6ub9cqkowUS1G7ePHQpUfS4AVeiznNvSXn0Lxxw8WNpeIao
         S/Xk/Du3ALnIgR++OQr8FHHEPRNjmX8ics6Ay7ONP2+TwvXNtPiu1ZaDX4FTfThocs
         Dq2/BJ/9PCe9Q==
Date:   Thu, 13 Jul 2023 23:22:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/5] dmaengine: qcom: gpi: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZLA5x/4Z8dgCrLjg@matsya>
References: <20230705081856.13734-1-frank.li@vivo.com>
 <168909383153.208679.15343948792914219046.b4-ty@kernel.org>
 <c3373ebe-2f52-bed7-7f59-98e1268c9af2@linux-m68k.org>
 <ZK6O2b88Nz6J2JeN@matsya>
 <CAMuHMdXiyk6NSGJWwby9VoP98=g0xu-SRAkDtxYqA-DcnOLmrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXiyk6NSGJWwby9VoP98=g0xu-SRAkDtxYqA-DcnOLmrQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 13-07-23, 10:00, Geert Uytterhoeven wrote:
> On Wed, Jul 12, 2023 at 1:30 PM Vinod Koul <vkoul@kernel.org> wrote:
> > On 12-07-23, 11:33, Geert Uytterhoeven wrote:
> >
> > Thanks for pointing that out, yes something is messed up for me.
> >
> > > However, the standard way is to add a Link: tag pointing to lore
> > > instead, cfr. [3].
> >
> > Yep and if you look at the dmaengine and phy commits for 6.4 they have
> > "Link" in them, so something is not working, let me fix that up.
> 
> Sorry, hadn't noticed that, so I assumed you were a new user ;-)
> 
> I saw you have already updated your branches, but FTR, the issue
> was caused by a new version of git, which broke the hook, cfr. commit
> 2bb19e740e9b3eb4 ("Documentation: update git configuration for Link:
> tag") in v6.5-rc1.

Yes that was exactly the cause, updating my hook fixed it up. Had to fix
all the commits in the trees though,    thanks

-- 
~Vinod
