Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE585568F2C
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiGFQ32 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGFQ31 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 12:29:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3025E87;
        Wed,  6 Jul 2022 09:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9027B81A99;
        Wed,  6 Jul 2022 16:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A78C341C8;
        Wed,  6 Jul 2022 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657124964;
        bh=cBCkLP2gTzX/q2OVTaImug7BGSJxWDD8OrsOwWBIJVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKQuwAR6/1+JPXRfI1Qv7oZd1ULgQDO/kOL/EFfTgCRCxcQSARXrhKH6Tvg2fzMh2
         IZ5wf/7h9v30tS+oqsJX87liFihTZcmZHxZ8MPAcZne4LqEuX4tXQ5wgOPpepqfUlK
         QmP468Q20PlQeA+Qq4PBEBUnblKBmIhmnqgtOl3FkgIz+BSHFwK3ZnuvlrAwu99VYI
         GkRIVRIx45aVQeeftJkGlp2XmTf8oXjYuECfCbLl8XGEmnW9F+UpW5kGIWXAgnIein
         nVcL6GSE7q4xtfL2o2buY0/TYaJA0TKVojK1X7PfUwGbZqVoWPAw36sPjimOkXJdnH
         qlPy3XAxcJ8DA==
Date:   Wed, 6 Jul 2022 21:59:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, joy.zou@nxp.com,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: imx-sdma: Add FIFO stride support for
 multi FIFO script
Message-ID: <YsW4YHL9+HkQndva@matsya>
References: <1655782566-21386-1-git-send-email-shengjiu.wang@nxp.com>
 <YsUlESAPklVFxpzy@matsya>
 <CAA+D8AOST1wK0G=65ufrhPrH8AQ0w-r1pMF5DOnqBauQtx7AOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AOST1wK0G=65ufrhPrH8AQ0w-r1pMF5DOnqBauQtx7AOg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-22, 14:54, Shengjiu Wang wrote:
> On Wed, Jul 6, 2022 at 2:00 PM Vinod Koul <vkoul@kernel.org> wrote:
> 
> > On 21-06-22, 11:36, Shengjiu Wang wrote:
> > > The peripheral may have several FIFOs, but some case just select
> > > some FIFOs from them for data transfer, which means FIFO0 and FIFO2
> > > may be selected. So add FIFO address stride support, 0 means all FIFOs
> > > are continuous, 1 means 1 word stride between FIFOs. All stride between
> > > FIFOs should be same.
> > >
> > > Another option words_per_fifo means how many audio channel data copied
> > > to one FIFO one time, 1 means one channel per FIFO, 2 means 2 channels
> > > per FIFO.
> > >
> > > If 'n_fifos_src =  4' and 'words_per_fifo = 2', it means the first two
> > > words(channels) fetch from FIFO0 and then jump to FIFO1 for next two
> > words,
> > > and so on after the last FIFO3 fetched, roll back to FIFO0.
> >
> > this fails to apply for me, pls rebase on dmaengine/next and revise
> >
> >
> > it based on my another commit, the one that fixes the struct documentation
> should I send them together?

Pls mention that in patch title.. I have applied that, so rebase and
resend please

-- 
~Vinod
