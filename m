Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01E5ACAF1
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiIEGdh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiIEGdL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:33:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480133E18;
        Sun,  4 Sep 2022 23:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E87C7B80ED2;
        Mon,  5 Sep 2022 06:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5C8C433D6;
        Mon,  5 Sep 2022 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662359545;
        bh=v8Uu4t3DK94xkNfwRECUeVVINR5kAkDQcI0D9fj/uEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHVLDhuvJaQTJ4t5AvwKmhUKBGuZvkzBfG9ugAsU3a9eGaHX8IrDjsD2u3Sqq0Hp7
         RRZrn+CSD5e/WNng3cMI9+KyVcUiyYv9HAYpFdTHoNxjoR1q45GGQMhvDMzcJku4zv
         M8zMfEb82AOEfm34cpabCTpB2xFlJfiTz5KBMGUv2QxJSrJwgoVF4jtwjhISMDQAzF
         sHZ5JhN9L/X3S6VyMAmxce9dSWjI+jeMaeKbtaRUMtsPCelhJWDfO384XvxjZfZ+09
         vbExgT9Z0aTVe7Inp537rd+SO/6KksZ/RXaTaU2pI00Pe0iV6zR+dQYifgeQNaa7gZ
         yt8Nzt9VKIuYQ==
Date:   Mon, 5 Sep 2022 12:02:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: Replace two if statements with only
 one with two conditions
Message-ID: <YxWX9YbMqYvba1LA@matsya>
References: <20220802140630.243550-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140630.243550-1-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-22, 17:06, Tudor Ambarus wrote:
> Add a cosmetic change and replace two if statements with a single if
> statement with two conditions. In case the optional txstate parameter is
> NULL, we return the dma_cookie_status, which is fine, no functional change
> required.

Applied, thanks

-- 
~Vinod
