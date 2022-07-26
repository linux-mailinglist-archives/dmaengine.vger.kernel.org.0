Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8D5813C0
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiGZND4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGZNDz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 09:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4915FF7
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 06:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B6A61557
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 13:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B6AC341C0;
        Tue, 26 Jul 2022 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840633;
        bh=iVlO64ggoDxi8TVdjUBpncUxqXs78Ayt6zabPJEmiYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiWMAEGlZGpe1ZoD17rJ0kmup5cNtF23YI3wJduIwtV8oK6IUYhDYiP58gLtJ4SW1
         IAR88wTRIje2tOquwL7n7qgUmBTg7GV53gK6lPtL3WYdmec52g2yY1Ng9neabrrr5h
         H+0w7ZgPR1eGAspioVfiXcZol1NrXBNwFGciy+B2ladZXLJkkucu23zuQWYNZnY6x7
         6SwPvWVxu7RtTxgEomjmovShX1MqbWxuYVBp9Ans6nto0q8UTeiZocVYxcjimrVSO+
         D+YQiiIf61HJmhD+Ir8VzrdeH++SbiuCbjLmIbHJuq1WtoS+jx97+118k0BI3dP+yr
         LpBjL9mSYODVA==
Date:   Tue, 26 Jul 2022 18:33:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Tausen <mta@satlab.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dmaengine: axi-dmac: check cache coherency register
Message-ID: <Yt/mNAz4xejDWu7R@matsya>
References: <20220714110644.2849191-1-mta@satlab.com>
 <PH0PR03MB6786D02B3DDFAD0B13A975DB998B9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <8735eyj176.fsf@satlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735eyj176.fsf@satlab.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-07-22, 09:31, Mathias Tausen wrote:
> > BTW, Mathias you should +cc the maintainers... Take a look at
> >
> > scripts/get_maintainer.pl
> 
> Thanks, Nuno.
> 
> +CC: Vinod

Can you please resend the patch, with the acks received

-- 
~Vinod
