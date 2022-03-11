Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396884D5FB3
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 11:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbiCKKgd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 05:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348027AbiCKKg3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 05:36:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DC115960;
        Fri, 11 Mar 2022 02:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82FD8B82B26;
        Fri, 11 Mar 2022 10:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD37C340E9;
        Fri, 11 Mar 2022 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646994913;
        bh=wm21xJ5baeJkPPj20x7VMn4tjjFzIKcijQ8aYc6wCCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urCsqq81srgWnxBxhy9F1NKaTMHHFWdjAW6oWLs5Ypm7sIheRwHLLnNf3pEqeBIKw
         ZAB67zR0zufKxLzt2YHcI0rceWq90vOOQBaGh3/y507kjPwe7C9Tlww8Ep/OSAwFtX
         NFjdUrscnENIbr+YRL1W5F1jO1zJOdbTNiKdsX+y9eFw259ygEcGfH0sHfR95vDIbn
         mgRJfbaDalFPs2MshVMuwIA9h5DQ4W2oVVCQJfbszH8ROGeV2dDzhk9RPpKmi89BkD
         iaOAxtfOpxbvrKcyKrSF08CiOjAWUnLBOXvLc4V2yf6ci+9knfXeusFPh6IcLT+Gr1
         3EjsQkbgBDGqw==
Date:   Fri, 11 Mar 2022 16:05:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     trix@redhat.com
Cc:     Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: cleanup comments
Message-ID: <Yisl3cliIotPpFkl@matsya>
References: <20220309020056.1026106-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309020056.1026106-1-trix@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-03-22, 18:00, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx, /* */ for *.h, remove extra space
> 
> Replacements
> configurarion to configuration
> inerrupts to interrupts
> chanels to channels

Applied, thanks

-- 
~Vinod
