Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC00056380B
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGAQgY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGAQgX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:36:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469F41987;
        Fri,  1 Jul 2022 09:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94CD5B830A5;
        Fri,  1 Jul 2022 16:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F24C3411E;
        Fri,  1 Jul 2022 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693380;
        bh=fON2n7V2Tz1MR0HNZ1rdq5xO7nnX+bihrmkwq2reX/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtnYQ0GRmWpSM/epbOXzk6dsor7PYc54WB4wSfDAqULsIUUBDb2L16AytdL5snVWx
         4ROsQCDALM96PcdlAUc7OJ4PppXrq+XObfJyMVSCeKg2gjrxfSSJNu20b1MTrBGh23
         uh1JQX/IQi6nJuQU+WFuExkn4hZfefX53kD2ixMlIK36ZtnwZBGu6qiJp8RIf2vgf1
         Zongz667m4F7xa5RdniGYU7Cw/p3/ZrbNI++B/OE07y5KTN6NzAfjZ/URDvRJAw/oh
         kD9Pj72bnzmtNc5oFDqNaj36kqb3YQJYZNT4zWhWrF06vU+lzlIQzF1paPhJrt0pI0
         qrW9j6mkMOI+A==
Date:   Fri, 1 Jul 2022 22:06:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix typo in comment
Message-ID: <Yr8ifg1ooWRoer12@matsya>
References: <20220618130349.11507-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618130349.11507-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-22, 21:03, Xiang wangx wrote:
> Delete the redundant word 'the'.

Applied, thanks

-- 
~Vinod
