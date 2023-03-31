Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1900F6D20CF
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjCaMsK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjCaMru (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F01D2E9;
        Fri, 31 Mar 2023 05:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F15FB82F28;
        Fri, 31 Mar 2023 12:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79021C4339B;
        Fri, 31 Mar 2023 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680266854;
        bh=x8TnEdhqK1xKEhcGbEgZoX2KmNiKogEIGPV8CmLXuBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaKxVDl9WKCzZhclbtxVpSYFRPHqUv7Mv2qvA3/80KTMooErvoYSltw4fc/eHcXKq
         dZBQkrIaat4hShpNTlXg0ydUNMYJd8Vhct0SX3yTy8mmgTgdCV10XrWXVvK7X4hQEn
         9WymsrM/TGNAzwdTvNyHmrVFHGNSfqFU8SeKtlTkBion1PxWxpgiFM84MeaCMJy5Oe
         aXyGsTYVf2EfLT3GqvX9EkIOqqmtiWuBm+1YRcPFVQGsCikfw+Jzc9O8MwYWHY1Wrn
         dmiR/y3LUBGyg/eCGKyHMu8NJB0bsqS7Kkx9EdvRlFxsIBARzIZWD766Nd+TPsyuNb
         4ihSzjKPJcP7w==
Date:   Fri, 31 Mar 2023 18:17:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: apple-admac: Handle 'global' interrupt
 flags
Message-ID: <ZCbWYR9LbGFw7S0A@matsya>
References: <20230224152222.26732-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230224152222.26732-1-povik+lin@cutebit.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-02-23, 16:22, Martin Povišer wrote:
> In addition to TX channel and RX channel interrupt flags there's
> another class of 'global' interrupt flags with unknown semantics. Those
> weren't being handled up to now, and they are the suspected cause of
> stuck IRQ states that have been sporadically occurring. Check the global
> flags and clear them if raised.

Applied, thanks

-- 
~Vinod
