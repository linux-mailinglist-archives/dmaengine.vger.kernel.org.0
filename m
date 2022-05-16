Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697C5284D4
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiEPM63 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiEPM6X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A0393E0;
        Mon, 16 May 2022 05:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18068B80B55;
        Mon, 16 May 2022 12:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0CAC385AA;
        Mon, 16 May 2022 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705899;
        bh=FPzbUnkJLcsG0M7oKuNBNoQ7cZEuK61KYiVzNaaFt/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coXRms2ldppWvGjiTqJ8B5o/hxAEt4epsMvfxMF6WBmqwJIikkE3/E108dR5EitXE
         +UifU8tPBttCQr1mSHyj+iQrdOVZ/WnmKarbJA9rnZ4mJ27yrLKrUNgdxWz5SM6uBK
         2y/mEUECw+lBzjqqLRodqG/ByUqanigZ9qq1GHpoIU9vnT8cPgUJLG7LoDBAlMhnCv
         +Ko8lRfZcfKcwEe7HQ00inruf06H2K471Ymjlolcnqcx0oFhZfVGvGc/UMKz2iJbpM
         LArjlpW2RALhiiLwY09MBBbeEkFQUnTw6WvCmAZ2f+v2SfPfjHT8EZxiCAA4XApCbi
         /CEZ1mkJYoHHQ==
Date:   Mon, 16 May 2022 18:28:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH 0/3] dmaengine: zynqmp_dma: coverity fixes
Message-ID: <YoJKZxAshe1I6IEu@matsya>
References: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-05-22, 12:42, Radhey Shyam Pandey wrote:
> This patchset addresses coverity issues reported on zynqmp dma driver.
> 

Applied, thanks

-- 
~Vinod
