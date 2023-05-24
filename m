Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511A670EE89
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjEXGwf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 02:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGv7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 02:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C7AE41;
        Tue, 23 May 2023 23:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1375638E9;
        Wed, 24 May 2023 06:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EED4C433D2;
        Wed, 24 May 2023 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684911069;
        bh=SQgChDcw6HLiiW8+cWOlKH9uJ8KGAUmFWwGc0/oyPJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pmy70/a2keU9fBFBIbRvYksnt7YJ8/C1aPUk6iYC9AGC2xaG0JuUpdR+HkChT494N
         oWedZdtvErqqabp2DhYJjB0wfnyf6R4GC0bNINaGmc4JifjeBx8ojnOyZNtwDbdQ8E
         GAf+DWxagT9fhIINBfvpzq9ZBqxmvEPSJL7vhM5YGYzvzKFDtyvvuHtLfp+J7Cty8O
         bjZWGGX2wsiLYpv//XMZFtH+mZ9kQxrMG1hUi1ARhBNcMHa6iYm+SEHoFj785Y5Jp0
         mft6j3KD+UBezEuuZmknMqF389jBm43Uc4tD3XpHr/VtHpLRoruKtBm4ikpmvhzbhV
         pFuE94THxBo9Q==
Date:   Wed, 24 May 2023 12:21:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 0/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <ZG2z2U2Bm7kk7mqu@matsya>
References: <20230520050854.73160-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520050854.73160-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-05-23, 13:08, Cai Huoqing wrote:
> Add support for HDMA NATIVE, as long the IP design has set
> the compatible register map parameter-HDMA_NATIVE,
> which allows compatibility for native HDMA register configuration.
> 
> The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> And the native HDMA registers are different from eDMA,
> so this patch add support for HDMA NATIVE mode.
> 
> HDMA write and read channels operate independently to maximize
> the performance of the HDMA read and write data transfer over
> the link When you configure the HDMA with multiple read channels,
> then it uses a round robin (RR) arbitration scheme to select
> the next read channel to be serviced.The same applies when
> youhave multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are aligned to byte.

Applied, thanks

-- 
~Vinod
