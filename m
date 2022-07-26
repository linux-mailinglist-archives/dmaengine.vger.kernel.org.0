Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3858177F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiGZQfi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiGZQfh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 12:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430F12A93
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 09:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7147C6155E
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 16:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB4FC433D6;
        Tue, 26 Jul 2022 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658853335;
        bh=8rimBTo+0HjigjRK8CtaktlTniOZwTR22swGrq1hZAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMjA6hya01PuKllW0nNdXg1Na5GZ05Q8CMJksrLT3REKrSA5jXbzW4xoRaayFktkX
         QzlQ5v4/R78e8yiuhjgSNaCWlRA2zammqkHLzW6eSGQ80/CWYRvTKI1wZQxk0ILnk4
         Ip/m9+dwwRH5lHXxJyqR/0CU5Inr/IMYbpxMfRgkZZ+C6RgYjRSRJiwgA0A7HMPqnM
         GPyeU48AqBMS4wWyYDz/H1wmE/HU2c/+HLA/eef0Bn/Z4SYEnN7Lm+WXOhI0LMR+YL
         2HQUhbw0hv8c1/zHMxG/26LB6FYug4aOy9PEicJGPH0Z16rEv2amlGDJ3/H5L3qBfu
         TJuZtwPHAqlQg==
Date:   Tue, 26 Jul 2022 22:05:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Tausen <mta@satlab.com>
Cc:     dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2] dmaengine: axi-dmac: check cache coherency register
Message-ID: <YuAX0zghLDSIfGCv@matsya>
References: <20220726140213.786939-1-mta@satlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726140213.786939-1-mta@satlab.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-22, 16:02, Mathias Tausen wrote:
> Marking the DMA as cache coherent (dma-coherent in devicetree) is only
> safe with versions of axi_dmac that have this feature enabled.

Applied, thanks

-- 
~Vinod
