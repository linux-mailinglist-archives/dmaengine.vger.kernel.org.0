Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCF619661
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 13:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKDMkt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 08:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDMks (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 08:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4B2AD2;
        Fri,  4 Nov 2022 05:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1BAB6216F;
        Fri,  4 Nov 2022 12:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8347C433C1;
        Fri,  4 Nov 2022 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667565647;
        bh=86lfsZhQiofECwdBXs+MGUADeqUzwNnoH81scqJlkF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOgihHFG7DvlRNq1fWGC6tK8cVXEkJgDWZtX+VyGNFA51eg1sTn82YVl3OSeafcph
         rzJvLIdXzod+5/+tx5ZI0dEkJMKMviP/GIQjKDsKI2BYkILiT01Iua1qEROQZQb2sO
         2dCOxlezc4wDwi8wbuaRYT2gzi5v3Dfl+VG6BIgYXWSUft8nrDYClyfSKPjKR0Z5T2
         Lzvh6a6m6Jtp00g6Bwwmu96/5N5I9mvfcKd60nvChtpuHFsoyC1wfLbJOLovXEOPLe
         4TXLT4wOA7qdGY5MA8GCJ1FtEBDIWDIHMPwUlTOWMG+iQkYYk1Pv9ftShuIV/pJfEP
         HfFe2mb4mrNdA==
Date:   Fri, 4 Nov 2022 18:10:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/3] dmaengine: Add support for immediate commands
Message-ID: <Y2UIS7P0alvqT4jn@matsya>
References: <20221027051429.46593-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027051429.46593-1-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-22, 10:44, Sireesh Kodali wrote:
> The IPA v2.x block, found on some older Qualcomm SoCs, uses BAM DMA to
> send and receive packets from the AP. It also uses BAM to receive
> commands from the AP (and possibly the modem). These commands are
> encoded as "Immediate Commands". They vary from regular BAM DMA
> commands. Adding support for immediate commands is trivial, but requires
> also adding Immediate Commands to the dmaengine API, which is what this
> patch series does.

Can you explain a bit more. I understand you need "Immediate Commands"
but am really reluctant to add another interface to support a specific
use case

> 
> Sireesh Kodali (3):
>   doc: dmaengine: client-api: Add immediate commands in the DMA client
>     API
>   dmaengine: Add support for immediate commands in the client API
>   dmaengine: bam_dma: Add support for immediate commands
> 
>  Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
>  drivers/dma/qcom/bam_dma.c                      |  3 +++
>  include/linux/dmaengine.h                       |  4 ++++
>  3 files changed, 17 insertions(+)
> 
> -- 
> 2.38.1

-- 
~Vinod
