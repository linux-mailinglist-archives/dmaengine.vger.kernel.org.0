Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226AD54E32C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbiFPORK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiFPORJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD3344C6;
        Thu, 16 Jun 2022 07:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD619B8216D;
        Thu, 16 Jun 2022 14:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E2C34114;
        Thu, 16 Jun 2022 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655389026;
        bh=4N0hBtR+SyS25pTqTpY1XXhf0OdTDS8HRBE+v+SkUaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU2a/TXPByQwnAX7hH2naRcQHMYUTMhF1YLcALCrrLHhovVp/GLqM+6+b7gwLFRDA
         /pTXQE4B8T3waGUgshRjaEIZK0l0z0GUJTVhHq7Yq+qbljhu5d+Bm0ujVqOw8MoubK
         4GVKzdCQ65tCJ4+bsH3uc/JSJ4yZe2d7Tz+5+GPc6ObWb8Ii0yAjXRB5UASFPyg6nx
         CbQOnSQCmi0NcWY9PNbilmjeFNZad4M1AvNal16z8T83TZFSJyThfml1Usthi9B/Gy
         a+yasFWIttcRUy4NKt+aGl8NUMegAXBkEHZ2/zoaluHy9NrAjcz5ov15x8tKMgkUAG
         +DpEU4Pu5zAXg==
Date:   Thu, 16 Jun 2022 07:17:05 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: apple-admac: Use {low,upp}er_32_bits() to
 split 64-bit address
Message-ID: <Yqs7YSR12L42zFL5@matsya>
References: <20220616141312.1953819-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616141312.1953819-1-geert@linux-m68k.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-22, 16:13, Geert Uytterhoeven wrote:
> If CONFIG_PHYS_ADDR_T_64BIT is not set:
> 
>     drivers/dma/apple-admac.c: In function ‘admac_cyclic_write_one_desc’:
>     drivers/dma/apple-admac.c:213:22: error: right shift count >= width of type [-Werror=shift-count-overflow]
>       213 |  writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
>           |                      ^~
> 
> Fix this by using the {low,upp}er_32_bits() helper macros to obtain the
> address parts.

Applied, thanks

-- 
~Vinod
