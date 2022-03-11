Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6E74D5F41
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiCKKS7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 05:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347789AbiCKKS7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 05:18:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAA58E62
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 02:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41544B82AFD
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 10:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A81C340E9;
        Fri, 11 Mar 2022 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646993873;
        bh=6lazla4endMCT0SdB2AeVjcrezl+dH9d8d06eIbHjH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIXYtYSGPcOyQS6Cr/3ZocCr/1q3FYwQVp/q3V1Hg9TrKmwsbOZTSrgVQF/xskZja
         Xp3yh4AO0ML6cEXvfgpINDkeAsPuQaIimiz0MM6U17KflQxV5VqumgaGsLrFQS8UWX
         q6bxIhp6qVTK3K/hyWJRN3YuArvQF0/xbuaDI4qcG5BGWas944Upfu2ZwMkJmZzT9j
         MEDj/54fxSldmmjArglUJmr2ndGefXphTsHL9gtd6qMT94+naDxf+oanG7pIJ2L607
         sXDNukDZd4vPyRLHyf6uIVvxRHmhU9r3Vb51yXK3JzbT9fajvVqxmRXLUfpoZtEyTs
         oeOaMX6KHwzdw==
Date:   Fri, 11 Mar 2022 15:47:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: Drop comma after SoC match
 table sentinel
Message-ID: <YishzdI3CtyH3Euw@matsya>
References: <0b8ad4dcc185aa7a17655983e0eb5690d8fed460.1646311558.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8ad4dcc185aa7a17655983e0eb5690d8fed460.1646311558.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-03-22, 13:47, Geert Uytterhoeven wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
> 
> Add a comment to clarify the purpose of the empty element.

Applied, thanks

-- 
~Vinod
