Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305E6D1FFE
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjCaMVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjCaMUz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:20:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C61FD15;
        Fri, 31 Mar 2023 05:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6FACB82EFB;
        Fri, 31 Mar 2023 12:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E565C433EF;
        Fri, 31 Mar 2023 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265188;
        bh=QqgdohJz5H3SIEJBlicGJEkmjVnoEztgtD3Rg/hD454=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhX5BTPQFaNX2dhHGbqWSNxZTV/yjv2svqdcEMWwu+M3yuntjzT5H25O6HaPQ5hjG
         I/VRjXjsEoZxh4KXr6iJehd6q3uykIonvEvLDX3+QqK94/d6cWzlCcqDlNalF6G2Zd
         6gLZUunUcKy621CHBE3WsoodQwl8AxVGRAbsl3x7qqjOpbbtDzn48IrOp9O6WW5lrC
         Mzl7sHzEK3hPFZM4CwdwvMwOKda7T73AjR/5KVzJKiZyTVvauLpnPlhmNNiu11RWMi
         OiF1mN6xXo9QytaJIURfZX0TWf3nHwB2e+CtqAt8mc1ikGWndSjdiyRnRUw7e33o9q
         UCERpgk1HQhKw==
Date:   Fri, 31 Mar 2023 17:49:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     peter.ujfalusi@gmail.com, vigneshr@ti.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Workaround errata i2234
Message-ID: <ZCbP4OogOMws3CIY@matsya>
References: <20230323120107.27638-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323120107.27638-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-03-23, 17:31, Jayesh Choudhary wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Per [1], UDMA TR15 transactions may hang if ICNT0 is less than 64B
> Work around is to set EOL flag is to 1 for ICNT0.
> 
> Since, there is no performance penalty / side effects of setting EOL
> flag event ICNTO > 64B, just set the flag for all UDMAP TR15
> descriptors.

Applied, thanks

-- 
~Vinod
