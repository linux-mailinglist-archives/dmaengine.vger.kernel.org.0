Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79B4FBADE
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbiDKL3K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiDKL3J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 07:29:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BA3B027;
        Mon, 11 Apr 2022 04:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D40BAB811A6;
        Mon, 11 Apr 2022 11:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E950EC385A4;
        Mon, 11 Apr 2022 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649676412;
        bh=EMTWp8dpFj9+gfzH1CPLMeaTXve4kBlv+N/I1XxXhWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeGicYyMCpRxuXAlJVME3hGWvJrkbieIqnfuRRnP77EqnXyZj7gFS5Z/UlpT5Tsba
         smxIldwU6DABgM+XgeeAmmd6dp4U/Zx0L4clOY8HebJdfCPcoB5FsaqJKsrx7Pwrnu
         AK548rqprQEnsc/rZr1fdst+ysunYRMQAD41OIVCVeI8/J3E3bEVjL9Qmum3bHKgyW
         +/BtCDisEfBtjv84Fa3HDPBKlUZiV/uW4AilPu78rdTdg9OX7bLvT+hTssqiNS0vyB
         b7nXhO9cnCm7x4O1bEZ29eL1FtsIap0qOq2eDmiZNfpRlcXDindWT+uDcl1OklCfZY
         ueL5RPrKkAtEQ==
Date:   Mon, 11 Apr 2022 16:56:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Colin Ian King <colin.king@intel.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: sh: rz-dmac: Set DMA transfer parameters
 based on the direction
Message-ID: <YlQQeIKrXS2EmYoU@matsya>
References: <20220409165348.46080-1-biju.das.jz@bp.renesas.com>
 <YlQJBPmECe2AkpOJ@matsya>
 <OS0PR01MB5922B6F81F53A58C7836B5AE86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922B6F81F53A58C7836B5AE86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 11:06, Biju Das wrote:

> > This is a deprecated field, pls do not use this...
> > 
> > Above code is correct and then based on direction of the descriptor you
> > would use either src or dstn parameters
> 
> OK, I get -EINVAL because of [1] as client driver is filling
> {src,dst}_addr_width based on direction. 
> 
> Maybe I should remove the check from this function or
> Fix [1], as it is deprecated?? Please share your views on this.

Yes please fix it, we need to remove users of direction

-- 
~Vinod
