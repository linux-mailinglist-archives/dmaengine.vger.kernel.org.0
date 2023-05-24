Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8F70EE98
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbjEXGyL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbjEXGxV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 02:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8C18D;
        Tue, 23 May 2023 23:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D69663997;
        Wed, 24 May 2023 06:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B12FC433D2;
        Wed, 24 May 2023 06:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684911175;
        bh=lmwb1wYkgWX0fEzusZ87So9a04WPkfbmwCPCTbS/1F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKWZD4VMWbep7swzgp5lKOZv0zxBlSQGwGGfbgnlaO2O9Cg/+UnGmWzDRl3ncpAuE
         Bn53CH5r1Hgbo3OAlE1CzunTtTghYM+T6uLL8PZ7R8fD+taqrjIk6ai4T0ucmSudaq
         CoPR0uUcUdt8Knpkh15IPaSSHD8TMaWfowKmYiRdHaDJXOMyWlCSQouEihChRwXIa8
         FyEM1CZpBcko7yDpINz8BwJrfWWi4RU5JLVkRA9n2PklfQubPR2xYwq3Tz6hTWe31O
         +Rd+OSWLnOEsLKPVB9tYTBnuBmwyHy954rGys3hRENCgrOQXN72rgcxsZ4OjvSO00C
         pYFOS7M1fGUTQ==
Date:   Wed, 24 May 2023 12:22:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v2] dmaengine: qcom: bam_dma: allow omitting
 num-{channels,ees}
Message-ID: <ZG20Q3GFxIO+SQ9d@matsya>
References: <20230518-bamclk-dt-v2-1-a1a857b966ca@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518-bamclk-dt-v2-1-a1a857b966ca@gerhold.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-05-23, 13:00, Stephan Gerhold wrote:
> The bam_dma driver needs to know the number of channels and execution
> environments (EEs) at probe time. If we are in full control of the BAM
> controller this information can be obtained from the BAM identification
> registers (BAM_REVISION/BAM_NUM_PIPES).
> 
> When the BAM is "controlled remotely" it is more complicated. The BAM
> might not be on at probe time, so reading the registers could fail.
> This is why the information must be added to the device tree in this
> case, using "num-channels" and "qcom,num-ees".
> 
> However, there are also some BAM instances that are initialized by
> something else but we still have a clock that allows to turn it on when
> needed. This can be set up in the DT with "qcom,controlled-remotely"
> and "clocks" and is already supported by the bam_dma driver. Examples
> for this are the typical BLSP BAM instances on older SoCs, QPIC BAM
> (for NAND) and the crypto BAM on some SoCs.
> 
> In this case, there is no need to read "num-channels" and
> "qcom,num-ees" from the DT. The BAN can be turned on using the clock
> so we can just read it from the BAM registers like in the normal case.
> 
> Check for the BAM clock earlier and skip reading "num-channels" and
> "qcom,num-ees" if it is present to allow simplifying the DT description
> a bit.

Applied, thanks

-- 
~Vinod
