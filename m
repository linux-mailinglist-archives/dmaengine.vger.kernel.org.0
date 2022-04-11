Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596FF4FBF03
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbiDKO1A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347258AbiDKO05 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C70377E5;
        Mon, 11 Apr 2022 07:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BB8DB81643;
        Mon, 11 Apr 2022 14:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DA1C385A3;
        Mon, 11 Apr 2022 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649687079;
        bh=3f8x8UDpZU8LjXOQXVkQWefAyi7CRWXDrUMWog7e55w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3b8gddofu7jH+t2PiWiNv3DnQsIJZ3wx+uxKFc/Plx9Hyi1xtyRtH8/Ia/JWnqLN
         Fti4jlIU8dMLW7w4r56KwcfZeK5MXlnvnstbu1wXfubacMow3fNP1vuxSJpBSYuV6F
         tkVlCn0M2WHxw9MZsvTuv8O44D8mVhvIVTF7vtxkFtHs7VBmg7dcSHOf2wT90kIfLP
         4NmRXI5loQKobwrbbsOZiROzGLhBbxQpPLeWkN3U3UB/flC0iZVCQ1NjEqjpLZ8u3p
         7q3N2a0dMnSC2cxyYdXa9MiRjVzj2j0U7GJQ1Jv26tTU+Q9v6I59WDRPM1iWmjdW03
         O8vQO8PMFvrog==
Date:   Mon, 11 Apr 2022 19:54:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/1] dmaengine: dw-edma: Fix unaligned 64bit access
Message-ID: <YlQ6I3ZzMDpU0Sjd@matsya>
References: <20220225120252.309404-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225120252.309404-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-02-22, 13:02, Herve Codina wrote:
> On some arch (ie aarch64 iMX8MM) unaligned PCIe accesses are
> not allowed and lead to a kernel Oops.
>   [ 1911.668835] Unable to handle kernel paging request at virtual address ffff80001bc00a8c
>   [ 1911.668841] Mem abort info:
>   [ 1911.668844]   ESR = 0x96000061
>   [ 1911.668847]   EC = 0x25: DABT (current EL), IL = 32 bits
>   [ 1911.668850]   SET = 0, FnV = 0
>   [ 1911.668852]   EA = 0, S1PTW = 0
>   [ 1911.668853] Data abort info:
>   [ 1911.668855]   ISV = 0, ISS = 0x00000061
>   [ 1911.668857]   CM = 0, WnR = 1
>   [ 1911.668861] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000040ff4000
>   [ 1911.668864] [ffff80001bc00a8c] pgd=00000000bffff003, pud=00000000bfffe003, pmd=0068000018400705
>   [ 1911.668872] Internal error: Oops: 96000061 [#1] PREEMPT SMP
>   ...
> 
> The llp register present in the channel group registers is not
> aligned on 64bit.
> 
> Fix unaligned 64bit access using two 32bit accesses

Applied, thanks

-- 
~Vinod
