Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30D70ED47
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 07:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbjEXFrU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjEXFrT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 01:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E0C1;
        Tue, 23 May 2023 22:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997A26390E;
        Wed, 24 May 2023 05:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D52C433EF;
        Wed, 24 May 2023 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684907237;
        bh=dxM2tJ5nOhZikrkpGLIdzfVYNAQtJdGEAJes99oOE6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ki0wTByhxc5O71eLm4JuXqKscEW9+cFxRAzQJi71whAZz54OP9J3hs3LtPi4EOa/Q
         WLez9nA2S4arRKekDgtjja92N8DcYoYMeMfW2NVUPygcgmVW5ddVJR5HmTAAbng00b
         VL5/WWHVSQaQWv1KsLBieUllgclisLnEcuupcU01+AWcHMLSj0KmCXX8lZKgBgy0Mq
         s3B8W9bo1hHAV8WRrWP+GVJPZg0xugp+WnWXOzijUgmcVcD25fUrOa4xl3Iq//iIxs
         RG83EqzUl8s765JKLfFD+joZmYslQrdzfYiP3xqu1Y81J4t9MD+Fr06H8ye4iWcNP/
         cuOFei2JOLcJw==
Date:   Wed, 24 May 2023 11:17:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Jaswinder Singh <jassisinghbrar@gmail.com>,
        Boojin Kim <boojin.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] dmaengine: pl330: rename _start to prevent build error
Message-ID: <ZG2k4DeQzs3oudxK@matsya>
References: <20230524045310.27923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524045310.27923-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-05-23, 21:53, Randy Dunlap wrote:
> "_start" is used in several arches and proably should be reserved
> for ARCH usage. Using it in a driver for a private symbol can cause
> a build error when it conflicts with ARCH usage of the same symbol.
> 
> Therefore rename pl330's "_start" to "pl330_start_thread" so that there
> is no conflict and no build error.
> 
> drivers/dma/pl330.c:1053:13: error: '_start' redeclared as different kind of symbol
>  1053 | static bool _start(struct pl330_thread *thrd)
>       |             ^~~~~~
> In file included from ../include/linux/interrupt.h:21,
>                  from ../drivers/dma/pl330.c:18:
> arch/riscv/include/asm/sections.h:11:13: note: previous declaration of '_start' with type 'char[]'
>    11 | extern char _start[];
>       |             ^~~~~~

Applied, thanks

-- 
~Vinod
