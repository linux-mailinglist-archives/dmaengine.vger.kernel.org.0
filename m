Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646EE566F28
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiGEN1Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiGEN1N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 09:27:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A941601;
        Tue,  5 Jul 2022 05:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBB2AB817C7;
        Tue,  5 Jul 2022 12:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC97EC341C7;
        Tue,  5 Jul 2022 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657025329;
        bh=unpkgiZ7iLWfroJs+BqlFoxz6dG1xKaDeB3iWMuXpvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cE+V+ETn3k/uhUlZHHvZKPVZXjS26zd3XCGdIJIMbnK2tKlJSZVgJ1TS0+xy1Nh97
         u2qRTP0ZQ02/lo01pLPPakaEHxGyg0k7zVjA1Kdy1Ddw1RP4gH8JJvdlYEKkvPupMX
         oJ5oTt5xxx0ysGOAO5pbpbGL3wWIX0kGISw8PiaP6DQkYn1/NaKEsYwUNO1QI42MIM
         LShXlq6Upbzlu3Hj6nWfigDoJCn7+Sq4PCqfF8u96oMTDS4zpgOps+uPLyPFJxHuKv
         WS9gCJkFoRnygUkDIfFfif4qCzJDs2S/NRhqqaRZUMoKqLJaG9xtkRjvW2wAShmbGF
         R4w52whxpbi1Q==
Date:   Tue, 5 Jul 2022 18:18:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdma: handle errors of
 at_xdmac_alloc_desc() correctly
Message-ID: <YsQzLZ+KsohkHW+2@matsya>
References: <20220526135111.1470926-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526135111.1470926-1-michael@walle.cc>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-05-22, 15:51, Michael Walle wrote:
> It seems that it is valid to have less than the requested number of
> descriptors. But what is not valid and leads to subsequent errors is to
> have zero descriptors. In that case, abort the probing.

Applied, thanks

-- 
~Vinod
