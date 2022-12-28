Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B8657597
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiL1LEk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiL1LEb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:04:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37BF658E;
        Wed, 28 Dec 2022 03:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E29BB8120C;
        Wed, 28 Dec 2022 11:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F7C433D2;
        Wed, 28 Dec 2022 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225467;
        bh=U/jjHsOn1V+z7VLnaTWqS9RxJwRkSJ7tQw76Ye2oYkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0NTM0vNWox/w7L20i6c7V0zYqhixXbINoEirfa1yc5Qy9LkV+OjX8+8duE/k10pU
         vSMDWgyzzZXRk7lHE9k7RjwS+3FIdQhNvWTtJ2JPSLI8ZB/CHfILqShysnhfkfS+v+
         N6U1cDVLndmMeSpWvMJY/G0G4aQWJQd/IbbYCIdKwtuOCvRm+OxTXmQArzIlnA4jzp
         XBpGKk4RG5RUk0OnpE2nDiHSfBilWAB62RTDgec9vMhYGN+yWD+u4ue/Wch0F3yJqB
         R97owkPDaBQhe7OhMjv0w0vbaVq1rRhsWWEAm6HopD0eujqPGcvKpbZ5iEV/juhOKV
         toDCYrE28Xp3w==
Date:   Wed, 28 Dec 2022 16:34:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     peter.ujfalusi@gmail.com, vaishnav.a@ti.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Do conditional decrement of
 UDMA_CHAN_RT_PEER_BCNT_REG
Message-ID: <Y6wit7+nfIZAZsHj@matsya>
References: <20221128085005.489964-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128085005.489964-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-11-22, 14:20, Jayesh Choudhary wrote:
> PSIL_EP_NATIVE endpoints may not have PEER registers for BCNT and thus
> udma_decrement_byte_counters() should not try to decrement these counters.
> This fixes the issue of crypto IPERF testing where the client side (EVM)
> hangs without transfer of packets to the server side, seen since this
> function was added.

Applied, thanks

-- 
~Vinod
